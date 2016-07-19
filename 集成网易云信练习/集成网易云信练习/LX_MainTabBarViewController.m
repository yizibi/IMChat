//
//  LX_MainTabBarViewController.m
//  集成网易云信练习
//
//  Created by 李lucy on 16/7/18.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

#import "LX_MainTabBarViewController.h"
#import "AppDelegate.h"


@interface LX_MainTabBarViewController ()

@end

@implementation LX_MainTabBarViewController

+ (instancetype)instance{
    
    AppDelegate *delegete = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *vc = delegete.window.rootViewController;
    if ([vc isKindOfClass:[LX_MainTabBarViewController class]]) {
        return (LX_MainTabBarViewController *)vc;
    }else{
        
        return nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
