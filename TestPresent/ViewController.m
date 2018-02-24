//
//  ViewController.m
//  TestPresent
//
//  Created by pirdboy on 2017/6/22.
//  Copyright © 2017年 CMB. All rights reserved.
//

#import "ViewController.h"
#import "QRScanManager.h"
#import "UIImage+Resize.h"
#import "UIImage+ImageEffects.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIVisualEffectView *visualView;
@property (strong, nonatomic) UIImageView *imageView2;
@property (strong, nonatomic) UIToolbar *toolBar;

@property (nonatomic, strong) QRScanManager *scanManager;
@property (nonatomic, strong) UIImage *image;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _image = [UIImage imageNamed:@"banner2"];
    _imageView.image = _image;
    CGRect frame = _imageView.frame;
    _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 44)];
    UIImage *image = [self imageWithSize:CGSizeMake(frame.size.width, 44) color:[UIColor grayColor]];
    image = [image imgWithBlur];
    [_imageView2 setImage:image];
    
    [self stretchImageView:_imageView];
    
    
    _visualView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];

    _visualView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 44);
    [self.view addSubview:_visualView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.view.layer addSublayer:_scanManager.layer];
//    [_scanManager startWithVC:self];
}

- (void)stretchImageView:(UIImageView *)imageView {
    UIImage *image = imageView.image;
    NSLog(@"size1:%@",NSStringFromCGSize(image.size));
    NSLog(@"frame:%@",NSStringFromCGRect(imageView.frame));
    
    CGFloat scale = image.size.width / imageView.frame.size.width;
    UIImage *newImage1 = [[UIImage alloc] initWithCGImage:image.CGImage scale:scale orientation:image.imageOrientation];
    
    UIImage *newImage = [newImage1 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, image.size.height-1, 0) resizingMode:UIImageResizingModeStretch];
    NSLog(@"size2:%@",NSStringFromCGSize(newImage.size));
    [imageView setImage:newImage];
    
}
- (IBAction)action1:(id)sender {
}
- (IBAction)connectToHost:(id)sender {
}

#pragma mark -
#pragma mark - UIGraphics Test

- (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color {
    if(!color || CGSizeEqualToSize(size, CGSizeZero)) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(size, YES, 2.0);
    [color setFill];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)image:(UIImage *)image withColor:(UIColor *)color {
    
    return nil;
}

#pragma mark -
#pragma mark - memory warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
