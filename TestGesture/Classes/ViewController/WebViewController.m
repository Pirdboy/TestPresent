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


@interface WebViewController ()<WKNavigationDelegate>
//@property (nonatomic, strong) PDWebView *webView;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, assign) BOOL loaded;

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
    _loaded = NO;
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
    _webView.navigationDelegate = self;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if(!_loaded) {
        NSURL *url = [NSURL URLWithString:_urlString];
        NSURLRequest *re = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:re];
        _loaded = YES;
    }
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

#pragma mark -
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    NSString *prevent = @"document.addEventListener(\'touchmove\', function (e) { e.preventDefault(); }, false);alert(\'注入JS\');";
//    [webView evaluateJavaScript:prevent completionHandler:nil];
}

@end
