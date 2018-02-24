//
//  EOCAutoDictionary.m
//  TestJSCore
//
//  Created by pirdboy on 2018/2/12.
//  Copyright © 2018年 CMB. All rights reserved.
//

// 测试注释

#import "EOCAutoDictionary.h"
#import <objc/runtime.h>

void autoDictionarySetter(id self, SEL _cmd, id value) {
    
}

id autoDictionaryGetter(id self, SEL _cmd) {
    return self;
}


@interface EOCAutoDictionary ()
@property (nonatomic, strong) NSMutableDictionary *backingStore;

@end

@implementation EOCAutoDictionary

@dynamic string, number, date, opaqueObject;


- (instancetype)init {
    if((self = [super init])) {
        _backingStore = [NSMutableDictionary new];
    }
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *str = NSStringFromSelector(sel);
//    if([str hasPrefix:@"set"]) {
//        class_addMethod(self, sel, (IMP)autoDictionarySetter, "v@:@");
//    } else {
//        class_addMethod(self, sel, (IMP)autoDictionaryGetter, "@@:");
//    }
    return [super resolveInstanceMethod:sel];
}


//
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return nil;
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"");
}
@end
