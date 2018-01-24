//
//  UIImage+Color.h
//  MPBBank-Vista
//
//  Created by liuliang on 16/8/17.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

- (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageNamed:(NSString *)name WithColor:(UIColor *)color;
+ (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color;

@end
