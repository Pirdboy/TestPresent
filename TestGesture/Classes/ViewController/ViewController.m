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

@interface ViewController ()

@property (nonatomic, strong) UIButton *pushBtn;
@property (nonatomic, strong) UIProgressView *progressView;
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
    
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    [self.view addSubview:_progressView];
    [_progressView setProgress:0.3];
    [_progressView setProgressTintColor:[UIColor blueColor]];
    [_progressView setTrackTintColor:[UIColor grayColor]];
    
}
- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mas_topLayoutGuide);
        make.left.mas_equalTo(self.view);
    }];
    
    [super updateViewConstraints];
}

- (void)pushViewController:(id)sender {
    MultiWebViewController *mvc = [[MultiWebViewController alloc] init];
    [self.navigationController pushViewController:mvc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
