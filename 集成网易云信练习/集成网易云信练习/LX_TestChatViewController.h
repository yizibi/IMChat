//
//  LX_TestChatViewController.h
//  集成网易云信练习
//
//  Created by 李lucy on 16/5/24.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

#import "NIMSessionViewController.h"

#define NTESNotifyID        @"id"
#define NTESCustomContent  @"content"

#define NTESCommandTyping  (1)
#define NTESCustom         (2)

@interface LX_TestChatViewController : NIMSessionViewController
/** 需要在导航条上显示“正在输入”*/
@property (nonatomic,assign) BOOL disableCommandTyping;

@end
