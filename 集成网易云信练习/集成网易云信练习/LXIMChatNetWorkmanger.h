//
//  LXIMChatNetWorkmanger.h
//  集成网易云信练习
//
//  Created by 李lucy on 16/7/16.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXIMChatNetWorkmanger : NSObject

#pragma mark - 解散群
/**
 *  解散群
 *
 *  @param tid     群号tid(创建群时产生)
 *  @param owner   群主accid
 *  @param success success description
 *  @param fail    fail description
 */
+ (void)removeTeamWithTid:(NSString *)tid
                    owner:(NSString *)owner
                  success:(void(^)(NSDictionary *result))success
                     fail:(void(^)(NSError *error))fail;

#pragma mark - 禁言群成员
/**
 *  禁言群成员
 *
 *  @param tid     群号id(创建群时产生)
 *  @param owner   群主accid
 *  @param accid   禁言对象的accid
 *  @param mute    1-禁言，0-解禁
 *  @param success success description
 *  @param fail    fail description
 */
+ (void)noSpeakInTeamWithTid:(NSString *)tid
                       owner:(NSString *)owner
                       accid:(NSString *)accid
                        mute:(NSString *)mute
                     success:(void(^)(NSDictionary *result))success
                        fail:(void(^)(NSError *error))fail;


#pragma mark - 高级群修改消息提醒开关
/**
 *  高级群修改消息提醒开关/免打扰
 *
 *  @param tid     群号id(创建群是返回)
 *  @param accid   要操作的群成员accid
 *  @param ope     1：关闭消息提醒，2：打开消息提醒，其他值无效
 *  @param success success description
 *  @param fail    fail description
 */
+ (void)modifiedTeamMsgTipSoundWithTid:(NSString *)tid
                                 accid:(NSString *)accid
                                   ope:(NSString *)ope
                               success:(void(^)(NSDictionary *result))success
                                  fail:(void(^)(NSError *error))fail;

#pragma mark - 修改指定账号在群内的昵称
/**
 *  修改指定账号在群内的昵称
 *
 *  @param tid     群号id(创建群是返回)
 *  @param owner   群主accid
 *  @param accid   指定群成员的accid
 *  @param nick    修改的昵称
 *  @param success success description
 *  @param fail    fail description
 */
+ (void)modifiedTeamNickWithTid:(NSString *)tid
                          owner:(NSString *)owner
                          accid:(NSString *)accid
                           nick:(NSString *)nick
                        success:(void(^)(NSDictionary *result))success
                           fail:(void(^)(NSError *error))fail;


#pragma mark - 获取某用户所加入的群信息
/**
 *  获取某用户所加入的群信息
 *
 *  @param userAccid 查询用户的accid
 *  @param success   success description
 *  @param fail      fail description
 */
+ (void)fetchJoinTeamInfosWithUserAccid:(NSString *)userAccid
                                success:(void(^)(NSDictionary *result))success
                                   fail:(void(^)(NSError *error))fail;


#pragma mark - 移除管理员
/**
 *  移除管理员
 *
 *  @param tid          群号tid
 *  @param owner        群主
 *  @param membersArray 群成员
 *  @param success      success description
 *  @param fail         fail description
 */
+ (void)removeTeamManagerWithTid:(NSString *)tid
                           owner:(NSString *)owner
                         members:(NSArray *)membersArray
                         success:(void(^)(NSDictionary *result))success
                            fail:(void(^)(NSError *error))fail;

#pragma mark - 任命管理员
/**
 *  任命管理员
 *
 *  @param tid          群号tid
 *  @param owner        群主
 *  @param membersArray 群成员
 *  @param success      success description
 *  @param fail         fail description
 */
+ (void)addTeamManagerWithTid:(NSString *)tid
                        owner:(NSString *)owner
                      members:(NSArray *)membersArray
                      success:(void(^)(NSDictionary *result))success
                         fail:(void(^)(NSError *error))fail;

#pragma mark - 编辑群资料
/**
 * 编辑群资料
 *
 *  @param tid          群号tid
 *  @param tname        群名称
 *  @param owner        群主accid
 *  @param announcement 群公告
 *  @param intro        群描述
 *  @param joinmode     群建好后，sdk操作时，0不用验证，1需要验证,2不允许任何人加入
 *  @param icon         群头像
 *  @param beinvtemode  被邀请人同意方式，0-需要同意(默认),1-不需要同意
 *  @param invitemode   谁可以邀请他人入群，0-管理员(默认),1-所有人
 *  @param uptinfomode  谁可以修改群资料，0-管理员(默认),1-所有人
 *  @param upcustommode 谁可以更新群自定义属性，0-管理员(默认),1-所有人
 *  @param success      success description
 *  @param fail         fail description
 */
+ (void)editTeamInfoWithTid:(NSString *)tid
                      tname:(NSString *)tname
                      owner:(NSString *)owner
               announcement:(NSString *)announcement
                      intro:(NSString *)intro
                   joinmode:(NSString *)joinmode
                       icon:(NSString *)icon
                beinvtemode:(NSString *)beinvtemode
                 invitemode:(NSString *)invitemode
                uptinfomode:(NSString *)uptinfomode
               upcustommode:(NSString *)upcustommode
                    success:(void(^)(NSDictionary *result))success
                       fail:(void(^)(NSError *error))fail;


#pragma mark - 群消息与成员列表查询
/**
 *  群消息与成员列表查询
 *
 *  @param tid     群号tid
 *  @param ope     1表示带上群成员列表，0表示不带群成员列表，只返回群信息
 *  @param success success description
 *  @param fail    fail description
 */
+ (void)queryTeamInfoWithTid:(NSArray *)tid
                         ope:(NSString *)ope
                     success:(void(^)(NSDictionary *result))success
                        fail:(void(^)(NSError *error))fail;


#pragma mark - 踢人出群
/**
 *  踢人出群
 *
 *  @param tid         云信服务器产生，群唯一标识，创建群时会返回
 *  @param owner       群主的accid，用户帐号
 *  @param memberAccid 被移除人的accid，用户账号
 *  @param success     success description
 *  @param fail        fail description
 */
+ (void)kickMembersWithTid:(NSString *)tid
                     owner:(NSString *)owner
                    member:(NSString *)memberAccid
                   success:(void(^)(NSDictionary *result))success
                      fail:(void(^)(NSError *error))fail;

#pragma mark - 邀请加群
/**
 *  邀请加群
 *
 *  @param tid          云信服务器产生，群唯一标识，创建群时会返回
 *  @param owner        群主用户帐号
 *  @param membersArray 群成员
 *  @param magree       管理后台建群时，0不需要被邀请人同意加入群，1需要被邀请人同意才可以加入群
 *  @param msg          邀请发送的文字
 *  @param success      success description
 *  @param fail         fail description
 */
+ (void)inviteMembersWithTid:(NSString *)tid
                       owner:(NSString *)owner
                     members:(NSArray *)membersArray
                      magree:(NSString *)magree
                         msg:(NSString *)msg
                     success:(void(^)(NSDictionary *result))success
                        fail:(void(^)(NSError *error))fail;


#pragma mark - 创建群
/**
 *  创建群
 *
 *  @param tname        群名称
 *  @param owner        群主accid
 *  @param membersArr   成员数组
 *  @param msg          邀请发送的文字
 *  @param magree       管理后台建群时，0不需要被邀请人同意加入群，1需要被邀请人同意才可以加入群
 *  @param joinmode     群建好后，sdk操作时，0不用验证，1需要验证,2不允许任何人加入
 *  @param announcement 群公告
 *  @param intro        群描述
 *  @param icon         群头像
 *  @param beinvitemode 被邀请人同意方式，0-需要同意(默认),1-不需要同意
 *  @param invitemode   谁可以邀请他人入群，0-管理员(默认),1-所有人
 *  @param uptinfomode  谁可以修改群资料，0-管理员(默认),1-所有人
 *  @param upcustommode 谁可以更新群自定义属性，0-管理员(默认),1-所有人
 *  @param success      success description
 *  @param fail         fail description
 */
+ (void)creatClassWithTname:(NSString *)tname
                      owner:(NSString *)owner
                    members:(NSArray *)membersArr
                        msg:(NSString *)msg
                     magree:(NSString *)magree
                   joinmode:(NSString *)joinmode
               announcement:(NSString *)announcement
                      intro:(NSString *)intro
                       icon:(NSString *)icon
               beinvitemode: (NSString *)beinvitemode
                 invitemode:(NSString *)invitemode
                uptinfomode:(NSString *)uptinfomode
               upcustommode:(NSString *)upcustommode
                    success:(void(^)(NSDictionary *result))success
                       fail:(void(^)(NSError *error))fail;


#pragma mark - 拉黑
/**
 *  拉黑或者取消拉黑
 *
 *  @param userAccount  用户accid
 *  @param targetAccid  被拉黑用户accid
 *  @param relationType 拉黑类型:1表示拉黑 2表示静音免打扰
 *  @param value        类型: 0 取消拉黑 1 取消静音
 *  @param success      success description
 *  @param fail         fail description
 */
+ (void)pullUserBlackWithAccid:(NSString *)userAccount
                   targetAccid:(NSString *)targetAccid
                  relationType:(NSString *)relationType
                         value:(NSString *)value
                       success:(void(^)(NSDictionary *result))success
                          fail:(void(^)(NSError *error))fail;




@end
