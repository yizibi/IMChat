//
//  UIView+LXFrame.m
//  贷了么
//
//  Created by 李lucy on 14/01/7.
//  Copyright © 2014年 Lucy. All rights reserved.
//

#import "UIView+LXFrame.h"

@implementation UIView (LXFrame)

- (void)setLx_width:(CGFloat)lx_width
{
    CGRect frame = self.frame;
    frame.size.width = lx_width;
    self.frame = frame;
}

- (void)setLx_height:(CGFloat)lx_height
{
    CGRect frame = self.frame;
    frame.size.height = lx_height;
    self.frame = frame;
}

- (CGFloat)lx_width
{
    return self.frame.size.width;
}

- (CGFloat)lx_height
{
    return self.frame.size.height;
}

- (void)setLx_x:(CGFloat)lx_x
{
    CGRect frame = self.frame;
    frame.origin.x = lx_x;
    self.frame = frame;
}

- (void)setLx_y:(CGFloat)lx_y
{
    CGRect frame = self.frame;
    frame.origin.y = lx_y;
    self.frame = frame;
}

- (CGFloat)lx_x
{
    return self.frame.origin.x;
}

- (CGFloat)lx_y
{
    return self.frame.origin.y;
}

- (void)setLx_centerX:(CGFloat)lx_centerX
{
    CGPoint center = self.center;
    center.x = lx_centerX;
    self.center = center;
}

- (void)setLx_centerY:(CGFloat)lx_centerY
{
    CGPoint center = self.center;
    center.y = lx_centerY;
    self.center = center;
}

- (CGFloat)lx_centerX
{
    return self.center.x;
}

- (CGFloat)lx_centerY
{
    return self.center.y;
}

- (void)setLx_right:(CGFloat)lx_right
{
    self.lx_x = lx_right - self.lx_width;
}

- (void)setLx_bottom:(CGFloat)lx_bottom
{
    self.lx_y = lx_bottom - self.lx_height;
}
- (CGFloat)lx_right
{
    return CGRectGetMaxX(self.frame);
}

-(CGFloat)lx_bottom
{
    return CGRectGetMaxY(self.frame);
}

//加载xib控件
+ (instancetype)viewloadFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
//判断两个不同的view,是否重叠,转换到window下的坐标系(也就是以window为父控件)
- (BOOL)intersectWithView:(UIView *)view
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return CGRectIntersectsRect(selfRect, viewRect);
}


// Move via offset
- (void) moveBy: (CGPoint) delta{
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

// Scaling
- (void)scaleBy:(CGFloat)scaleFactor{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void)fitInSize:(CGSize)aSize{
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height)){
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width)){
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;
}


@end
