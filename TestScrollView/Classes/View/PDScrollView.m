//
//  PDScrollView.m
//  TestScrollView
//
//  Created by pirdboy on 2018/1/19.
//  Copyright © 2018年 CMB. All rights reserved.
//

#import "PDScrollView.h"

@implementation PDScrollView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView * v= [super hitTest:point withEvent:event];
    NSLog(@"=======PBScrollView==========");
//    NSLog(@"hitTest:%@",v);
    NSLog(@"手势:%@",v.gestureRecognizers);
    NSLog(@"=================");
    return v;
}

@end
