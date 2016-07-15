//
//  LX_TestSessionConfig.m
//  集成网易云信练习
//
//  Created by 李lucy on 16/5/24.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

#import "LX_TestSessionConfig.h"

#import "NIMMediaItem.h"



@interface LX_TestSessionConfig()

@end

@implementation LX_TestSessionConfig


/**
 *  可以显示在点击输入框“+”按钮里的多媒体按钮
 */
- (NSArray *)mediaItems
{
    // NTESMediaButtonPicture , NTESMediaButtonShoot 为 NIMMediaItem 的 tag 值，用来区分多个 NIMMediaItem 。
    
    return @[[NIMMediaItem item:NTESMediaButtonPicture
                    normalImage:[UIImage imageNamed:@"bk_media_picture_normal"]
                  selectedImage:[UIImage imageNamed:@"bk_media_picture_nomal_pressed"]
                          title:@"相册"],
             
             [NIMMediaItem item:NTESMediaButtonShoot
                    normalImage:[UIImage imageNamed:@"bk_media_shoot_normal"]
                  selectedImage:[UIImage imageNamed:@"bk_media_shoot_pressed"]
                          title:@"拍摄"],
             
//             [NIMMediaItem item:NTESMediaButtonLocation
//                    normalImage:[UIImage imageNamed:@"bk_media_position_normal"]
//                  selectedImage:[UIImage imageNamed:@"bk_media_position_pressed"]
//                          title:@"位置"],
             
//             [NIMMediaItem item:NTESMediaButtonJanKenPon
//                    normalImage:[UIImage imageNamed:@"icon_jankenpon_normal"]
//                  selectedImage:[UIImage imageNamed:@"icon_jankenpon_pressed"]
//                          title:@"石头剪刀布"],
             
             [NIMMediaItem item:NTESMediaButtonAudioChat
                    normalImage:[UIImage imageNamed:@"btn_media_telphone_message_normal"]
                  selectedImage:[UIImage imageNamed:@"btn_media_telphone_message_pressed"]
                          title:@"实时语音"],
             
             [NIMMediaItem item:NTESMediaButtonVideoChat
                    normalImage:[UIImage imageNamed:@"btn_bk_media_video_chat_normal"]
                  selectedImage:[UIImage imageNamed:@"btn_bk_media_video_chat_pressed"]
                          title:@"视频聊天"],
             
             [NIMMediaItem item:NTESMediaButtonWhiteBoard
                    normalImage:[UIImage imageNamed:@"btn_whiteboard_invite_normal"]
                  selectedImage:[UIImage imageNamed:@"btn_whiteboard_invite_pressed"]
                          title:@"白板"],
             
             [NIMMediaItem item:NTESMediaButtonTip
                    normalImage:[UIImage imageNamed:@"bk_media_tip_normal"]
                  selectedImage:[UIImage imageNamed:@"bk_media_tip_pressed"]
                          title:@"提醒"]
             
             
             ];
    
    
    
    
    
}


/**
 *  禁用贴图表情
 */
- (BOOL)disableCharlet{
    return NO;
}

/**
 *  是否禁用在贴耳的时候自动切换成听筒模式
 */
- (BOOL)disableProximityMonitor{
    return YES;
}
/**
 *  是否隐藏多媒体按钮
 */
- (BOOL)shouldHideItem:(NIMMediaItem *)item
{
    
    return NO;
    
}
             
/**
 *  是否禁用输入控件
 */
- (BOOL)disableInputView
    {
        return NO;
    }
             
/**
 *  输入控件最大输入长度
 */
- (NSInteger)maxInputLength
    {
        return 5000;
    }
             
/**
 *  输入控件placeholder
 */
- (NSString *)inputViewPlaceholder
    {
        return @"请输入消息";
    }
             
/**
 *  一次最多显示的消息条数
 */
- (NSInteger)messageLimit{
        return 20;
    }
             
/**
 *  消息的排版配置，只有使用默认的NIMMessageCell，才会触发此回调
 */
//- (id<NIMCellLayoutConfig>)layoutConfigWithMessage:(NIMMessage *)message
//    {
//        //具体消息的排版配置，关于消息结构模型，请参考下一章节 自定义消息和 MessageCell 。
//        id<NIMCellLayoutConfig> config;
//        switch (message.messageType) {
//            case NIMMessageTypeCustom:{
//                if ([NTESSessionCustomLayoutConfig supportMessage:message]) {
//                    config = [[NTESSessionCustomLayoutConfig alloc] init];
//                    break;
//                }
//            }
//            default:
//                break;
//        }
//        return config;
//    }

@end
