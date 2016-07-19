//
//  LX_TestChatViewController.m
//  集成网易云信练习
//
//  Created by 李lucy on 16/5/24.
//  Copyright © 2016年 com.muyandialog.Co.,Ltd. All rights reserved.
//

#import "LX_TestChatViewController.h"
#import "LX_TestSessionConfig.h"
#import "NTESFileLocationHelper.h"
#import "NTESTimerHolder.h"

#import "NSDictionary+NTESJson.h"
#import "NTESCustomSysNotificationSender.h"
#import "NTESChartletAttachment.h"

#import "NTESSessionMsgConverter.h"
#import "UIView+NIMKitToast.h"

#import "NTESGalleryViewController.h"//浏览大图
#import "NTESSnapchatAttachment.h"//阅后即焚

//音视频
#import "NTESAudioChatViewController.h"
#import "UIView+NIMKitToast.h"
#import "Reachability.h"


@import MobileCoreServices;
@import AVFoundation;

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

typedef enum : NSUInteger {
    NTESImagePickerModeImage,
    NTESImagePickerModeSnapChat,//阅后即焚
} NTESImagePickerMode;


@interface LX_TestChatViewController()
<NIMInputActionDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
NTESTimerHolderDelegate,
NIMSystemNotificationManagerDelegate,
NIMMediaManagerDelgate>

/** 配置信息 */
@property (nonatomic, strong) LX_TestSessionConfig *sessionConfig;

@property (nonatomic,strong)    UIImagePickerController *imagePicker;

@property (nonatomic,assign)    NTESImagePickerMode   mode;

@property (nonatomic,strong)    NTESTimerHolder      *titleTimer;

@property (nonatomic,strong)    NSString *playingAudioPath; //正在播放的音频路径

@property (nonatomic,strong)    NTESCustomSysNotificationSender *notificaionSender;


@end


@implementation LX_TestChatViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSLog(@"enter session, id = %@",self.session.sessionId);
    
    BOOL disableCommandTyping = self.disableCommandTyping || (self.session.sessionType == NIMSessionTypeP2P &&[[NIMSDK sharedSDK].userManager isUserInBlackList:self.session.sessionId]);
    
    if (!disableCommandTyping) {
        
        _titleTimer = [[NTESTimerHolder alloc] init];
        
        [[[NIMSDK sharedSDK] systemNotificationManager] addDelegate:self];
    }
    

}


- (void)dealloc{
    [[[NIMSDK sharedSDK] systemNotificationManager] removeDelegate:self];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NIMSDK sharedSDK].mediaManager stopRecord];
    [[NIMSDK sharedSDK].mediaManager stopPlay];
}

-(id<NIMSessionConfig>)sessionConfig
{
    if (!_sessionConfig) {
        _sessionConfig = [[LX_TestSessionConfig alloc] init];
        _sessionConfig.session = self.session;
    }
   return  _sessionConfig;
}


#pragma mark - NIMSystemNotificationManagerProcol
- (void)onReceiveCustomSystemNotification:(NIMCustomSystemNotification *)notification
{
    if (!notification.sendToOnlineUsersOnly) {
        return;
    }
    
    NSData *data = [[notification content] dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if ([dict jsonInteger:NTESNotifyID] == NTESCommandTyping && self.session.sessionType == NIMSessionTypeP2P && [notification.sender isEqualToString:self.session.sessionId])
        {
            self.navigationItem.title = @"正在输入...";
            [_titleTimer startTimer:5
                           delegate:self
                            repeats:NO];
        }
    }
    
}


- (void)onNTESTimerFired:(NTESTimerHolder *)holder
{
    self.navigationItem.title = [self sessionTitle];
}

- (NSString *)sessionTitle{
    if ([self.session.sessionId isEqualToString:[NIMSDK sharedSDK].loginManager.currentAccount]) {
        return  @"我的电脑";
    }
    
    return [super sessionTitle];
    
}

#pragma mark - NIMInputActionDelegate
- (void)onTapMediaItem:(NIMMediaItem *)item{
    
    NSDictionary *actions = [self inputActions];
    
    NSString *value = actions[@(item.tag)];
    BOOL handled = NO;
    if (value) {
        SEL selector = NSSelectorFromString(value);
        if (selector && [self respondsToSelector:selector]) {
            SuppressPerformSelectorLeakWarning([self performSelector:selector]);
            handled = YES;
        }
    }
    if (!handled) {
        NSAssert(0, @"invalid item tag");
    }

}


- (void)onTextChanged:(id)sender
{
    [_notificaionSender sendTypingState:self.session];
}


- (void)onSelectChartlet:(NSString *)chartletId
                 catalog:(NSString *)catalogId
{
    NTESChartletAttachment *attachment = [[NTESChartletAttachment alloc] init];
    attachment.chartletId = chartletId;
    attachment.chartletCatalog = catalogId;
    
    [self sendMessage:[NTESSessionMsgConverter msgWithChartletAttachment:attachment]];
}

#pragma mark - 会话界面底部媒体键盘
- (NSDictionary *)inputActions{
    
    static NSDictionary *actions = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        actions = @{
                    @(NTESMediaButtonPicture)   ://相册
                        @"mediaPicturePressed",
                    @(NTESMediaButtonShoot)     ://拍摄
                        @"mediaShootPressed",
                    @(NTESMediaButtonAudioChat) ://语音
                        @"mediaAudioChatPressed",
                    @(NTESMediaButtonVideoChat) ://视频
                        @"mediaVideoChatPressed",
                    @(NTESMediaButtonWhiteBoard)://白板
                        @"mediaWhiteBoardPressed",
                    @(NTESMediaButtonTip)       ://提醒消息
                        @"mediaTipPressed"
                    };
    });
    
    return actions;

}

#pragma mark - 会话cell事件
- (NSDictionary *)cellActions
{
    static NSDictionary *actions = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        actions = @{@(NIMMessageTypeImage) ://展示大图
                        @"showImage:",
                    @(NIMMessageTypeAudio) ://播放音频
                        @"playAudio:",
                    
//                    @(NIMMessageTypeVideo) :    @"showVideo:",
                    
//                    @(NIMMessageTypeLocation) ://位置
//                        @"showLocation:",
//                    @(NIMMessageTypeFile)  ://文件类型
//                        @"showFile:",
//                    @(NIMMessageTypeCustom):
//                        @"showCustom:"
                    };
    });
    
    return actions;
}



#pragma mark - cellActions事件
#pragma mark - 点击cell,浏览大图
- (void)showImage:(NIMMessage *)message
{
    NIMImageObject *object = message.messageObject;

    
    NTESGalleryItem *item = [[NTESGalleryItem alloc] init];
    item.thumbPath      = [object thumbPath];
    item.imageURL       = [object url];
    item.name           = [object displayName];
    
    NTESGalleryViewController *vc = [[NTESGalleryViewController alloc] initWithItem:item];
    [self.navigationController pushViewController:vc animated:YES];
    if(![[NSFileManager defaultManager] fileExistsAtPath:object.thumbPath]){
        //如果缩略图下跪了，点进看大图的时候再去下一把缩略图
        __weak typeof(self) wself = self;
        [[NIMSDK sharedSDK].resourceManager download:object.thumbUrl filepath:object.thumbPath progress:nil completion:^(NSError *error) {
            if (!error) {
                [wself uiUpdateMessage:message];
            }
        }];
    }
    
    
}


#pragma mark - 辅助方法
- (BOOL)checkCondition
{
    BOOL result = YES;
    
    if (![[Reachability reachabilityForInternetConnection] isReachable]) {
        [self.view nimkit_makeToast:@"请检查网络" duration:2.0 position:NIMKitToastPositionCenter];
        result = NO;
    }
    
    NSString *currentAccount = [[NIMSDK sharedSDK].loginManager currentAccount];
    if ([currentAccount isEqualToString:self.session.sessionId]) {
        [self.view nimkit_makeToast:@"不能和自己通话哦" duration:2.0 position:NIMKitToastPositionCenter];
        result = NO;
    }
    
    return result;
}

#pragma mark - inputActions事件

#pragma mark - 语音呼叫
- (void)mediaAudioChatPressed
{
    NSLog(@"点击了语音呼叫");
    if ([self checkCondition]) {
        //由于音视频聊天里头有音频和视频聊天界面的切换，直接用present的话页面过渡会不太自然，这里还是用push，然后做出present的效果
        
        NTESAudioChatViewController *vc = [[NTESAudioChatViewController alloc] initWithCallee:self.session.sessionId];
        
//        CATransition *transition = [CATransition animation];
//        transition.duration = 0.25;
//        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
//        transition.type = kCATransitionPush;
//        transition.subtype = kCATransitionFromTop;
//        transition.delegate = self;
//        [self.navigationController.view.layer addAnimation:transition forKey:nil];
//        self.navigationController.navigationBarHidden = YES;
//        [self.navigationController pushViewController:vc animated:NO];
        
        [self presentViewController:vc animated:YES completion:nil];
    }
    
}


#pragma mark - 视频呼叫
- (void)mediaVideoChatPressed
{
    NSLog(@"点击了视频呼叫");
//    if ([self checkCondition]) {
//        //由于音视频聊天里头有音频和视频聊天界面的切换，直接用present的话页面过渡会不太自然，这里还是用push，然后做出present的效果
//        NTESVideoChatViewController *vc = [[NTESVideoChatViewController alloc] initWithCallee:self.session.sessionId];
//        CATransition *transition = [CATransition animation];
//        transition.duration = 0.25;
//        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
//        transition.type = kCATransitionPush;
//        transition.subtype = kCATransitionFromTop;
//        transition.delegate = self;
//        [self.navigationController.view.layer addAnimation:transition forKey:nil];
//        self.navigationController.navigationBarHidden = YES;
//        [self.navigationController pushViewController:vc animated:NO];
//    }
}





#pragma mark - 摄像
- (void)mediaShootPressed
{
    if ([self initCamera]) {
#if TARGET_IPHONE_SIMULATOR
        NSAssert(0, @"not supported");
#elif TARGET_OS_IPHONE
        self.imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
#endif
    }
}

- (BOOL)initCamera{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:@"检测不到相机设备"
                                   delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil] show];
        return NO;
    }
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:@"相机权限受限"
                                   delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil] show];
        return NO;
        
    }
    [self initImagePicker];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage];
    return YES;
}

#pragma mark - 相册
- (void)mediaPicturePressed{
    
    NSLog(@"点击了相册");
    [self initImagePicker];
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    _mode = NTESImagePickerModeImage;
    [self presentViewController:_imagePicker animated:YES completion:nil];

}

- (void)initImagePicker{
    
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
    }

    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *inputURL  = [info objectForKey:UIImagePickerControllerMediaURL];
            
            NSString *outputFileName = [NTESFileLocationHelper genFilenameWithExt:VideoExt];
            NSString *outputPath = [NTESFileLocationHelper filepathForVideo:outputFileName];
            AVURLAsset *asset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
            AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:asset
                                                                             presetName:AVAssetExportPresetMediumQuality];
            session.outputURL = [NSURL fileURLWithPath:outputPath];
            session.outputFileType = AVFileTypeMPEG4;   // 支持安卓某些机器的视频播放
            session.shouldOptimizeForNetworkUse = YES;
            [session exportAsynchronouslyWithCompletionHandler:^(void)
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     if (session.status == AVAssetExportSessionStatusCompleted) {
                         
                         NSLog(@"发送视频");
                         [self sendMessage:[NTESSessionMsgConverter msgWithVideo:outputPath]];
                     }
                     else {
//                         
                         [self.view nimkit_makeToast:@"发送失败"
                                     duration:2
                                     position:NIMKitToastPositionCenter];
                         
                         NSLog(@"发送失败了");
                     }
                 });
             }];
            
        });
        
    }else{
        UIImage *orgImage = info[UIImagePickerControllerOriginalImage];
        switch (_mode) {
            case NTESImagePickerModeImage:
                [self sendMessage:[NTESSessionMsgConverter msgWithImage:orgImage]];
                break;
            case NTESImagePickerModeSnapChat:
                [self sendSnapchatMessage:orgImage];
                break;
            default:
                break;
        }
    }
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendSnapchatMessage:(UIImage *)image
{
    NTESSnapchatAttachment *attachment = [[NTESSnapchatAttachment alloc] init];
    [attachment setImage:image];
    [self sendMessage:[NTESSessionMsgConverter msgWithSnapchatAttachment:attachment]];
}

#pragma mark - 白板呼叫
- (void)mediaWhiteBoardPressed
{
    NSLog(@"点击了白板呼叫");
//    NTESWhiteboardViewController *vc = [[NTESWhiteboardViewController alloc] initWithSessionID:nil
//                                                                                        peerID:self.session.sessionId
//                                                                                         types:NIMRTSServiceReliableTransfer | NIMRTSServiceAudio
//                                                                                          info:@"白板演示"];
//    [self presentViewController:vc animated:NO completion:nil];
}



#pragma mark - 提醒消息
- (void)mediaTipPressed
{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:@"输入提醒" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert showAlertWithCompletionHandler:^(NSInteger index) {
        switch (index) {
            case 1:{
                UITextField *textField = [alert textFieldAtIndex:0];
                NIMMessage *message = [NTESSessionMsgConverter msgWithTip:textField.text];
                [self sendMessage:message];
                
            }
                break;
            default:
                break;
        }
    }];
}

#pragma mark - 系统通知

#pragma mark - Cell事件
- (void)onTapCell:(NIMKitEvent *)event
{
    BOOL handled = NO;
    NSString *eventName = event.eventName;
    if ([eventName isEqualToString:NIMKitEventNameTapContent])
    {
        NIMMessage *message = event.messageModel.message;
        NSDictionary *actions = [self cellActions];
        NSString *value = actions[@(message.messageType)];
        if (value) {
            SEL selector = NSSelectorFromString(value);
            if (selector && [self respondsToSelector:selector]) {
                SuppressPerformSelectorLeakWarning([self performSelector:selector withObject:message]);
                handled = YES;
            }
        }
    }
    else if([eventName isEqualToString:NIMKitEventNameTapLabelLink])
    {
        NSString *link = event.data;
        [self.view nimkit_makeToast:[NSString stringWithFormat:@"tap link : %@",link]
                    duration:2
                    position:NIMKitToastPositionCenter];
        handled = YES;
    }
    
//    else if([eventName isEqualToString:NIMDemoEventNameOpenSnapPicture])
//    {
//        NIMCustomObject *object = event.messageModel.message.messageObject;
//        NTESSnapchatAttachment *attachment = (NTESSnapchatAttachment *)object.attachment;
//        if(attachment.isFired){
//            return;
//        }
//        UIView *sender = event.data;
//        self.currentSingleSnapView = [NTESGalleryViewController alertSingleSnapViewWithMessage:object.message baseView:sender];
//        handled = YES;
//    }
//    else if([eventName isEqualToString:NIMDemoEventNameCloseSnapPicture])
//    {
//        //点击很快的时候可能会触发两次查看，所以这里不管有没有查看过 先强直销毁掉
//        NIMCustomObject *object = event.messageModel.message.messageObject;
//        UIView *senderView = event.data;
//        [senderView dismissPresentedView:YES complete:nil];
//        
//        NTESSnapchatAttachment *attachment = (NTESSnapchatAttachment *)object.attachment;
//        if(attachment.isFired){
//            return;
//        }
//        attachment.isFired  = YES;
//        NIMMessage *message = object.message;
//        if ([NTESBundleSetting sharedConfig].autoRemoveSnapMessage) {
//            [[NIMSDK sharedSDK].conversationManager deleteMessage:message];
//            [self uiDeleteMessage:message];
//            
//        }else{
//            [[NIMSDK sharedSDK].conversationManager updateMessage:message forSession:message.session completion:nil];
//            [self uiUpdateMessage:message];
//        }
//        [[NSFileManager defaultManager] removeItemAtPath:attachment.filepath error:nil];
//        handled = YES;
//        self.currentSingleSnapView = nil;
//    }
//    
    if (!handled) {
        NSAssert(0, @"invalid event");
    }
}


#pragma mark - 长按cell事件
- (void)onLongPressCell:(NIMMessage *)message inView:(UIView *)view
{
    [super onLongPressCell:message
                    inView:view];
}


#pragma mark - NIMMediaManagerDelgate
- (void)playAudio:(NSString *)filePath didBeganWithError:(NSError *)error {
    self.playingAudioPath = filePath;
}

- (void)playAudio:(NSString *)filePath didCompletedWithError:(NSError *)error
{
    self.playingAudioPath = nil;
}


#pragma mark - 录音事件
- (void)onRecordFailed:(NSError *)error
{
    [self.view nimkit_makeToast:@"录音失败" duration:2 position:NIMKitToastPositionCenter];
}

- (BOOL)recordFileCanBeSend:(NSString *)filepath
{
    NSURL    *movieURL = [NSURL fileURLWithPath:filepath];
    AVURLAsset *urlAsset = [[AVURLAsset alloc]initWithURL:movieURL options:nil];
    CMTime time = urlAsset.duration;
    CGFloat mediaLength = CMTimeGetSeconds(time);
    return mediaLength > 2;
}

- (void)showRecordFileNotSendReason
{
    [self.view nimkit_makeToast:@"录音时间太短" duration:0.2f position:NIMKitToastPositionCenter];
}


@end
