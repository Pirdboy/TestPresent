//
//  MapViewController.m
//  TestPresent
//
//  Created by pirdboy on 2017/11/9.
//  Copyright © 2017年 CMB. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "MapViewController.h"

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) UIVisualEffectView *blurView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _blurView.frame = CGRectMake(0, 0, 375, 44);
    
    [self.view insertSubview:_blurView aboveSubview:_mapView];
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
