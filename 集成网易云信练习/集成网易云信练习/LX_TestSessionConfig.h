//
//  LX_TestSessionConfig.h
//  集成网易云信练习
//
//  Created by 李lucy on 16/5/24.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NIMSessionConfig.h"


typedef NS_ENUM(NSInteger, NTESMediaButton)
{
    NTESMediaButtonPicture = 0,    //相册
    NTESMediaButtonShoot,          //拍摄
    NTESMediaButtonLocation,       //位置
    NTESMediaButtonJanKenPon,      //石头剪刀布
    NTESMediaButtonVideoChat,      //视频语音通话
    NTESMediaButtonAudioChat,      //免费通话
    NTESMediaButtonFileTrans,      //文件传输
    NTESMediaButtonSnapchat,       //阅后即焚
    NTESMediaButtonWhiteBoard,     //白板沟通
    NTESMediaButtonTip,            //提醒消息
};


@interface LX_TestSessionConfig : NSObject<NIMSessionConfig>


@property (nonatomic,strong)    NIMSession *session;

@end
