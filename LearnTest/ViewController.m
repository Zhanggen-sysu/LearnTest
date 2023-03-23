//
//  ViewController.m
//  LearnTest
//
//  Created by GenZhang on 2023/2/10.
//

#import "ViewController.h"
#import "LTAView.h"
#import "LTBView.h"
#import "LTCView.h"
#import "LTDView.h"
#import "LTEView.h"
#import "GZECustomButton.h"
#import "Masonry.h"
#import <YYText/YYText.h>
#import "GZEWrappingLabel.h"
@interface ViewController ()

@property (nonatomic, strong) YYLabel *tokenLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    LTAView *aview = [[LTAView alloc] initWithFrame:CGRectMake(50, 50, 300, 550)];
//    aview.backgroundColor = [UIColor redColor];
//
//    LTBView *bview = [[LTBView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
//    bview.backgroundColor = [UIColor greenColor];
//
//    LTCView *cview = [[LTCView alloc] initWithFrame:CGRectMake(50, 300, 200, 200)];
//    cview.backgroundColor = [UIColor blueColor];
//
//    LTDView *dview = [[LTDView alloc] initWithFrame:CGRectMake(50, 50, 100, 50)];
//    dview.backgroundColor = [UIColor whiteColor];
//
//    LTEView *eview = [[LTEView alloc] initWithFrame:CGRectMake(50, 100, 100, 50)];
//    eview.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:aview];
//    [aview addSubview:bview];
//    [aview addSubview:cview];
//    [cview addSubview:dview];
//    [cview addSubview:eview];
    
//    GZECustomButton *button = [[GZECustomButton alloc] init];
//    [button setTitle:@"测试" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:@"fillm-fill"] forState:UIControlStateNormal];
//    button.backgroundColor = [UIColor redColor];
//    [self.view addSubview:button];
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.size.mas_equalTo(CGSizeMake(200,200));
//    }];
//    [button setImagePosition:GZEBtnImgPosition_Right spacing:20 contentAlign:GZEBtnContentAlign_Center contentOffset:50 imageSize:CGSizeMake(10, 10) titleSize:CGSizeZero];
    GZEWrappingLabel *label = [[GZEWrappingLabel alloc] initWithFrame:CGRectMake(20, 100, 300, 500)];
    label.text = @"If you specify the region parameter, the regional release date will be used instead of the primary release date. The date returned will be the first date based on your query (ie. if a with_release_type is specified). It's important to note the order of the release types that are used. Specifying would return the limited theatrical release date as opposed to which would return the theatrical date.";
    [self.view addSubview:label];
}

- (NSArray *)getLinesArrayOfStringInLabel:(UILabel *)label{
    NSString *text = [label text];
    UIFont *font = [label font];
    CGRect rect = [label frame];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attStr.length)];
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    CGPathRelease(path);
    CFRelease( frame );
    CFRelease(frameSetter);
    return (NSArray *)linesArray;
}


- (YYLabel *)tokenLabel {
    if (!_tokenLabel) {
        _tokenLabel = [YYLabel new];
        _tokenLabel.frame = CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 40, 30);
        _tokenLabel.numberOfLines = 0;
        _tokenLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.75];
        [self addSeeMoreButtonInLabel:_tokenLabel];
        
    }
    
    return _tokenLabel;
}

- (void)addSeeMoreButtonInLabel:(YYLabel *)label {
    UIFont *font16 = [UIFont systemFontOfSize:16];
    label.attributedText = [[NSAttributedString alloc] initWithString:@"我们可以使用以下方式来指定切断文本; 收起 我们可以使用以下方式来指定切断文本" attributes:@{NSFontAttributeName : font16}];

    NSString *moreString = @" 展开";
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"... %@", moreString]];
    NSRange expandRange = [text.string rangeOfString:moreString];
    
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:expandRange];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor darkTextColor] range:NSMakeRange(0, expandRange.location)];
    
    //添加点击事件
    YYTextHighlight *hi = [YYTextHighlight new];
    [text yy_setTextHighlight:hi range:[text.string rangeOfString:moreString]];
    
    __weak typeof(self) weakSelf = self;
    hi.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        //点击展开
        [weakSelf setFrame:YES];
    };
    
    text.yy_font = font16;
    
    YYLabel *seeMore = [YYLabel new];
    seeMore.attributedText = text;
    [seeMore sizeToFit];
    
    NSAttributedString *truncationToken = [NSAttributedString yy_attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.frame.size alignToFont:text.yy_font alignment:YYTextVerticalAlignmentTop];
    
    label.truncationToken = truncationToken;
}

- (NSAttributedString *)appendAttriStringWithFont:(UIFont *)font {
    if (!font) {
        font = [UIFont systemFontOfSize:16];
    }
    
    NSString *appendText = @" 收起 ";
    NSMutableAttributedString *append = [[NSMutableAttributedString alloc] initWithString:appendText attributes:@{NSFontAttributeName : font, NSForegroundColorAttributeName : [UIColor blueColor]}];
    
    YYTextHighlight *hi = [YYTextHighlight new];
    [append yy_setTextHighlight:hi range:[append.string rangeOfString:appendText]];
    
    __weak typeof(self) weakSelf = self;
    hi.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        //点击收起
        [weakSelf setFrame:NO];
    };
    
    return append;
}

- (void)expandString {
    NSMutableAttributedString *attri = [_tokenLabel.attributedText mutableCopy];
    [attri appendAttributedString:[self appendAttriStringWithFont:attri.yy_font]];
    _tokenLabel.attributedText = attri;
}

- (void)packUpString {
    NSString *appendText = @" 收起 ";
    NSMutableAttributedString *attri = [_tokenLabel.attributedText mutableCopy];
    NSRange range = [attri.string rangeOfString:appendText options:NSBackwardsSearch];

    if (range.location != NSNotFound) {
        [attri deleteCharactersInRange:range];
    }

    _tokenLabel.attributedText = attri;
}


- (void)setFrame:(BOOL)isExpand {
    if (isExpand) {
        [self expandString];
        self.tokenLabel.frame = CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 40, 200);
    }
    else {
        [self packUpString];
        self.tokenLabel.frame = CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 40, 30);
    }
}


@end
