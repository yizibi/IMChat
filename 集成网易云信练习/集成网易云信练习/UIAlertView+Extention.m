//
//  UIAlertView+Extention.m
//  集成网易云信练习
//
//  Created by 李lucy on 16/5/24.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

#import "UIAlertView+Extention.h"

#import <objc/runtime.h>
#import <objc/message.h>

static char kUIAlertViewBlockAddress;
@implementation UIAlertView (Extention)

- (void)showAlertWithCompletionHandler:(alertBlack)block{
    self.delegate = self;
    objc_setAssociatedObject(self, &kUIAlertViewBlockAddress, block, OBJC_ASSOCIATION_COPY);
    
    [self show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    alertBlack block = objc_getAssociatedObject(self, &kUIAlertViewBlockAddress);
    if (block)
    {
        block(buttonIndex);
        objc_setAssociatedObject(self, &kUIAlertViewBlockAddress, nil, OBJC_ASSOCIATION_COPY);
    }
}

- (void)clearActionBlock
{
    self.delegate = nil;
    objc_setAssociatedObject(self, &kUIAlertViewBlockAddress, nil, OBJC_ASSOCIATION_COPY);
}

@end
