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

@end

@implementation MultiWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView = [[PDScrollView alloc] init];

}

- (void)updateViewConstraints {
    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
