//
//  LX_MyDataManger.h
//  集成网易云信练习
//
//  Created by 李lucy on 16/5/24.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NIMKitDataProvider.h"

@interface LX_MyDataManger : NSObject<NIMKitDataProvider>


+ (instancetype)sharedInstance;

@property (nonatomic,strong) UIImage *defaultUserAvatar;

@property (nonatomic,strong) UIImage *defaultTeamAvatar;

@end
