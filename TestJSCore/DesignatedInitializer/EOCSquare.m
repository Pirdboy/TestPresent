//
//  EOCSquare.m
//  TestJSCore
//
//  Created by pirdboy on 2018/2/12.
//  Copyright © 2018年 CMB. All rights reserved.
//

// 测试注释

#import "EOCSquare.h"

@implementation EOCSquare

- (instancetype)initWithDimension:(float)dimension {
    return [super initWithWidth:dimension andHeight:dimension];
}

// 为防止调用父类的initWithWidth导致不正确的初始化, 需进行覆盖
- (instancetype)initWithWidth:(float)aWidth andHeight:(float)aHeight {
//    float dimension = MAX(aWidth, aHeight);
//    return [self initWithDimension:dimension];
    
    // 有时对于这种调用需要抛出错误
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Must use initWithDimension: instead." userInfo:nil];
}
@end
