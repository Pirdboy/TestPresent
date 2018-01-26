//
//  PDScrollView.m
//  TestGesture
//
//  Created by pirdboy on 2018/1/24.
//  Copyright © 2018年 CMB. All rights reserved.
//

#import "PDScrollView.h"

@implementation PDScrollView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    if(CGRectContainsPoint((CGRect){0,0,315,190}, point)) {
//        self.scrollEnabled = NO;
//    } else {
//        self.scrollEnabled = YES;
//    }
    return [super pointInside:point withEvent:event];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    
    return view;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    NSLog(@"手势1:%@",gestureRecognizer);
    NSLog(@"手势2:%@",otherGestureRecognizer);
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]){
        return YES;
    }else {
        return NO;
    }
}

@end
