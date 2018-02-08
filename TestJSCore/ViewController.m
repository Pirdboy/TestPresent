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

//JSExportAs
//(setTopBarButton,
// - (void)setTopBar:(NSString *)btn1 aautton:(NSString *)str2);


@end


@interface ViewController ()
<
UIWebViewDelegate,MultiWebPageSwitch
>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIWebView *webView2;
@property (nonatomic, strong) UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testRuntimeProtocol];
    _webView.delegate = self;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *re = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:re];
    
    _webView2.delegate = self;
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"test2" ofType:@"html"];
    NSURL *url2 = [NSURL fileURLWithPath:path2];
    NSURLRequest *re2 = [NSURLRequest requestWithURL:url2];
    [_webView2 loadRequest:re2];
    
    NSString *path3 = [[NSBundle mainBundle] pathForResource:@"xmlconfig" ofType:@"xml"];
    NSString *xmlStr = [[NSString alloc] initWithContentsOfFile:path3 encoding:NSUTF8StringEncoding error:NULL];
    
    XMLDictionaryParser *parser = [XMLDictionaryParser sharedInstance];
    NSDictionary *xmlDict = [parser dictionaryWithString:xmlStr];
//    NSLog(@"%@",xmlDict);
    
//    JSContext *context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    context[@"webView1"] = self;
//    [context evaluateScript:@"window.webView1 = webView1;"];
    
    // 动态添加协议的方法无法实现
    JSContext *context2 = [_webView2 valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context2[@"MultiWebPageSwitch"] = self;
    Protocol *jsexport = objc_getProtocol("JSExport");
    BOOL ok1 = [self conformsToProtocol:jsexport];
    [context2 evaluateScript:@"window.MultiWebPageSwitch = MultiWebPageSwitch;"];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if(webView == _webView) {
        // 这种方法可以
        JSContext *context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        context[@"goTab"] = ^(NSString *str1,NSString *str2) {
            NSLog(@"测试goTab:%@ %@",str1,str2);
        };
        [context evaluateScript:@"window.MultiWebPageSwitch={};window.MultiWebPageSwitch.goTab = goTab;"];
    }

}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if(webView == _webView) {
        JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        JSValue *a = [context evaluateScript:@"cmbls"];
        id obj = [a toObject];
        BOOL isNull = [obj isKindOfClass:[NSNull class]];
        BOOL isNil = obj==nil;
        NSLog(@"测试:%@ %@",isNull?@"Y1":@"N1",isNil?@"Y2":@"N2");
    }
}

- (void)setTopBar:(NSString *)btn1 aautton:(NSString *)str2 {
    NSLog(@"设置按钮1:%@",btn1);
    NSLog(@"设置按钮2:%@",str2);
}

#pragma mark - Runtime Protocol

- (void)testRuntimeProtocol {
    
//    const char *name = "MyProtocol";
//    Protocol *myPro = objc_allocateProtocol(name);
//    Protocol *jsExport = objc_getProtocol("JSExport");
//    protocol_addProtocol(myPro, jsExport);
//    objc_registerProtocol(myPro);
//    BOOL confirm = protocol_conformsToProtocol(myPro, jsExport);
//    NSLog(@"");
    
    // MultiWeb.goTab
    
    // 创建一个协议
//    NSString *jsObjectName = @"MultiWebPageSwitch";
//    const char *jsFuncName = "goTab";
    const char *proName = "MultiWebPage";
    Protocol *jsExport = objc_getProtocol("JSExport");
    Protocol *pro = objc_allocateProtocol(proName);
    if(pro == nil) {
        pro = objc_getProtocol(proName);
    }
    protocol_addProtocol(pro, jsExport);
//    protocol_addMethodDescription(pro, @selector(goTopBar:Button:), "v@:@@", NO, YES);
    
    objc_registerProtocol(pro);
    
    
    // 如何获取某个类的方法的实现(IMP)
    
    //让self类实现该协议
    BOOL ok = class_addProtocol([ViewController class], pro);
    NSLog(@"");
    
}


- (void)goTopBar:(NSString *)left Button:(NSString *)right {
    NSLog(@"新方法left:%@",left);
    NSLog(@"新方法right:%@",right);
}

@end
