//
//  AnimationView.h
//  集成网易云信练习
//
//  Created by 李lucy on 16/7/19.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationView : UIView

+ (instancetype)loginAnimationView;

//开始动画
- (void)startAnima:(BOOL)isClose;
@end
