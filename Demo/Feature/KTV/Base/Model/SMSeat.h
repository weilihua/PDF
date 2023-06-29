//
//  SMSeat.h
//  Demo
//
//  Created by weilihua on 2022/11/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMSeat : QMBaseModel

@property(nonatomic, assign)NSInteger seatId;
@property(nonatomic, copy)NSString *seatName;

@end

NS_ASSUME_NONNULL_END
