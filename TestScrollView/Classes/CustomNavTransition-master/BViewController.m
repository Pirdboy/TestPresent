//
//  BViewController.m
//  CustomNavTransition
//
//  Created by Baoqin Huang on 2017/6/26.
//  Copyright © 2017年 Baoqin Huang. All rights reserved.
//

#import "BViewController.h"

@interface BViewController ()

@property (weak, nonatomic) IBOutlet UIButton *BackButton;

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _BackButton.layer.cornerRadius = 8.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - button methods

- (IBAction)handleBackButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
