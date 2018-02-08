//
//  ViewController.m
//  TestSocket
//
//  Created by pirdboy on 2018/2/6.
//  Copyright © 2018年 CMB. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSStreamDelegate>

@property (nonatomic, strong) NSInputStream *inputStream;
@property (nonatomic, strong) NSOutputStream *outputStream;
@property (nonatomic, strong) NSMutableArray *chatMsgs;
@property (nonatomic, strong) UIButton *connectBtn;
@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _connectBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_connectBtn addTarget:self action:@selector(connectToHost:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_connectBtn];
    _connectBtn.frame = (CGRect){30,150,60,30};
    [_connectBtn setTitle:@"连接" forState:UIControlStateNormal];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    _loginBtn.frame = (CGRect){30,150,60,30};
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
    
    NSLog(@"%@",[NSThread currentThread]);
    
    switch (eventCode) {
        case NSStreamEventOpenCompleted:
            NSLog(@"输入输出流打开完成");
            break;
        case NSStreamEventHasBytesAvailable:
            NSLog(@"有字节可读");
            // 读取数据
            break;
        case NSStreamEventHasSpaceAvailable:
            NSLog(@"可以发送字节");
            break;
        case NSStreamEventErrorOccurred:
            NSLog(@"连接出现错误");
            break;
        case NSStreamEventEndEncountered:
            NSLog(@"连接结束");
            [_inputStream close];
            [_outputStream close];
            [_inputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
            [_outputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
            break;
        default:
            break;
    }
}

- (NSMutableArray *)chatMsgs {
    if(!_chatMsgs) {
        _chatMsgs = [NSMutableArray array];
    }
    return _chatMsgs;
}

- (void)connectToHost:(id)sender {
    NSString *host = @"127.0.0.1";
    int port = 2222;
    // 定义输入输出流
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, (__bridge CFStringRef)host, port, readStream, writeStream);
    
    // 将CF对象转为OC对象
    _inputStream = (__bridge NSInputStream *)readStream;
    _outputStream = (__bridge NSOutputStream *)writeStream;
    
    _inputStream.delegate = self;
    _outputStream.delegate = self;
    
    // 把输入输出流添加到主runLoop
    [_inputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    [_outputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    [_inputStream open];
    [_outputStream open];
}

- (void)loginBtnClicked:(id)sender {
    
    NSString *loginStr = @"testStr";
    NSData *data = [loginStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [_outputStream write:data.bytes maxLength:data.length];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
