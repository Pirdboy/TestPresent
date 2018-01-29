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
#import "UIImage+Addtions.h"
#import "ViewController.h"

@interface MultiWebViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) PDScrollView *scrollView;
@property (nonatomic, strong) WebViewController *webVC1;
@property (nonatomic, strong) WebViewController *webVC2;
@property (nonatomic, strong) WebViewController *webVC3;
@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic, assign) CGFloat screenHeight;
@property (nonatomic, assign) CGFloat navHeight;


@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIButton *button4;
@property (nonatomic, strong) UIButton *button5;
@property (nonatomic, strong) UIButton *button6;

@property (nonatomic, strong) UIButton *button7;

@end

@implementation MultiWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    _screenWidth = [UIScreen mainScreen].bounds.size.width;
    _screenHeight = [UIScreen mainScreen].bounds.size.height;
    _navHeight = 88.0f;
    
    _scrollView = [[PDScrollView alloc] init];
    [self.view addSubview:_scrollView];
    NSString *str1 = @"https://ai.cmbchina.com/mbf4infoweb/CmbReferNewsDiscovery.html";
    NSString *str2 = @"https://ai.cmbchina.com/mbf4infoweb/CmbReferNewsRecInfo.html";
    NSString *str3 = @"https://www.baidu.com";
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
    if(@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    _scrollView.bounces = NO;
    
    _button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    _button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    _button3 = [UIButton buttonWithType:UIButtonTypeSystem];
    _button4 = [UIButton buttonWithType:UIButtonTypeSystem];
    _button5 = [UIButton buttonWithType:UIButtonTypeSystem];
    _button6 = [UIButton buttonWithType:UIButtonTypeSystem];
    _button7 = [UIButton buttonWithType:UIButtonTypeSystem];
    [_button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_button3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_button4 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_button5 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_button6 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_button7 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_button1 setTitle:@"Back" forState:UIControlStateNormal];
    [_button2 setTitle:@"show NavBar" forState:UIControlStateNormal];
    [_button3 setTitle:@"hide NavBar" forState:UIControlStateNormal];
    [_button4 setTitle:@"Back animate" forState:UIControlStateNormal];
    [_button5 setTitle:@"show NavBar animate" forState:UIControlStateNormal];
    [_button6 setTitle:@"hide NavBar animate" forState:UIControlStateNormal];
    [_button7 setTitle:@"push Next" forState:UIControlStateNormal];
    [_button1 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_button1 addTarget:self action:@selector(btnClicked2:) forControlEvents:UIControlEventTouchUpInside];
    [_button2 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_button3 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_button4 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_button5 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_button6 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_button7 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button1];
    [self.view addSubview:_button2];
    [self.view addSubview:_button3];
    [self.view addSubview:_button4];
    [self.view addSubview:_button5];
    [self.view addSubview:_button6];
    [self.view addSubview:_button7];
    /* 当该界面被push animated:NO时,可能不会更新约束,需要标记需要更新约束 */
    [self.view setNeedsUpdateConstraints];
    
    // 当用了3D touch 弹出界面时,interactivePopGestureRecognizer为nil导致闪退,建议通过继承scrollView来设置手势优先级
//    NSLog(@"%@",self.navigationController.interactivePopGestureRecognizer);
//    [_scrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
}
- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}

- (void)updateViewConstraints {
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-88);
    }];
    [_webVC1.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scrollView);
        make.left.mas_equalTo(_scrollView);
        make.bottom.mas_equalTo(_scrollView);
        make.right.mas_equalTo(_webVC2.view.mas_left);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).offset(-88);
    }];
    [_webVC2.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scrollView);
        make.bottom.mas_equalTo(_scrollView);
        make.right.mas_equalTo(_webVC3.view.mas_left);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).offset(-88);
    }];
    [_webVC3.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scrollView);
        make.bottom.mas_equalTo(_scrollView);
        make.right.mas_equalTo(_scrollView);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).offset(-88);
    }];
    [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scrollView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
    }];
    [_button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scrollView.mas_bottom).offset(10);
        make.left.mas_equalTo(_button1.mas_right).offset(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
    }];
    [_button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scrollView.mas_bottom).offset(10);
        make.left.mas_equalTo(_button2.mas_right).offset(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
    }];
    [_button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scrollView.mas_bottom).offset(10);
        make.left.mas_equalTo(_button3.mas_right).offset(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
    }];
    [_button5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scrollView.mas_bottom).offset(10);
        make.left.mas_equalTo(_button4.mas_right).offset(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
    }];
    [_button6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scrollView.mas_bottom).offset(10);
        make.left.mas_equalTo(_button5.mas_right).offset(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
    }];
    [_button7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_button6.mas_bottom).offset(10);
        make.left.mas_equalTo(_button5.mas_right).offset(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
    }];
    [super updateViewConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithSize:(CGSize){20,40} color:[UIColor blueColor]] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"滚动视图大小%@",NSStringFromCGSize(_scrollView.contentSize));
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithSize:(CGSize){20,40} color:[UIColor greenColor]] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)btnClicked2:(UIButton *)btn2 {
    NSLog(@"另一个点击事件");
}

- (void)btnClicked:(UIButton *)btn {
    id ges = self.navigationController.interactivePopGestureRecognizer;
    id delg = self.navigationController.interactivePopGestureRecognizer.delegate;
    if([delg respondsToSelector:@selector(gestureRecognizerShouldBegin:)]) {
        BOOL ok = [delg gestureRecognizerShouldBegin:ges];
        NSLog(@"%@",ok?@"Yes":@"No");
    }
    
    //bannerContainer
    NSString *prevent = @"document.getElementById(\"bannerContainer\").addEventListener(\'touchmove\', function (e) { e.preventDefault(); }, false);";
    [_webVC1.webView evaluateJavaScript:prevent completionHandler:nil];
    if(btn == _button1) {
        [self.navigationController popViewControllerAnimated:NO];
    } else if(btn == _button2) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    } else if(btn == _button3) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    } else if(btn == _button4) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if(btn == _button5) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    } else if(btn == _button6) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    } else if(btn == _button7) {
        ViewController *vc = [[ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    NSLog(@"Nav手势delegate:%@",[self.navigationController interactivePopGestureRecognizer].delegate);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
