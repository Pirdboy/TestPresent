//
//  ViewController3.m
//  TestPresent
//
//  Created by pirdboy on 2017/11/16.
//  Copyright © 2017年 CMB. All rights reserved.
//

#import "ViewController3.h"

@interface ViewController3 ()

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismiss1:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)dismiss2:(id)sender {
    UIViewController *vc2 = self.presentingViewController;
    UIViewController *rootVC = self.presentingViewController.presentingViewController;
    
    [rootVC dismissViewControllerAnimated:NO completion:nil];
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
