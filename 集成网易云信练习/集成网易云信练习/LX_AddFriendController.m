//
//  LX_AddFriendController.m
//  集成网易云信练习
//
//  Created by 李lucy on 16/5/24.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

#import "LX_AddFriendController.h"

@interface LX_AddFriendController ()



@property (weak, nonatomic) IBOutlet UITextField *userAccout;


@property (nonatomic,strong) NIMUser   *user;


@property (nonatomic, strong) NSArray *data;


@end

@implementation LX_AddFriendController

/**
 *  添加好友
 *
 *  @param sender
 */
- (IBAction)addFriendBtnDidClick:(id)sender {
    
    NIMUserRequest *request = [[NIMUserRequest alloc] init];
    request.userId = self.userAccout.text;
    
    request.operation = NIMUserOperationAdd;
   
    request.message = @"跪求通过";

    NSString *successText = request.operation == NIMUserOperationAdd ? @"添加成功" : @"请求成功";
    NSString *failedText =  request.operation == NIMUserOperationAdd ? @"添加失败" : @"请求失败";
    
    __weak typeof(self) wself = self;
    
     [NIMProgressHUD show];
    
    [[NIMSDK sharedSDK].userManager requestFriend:request completion:^(NSError *error) {
        
        [NIMProgressHUD dismiss];
        
        if (!error) {
            
            [wself.view nimkit_makeToast:successText
                         duration:2.0f
                         position:NIMKitToastPositionCenter];
            
#pragma mark - 添加好友
            //刷新好友
//            [wself refresh];
            
        }else{
            [wself.view nimkit_makeToast:failedText
                         duration:2.0f
                         position:NIMKitToastPositionCenter];
        }
    }];

    
}




- (void)viewDidLoad {
    [super viewDidLoad];
//    
//    id<NIMSystemNotificationManager> systemNotificationManager = [[NIMSDK sharedSDK] systemNotificationManager];
//    
//    [systemNotificationManager addDelegate:self];
}





@end
