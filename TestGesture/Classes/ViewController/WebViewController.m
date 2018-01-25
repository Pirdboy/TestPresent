//
//  WebViewController.m
//  TestGesture
//
//  Created by pirdboy on 2018/1/24.
//  Copyright © 2018年 CMB. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import "Masonry.h"
#import "PDWebView.h"

@interface WebViewController ()
@property (nonatomic, strong) PDWebView *webView;
@property (nonatomic, copy) NSString *urlString;

@end

@implementation WebViewController

- (instancetype)initWithURLString:(NSString *)urlString {
    self = [super init];
    if(self) {
        _urlString = urlString;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _webView = [[PDWebView alloc] init];
    if(@available(iOS 11.0, *)) {
        _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSURL *url = [NSURL URLWithString:_urlString];
    NSURLRequest *re = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:re];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
}

- (void)dealloc {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
