//
//  ViewController.m
//  TestJSCore
//
//  Created by pirdboy on 2018/2/7.
//  Copyright © 2018年 CMB. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "XMLDictionary.h"
#import <objc/runtime.h>
#import <objc/objc.h>

@protocol MultiWebPageSwitch <JSExport>

JSExportAs
(setTopBarButton,
 - (void)setTopBar:(id)btn1 aautton:(id)str2);


@end


@interface ViewController ()
<
UIWebViewDelegate,MultiWebPageSwitch
>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIWebView *webView2;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) JSContext *context2;

@property (nonatomic, strong) NSMutableDictionary<NSString *,JSBlock> *handler;
@end

@implementation ViewController

- (void)viewDidLoad {
    _handler = [NSMutableDictionary dictionary];
    [super viewDidLoad];

    _webView.delegate = self;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *re = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:re];
    
//    _webView2.delegate = self;
//    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"test2" ofType:@"html"];
//    NSURL *url2 = [NSURL fileURLWithPath:path2];
//    NSURLRequest *re2 = [NSURLRequest requestWithURL:url2];
//    [_webView2 loadRequest:re2];
    
//    NSString *path3 = [[NSBundle mainBundle] pathForResource:@"xmlconfig" ofType:@"xml"];
//    NSString *xmlStr = [[NSString alloc] initWithContentsOfFile:path3 encoding:NSUTF8StringEncoding error:NULL];
//
//    XMLDictionaryParser *parser = [XMLDictionaryParser sharedInstance];
//    NSDictionary *xmlDict = [parser dictionaryWithString:xmlStr];
//    NSLog(@"%@",xmlDict);
    JSContext *context2 = [_webView2 valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    _context2 = context2;
    context2[@"MultiWebPageSwitch"] = self;
    [context2 evaluateScript:@"window.MultiWebPageSwitch=MultiWebPageSwitch"];
    

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    // 重定向时获取JSContext仍然为上一次的context
    
    if(webView == _webView) {
        [self registerJSFunctionName:@"window.MultiWebPageSwitch.method2" block:^(UIWebView *webView, UIViewController *viewController, NSArray *args, NSError *error) {
            NSLog(@"获得的参数:%@",args);
        }];
        
        [self registerJSFunctionName:@"method2" block:^(UIWebView *webView, UIViewController *viewController, NSArray *args, NSError *error) {
            NSLog(@"method2获得的参数:%@",args);
        }];
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {

}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if(webView == _webView) {
        [self registerJSFunctionName:@"window.MultiWebPageSwitch.method2" block:^(UIWebView *webView, UIViewController *viewController, NSArray *args, NSError *error) {
            NSLog(@"获得的参数:%@",args);
        }];
        
        [self registerJSFunctionName:@"method2" block:^(UIWebView *webView, UIViewController *viewController, NSArray *args, NSError *error) {
            NSLog(@"method2获得的参数:%@",args);
        }];
    }
}

#pragma mark - 注册JS调用原生方法
- (void)registerJSFunctionName:(NSString *)jsFunctionName block:(JSBlock)block {
    
    NSArray *components = [jsFunctionName componentsSeparatedByString:@"."];
    
    NSString *jsName = @"";
    for(uint i=0;i<components.count;i++) {
        if(i > 0) {
            jsName = [jsName stringByAppendingString:[NSString stringWithFormat:@".%@",components[i]]];
        } else {
            jsName = [components[i] copy];
        }
        NSLog(@"当前jsName:%@",jsName);
        [self writeJSObject:jsName];
    }
    _handler[jsFunctionName] = [block copy];
    JSContext *context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *tempName = @"objInner";
    context[tempName] = ^(){
        NSArray<JSValue *> *args = [JSContext currentArguments];
        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:args.count];
        for(JSValue *value in args) {
            [mArray addObject:[value toObject]];
        }
        JSBlock block = _handler[jsFunctionName];
        dispatch_async(dispatch_get_main_queue(), ^{
            block(_webView,self,mArray,nil);
        });
        
    };
    NSString *str = [NSString stringWithFormat:@"%@=%@;delete(%@)",jsFunctionName,tempName,tempName];
    [context evaluateScript:str];
}

- (void)writeJSObject:(NSString *)name {
    JSContext *context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    JSValue *value = [context evaluateScript:name];
    id obj = [value toObject];
    if([obj isKindOfClass:[NSNull class]] || obj == nil) {
        [context evaluateScript:[NSString stringWithFormat:@"%@ = {}",name]];
    }
}

#pragma mark - 测试
- (void)setTopBar:(id)btn1 aautton:(id)str2 {
    JSContext *context = [JSContext currentContext];
    NSArray *args = [JSContext currentArguments];
    if(context == _context2) {
        NSLog(@"2222");
    }
    NSLog(@"设置按钮1:%@",btn1);
    NSLog(@"设置按钮2:%@",str2);
}

- (void)goTopBar:(NSString *)left Button:(NSString *)right {
    NSLog(@"新方法left:%@",left);
    NSLog(@"新方法right:%@",right);
}

@end
