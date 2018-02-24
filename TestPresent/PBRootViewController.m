//
//  PBRootViewController.m
//  TestPresent
//
//  Created by pirdboy on 2017/11/16.
//  Copyright © 2017年 CMB. All rights reserved.
//

#import "PBRootViewController.h"
#import "ViewController2.h"
#import <AudioToolbox/AudioToolbox.h>


@interface PBRootViewController ()

@end

@implementation PBRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)present:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"vc2"];
    /* 如果该VC是NavigationController中的一个视图,该实际负责present的是navigationController */
    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)push:(id)sender {
}
- (IBAction)playsound:(id)sender {
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);

    // iPhone的Taptic Engine
    
    // 短振动效果(iOS 10.0+),推荐使用
    UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle: UIImpactFeedbackStyleMedium];
    [generator prepare];
    [generator impactOccurred];
    
//    UISelectionFeedbackGenerator
//    UINotificationFeedbackGenerator
    
//    AudioServicesPlaySystemSound(1519);  // 3d touch peek时的振动效果
//    AudioServicesPlaySystemSound(1520);    //3d touch pop时的振动效果
//    AudioServicesPlaySystemSound(1521);   // 连续3次短振动
}

- (IBAction)dismissRoot:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];
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
