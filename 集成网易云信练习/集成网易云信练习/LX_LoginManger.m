//
//  LX_LoginManger.m
//  集成网易云信练习
//
//  Created by 李lucy on 16/5/24.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

#import "LX_LoginManger.h"
#import "NTESFileLocationHelper.h"

#define NIMAccount      @"account"
#define NIMToken        @"token"



@interface LoginData()



@end

@implementation  LoginData


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _account = [aDecoder decodeObjectForKey:NIMAccount];
        _token = [aDecoder decodeObjectForKey:NIMToken];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    if ([_account length]) {
        [encoder encodeObject:_account forKey:NIMAccount];
    }
    if ([_token length]) {
        [encoder encodeObject:_token forKey:NIMToken];
    }
}


@end



@interface LX_LoginManger()

@property (nonatomic,copy)  NSString    *filepath;


@end


@implementation LX_LoginManger


+ (instancetype)sharedManager{
    static LX_LoginManger *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *filepath = [[NTESFileLocationHelper getAppDocumentPath] stringByAppendingPathComponent:@"nim_sdk_login_data"];
        instance = [[LX_LoginManger alloc] initWithPath:filepath];
    });
    return instance;
}


- (void)setCurrentLoginData:(LoginData *)currentLoginData{
    _currentLoginData = currentLoginData;
    [self saveData];
}


- (instancetype)initWithPath:(NSString *)filepath{
    if (self = [super init]){
        _filepath = filepath;
        [self readData];
    }
    return self;
}


- (void)readData{
    
    NSString *filepath = [self filepath];
    
//    NSLog(@"%@",filepath);
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath])
    {
        id object = [NSKeyedUnarchiver unarchiveObjectWithFile:filepath];
        _currentLoginData = [object isKindOfClass:[LoginData class]] ? object : nil;
    }

    
}

- (void)saveData{
    NSData *data = [NSData data];
    if (_currentLoginData)
    {
        data = [NSKeyedArchiver archivedDataWithRootObject:_currentLoginData];
    }
    [data writeToFile:[self filepath] atomically:YES];

}
@end
