//
//  LTAView.m
//  LearnTest
//
//  Created by GenZhang on 2023/2/10.
//

#import "LTAView.h"

@implementation LTAView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"进入A_View---hitTest withEvent ---");
    UIView * view = [super hitTest:point withEvent:event];
    NSLog(@"离开A_View--- hitTest withEvent ---hitTestView:%@",view);
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event
{
   NSLog(@"A_view--- pointInside withEvent ---");
   BOOL isInside = [super pointInside:point withEvent:event];
   NSLog(@"A_view--- pointInside withEvent --- isInside:%d",isInside);
   return isInside;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"A_touchesBegan");
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent
   *)event
{
   NSLog(@"A_touchesMoved");
   [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent
*)event
{
   NSLog(@"A_touchesEnded");
   [super touchesEnded:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   NSLog(@"A_touchesCancelled");
   [super touchesCancelled:touches withEvent:event];
}

@end
