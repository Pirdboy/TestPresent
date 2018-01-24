//
//  AViewController.m
//  CustomNavTransition
//
//  Created by Baoqin Huang on 2017/6/26.
//  Copyright © 2017年 Baoqin Huang. All rights reserved.
//

#import "AViewController.h"
#import "BViewController.h"

@interface AViewController ()
@property (weak, nonatomic) IBOutlet UIButton *PushButton;

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _PushButton.layer.cornerRadius = 8.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - button methods

- (IBAction)handlePushButtonPressed:(id)sender {
    BViewController *BVC = [BViewController new];
    [self.navigationController pushViewController:BVC animated:YES];
}


@end
