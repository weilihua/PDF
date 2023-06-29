//
//  QMUserDefaults.h
//  StarMaker
//
//  Created by weilihua on 14/8/18.
//  Copyright © 2018年 uShow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMUserDefaults : NSObject

/**
 设置NSString值

 @param value NSString类型
 @param key 键值
 */
+ (void)qm_setString:(NSString * _Nullable)value
              forKey:(NSString * _Nonnull)key;


/**
 设置Integer值

 @param value Integer类型
 @param key 键值
 */
+ (void)qm_setInteger:(NSInteger)value
               forKey:(NSString * _Nonnull)key;

/**
 设置Double值

 @param value Double类型
 @param key 键值
 */
+ (void)qm_setDouble:(double)value
              forKey:(NSString * _Nonnull)key;

/**
 设置Float值

 @param value Float类型
 @param key 键值
 */
+ (void)qm_setFloat:(float)value
             forKey:(NSString * _Nonnull)key;

/**
 设置BOOL类型

 @param value BOOL类型
 @param key 键值
 */
+ (void)qm_setBool:(BOOL)value
            forKey:(NSString * _Nonnull)key;

/**
 设置NSData类型

 @param value NSData类型
 @param key 键值
 */
+ (void)qm_setData:(NSData* _Nullable)value
            forKey:(NSString  * _Nonnull)key;

/**
 设置NSDate类型

 @param value NSDate类型
 @param key 键值
 */
+ (void)qm_setDate:(NSDate* _Nullable)value
            forKey:(NSString * _Nonnull)key;

/**
 设置Object类型

 @param value Object类型(支持自定义对象)
 @param key 键值
 */
+ (BOOL)qm_setObject:(id)value
              forKey:(NSString * _Nonnull)key;

/**
 获取NSString类型

 @param key 键值
 @return 返回NSString
 */
+ (nullable NSString*)qm_getString:(NSString * _Nonnull)key;

/**
 获取Integer类型

 @param key 键值
 @return 返回Integer类型
 */
+ (NSInteger)qm_getInteger:(NSString * _Nonnull)key;

/**
 获取double类型

 @param key 键值
 @return 返回double类型
 */
+ (double)qm_getDouble:(NSString * _Nonnull)key;

/**
 获取float类型

 @param key 键值
 @return 返回float类型
 */
+ (float)qm_getFloat:(NSString * _Nonnull)key;

/**
 获取BOOL类型

 @param key 键值
 @return 返回BOOL类型
 */
+ (BOOL)qm_getBool:(NSString * _Nonnull)key;

/**
 获取NSData类型

 @param key 键值
 @return 返回NSData类型
 */
+ (nullable NSData*)qm_getData:(NSString * _Nonnull)key;

/**
 获取NSDate类型

 @param key 键值
 @return 返回NSDate类型
 */
+ (nullable NSDate*)qm_getDate:(NSString * _Nonnull)key;

/**
 获取Object类型

 @param key 键值
 @param ofClass 类名
 @return 返回Class类型
 */
+ (id)qm_getObject:(NSString * _Nonnull)key ofClass:(Class)ofClass;

/// 根据key删除value
/// @param key key值
+ (void)clearWithKey:(NSString * _Nonnull)key;

@end
