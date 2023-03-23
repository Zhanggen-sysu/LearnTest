//
//  GZEWrappingLabel.m
//  LearnTest
//
//  Created by GenZhang on 2023/3/22.
//

#import "GZEWrappingLabel.h"
#import <CoreText/CoreText.h>
@interface GZEWrappingLabel () <UITextViewDelegate>

@end

@implementation GZEWrappingLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.editable = NO;
        self.scrollEnabled = NO;
        self.textContainerInset = UIEdgeInsetsZero;
        self.textContainer.lineFragmentPadding = 0;
        self.wrapNumberOfLine = 3;
        self.isWrap = YES;
        self.delegate = self;
        self.wrapText = [[NSAttributedString alloc] initWithString:@"收起" attributes:@{
            NSForegroundColorAttributeName:[UIColor blueColor],
            NSFontAttributeName:[UIFont systemFontOfSize:17.f],
            NSLinkAttributeName:@"wrap://",
        }];
        self.expandText = [[NSAttributedString alloc] initWithString:@"展开" attributes:@{
            NSForegroundColorAttributeName:[UIColor blueColor],
            NSFontAttributeName:[UIFont systemFontOfSize:17.f],
            NSLinkAttributeName:@"expand://",
        }];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // CoreText一开始是定位于桌面的排版系统，使用了传统的原点在左下角的坐标系，所以要先调整坐标系，否则绘制出来会上下颠倒
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextConcatCTM(context, CGAffineTransformMake(1, 0, 0, -1, 0, rect.size.height));
    self.font = !self.font ? [UIFont systemFontOfSize:17]: self.font;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:self.text attributes:@{
        NSFontAttributeName: self.font
    }];
    /*
    从属性字符串创建不可变的CTFramesetterRef对象。

    生成的CTFramesetterRef可用于通过CTFramesetterCreateFrame调用创建和填充CTFrame。
    */
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, rect.size.width, 1000));
    /*
    使用CTFramesetterRef创建不可变CTFrameRef。

    创建一个由path参数提供的路径形状的，充满了字形的CTFrame。framesetter将继续填充frame，直到用完文本或发现不再适合的文本为止。

    framesetter
    用来创建CTFrame的CTFramesetterRef。
    stringRange
    创建framesetter的属性字符串的范围，该范围将在适合框架的行中排版。如果range的length部分设置为0，则framesetter将继续添加行，直到用完文本或空格为止。
    path
    指定frame形状的CGPath对象。该路径可能不是矩形的。
    frameAttributes
    可以在此处指定控制帧填充过程的其他属性，如果没有这样的属性，则为NULL。
    */
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    // 不设置按钮文本，不收起/展开，直接全部绘制
    if (!self.expandText) {
        CTFrameDraw(frame, context);
    } else {
        // 返回frame中的CTLine的数组
        NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
        CGPoint lineOrigins[self.wrapNumberOfLine];
        /*
        获取CTFrame中每一行的起始坐标，结果保存在返回参数中

        将一些CGPoint结构体复制到原点缓冲区中。复制到原点缓冲区的最大行原点数是range参数的长度。
        frame
        您要从中获取线原点数组的frame。
        range
        复制的线起点范围。如果range的长度为0，则将从range的location起到最后的行原点。
        origins
        将原点复制到的缓冲区。具有至少与range.length一样多的元素。此数组中的每个CGPoint都是CTFrameGetLines返回的相对于路径边界框原点的线数组中对应线的原点，可以从CGPathGetPathBoundingBox获得该点。
        */
        CTFrameGetLineOrigins(frame, CFRangeMake(0, self.wrapNumberOfLine), lineOrigins);
        
        if (self.isWrap) {
            // 收起状态
            for (int lineIndex = 0; lineIndex < self.wrapNumberOfLine; lineIndex ++) {
                // 获得当前行
                CTLineRef line = (__bridge CTLineRef)(lines[lineIndex]);
                // 获取该行中最初产生字形的字符范围
                CFRange range = CTLineGetStringRange(line);
                // 最后一行显示不完文字，拼接上expandText
                if (lineIndex == self.wrapNumberOfLine - 1 && range.location + range.length < attStr.length) {
                    // 创建expandText的CTLine
                    CTLineRef truncationTokenLine = CTLineCreateWithAttributedString((CFAttributedStringRef)self.expandText);
                    // 在行尾截断，使开始部分可见
                    CTLineTruncationType truncationType = kCTLineTruncationEnd;
                    /*
                    计算线条的印刷范围。
                    line
                    计算其印刷范围的线。
                    ascent
                    线的上升。 如果不需要，可以将此参数设置为NULL。
                    descent
                    线的下降。 如果不需要，可以将此参数设置为NULL。
                    leading
                    该行的前导。 如果不需要，可以将此参数设置为NULL。
                    */
                    double lineW = CTLineGetTypographicBounds(line, NULL, NULL, NULL);
                    /*
                    从现有行创建截断的行。
                    line
                    创建截断行的行。
                    width
                    截断开始处的宽度。如果line的宽度大于width，则该行将被截断。
                    truncationType 截断类型
                    truncationToken
                    该CTLineRef被添加到发生截断的位置，以指示该行已被截断。 通常，截断令牌是省略号（U + 2026）。 如果此参数设置为NULL，则不使用截断令牌，仅将行切断。
                    */
                    // 创建拼接了expandText的CTLine
                    CTLineRef lastLine = CTLineCreateTruncatedLine(line, lineW-0.1 , truncationType, truncationTokenLine);
                    CFRelease(truncationTokenLine);
                    CGContextSetTextPosition(context, lineOrigins[lineIndex].x, lineOrigins[lineIndex].y);
                    CTLineDraw(lastLine, context);
                } else {
                    CGContextSetTextPosition(context, lineOrigins[lineIndex].x, lineOrigins[lineIndex].y);
                    CTLineDraw(line, context);
                }
            }
        } else {
            // 展开状态
            for (int lineIndex = 0; lineIndex < lines.count; lineIndex ++) {
                // 获得当前行
                CTLineRef line = (__bridge CTLineRef)(lines[lineIndex]);
                // 获取该行中最初产生字形的字符范围
                CFRange range = CTLineGetStringRange(line);
                // 最后一行显示不完文字
                if (lineIndex == self.wrapNumberOfLine - 1 && range.location + range.length < attStr.length) {
                    
                } else {
                    CGContextSetTextPosition(context, lineOrigins[lineIndex].x, lineOrigins[lineIndex].y);
                    CTLineDraw(line, context);
                }
            }
        }
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    if ([URL.scheme isEqualToString:@"wrap"]) {
        self.isWrap = YES;
        [self setNeedsDisplay];
        return NO;
    }
    if ([URL.scheme isEqualToString:@"expand"]) {
        self.isWrap = NO;
        [self setNeedsDisplay];
        return NO;
    }
    return YES;
}

@end
