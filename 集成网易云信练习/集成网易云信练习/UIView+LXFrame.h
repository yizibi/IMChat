//
//  UIView+LXFrame.h
//  贷了么
//
//  Created by 李lucy on 14/01/7.
//  Copyright © 2014年 Lucy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LXFrame)

@property (nonatomic, assign) CGFloat lx_width;
@property (nonatomic, assign) CGFloat lx_height;
@property (nonatomic, assign) CGFloat lx_x;
@property (nonatomic, assign) CGFloat lx_y;
@property (nonatomic, assign) CGFloat lx_centerX;
@property (nonatomic, assign) CGFloat lx_centerY;
@property (nonatomic, assign) CGFloat lx_right;
@property (nonatomic, assign) CGFloat lx_bottom;

+ (instancetype)viewloadFromXib;
- (BOOL)intersectWithView:(UIView *)view;
- (void)moveBy:(CGPoint)delta;
- (void)scaleBy:(CGFloat)scaleFactor;
- (void)fitInSize:(CGSize)aSize;
@end
