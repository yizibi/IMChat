//
//  AppDelegate.m
//  集成网易云信练习
//
//  Created by 李lucy on 16/5/23.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "NIMSDK.h"
#import "NIMKit.h"
#import "LX_MyDataManger.h"
#import "LX_LoginManger.h"
#import "NTESClientUtil.h"
#import "NTESNotificationCenter.h"

NSString *LX_NotificationLogout = @"NTESNotificationLogout";

static AppDelegate *_appDelegate = nil;
@interface AppDelegate ()<NIMLoginManagerDelegate>

@end

@implementation AppDelegate

+ (AppDelegate *)appDelegate {
    return _appDelegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _appDelegate = self;
#pragma mark - 初始化云信SDK
    [[NIMSDK sharedSDK] registerWithAppID:@"5932b2777bfd69d2e2fab23ae4519562"
                                  cerName:nil];

    [[NIMKit sharedKit] setProvider:[LX_MyDataManger new]];
    
    //设置通话回调
    [self setupServices];
    //初始化监听
    [self commonInitListenEvents];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor grayColor];
    [self.window makeKeyAndVisible];
    [self setupMainViewController];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
 
}

/**
 *  app进入后台
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSInteger count = [[[NIMSDK sharedSDK] conversationManager] allUnreadCount];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//注册远程通知
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[NIMSDK sharedSDK] updateApnsToken:deviceToken];
}
//接收到远程通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"receive remote notification:  %@", userInfo);
}
//注册远程通知失败
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"fail to get apns token :%@",error);
}


- (void)setupMainViewController{
    
    LoginData *data = [[LX_LoginManger sharedManager] currentLoginData];
   
    NSString *account = [data account];
    NSString *token = [data token];
    //如果有缓存用户名密码推荐使用自动登录
    if ([account length] && [token length])
    {
        [[[NIMSDK sharedSDK] loginManager] autoLogin:account
                                               token:token];
        //加载Main
        self.window.rootViewController = [UIStoryboard storyboardWithName:@"Main" bundle:nil].instantiateInitialViewController;
    }else
    {
        [self setupLoginViewController];
    }
}


- (void)setupLoginViewController{
    
    self.window.rootViewController = [UIStoryboard storyboardWithName:@"Login" bundle:nil].instantiateInitialViewController;
    
}

- (void)commonInitListenEvents{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(logout:)
                                                 name:LX_NotificationLogout
                                               object:nil];
    
    [[[NIMSDK sharedSDK] loginManager] addDelegate:self];

}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[[NIMSDK sharedSDK] loginManager] removeDelegate:self];
}

#pragma mark - 注销
-(void)logout:(NSNotification*)note
{
    [self doLogout];
}

- (void)doLogout
{
    [[LX_LoginManger sharedManager] setCurrentLoginData:nil];
//    [[NTESServiceManager sharedManager] destory];
    [self setupLoginViewController];
}


#pragma NIMLoginManagerDelegate(云信登陆代理)
-(void)onKick:(NIMKickReason)code clientType:(NIMLoginClientType)clientType
{
    NSString *reason = @"你被踢下线";
    switch (code) {
        case NIMKickReasonByClient:
        case NIMKickReasonByClientManually:{
            NSString *clientName = [NTESClientUtil clientName:clientType];
            reason = clientName.length ? [NSString stringWithFormat:@"你的帐号被%@端踢出下线，请注意帐号信息安全",clientName] : @"你的帐号被踢出下线，请注意帐号信息安全";
            break;
        }
        case NIMKickReasonByServer:
            reason = @"你被服务器踢下线";
            break;
        default:
            break;
    }
    [[[NIMSDK sharedSDK] loginManager] logout:^(NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LX_NotificationLogout object:nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"下线通知" message:reason delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

- (void)onAutoLoginFailed:(NSError *)error
{
    //只有连接发生严重错误才会走这个回调，在这个回调里应该登出，返回界面等待用户手动重新登录。
    NSLog(@"onAutoLoginFailed %zd",error.code);
    NSString *toast = [NSString stringWithFormat:@"登录失败: %zd",error.code];
    
    [self.window  nimkit_makeToast:toast duration:2.0 position:NIMKitToastPositionCenter];
    
    [[[NIMSDK sharedSDK] loginManager] logout:^(NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LX_NotificationLogout object:nil];
    }];
    
}

#pragma mark - logic impl
- (void)setupServices
{
    [[NTESNotificationCenter sharedCenter] start];
}
#pragma mark - 远程通知
- (void)registerAPNs
{
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)])
    {
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        UIRemoteNotificationType types = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
    }
}



@end
