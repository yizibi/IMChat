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
#import "AnimationView.h"

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *AnimationView;

/** 动画控件  */
@property (nonatomic,weak)  AnimationView *aniView;


@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation ViewController

//注册
- (IBAction)regisButtonDidClick:(UIButton *)sender {

    NSLog(@"云信不支持客户端注册账号,只能由服务端注册");
    
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

                                          
                                      }else{
                                          
                                          NSString *toast = [NSString stringWithFormat:@"登录失败 code: %zd",error.code];
                                          [self.view nimkit_makeToast:toast duration:2.0 position:NIMKitToastPositionCenter];
                                      }
                                  
                                  }];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    AnimationView *animaView = [AnimationView loginAnimationView];
    _aniView = animaView;
    [self.AnimationView addSubview:animaView];
    
    //设置文本框代理,监听文本框
    _userName.delegate = self;
    _passWord.delegate = self;
    [_userName addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [_passWord addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    //主动判断
    [self textChange];


}

//监听文本框的输入,判断是否进行动画
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.frame.origin.y == _userName.frame.origin.y) {
        [_aniView startAnima:NO];
    }else{
        [_aniView startAnima:YES];
    }
}
//view将要消失的时候,调用,退出键盘
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //T退出键盘
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
//根据文本框判断登陆按钮是否可点击
- (void)textChange
{
    _loginBtn.enabled = _userName.text.length && _passWord.text.length;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
