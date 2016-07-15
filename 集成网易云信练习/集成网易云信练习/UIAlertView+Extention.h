//
//  UIAlertView+Extention.h
//  集成网易云信练习
//
//  Created by 李lucy on 16/5/24.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef void(^alertBlack)(NSInteger);

@interface UIAlertView (Extention)

- (void)showAlertWithCompletionHandler:(alertBlack)block;
- (void)clearActionBlock;

@end
