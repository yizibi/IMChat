//
//  LXIMChatNetWorkmanger.m
//  集成网易云信练习
//
//  Created by 李lucy on 16/7/16.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

#import "LXIMChatNetWorkmanger.h"

@implementation LXIMChatNetWorkmanger

#pragma mark - 解散群
+ (void)removeTeamWithTid:(NSString *)tid owner:(NSString *)owner success:(void (^)(NSDictionary *))success fail:(void (^)(NSError *))fail{
    NSString *url                = @"http://192.168.1.150:8080/api/common/im/team/Remove";
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFSecurityPolicy *policy     = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger setSecurityPolicy:policy];
    manger.requestSerializer     = [AFJSONRequestSerializer serializer];
    manger.responseSerializer    = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    
    params[@"tid"] = tid;
    params[@"owner"] = owner;
    [manger POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
    

}


#pragma mark - 禁言群成员
+ (void)noSpeakInTeamWithTid:(NSString *)tid owner:(NSString *)owner accid:(NSString *)accid mute:(NSString *)mute success:(void (^)(NSDictionary *))success fail:(void (^)(NSError *))fail{
    
    NSString *url                = @"http://192.168.1.150:8080/api/common/im/team/MuteTList";
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFSecurityPolicy *policy     = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger setSecurityPolicy:policy];
    manger.requestSerializer     = [AFJSONRequestSerializer serializer];
    manger.responseSerializer    = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    
    params[@"tid"] = tid;
    params[@"owner"] = owner;
    params[@"accid"] = accid;
    params[@"mute"] = mute;
    
    [manger POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
    
}


#pragma mark - 高级群修改消息提醒开关
+ (void)modifiedTeamMsgTipSoundWithTid:(NSString *)tid accid:(NSString *)accid ope:(NSString *)ope success:(void (^)(NSDictionary *))success fail:(void (^)(NSError *))fail{
    NSString *url                = @"http://192.168.1.150:8080/api/common/im/team/MuteTeam";
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFSecurityPolicy *policy     = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger setSecurityPolicy:policy];
    manger.requestSerializer     = [AFJSONRequestSerializer serializer];
    manger.responseSerializer    = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    
    params[@"tid"] = tid;
    params[@"accid"] = accid;
    params[@"ope"] = ope;
    
    [manger POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];

}

#pragma mark - 修改指定账号在群内的昵称
+ (void)modifiedTeamNickWithTid:(NSString *)tid owner:(NSString *)owner accid:(NSString *)accid nick:(NSString *)nick success:(void (^)(NSDictionary *))success fail:(void (^)(NSError *))fail{
    NSString *url                = @"http://192.168.1.150:8080/api/common/im/team/UpdateTeamNick";
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFSecurityPolicy *policy     = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger setSecurityPolicy:policy];
    manger.requestSerializer     = [AFJSONRequestSerializer serializer];
    manger.responseSerializer    = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    
    params[@"tid"] = tid;
    params[@"owner"] = owner;
    params[@"accid"] = accid;
    params[@"nick"] = nick;
    
    [manger POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}


#pragma mark - 获取某用户所加入的群信息
+ (void)fetchJoinTeamInfosWithUserAccid:(NSString *)userAccid success:(void (^)(NSDictionary *))success fail:(void (^)(NSError *))fail{
    NSString *url                = @"http://192.168.1.150:8080/api/common/im/team/JoinTeams";
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFSecurityPolicy *policy     = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger setSecurityPolicy:policy];
    manger.requestSerializer     = [AFJSONRequestSerializer serializer];
    manger.responseSerializer    = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    
    params[@"accid"] = userAccid;
    
    [manger POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];

}

#pragma mark - 移除管理员
+ (void)removeTeamManagerWithTid:(NSString *)tid owner:(NSString *)owner members:(NSArray *)membersArray success:(void (^)(NSDictionary *))success fail:(void (^)(NSError *))fail{
    NSString *url                = @"http://192.168.1.150:8080/api/common/im/team/RemoveManager";
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFSecurityPolicy *policy     = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger setSecurityPolicy:policy];
    manger.requestSerializer     = [AFJSONRequestSerializer serializer];
    manger.responseSerializer    = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:membersArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    params[@"tid"] = tid;
    params[@"owner"] = owner;
    params[@"members"] = str;
    
    [manger POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}


#pragma mark - 任命管理员
+ (void)addTeamManagerWithTid:(NSString *)tid owner:(NSString *)owner members:(NSArray *)membersArray success:(void (^)(NSDictionary *))success fail:(void (^)(NSError *))fail{
    NSString *url                = @"http://192.168.1.150:8080/api/common/im/team/AddManager";
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFSecurityPolicy *policy     = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger setSecurityPolicy:policy];
    manger.requestSerializer     = [AFJSONRequestSerializer serializer];
    manger.responseSerializer    = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:membersArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    params[@"tid"] = tid;
    params[@"owner"] = owner;
    params[@"members"] = str;
    
    [manger POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];

}


#pragma mark - 编辑群资料
+ (void)editTeamInfoWithTid:(NSString *)tid tname:(NSString *)tname owner:(NSString *)owner announcement:(NSString *)announcement intro:(NSString *)intro joinmode:(NSString *)joinmode icon:(NSString *)icon beinvtemode:(NSString *)beinvtemode invitemode:(NSString *)invitemode uptinfomode:(NSString *)uptinfomode upcustommode:(NSString *)upcustommode success:(void (^)(NSDictionary *))success fail:(void (^)(NSError *))fail{
    NSString *url                = @"http://192.168.1.150:8080/api/common/im/team/Update";
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFSecurityPolicy *policy     = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger setSecurityPolicy:policy];
    manger.requestSerializer     = [AFJSONRequestSerializer serializer];
    manger.responseSerializer    = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    
    params[@"tid"] = tid;
    params[@"tname"] = tname;
    params[@"owner"] = owner;
    params[@"announcement"] = announcement;
    params[@"intro"] = intro;
    params[@"joinmode"] = joinmode;
    params[@"icon"] = icon;
    params[@"beinvitemode"] = beinvtemode;
    params[@"invitemode"] = invitemode;
    params[@"uptinfomode"] = uptinfomode;
    params[@"upcustommode"] = upcustommode;
    
    [manger POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
    

}


#pragma mark - 获取群信息
+ (void)queryTeamInfoWithTid:(NSArray *)tids ope:(NSString *)ope success:(void (^)(NSDictionary *))success fail:(void (^)(NSError *))fail{
    NSString *url                = @"http://192.168.1.150:8080/api/common/im/team/Infos";
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFSecurityPolicy *policy     = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger setSecurityPolicy:policy];
    manger.requestSerializer     = [AFJSONRequestSerializer serializer];
    manger.responseSerializer    = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tids options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    params[@"tids"] = str;
    params[@"ope"] = ope;
    
    [manger POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];

}

#pragma mark - 踢人出群
+ (void)kickMembersWithTid:(NSString *)tid owner:(NSString *)owner member:(NSString *)memberAccid success:(void (^)(NSDictionary *))success fail:(void (^)(NSError *))fail{
    NSString *url                = @"http://192.168.1.150:8080/api/common/im/team/Kick";
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFSecurityPolicy *policy     = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger setSecurityPolicy:policy];
    manger.requestSerializer     = [AFJSONRequestSerializer serializer];
    manger.responseSerializer    = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    
    params[@"tid"] = tid;
    params[@"owner"] = owner;
    params[@"member"] = memberAccid;
    
    [manger POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];

}

#pragma mark - 邀请加群
+ (void)inviteMembersWithTid:(NSString *)tid owner:(NSString *)owner members:(NSArray *)membersArray magree:(NSString *)magree msg:(NSString *)msg success:(void (^)(NSDictionary *))success fail:(void (^)(NSError *))fail{
    NSString *url                = @"http://192.168.1.150:8080/api/common/im/team/Add";
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFSecurityPolicy *policy     = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger setSecurityPolicy:policy];
    manger.requestSerializer     = [AFJSONRequestSerializer serializer];
    manger.responseSerializer    = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    
    params[@"tid"] = tid;
    params[@"owner"] = owner;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:membersArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    params[@"members"] = str;
    params[@"msg"] = msg;
    params[@"magree"] = magree;
   
    [manger POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];

}


#pragma mark - 创建群
+ (void)creatClassWithTname:(NSString *)tname owner:(NSString *)owner members:(NSArray *)membersArr msg:(NSString *)msg magree:(NSString *)magree joinmode:(NSString *)joinmode announcement:(NSString *)announcement intro:(NSString *)intro icon:(NSString *)icon beinvitemode:(NSString *)beinvitemode invitemode:(NSString *)invitemode uptinfomode:(NSString *)uptinfomode upcustommode:(NSString *)upcustommode success:(void (^)(NSDictionary *))success fail:(void (^)(NSError *))fail{
    
    NSString *url                = @"http://192.168.1.150:8080/api/common/im/team/create";
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFSecurityPolicy *policy     = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger setSecurityPolicy:policy];
    manger.requestSerializer     = [AFJSONRequestSerializer serializer];
    manger.responseSerializer    = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
   
    params[@"tname"] = tname;
    params[@"owner"] = owner;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:membersArr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    params[@"members"] = str;
    params[@"msg"] = msg;
    params[@"magree"] = magree;
    params[@"joinmode"] = joinmode;
    params[@"announcement"] = announcement;
    params[@"intro"] = intro;
    params[@"icon"] = icon;
    params[@"beinvitemode"] = beinvitemode;
    params[@"invitemode"] = invitemode;
    params[@"uptinfomode"] = uptinfomode;
    params[@"upcustommode"] = upcustommode;

    [manger POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];

}


#pragma mark - 拉黑或者取消拉黑
+ (void)pullUserBlackWithAccid:(NSString *)userAccount targetAccid:(NSString *)targetAccid relationType:(NSString *)relationType value:(NSString *)value success:(void (^)(NSDictionary *))success fail:(void (^)(NSError *))fail{
    NSString *url                = @"http://192.168.1.150:8080/api/common/im/user/setSpecialRelation";
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFSecurityPolicy *policy     = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger setSecurityPolicy:policy];
    manger.requestSerializer     = [AFJSONRequestSerializer serializer];
    manger.responseSerializer    = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    params[@"accid"]                = userAccount;
    params[@"targetAcc"] = targetAccid;
    params[@"relationType"] = relationType;
    params[@"value"] = value;
    
    [manger POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];

}
@end
