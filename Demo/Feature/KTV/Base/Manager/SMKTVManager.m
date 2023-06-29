//
//  SMKTVManager.m
//  Demo
//
//  Created by weilihua on 2022/11/5.
//

#import "SMKTVManager.h"

// 创建静态对象 防止外部访问
static SMKTVManager* instance = nil;

NSString *kSMJoinRoomSuccessNotify = @"joinRoomSuccessNotify";// 加入房间成功通知
NSString *kSMSwitchRoomSuccessNotify = @"switchRoomSuccessNotify";// 切换房间成功通知

@interface SMKTVManager()

@property(nonatomic, strong, nullable)SMRoom *room;
@property(nonatomic, strong, nullable)NSArray<SMUser*> *users;
@property(nonatomic, strong, nullable)NSArray<SMSeat*> *seats;

@end

@implementation SMKTVManager

#pragma mark -
#pragma mark System Method

// 生成单例对象
+ (instancetype)share {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    }) ;
    return instance ;
}

// 禁止alloc新对象
+(id)allocWithZone:(struct _NSZone *)zone {
    return [SMKTVManager share] ;
}

// 禁止copy新对象
-(id)copyWithZone:(struct _NSZone *)zone {
    return [SMKTVManager share] ;
}

#pragma mark -
#pragma mark Private Method

/// 请求房间信息
- (void)requestRoomInfoWithId:(NSInteger)roomId
                  resultBlock:(void(^)(SMRoom *room, NSError *error))resultBlock {
    if (self.room) {
        if (resultBlock) {
            resultBlock(self.room, nil);
        }
    }else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            SMRoom *room = [SMRoom new];
            room.roomId = roomId;
            room.roomName = [NSString stringWithFormat:@"房间:%ld", (long)roomId];
            self.room = room;
            if (resultBlock) {
                resultBlock(self.room, nil);
            }
        });
    }
}

/// 请求加入房间
- (void)requestJoinRoom {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self joinRoomSuccess];
    });
}

/// 切换房间
- (void)switchRoomWityType:(SMRoomType)type {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self switchRoomSuccess:type];
    });
}

- (void)insertMsg:(SMMessage *)msg {
    if (!msg) {
        return;
    }
    if (!self.messages) {
        self.messages = [NSMutableArray new];
    }
    [self.messages addObject:msg];
}

#pragma mark -
#pragma mark Recive Message

- (void)joinRoomSuccess {
    SMUser *user = [SMUser new];
    user.userId = 1000;
    user.userName = @"User1";
    
    [NSNotificationCenter.defaultCenter postNotificationName:kSMJoinRoomSuccessNotify
                                                      object:user];
}

- (void)switchRoomSuccess:(SMRoomType)type {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [NSNotificationCenter.defaultCenter postNotificationName:kSMSwitchRoomSuccessNotify
                                                          object:@(type)];
    });
}

#pragma mark -
#pragma mark Public Method

/// 获取房间信息
+ (void)requestRoomInfoWithId:(NSInteger)roomId
                  resultBlock:(void(^)(SMRoom *room, NSError *error))resultBlock {
    [SMKTVManager.share requestRoomInfoWithId:roomId resultBlock:resultBlock];
}

/// 请求加入房间
+ (void)requestJoinRoom:(NSInteger)roomId {
    [SMKTVManager.share requestJoinRoom];
}

/// 切换房间
+ (void)switchRoomWityType:(SMRoomType)type {
    [SMKTVManager.share switchRoomWityType:type];
}

+ (void)insertMsg:(SMMessage *)msg {
    [SMKTVManager.share insertMsg:msg];
}

@end
