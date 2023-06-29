//
//  SMUser.h
//  Demo
//
//  Created by weilihua on 2022/11/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMUser : QMBaseModel

@property(nonatomic, assign)NSInteger userId;
@property(nonatomic, copy)NSString *userName;

@end

NS_ASSUME_NONNULL_END
