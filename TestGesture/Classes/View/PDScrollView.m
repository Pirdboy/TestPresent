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
//    NSLog(@"事件point:%@",NSStringFromCGPoint(point));
//    if(CGRectContainsPoint((CGRect){25,40,315,190}, point)) {
//        self.scrollEnabled = NO;
//    } else {
//        self.scrollEnabled = YES;
//    }
    return [super pointInside:point withEvent:event];
}


//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]){
//        return YES;
//    }else {
//        return  NO;
//    }
//}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]){
        return YES;
    }else {
        return NO;
    }
}

@end
