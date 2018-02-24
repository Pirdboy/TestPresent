//
//  EOCRectangle.m
//  TestJSCore
//
//  Created by pirdboy on 2018/2/12.
//  Copyright © 2018年 CMB. All rights reserved.
//

// 测试注释

#import "EOCRectangle.h"

@implementation EOCRectangle

- (instancetype)init {
    return [self initWithWidth:0.5 andHeight:0.5];
}

- (instancetype)initWithWidth:(float)aWidth andHeight:(float)aHeight {
    if(self = [super init]) {
        _width = aWidth;
        _height = aHeight;
    }
    return self;
}
@end
