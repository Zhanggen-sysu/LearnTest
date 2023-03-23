//
//  GZEWrappingLabel.h
//  LearnTest
//
//  Created by GenZhang on 2023/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GZEWrappingLabel : UITextView

@property (nonatomic, assign) NSInteger wrapNumberOfLine;
@property (nonatomic, assign) BOOL isWrap;
@property (nonatomic, copy) NSAttributedString *wrapText;
@property (nonatomic, copy) NSAttributedString *expandText;
@end

NS_ASSUME_NONNULL_END
