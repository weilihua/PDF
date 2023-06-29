//
//  SMMessage.h
//  Demo
//
//  Created by weilihua on 2022/11/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SMMessageTypeNormal,
    SMMessageTypeSystem,
} SMMessageType;

@interface SMMessage : QMBaseModel

@property(nonatomic, assign)NSInteger msgId;
@property(nonatomic, copy)NSString *content;
@property(nonatomic, assign)SMMessageType type;
@property(nonatomic, assign)CGFloat height;

@end

NS_ASSUME_NONNULL_END
