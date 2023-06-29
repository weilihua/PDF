//
//  SMRoom.h
//  Demo
//
//  Created by weilihua on 2022/11/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SMRoomTypeSolo,
    SMRoomTypeChat,
    SMRoomTypeGame,
    SMRoomTypeStage,
} SMRoomType;

@interface SMRoom : QMBaseModel

@property(nonatomic, assign)NSInteger roomId;
@property(nonatomic, copy)NSString *roomName;
@property(nonatomic, assign)SMRoomType type;

@end

NS_ASSUME_NONNULL_END
