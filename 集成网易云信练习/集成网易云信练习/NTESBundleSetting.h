//
//  NTESBundleSetting.h
//  NIM
//
//  Created by chris on 15/7/1.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NIMGlobalDefs.h"

//部分API提供了额外的选项，如删除消息会有是否删除会话的选项,为了测试方便提供配置参数
//上层开发只需要按照策划需求选择一种适合自己项目的选项即可，这个设置只是为了方便测试不同的case下API的正确性

@interface NTESBundleSetting : NSObject

+ (instancetype)sharedConfig;

- (BOOL)removeSessionWheDeleteMessages;             //删除消息时是否同时删除会话项

- (BOOL)localSearchOrderByTimeDesc;                 //本地搜索消息顺序 YES表示按时间戳逆序搜索,NO表示按照时间戳顺序搜索

- (BOOL)autoRemoveRemoteSession;                    //删除会话时是不是也同时删除服务器会话 (防止漫游)

- (BOOL)autoRemoveSnapMessage;                      //阅后即焚消息在看完后是否删除

- (BOOL)needVerifyForFriend;                        //添加好友是否需要验证

- (BOOL)showFps;                                    //是否显示Fps

- (BOOL)disableProximityMonitor;                    //贴耳的时候是否需要自动切换成听筒模式

- (BOOL)enableRotate;                               //支持旋转(仅组件部分，其他部分可能会显示不正常，谨慎开启)

- (BOOL)usingAmr;                                   //使用amr作为录音

- (BOOL)serverRecordAudio;                          //服务器录制语音

- (BOOL)serverRecordVideo;                          //服务器录制视频

- (NIMNetCallVideoQuality)preferredVideoQuality;    //期望的视频发送清晰度

@end
