//
//  QRScanManager.m
//  MPBBank-Vista
//
//  Created by pirdboy on 2017/7/3.
//
//

#import "QRScanManager.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
//#import <ZXingObjC/ZXingObjC.h>

enum CameraPosition {
    CameraPositionBack = 1,
    CameraPositionFront = 2,
};

@interface QRScanManager ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) dispatch_queue_t captureQueue;
@property (nonatomic, strong) AVCaptureMetadataOutput *metaOutput;
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *layer;
//@property (nonatomic, strong) ZXCapture *zxCapture;

@property (nonatomic, assign) int camera;
@property (nonatomic, assign) BOOL torch;

@end

@implementation QRScanManager

- (instancetype)init {
    self = [super init];
    if(self){
        _captureQueue = dispatch_queue_create("com.cmbchina.qrcapture", NULL);
        _camera = 1;
        _torch = NO;
        
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        [_device lockForConfiguration:nil];
        [_device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        [_device setAutoFocusRangeRestriction:AVCaptureAutoFocusRangeRestrictionNear];
        [_device unlockForConfiguration];
        
        _deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:_device error:nil];
        _metaOutput = [[AVCaptureMetadataOutput alloc] init];
        [_metaOutput setMetadataObjectsDelegate:self queue:_captureQueue];
        
        _session = [[AVCaptureSession alloc] init];
        [_session beginConfiguration];
        [_session addInput:_deviceInput];
        [_session addOutput:_metaOutput];
        [_session setSessionPreset:AVCaptureSessionPreset1280x720];
        [_session commitConfiguration];
        
        NSMutableArray *types = [NSMutableArray
                                 arrayWithObjects:AVMetadataObjectTypeQRCode,
                                 AVMetadataObjectTypeDataMatrixCode,
                                 AVMetadataObjectTypeAztecCode,
                                 
                                 AVMetadataObjectTypeEAN8Code,
                                 AVMetadataObjectTypeEAN13Code,
                                 AVMetadataObjectTypeCode128Code,
                                 AVMetadataObjectTypeUPCECode,
                                 AVMetadataObjectTypePDF417Code,
                                 AVMetadataObjectTypeInterleaved2of5Code,
                                 AVMetadataObjectTypeCode39Code,
                                 AVMetadataObjectTypeCode93Code,
                                 AVMetadataObjectTypeITF14Code,nil];
        // 确保上面的格式可用后再加入到metadataObjectTypes,如果有不支持的格式加入会导致程序崩溃
        for (int i=0;i<[types count]; i++) {
            if(![_metaOutput.availableMetadataObjectTypes containsObject:types[i]]) {
                [types removeObjectAtIndex:i];
            }
        }
        _metaOutput.metadataObjectTypes = types;
        
        _layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
        _layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _layer.frame = [[UIScreen mainScreen] bounds];
    }
    return self;
}


#pragma mark -
#pragma mark - public Methods

- (void)start {
    if(!_session.running) {
        [_session startRunning];
    }
}
- (void)startWithVC:(UIViewController *)vc {
    [vc.view.layer addSublayer:_layer];
    if(!_session.running) {
        [_session startRunning];
    }
}
- (void)stop {
    if(_session.running) {
        [_session stopRunning];
    }
}
- (AVCaptureVideoPreviewLayer *)layer {
    return _layer;
}

#pragma mark -
#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if(metadataObjects.count > 0 )
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        NSString *text = metadataObject.stringValue;
        NSLog(@"stringValue:%@",text);
        
    }
}

#pragma mark -
#pragma mark - dealloc

- (void)dealloc {
    
}

@end
