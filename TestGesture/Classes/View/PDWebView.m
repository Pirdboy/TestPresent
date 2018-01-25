//
//  PDWebView.m
//  TestGesture
//
//  Created by pirdboy on 2018/1/24.
//  Copyright © 2018年 CMB. All rights reserved.
//

#import "PDWebView.h"

@implementation PDWebView


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    NSLog(@"测试hitTest%@",view);
    NSLog(@"=====================");
    NSLog(@"测试手势%@",[view gestureRecognizers]);
    
    return view;
}

@end
