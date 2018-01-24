//
//  MultiWebViewController.m
//  TestGesture
//
//  Created by pirdboy on 2018/1/24.
//  Copyright © 2018年 CMB. All rights reserved.
//

#import "MultiWebViewController.h"
#import "PDScrollView.h"
#import "WebViewController.h"
#import "Masonry.h"

@interface MultiWebViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) PDScrollView *scrollView;
@property (nonatomic, strong) WebViewController *webVC1;
@property (nonatomic, strong) WebViewController *webVC2;
@property (nonatomic, strong) WebViewController *webVC3;
@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic, assign) CGFloat screenHeight;
@property (nonatomic, assign) CGFloat navHeight;

@end

@implementation MultiWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _screenWidth = [UIScreen mainScreen].bounds.size.width;
    _screenHeight = [UIScreen mainScreen].bounds.size.height;
    _navHeight = 88.0f;
    
    _scrollView = [[PDScrollView alloc] init];
    [self.view addSubview:_scrollView];
    NSString *str1 = @"https://ai.cmbchina.com/mbf4infoweb/CmbReferNewsDiscovery.html";
    NSString *str2 = @"https://github.com";
    NSString *str3 = @"https://ai.cmbchina.com/mbf4infoweb/CmbReferNewsRecInfo.html";
    _webVC1 = [[WebViewController alloc] initWithURLString:str1];
    _webVC2 = [[WebViewController alloc] initWithURLString:str2];
    _webVC3 = [[WebViewController alloc] initWithURLString:str3];
    
    [self addChildViewController:_webVC1];
    [_scrollView addSubview:_webVC1.view];
    [_webVC1 didMoveToParentViewController:self];
    
    [self addChildViewController:_webVC2];
    [_scrollView addSubview:_webVC2.view];
    [_webVC2 didMoveToParentViewController:self];
    
    [self addChildViewController:_webVC3];
    [_scrollView addSubview:_webVC3.view];
    [_webVC3 didMoveToParentViewController:self];
    
    _scrollView.pagingEnabled = YES;
    _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
}
- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}

- (void)updateViewConstraints {
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(self.view);
    }];
    [_webVC1.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scrollView);
        make.left.mas_equalTo(_scrollView);
        make.bottom.mas_equalTo(_scrollView);
        make.right.mas_equalTo(_webVC2.view.mas_left);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view);
    }];
    [_webVC2.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scrollView);
        make.bottom.mas_equalTo(_scrollView);
        make.right.mas_equalTo(_webVC3.view.mas_left);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view);
    }];
    [_webVC3.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scrollView);
        make.bottom.mas_equalTo(_scrollView);
        make.right.mas_equalTo(_scrollView);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view);
    }];
    
    [super updateViewConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"滚动视图大小%@",NSStringFromCGSize(_scrollView.contentSize));
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
