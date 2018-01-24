//
//  ViewController2.m
//  TestScrollView
//
//  Created by pirdboy on 2018/1/22.
//  Copyright © 2018年 CMB. All rights reserved.
//

////////////////////////////////////////////////////////////////////
//							_ooOoo_								  //
//						   o8888888o							  //	
//						   88" . "88							  //	
//						   (| ^_^ |)							  //	
//						   O\  =  /O							  //
//						____/`---'\____							  //						
//					  .'  \\|     |//  `.						  //
//					 /  \\|||  :  |||//  \						  //	
//				    /  _||||| -:- |||||-  \						  //
//				    |   | \\\  -  /// |   |						  //
//					| \_|  ''\---/''  |   |						  //		
//					\  .-\__  `-`  ___/-. /						  //		
//				  ___`. .'  /--.--\  `. . ___					  //	
//				."" '<  `.___\_<|>_/___.'  >'"".				  //
//			  | | :  `- \`.;`\ _ /`;.`/ - ` : | |				  //	
//			  \  \ `-.   \_ __\ /__ _/   .-` /  /                 //
//		========`-.____`-.___\_____/___.-`____.-'========		  //	
//				             `=---='                              //
//		^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        //
//         佛祖保佑       永无BUG		永不修改				  //
////////////////////////////////////////////////////////////////////
#import "ViewController2.h"
#import "ViewController.h"

@interface ViewController2 ()<UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController2

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self registerForPreviewingWithDelegate:self sourceView:self.view];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithSize:(CGSize){375,88} color:[UIColor yellowColor]] forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color
{
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

#pragma mark - previewing delegate

-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *vc = [sb instantiateViewControllerWithIdentifier:@"VC"];
    vc.preferredContentSize = CGSizeMake(0.0f, 400);
    previewingContext.sourceRect = (CGRect){10, location.y - 10, self.view.frame.size.width-20,20};
    return vc;
}
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
//    [self.navigationController pushViewController:viewControllerToCommit animated:YES];
    [self.navigationController showViewController:viewControllerToCommit sender:self];
}


@end
