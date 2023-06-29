//
//  SMBaseKTVRoomController.m
//  Demo
//
//  Created by weilihua on 2022/11/4.
//

#import "SMBaseKTVRoomController.h"
#import "SMKTVChatRoomController.h"
#import "SMKTVGameRoomController.h"
#import "SMKTVManager.h"

@interface SMBaseKTVRoomController ()

@end

@implementation SMBaseKTVRoomController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self addNotification];
    [self requestRoomInfo];
}

// 状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark -
#pragma mark Privete Method

- (void)requestRoomInfo {
    if (SMKTVManager.share.room) {
        [self.roomView hiddenLoadView];
    } else {
        [self.roomView showLoadView];
        [SMKTVManager requestRoomInfoWithId:self.roomId
                                resultBlock:^(SMRoom * _Nonnull room, NSError * _Nonnull error) {
            [self.roomView hiddenLoadView];
            [SMKTVManager requestJoinRoom:self.roomId];
        }];
    }
}

- (void)addNotification {
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(joinRoomSuccessNotify:)
                                               name:kSMJoinRoomSuccessNotify
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(switchRoomSuccessNotify:)
                                               name:kSMSwitchRoomSuccessNotify
                                             object:nil];
}

- (void)switchRoomType:(SMRoomType)type {
    if ([self isMemberOfClass:SMKTVChatRoomController.class] && type == SMRoomTypeChat) {
        return;
    }
    
    if ([self isMemberOfClass:SMKTVGameRoomController.class] && type == SMRoomTypeGame) {
        return;
    }
    SMBaseKTVRoomController *vc = nil;
    if (type == SMRoomTypeChat) {
        vc = [SMKTVChatRoomController new];
    } else if (type == SMRoomTypeGame) {
        vc = [SMKTVGameRoomController new];
    }
    [self.navigationController pushViewController:vc animated:NO];
    
    NSMutableArray *vcs = [NSMutableArray new];
    [vcs addObjectsFromArray:self.navigationController.viewControllers];
    [vcs enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:SMBaseKTVRoomController.class]) {
            [vcs removeObject:obj];
            *stop = YES;
        }
    }];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.viewControllers = vcs;
}

- (void)reloadData {
    [self.roomView reloadData:SMKTVManager.share.messages];
}

#pragma mark -
#pragma mark BaseViewDelegate

- (void)roomViewDidSwitchRoom:(SMRoomType)type {
    [self switchRoomType:type];
//    [SMKTVManager switchRoomWityType:type];
}

#pragma mark -
#pragma mark Notification Method

- (void)joinRoomSuccessNotify:(NSNotification*)notification {
    SMUser *user = notification.object;
    if (user) {
        SMMessage *msg = [SMMessage new];
        msg.type = SMMessageTypeSystem;
        msg.content = [NSString stringWithFormat:@"%@加入了房间",user.userName];
        [SMKTVManager insertMsg:msg];
        [self.roomView insertMsg:msg];
    }
}

- (void)switchRoomSuccessNotify:(NSNotification*)notification {
    SMRoomType type = [notification.object integerValue];
    [self switchRoomType:type];
}

@end
