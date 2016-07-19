//
//  LX_SessionListController.m
//  集成网易云信练习
//
//  Created by 李lucy on 16/5/25.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

#import "LX_SessionListController.h"
#import "LX_TestChatViewController.h"


#define SessionListTitle @"test"

@interface LX_SessionListController()

@property (nonatomic,strong) UILabel *titleLabel;


@end


@implementation LX_SessionListController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.emptyTipLabel = [[UILabel alloc] init];
    self.emptyTipLabel.text = @"还没有会话，在通讯录中找个人聊聊吧";
    [self.emptyTipLabel sizeToFit];
    self.emptyTipLabel.hidden = self.recentSessions.count;

    
    [self.view addSubview:self.emptyTipLabel];
    
    
    NSString *userID = [[[NIMSDK sharedSDK] loginManager] currentAccount];
    
    self.navigationItem.title = userID;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self refreshSubview];
}

- (void)onSelectedRecent:(NIMRecentSession *)recent atIndexPath:(NSIndexPath *)indexPath{
    LX_TestChatViewController *vc = [[LX_TestChatViewController alloc] initWithSession:recent.session];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)refreshSubview{
    self.emptyTipLabel.lx_centerX = self.view.lx_width * .5f;
    self.emptyTipLabel.lx_centerY = self.tableView.lx_height * .5f;
}

- (void)reload{
    [super reload];
    self.emptyTipLabel.hidden = self.recentSessions.count;
}
@end
