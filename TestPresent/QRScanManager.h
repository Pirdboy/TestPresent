//
//  QRScanManager.h
//  MPBBank-Vista
//
//  Created by pirdboy on 2017/7/3.
//
//

#import <Foundation/Foundation.h>

@class AVCaptureVideoPreviewLayer;
@class UIViewController;

@interface QRScanManager : NSObject

- (instancetype)init;


/**
 开始扫描
 */
- (void)start;

- (void)startWithVC:(UIViewController *)vc;

/**
 停止扫描
 */
- (void)stop;

/**
 使用前置或者后置摄像头,默认为后置
 
 @param camera 1:后置,2:前置
 */
- (void)setCamera:(int)camera;

/**
 打开灯光,默认关闭
 
 @param torch YES/NO
 */
- (void)setTorch:(BOOL)torch;

- (AVCaptureVideoPreviewLayer *)layer;

@end
