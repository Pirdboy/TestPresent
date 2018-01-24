//
//  ViewController.m
//  TestScrollView
//
//  Created by pirdboy on 2018/1/19.
//  Copyright © 2018年 CMB. All rights reserved.
//

#import "ViewController.h"
#import "PDWebView.h"
#import "PDScrollView.h"

#define TestLoop

float r() {
    uint32_t a = arc4random_uniform(1000);
    a %= 255;
    return (float)a*1.0;
}

@interface ViewController ()<UIScrollViewDelegate, UIWebViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) PDWebView *webView;
@property (nonatomic, strong) PDScrollView *innerScrollView;
@property (nonatomic, strong) PDScrollView *outerScrollView;

@property (nonatomic, strong) NSArray<UIView *> *views;

@property (nonatomic, strong) UIButton *button1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    
    _button1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 700, 100, 30)];
    [_button1 setTitle:@"LeftItem" forState:UIControlStateNormal];
    [_button1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:_button1];
    
    _webView = [[PDWebView alloc] init];
    _innerScrollView = [[PDScrollView alloc] init];
    _outerScrollView = [[PDScrollView alloc] init];
    _outerScrollView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    UIView *view1 = [[UIView alloc] init];

    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor colorWithRed:r()/255.0 green:r()/255.0 blue:r()/255.0 alpha:1.0];
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor colorWithRed:r()/255.0 green:r()/255.0 blue:r()/255.0 alpha:1.0];
    UIView *view4 = [[UIView alloc] init];
    view4.backgroundColor = [UIColor colorWithRed:r()/255.0 green:r()/255.0 blue:r()/255.0 alpha:1.0];
    
    UIView *view5 = [[UIView alloc] init];

    view1.backgroundColor = view4.backgroundColor;
    view5.backgroundColor = view2.backgroundColor;
    
    _views = @[view1,view2,view3,view4,view5];
    
    [self.view addSubview:_outerScrollView];
    
    UIButton *btn = [[UIButton alloc] init];
    
    [btn setTitle:@"断点" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_outerScrollView addSubview:_innerScrollView];
    [_outerScrollView addSubview:_webView];
    [_outerScrollView addSubview:btn];
    btn.frame = CGRectMake(20+320, 310, 100, 30);
    
    CGFloat startX = 0, startY = 100;
    _outerScrollView.frame = (CGRect){startX, startY, 320, 400};
    _innerScrollView.frame = (CGRect){0, 0, 320, 300};
    _webView.frame = (CGRect){320, 0, 320, 300};
    
    for (int i=0; i<_views.count; ++i) {
        UILabel *label = [[UILabel alloc] init];
        
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor blackColor];
        if(i==0) {
            label.text = [NSString stringWithFormat:@"%d",3];
        } else if(i == _views.count-1) {
            label.text = [NSString stringWithFormat:@"%d",1];
        } else {
            label.text = [NSString stringWithFormat:@"%d",i];
        }
        label.frame = CGRectMake(30, 30, 40, 40);
        UIView *v = _views[i];
        [v addSubview:label];
        v.frame = (CGRect){30,30,30,30};
        [_innerScrollView addSubview:v];
        v.frame = (CGRect){i*320, 0, 320, 300};
    }
    
    _outerScrollView.contentSize = (CGSize){320+320, 400};
    _outerScrollView.pagingEnabled = YES;
    _innerScrollView.contentSize = (CGSize){320*5, 300};
    
    _innerScrollView.contentOffset = CGPointMake(320, 0);
    _innerScrollView.delegate = self;
    
    
    [_outerScrollView addObserver:self forKeyPath:@"panGestureRecognizer.state" options:NSKeyValueObservingOptionNew context:nil];
    [_webView.scrollView addObserver:self forKeyPath:@"panGestureRecognizer.state" options:NSKeyValueObservingOptionNew context:nil];
    
    [_innerScrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
    [_outerScrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
    
    // 循环滚动
#ifdef TestLoop
    _innerScrollView.bounces = NO;
    _innerScrollView.showsHorizontalScrollIndicator = NO;
    _innerScrollView.pagingEnabled = YES;
#endif
    // 测试非循环
//    _innerScrollView.bounces = NO;
    
    // 测试禁止外部滚动
    [_outerScrollView setContentOffset:CGPointMake(320, 0)];
//    _outerScrollView.scrollEnabled = NO;
//    _webView.scrollView.scrollEnabled = NO;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    [self.navigationController.navigationBar setBackgroundImage:[self imageWithSize:(CGSize){375,88} color:[UIColor redColor]] forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];

    NSURLRequest *re = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://ai.cmbchina.com/mbf4infoweb/CmbReferNewsDiscovery.html"]];
    [_webView loadRequest:re];
    NSLog(@"nav:%@",self.navigationController.interactivePopGestureRecognizer);

    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"");
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
#ifdef TestLoop
    CGPoint offset = scrollView.contentOffset;
    int index = offset.x / 320;
    if(index == 0) {
        index = 3;
    } else if(index == 4) {
        index = 1;
    }
    [scrollView setContentOffset:CGPointMake(320*index, 0) animated:NO];
#endif

}

#pragma mark - Gesture Recognize Delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//
//}
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//
//}
#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if(object == _webView.scrollView && [keyPath isEqualToString:@"panGestureRecognizer.state"]) {
        NSValue *value = change[NSKeyValueChangeNewKey];
        NSInteger state;
        [value getValue:&state];
        NSLog(@"测试. webView gesture state:%@",[self stateFromCode:state]);
    } else if(object == _outerScrollView && [keyPath isEqualToString:@"panGestureRecognizer.state"]) {
        NSValue *value = change[NSKeyValueChangeNewKey];
        NSInteger state;
        [value getValue:&state];
        NSLog(@"测试. outerScrollView gesture state:%@",[self stateFromCode:state]);
    }
}

- (NSString *)stateFromCode:(NSInteger)code {
    switch (code) {
        case UIGestureRecognizerStatePossible:
            return @"possible";
        case UIGestureRecognizerStateBegan:
            return @"began";
        case UIGestureRecognizerStateChanged:
            return @"changed";
        case UIGestureRecognizerStateEnded:
            return @"ended";
        case UIGestureRecognizerStateCancelled:
            return @"cancelled";
        case UIGestureRecognizerStateFailed:
            return @"failed";
        default:
            return @"none";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

static int flag=0;
- (void)btnClick:(id)sender {
    if(sender == _button1) {
        self.navigationItem.hidesBackButton = YES;
        return;
    }
    
    NSLog(@"webview:\n%@",[_webView subviews]);
    NSLog(@"================");
    for (UIView *v in [_webView subviews]) {
        NSLog(@"%@",v);
    }
    NSLog(@"");
    [_webView goBack];
    
    if(flag%2==0) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self.navigationItem setHidesBackButton:NO animated:YES];
    } else {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    flag++;
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

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"action1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {

    }];
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"action2" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"action2");
    }];
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"取消" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"action3");
    }];
    UIPreviewActionGroup *actionGroup = [UIPreviewActionGroup actionGroupWithTitle:@"选项组" style:UIPreviewActionStyleDefault actions:@[action1, action2]];
    NSArray *array = @[action1, action2, action3,actionGroup];
    return array;
}
@end
