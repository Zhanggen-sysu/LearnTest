//
//  GZEWrappingLabel.h
//  LearnTest
//
//  Created by GenZhang on 2023/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GZEWrappingLabel : UIView

@property (nonatomic, assign) NSInteger wrapNumberOfLine;
@property (nonatomic, assign) BOOL isWrap;
// 初始化后，expandText设置为空，就全部绘制，wrapText设置为空就只展开不收起
@property (nonatomic, copy) NSAttributedString *wrapText;
@property (nonatomic, copy) NSAttributedString *expandText;

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *textColor;

@end

NS_ASSUME_NONNULL_END
