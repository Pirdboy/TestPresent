//
//  EOCRectangle.h
//  TestJSCore
//
//  Created by pirdboy on 2018/2/12.
//  Copyright © 2018年 CMB. All rights reserved.
//

// 测试注释

// 测试注释// 测试注释

#import <Foundation/Foundation.h>

@interface EOCRectangle : NSObject

@property (nonatomic, assign, readonly) float width;
@property (nonatomic, assign, readonly) float height;

- (instancetype)initWithWidth:(float)aWidth andHeight:(float)aHeight NS_DESIGNATED_INITIALIZER;

@end
