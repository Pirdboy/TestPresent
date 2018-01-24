//
//  PaintView.m
//  TestPresent
//
//  Created by pirdboy on 2017/12/15.
//  Copyright © 2017年 CMB. All rights reserved.
//

#import "PaintView.h"

@implementation PaintView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    /*
    设备空间与用户空间的概念，可理解为两张纸，设备空间为一张纸，固定着不动，代表着屏幕；用户空间也是一张纸，实际绘图在用户空间这张纸上画，但最终需要贴到设备空间那张纸上，怎么贴就是CTM描述的问题，我可能将用户空间的纸平移一些距离再贴，也可能放大缩小一些再贴，也可能旋转一定的角度再贴。用户空间的纸对应与绘画过程中的每一page,不同的page可能用不同的用户空间，即每次绘制时的CTM可能都不一样。
     */
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    /* 绘制背景色 */
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextFillRect(context, rect);
    
    
//    CGContextMoveToPoint(context, 0, 0);
//    CGContextAddLineToPoint(context, 100, 100);
//
//    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
//    CGContextStrokePath(context);
    
    
    /* 这些变化都会先将坐标移到原点再执行 */
    CGContextTranslateCTM(context, 100, 100);
    CGContextScaleCTM(context, 1, -1.0);
    CGContextRotateCTM(context, -45.0/180.0 * M_PI);  // 负数表示逆时针
    
    /* rotate时,负数表示顺时针,但当前context由UIKit产生经过翻转处理,原来的顺时针就变成了逆时针,所以需要用正数才能顺时针 */
    /* 仿射变换,平移和旋转顺序不同,会产生不同结果 */
//    CGAffineTransform t1 = CGAffineTransformMakeTranslation(100, 100);
//    CGAffineTransform t2 = CGAffineTransformMakeRotation(45.0/180.0 * M_PI);
//    CGContextConcatCTM(context, CGAffineTransformConcat(t1, t2));
    // 顺时针和逆时针可能会由于坐标翻转发生变化, 具体使用前先测试
    
    UIImage *img = [UIImage imageNamed:@"phone"];
    CGContextClipToMask(context, (CGRect){100,100,100,100}, [img CGImage]);
//    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillRect(context, (CGRect){100,100,100,100});
    CGContextClip(context);
}


@end
