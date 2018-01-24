//
//  main.m
//  MethodTest
//
//  Created by pirdboy on 2018/1/22.
//  Copyright © 2018年 CMB. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        NSString *str = @"2";
        NSRange range = [str rangeOfString:@"^[0-2]$" options:NSRegularExpressionSearch];
        if(range.location != NSNotFound) {
            NSLog(@"%@",NSStringFromRange(range));
        } else {
            NSLog(@"Not found");
        }
    }
    return 0;
}
