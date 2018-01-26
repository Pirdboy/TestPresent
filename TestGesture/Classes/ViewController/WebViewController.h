//
//  WebViewController.h
//  TestGesture
//
//  Created by pirdboy on 2018/1/24.
//  Copyright © 2018年 CMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDWebView.h"

@interface WebViewController : UIViewController
@property (nonatomic, strong) PDWebView *webView;
- (instancetype)initWithURLString:(NSString *)urlString;


@end
