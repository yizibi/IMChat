//
//  LX_CustomAttachmentInfo.h
//  集成网易云信练习
//
//  Created by 李lucy on 16/5/24.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

#ifndef LX_CustomAttachmentInfo_h
#define LX_CustomAttachmentInfo_h

typedef NS_ENUM(NSInteger,LX_CustomMessageType){
    CustomMessageTypeJanKenPon  = 1, //剪子石头布
    CustomMessageTypeSnapchat   = 2, //阅后即焚
    CustomMessageTypeChartlet   = 3, //贴图表情
    CustomMessageTypeWhiteboard = 4,  //白板会话
};


#define CMType          @"type"
#define CMData          @"data"
#define CMValue         @"value"
#define CMFlag          @"flag"
#define CMURL           @"url"
#define CMMD5           @"md5"
#define CMFIRE          @"fired"    //阅后即焚消息是否被焚毁
#define CMCatalog       @"catalog"  //贴图类别
#define CMChartlet      @"chartlet" //贴图表情ID
#endif


@protocol LX_CustomAttachmentInfo <NSObject>

@optional

- (NSString *)cellContent:(NIMMessage *)message;

- (CGSize)contentSize:(NIMMessage *)message cellWidth:(CGFloat)width;

- (UIEdgeInsets)contentViewInsets:(NIMMessage *)message;

- (NSString *)formatedMessage;

- (UIImage *)showCoverImage;

- (void)setShowCoverImage:(UIImage *)image;

@end

