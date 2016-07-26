//
//  AnimationView.m
//  集成网易云信练习
//
//  Created by 李lucy on 16/7/19.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

#import "AnimationView.h"


@interface AnimationView()
@property (weak, nonatomic) IBOutlet UIImageView *leftArm;
@property (weak, nonatomic) IBOutlet UIImageView *rightArm;
@property (weak, nonatomic) IBOutlet UIImageView *leftHand;
@property (weak, nonatomic) IBOutlet UIImageView *rightHand;
@property (weak, nonatomic) IBOutlet UIView *contentView;

//手臂偏移量
@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, assign) CGFloat leftarmOffsetX;
@property (nonatomic, assign) CGFloat rightarmOffsetx;

@end


@implementation AnimationView

//初始化子控件
- (void)awakeFromNib
{
    //初始化两只手的位置,使之隐藏,两只手的y 轴偏移量是相同的
    //y 轴偏移量
    _offsetY = self.bounds.size.height - _leftHand.frame.origin.y;
    
    //左手 X 轴偏移量
    _leftarmOffsetX = _leftHand.frame.origin.x;
    //右手 X 轴偏移量
    _rightarmOffsetx = _contentView.bounds.size.width - _rightHand.frame.origin.x - _rightArm.bounds.size.width;
    _leftHand.transform = CGAffineTransformMakeTranslation(-_leftarmOffsetX, _offsetY);
    _rightHand.transform = CGAffineTransformMakeTranslation(_rightarmOffsetx, _offsetY);
}


+ (instancetype)loginAnimationView
{
    return [[NSBundle mainBundle] loadNibNamed:@"AnimationView" owner:nil options:nil].firstObject;
}
//根据眼睛是否睁开,判断是否执行遮眼动画
- (void)startAnima:(BOOL)isClose
{
    if (isClose) {
        
        
        //手臂,眼睛闭着的时候,手臂与手同时移动
        [UIImageView animateWithDuration:.25 animations:^{
            //清空形变
            //手
            _leftHand.transform = CGAffineTransformIdentity;
            _rightHand.transform = CGAffineTransformIdentity;
            //左手臂
            _leftArm.transform = CGAffineTransformMakeTranslation(_leftarmOffsetX,-_offsetY + 20 );
            _leftArm.transform = CGAffineTransformScale(_leftArm.transform, 0.01, 0.01);
            //右手臂
            _rightArm.transform = CGAffineTransformMakeTranslation(-_rightarmOffsetx, -_offsetY + 20 );
            _rightArm.transform = CGAffineTransformScale(_rightArm.transform, 0.01, 0.01);
        }];
    }else{//眼睛睁开的话,就平移手臂
        [UIImageView animateWithDuration:.25 animations:^{
            //平移手臂
            _leftHand.transform = CGAffineTransformMakeTranslation(-_leftarmOffsetX, _offsetY);
            _rightHand.transform = CGAffineTransformMakeTranslation(_rightarmOffsetx, _offsetY);
            //清楚手的形变
            _leftArm.transform = CGAffineTransformIdentity;
            _rightArm.transform = CGAffineTransformIdentity;
        }];
    }
}

@end
