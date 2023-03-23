//
//  LTBView.m
//  LearnTest
//
//  Created by GenZhang on 2023/2/10.
//

#import "LTBView.h"

@implementation LTBView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"进入B_View---hitTest withEvent ---");
    UIView * view = [super hitTest:point withEvent:event];
    NSLog(@"离开B_View--- hitTest withEvent ---hitTestView:%@",view);
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event
{
   NSLog(@"B_view--- pointInside withEvent ---");
   BOOL isInside = [super pointInside:point withEvent:event];
   NSLog(@"B_view--- pointInside withEvent --- isInside:%d",isInside);
   return isInside;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"B_touchesBegan");
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent
   *)event
{
   NSLog(@"B_touchesMoved");
   [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent
*)event
{
   NSLog(@"B_touchesEnded");
   [super touchesEnded:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   NSLog(@"B_touchesCancelled");
   [super touchesCancelled:touches withEvent:event];
}

@end
