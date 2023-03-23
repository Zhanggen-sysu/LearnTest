//
//  LTEView.m
//  LearnTest
//
//  Created by GenZhang on 2023/2/10.
//

#import "LTEView.h"

@implementation LTEView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"进入E_View---hitTest withEvent ---");
    UIView * view = [super hitTest:point withEvent:event];
    NSLog(@"离开E_View--- hitTest withEvent ---hitTestView:%@",view);
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event
{
   NSLog(@"E_view--- pointInside withEvent ---");
   BOOL isInside = [super pointInside:point withEvent:event];
   NSLog(@"E_view--- pointInside withEvent --- isInside:%d",isInside);
   return isInside;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"E_touchesBegan");
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent
   *)event
{
   NSLog(@"E_touchesMoved");
   [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent
*)event
{
   NSLog(@"E_touchesEnded");
   [super touchesEnded:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   NSLog(@"E_touchesCancelled");
   [super touchesCancelled:touches withEvent:event];
}

@end
