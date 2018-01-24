//
//  PaintViewController.m
//  TestPresent
//
//  Created by pirdboy on 2017/12/15.
//  Copyright © 2017年 CMB. All rights reserved.
//

#import "PaintViewController.h"
#import "PaintView.h"
#import "PBBadgeButton.h"

@interface PaintViewController ()
@property (nonatomic, strong) UIButton *testBtn;

@property (nonatomic, strong) PBBadgeButton *badgeButton;
@property (nonatomic, strong) PBBadgeButton *badgeButton2;
@end

@implementation PaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PaintView *paintView = ({
        PaintView *v = [[PaintView alloc] initWithFrame:self.view.bounds];
        v;
    });
    
    _testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_testBtn setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    [_testBtn setTitle:@"卡列表" forState:UIControlStateNormal];
    [_testBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_testBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    _testBtn.frame = (CGRect){200,200,36,36};
//    [_testBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
//    [_testBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    
    UIButton *changeImageBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [changeImageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [changeImageBtn setTitle:@"测试badge1" forState:UIControlStateNormal];
    [changeImageBtn addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchUpInside];
    changeImageBtn.frame = CGRectMake(100, 400, 50, 50);
    
    UIButton *changeImageBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [changeImageBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [changeImageBtn2 setTitle:@"测试badge换图" forState:UIControlStateNormal];
    [changeImageBtn2 addTarget:self action:@selector(changeImage2:) forControlEvents:UIControlEventTouchUpInside];
    changeImageBtn2.frame = CGRectMake(100, 500, 80, 50);
    
    UIImage *img = [UIImage imageNamed:@"activity_fill.png"];
    UIImage *image;
    if(img) {
        image = [[UIImage alloc] initWithData:UIImagePNGRepresentation(img) scale:[UIScreen mainScreen].scale];
    }
    _badgeButton2 = [[PBBadgeButton alloc] initWithImage:image title:@"卡关联"];
    CGRect bounds = _badgeButton2.bounds;
    [_badgeButton2 setFrame:(CGRect){100,280,bounds.size.width,bounds.size.height}];
    
    [self.view addSubview:paintView];
    [self.view addSubview:_testBtn];
    [self.view addSubview:changeImageBtn];
    [self.view addSubview:changeImageBtn2];
    [self.view addSubview:_badgeButton2];
    [self testNavigationItem];
}


- (void)testNavigationItem {
    UIButton *btn1 = [self customButtonWithSize:(CGSize){36,36} image:[UIImage imageNamed:@"home"]];
    UIBarButtonItem *spacingItem1 = [self spacingItem];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    UIButton *btn2 = [self customButtonWithSize:(CGSize){32,32} image:[UIImage imageNamed:@"scan"]];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    [self.navigationItem setLeftBarButtonItems:@[/*spacingItem1,*/ item1,item2]];
    
}
- (void)changeImage:(id)sender {
    [_testBtn setImage:[UIImage imageNamed:@"scan"] forState:UIControlStateNormal];
    
    /* 将按钮添加到导航栏时,按钮的大小会被强制设置,保证视图不被压缩 */
    /* 测试PBBadgeButton */
    UIImage *img = [UIImage imageNamed:@"activity_fill.png"];
    UIImage *image;
    if(img) {
        image = [[UIImage alloc] initWithData:UIImagePNGRepresentation(img) scale:[UIScreen mainScreen].scale];
    }
    _badgeButton = [[PBBadgeButton alloc] initWithImage:image title:@"卡视图"];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:_badgeButton];
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.rightBarButtonItems = @[barItem];
}
- (void)changeImage2:(id)sender {
    /* 更换导航栏PBBadgeButton图片 */
    UIImage *img = [UIImage imageNamed:@"activity_fill.png"];
    UIImage *image;
    if(img) {
        image = [[UIImage alloc] initWithData:UIImagePNGRepresentation(img) scale:[UIScreen mainScreen].scale];
    }
//    UIButton *btn = (UIButton *)[self.navigationItem.rightBarButtonItem customView];
//    [btn setImage:image forState:UIControlStateNormal];
    [_badgeButton setImage:image forState:UIControlStateNormal];
    [self.navigationController.navigationBar setNeedsLayout];
    [self.navigationController.navigationBar layoutIfNeeded];
    [self.navigationController.navigationBar setNeedsDisplay];
}
- (UIBarButtonItem *)spacingItem {
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    /* 左边第一个item与左边的间距是固定的16,加了spacing也没用 */
//    item1.width = 1;  // iOS 11.0上这个width没用
    return item1;
}

- (UIButton *)customButtonWithSize:(CGSize)size image:(UIImage *)image {
    UIButton *button = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        /* 用imageEdgeInset来挤压图片 */
        // 应该与_UITAMICAdaptorView有关
//        (translatesAutoresizingMaskIntoConstraints = NO时该View就消失,且button不能通过frame设置大小)
//        [btn setContentEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
        [btn setImage:image forState:UIControlStateNormal];
        btn.frame = (CGRect){0, 0, size.width, size.height};
        btn;
    });
    return button;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
