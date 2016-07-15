//
//  ViewController.m
//  集成网易云信练习
//
//  Created by 李lucy on 16/5/23.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

#import "ViewController.h"
#import "NIMSDK.h"
#import "NIMSessionViewController.h"
#import "NIMSession.h"
#import "LX_TestChatViewController.h"

#import "LX_LoginManger.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;

@end

@implementation ViewController

//注册
- (IBAction)regisButtonDidClick:(UIButton *)sender {

    
}

- (IBAction)loginInBtnClick:(UIButton *)sender {
    
    if (!(self.userName.text&&self.passWord.text)) {
        return;
    }
    
    
//    [NIMProgressHUD show];
    [NIMProgressHUD showWithStatus:@"正在登陆..."];

    
    
    [[[NIMSDK sharedSDK] loginManager] login:self.userName.text
                                       token:self.passWord.text
                                  completion:^(NSError *error) {
                                      
//                                      NSLog(@"%@",error);
                                      
                                      if (!error) {
                                          [NIMProgressHUD dismiss];
                                          NSLog(@"%@登陆成功",self.userName.text);
                                          
                                          LoginData *sdkData = [[LoginData alloc] init];
                                          sdkData.account   = self.userName.text;
                                          sdkData.token     = self.passWord.text;
    
                                          [[LX_LoginManger sharedManager] setCurrentLoginData:sdkData];
                                          
                                          //加载Main
                                          [UIApplication sharedApplication].keyWindow.rootViewController = [UIStoryboard storyboardWithName:@"Main" bundle:nil].instantiateInitialViewController;

                                          
//                                          LX_TestChatViewController *chatVc = [[LX_TestChatViewController alloc] init];
//                                          
//                                          [self.navigationController pushViewController:chatVc animated:YES];
                                          
                                      }else{
                                          
                                          NSString *toast = [NSString stringWithFormat:@"登录失败 code: %zd",error.code];
                                          [self.view nimkit_makeToast:toast duration:2.0 position:NIMKitToastPositionCenter];
                                      }
                                  
                                  }];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
