//
//  ViewController.m
//  TestGesture
//
//  Created by pirdboy on 2018/1/24.
//  Copyright © 2018年 CMB. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "MultiWebViewController.h"
#import "UIImage+Addtions.h"
#import "MyNavigationController.h"

@interface ViewController ()<UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) UIButton *pushBtn;
@property (nonatomic, strong) UIButton *popBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _pushBtn = [UIButton buttonWithType:UIButtonTypeSystem];  // Custom类型没有高亮时的渐变动画
    [_pushBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_pushBtn setTitleColor:[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.5] forState:UIControlStateHighlighted];
    [_pushBtn setTitle:@"PUSH" forState:UIControlStateNormal];
    [_pushBtn setTitle:@"push" forState:UIControlStateHighlighted];
    [self.view addSubview:_pushBtn];
    [_pushBtn addTarget:self action:@selector(pushViewController:) forControlEvents:UIControlEventTouchUpInside];

    
    _popBtn = [UIButton buttonWithType:UIButtonTypeSystem];  // Custom类型没有高亮时的渐变动画
    [_popBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_popBtn setTitleColor:[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.5] forState:UIControlStateHighlighted];
    [_popBtn setTitle:@"POP" forState:UIControlStateNormal];
    [_popBtn setTitle:@"pop" forState:UIControlStateHighlighted];
    [self.view addSubview:_popBtn];
    [_popBtn addTarget:self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
    
    [self registerForPreviewingWithDelegate:self sourceView:self.view];
}
- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithSize:(CGSize){20,40} color:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)updateViewConstraints {
    [_pushBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@40);
        make.top.mas_equalTo(self.mas_topLayoutGuide).offset(20.f);
        make.left.mas_equalTo(self.view).offset(20.f);
    }];
    [_popBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_pushBtn.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view).offset(20.f);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@40);
    }];
    
    [super updateViewConstraints];
}

- (void)pushViewController:(id)sender {
    MultiWebViewController *mvc = [[MultiWebViewController alloc] init];
    MyNavigationController *nav2 = [[MyNavigationController alloc] initWithRootViewController:mvc];
    nav2.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController pushViewController:mvc animated:YES];
//    [self presentViewController:nav2 animated:NO completion:nil];
}
- (void)pop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - 3dtouch
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    MultiWebViewController *mvc = [[MultiWebViewController alloc] init];
    mvc.preferredContentSize = CGSizeMake(300, 400);
    previewingContext.sourceRect = (CGRect){10, location.y-10, 375, 20};
    return mvc;
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self.navigationController showViewController:viewControllerToCommit sender:self];
}


@end
