//
//  LX_LoginManger.h
//  集成网易云信练习
//
//  Created by 李lucy on 16/5/24.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LoginData : NSObject
@property (nonatomic,copy)  NSString *account;
@property (nonatomic,copy)  NSString *token;
@end


@interface LX_LoginManger : NSObject

+ (instancetype)sharedManager;

/** 用户登陆数据 */
@property (nonatomic, strong) LoginData *currentLoginData;

@end
