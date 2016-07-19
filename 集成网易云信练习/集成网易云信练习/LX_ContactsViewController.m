//
//  LX_ContactsViewController.m
//  集成网易云信练习
//
//  Created by 李lucy on 16/5/24.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

#import "LX_ContactsViewController.h"

#import "NIMUserManagerProtocol.h"
#import "LX_TestChatViewController.h"


typedef NS_ENUM(NSInteger, NotificationHandleType) {
    NotificationHandleTypePending = 0,
    NotificationHandleTypeOk,
    NotificationHandleTypeNo,
    NotificationHandleTypeOutOfDate
};


static const NSInteger MaxNotificationCount = 20;

@interface LX_ContactsViewController ()
<UITableViewDelegate,UITableViewDataSource,
NIMSystemNotificationManagerDelegate,
NIMLoginManagerDelegate,
NIMUserManagerDelegate>



@property (nonatomic,strong)    NSMutableArray  *notifications;

@property (nonatomic,assign)    BOOL shouldMarkAsRead;

/** 好友列表 */
@property (nonatomic, strong) NSArray *friendlist;

@end

@implementation LX_ContactsViewController




- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUserInfoHasUpdatedNotification:) name:NIMKitUserInfoHasUpdatedNotification object:nil];
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    UIEdgeInsets separatorInset   = self.tableView.separatorInset;
    separatorInset.right          = 0;
    self.tableView.separatorInset = separatorInset;
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    
    //系统通知管理者
    
    id<NIMSystemNotificationManager> systemNotificationManager = [[NIMSDK sharedSDK] systemNotificationManager];
    
    [systemNotificationManager addDelegate:self];
    
    [[[NIMSDK sharedSDK] loginManager] addDelegate:self];
    
    [[[NIMSDK sharedSDK] userManager] addDelegate:self];
    
    
    self.friendlist = [[[NIMSDK sharedSDK] userManager] myFriends];
    
    NSLog(@"获取本地数据库好友成功 -- %@",self.friendlist);
    
    NSArray *notifications = [systemNotificationManager fetchSystemNotifications:nil limit:MaxNotificationCount];
    
    
    NSLog(@"抓取系统通知%@",notifications);
    
    
    //获取云信服务端当前登录用户的信息
//    
    [[[NIMSDK sharedSDK] userManager]fetchUserInfos:@[[[[NIMSDK sharedSDK] loginManager] currentAccount]] completion:^(NSArray *users, NSError *error) {
        
        if (!error) {
            
            NSLog(@"%@",users);
            
        }else{
    
            NSLog(@"获取好友出错%@",error);
    
        }
    }];
    
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self.tableView reloadData];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[[NIMSDK sharedSDK] systemNotificationManager] removeDelegate:self];
    [[[NIMSDK sharedSDK] loginManager] removeDelegate:self];
    [[[NIMSDK sharedSDK] userManager] removeDelegate:self];
    
    //标记已读
    if (_shouldMarkAsRead){
        
        [[[NIMSDK sharedSDK] systemNotificationManager] markAllNotificationsAsRead];
        }
}



#pragma mark - 接收到系统通知
- (void)onReceiveSystemNotification:(NIMSystemNotification *)notification{
    
    NSLog(@"接收到系统通知%@",notification);
    
}


#pragma mark - tableview代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }

    cell.textLabel.text = @"test";
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NIMSession *sesstion = [NIMSession session:@"test" type:NIMSessionTypeP2P];
    LX_TestChatViewController *chatVc = [[LX_TestChatViewController alloc] initWithSession:sesstion];
    
    chatVc.disableCommandTyping = YES;
    chatVc.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:chatVc animated:YES];
    
}

- (void)onUserInfoHasUpdatedNotification:(NIMSystemNotification *)usernote{
    
}

@end
