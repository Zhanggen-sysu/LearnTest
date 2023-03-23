//
//  LTCView.m
//  LearnTest
//
//  Created by GenZhang on 2023/2/10.
//

#import "LTCView.h"

@implementation LTCView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"进入C_View---hitTest withEvent ---");
    UIView * view = [super hitTest:point withEvent:event];
    NSLog(@"离开C_View--- hitTest withEvent ---hitTestView:%@",view);
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event
{
   NSLog(@"C_view--- pointInside withEvent ---");
   BOOL isInside = [super pointInside:point withEvent:event];
   NSLog(@"C_view--- pointInside withEvent --- isInside:%d",isInside);
   return isInside;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"C_touchesBegan");
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent
   *)event
{
   NSLog(@"C_touchesMoved");
   [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent
*)event
{
   NSLog(@"C_touchesEnded");
   [super touchesEnded:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   NSLog(@"C_touchesCancelled");
   [super touchesCancelled:touches withEvent:event];
}

@end
