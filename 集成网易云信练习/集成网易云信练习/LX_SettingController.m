
//
//  LX_SettingController.m
//  集成网易云信练习
//
//  Created by 李lucy on 16/5/24.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

#import "LX_SettingController.h"

@interface LX_SettingController ()

@property (weak, nonatomic) IBOutlet UIButton *loginoutBtn;
@end

@implementation LX_SettingController


#pragma mark - 退出登陆
- (IBAction)logoutBtnDidClick:(id)sender {
   
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"退出当前帐号？" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert showAlertWithCompletionHandler:^(NSInteger alertIndex) {
        switch (alertIndex) {
            case 1:
                [NIMProgressHUD showWithStatus:@"正在退出..."];

                [[[NIMSDK sharedSDK] loginManager] logout:^(NSError *error)
                 {
                     if (!error) {
                         [NIMProgressHUD dismiss];
                         extern NSString *LX_NotificationLogout;
                         [[NSNotificationCenter defaultCenter] postNotificationName:LX_NotificationLogout object:nil];

                     }
                 }];
                break;
            default:
                break;
        }
    }];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    NSString *name = [NIMSDK sharedSDK].loginManager.currentAccount;
    self.navigationItem.title = name;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
