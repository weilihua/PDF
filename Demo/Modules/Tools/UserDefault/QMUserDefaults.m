//
//  QMUserDefaults.m
//  StarMaker
//
//  Created by weilihua on 14/8/18.
//  Copyright © 2018年 uShow. All rights reserved.
//

#import "QMUserDefaults.h"
#import <MMKV/MMKV.h>

@implementation QMUserDefaults

// 设置NSString值
+ (void)qm_setString:(NSString * _Nullable)value
              forKey:(NSString * _Nonnull)key {
    if (!key || key.length <= 0) {
        return;
    }
    [MMKV.defaultMMKV setString:value forKey:key];
}

// 设置Integer值
+ (void)qm_setInteger:(NSInteger)value
               forKey:(NSString * _Nonnull)key {
    if (!key || key.length <= 0) {
        return;
    }
    [MMKV.defaultMMKV setInt64:value forKey:key];
}

// 设置Double
+ (void)qm_setDouble:(double)value
              forKey:(NSString * _Nonnull)key {
    if (!key || key.length <= 0) {
        return;
    }
    [MMKV.defaultMMKV setDouble:value forKey:key];
}

// 设置Float值
+ (void)qm_setFloat:(float)value
             forKey:(NSString * _Nonnull)key {
    if (!key || key.length <= 0) {
        return;
    }
    [MMKV.defaultMMKV setFloat:value forKey:key];
}

// 设置BOOL类型
+ (void)qm_setBool:(BOOL)value
            forKey:(NSString * _Nonnull)key {
    if (!key || key.length <= 0) {
        return;
    }
    [MMKV.defaultMMKV setBool:value forKey:key];
}

// 设置qm_setData类型
+ (void)qm_setData:(NSData * _Nullable)value
            forKey:(NSString * _Nonnull)key {
    if (!key || key.length <= 0) {
        return;
    }
    [MMKV.defaultMMKV setData:value forKey:key];
}

// 设置NSDate类型
+ (void)qm_setDate:(NSDate * _Nullable)value
            forKey:(NSString * _Nonnull)key {
    if (!key || key.length <= 0) {
        return;
    }
    [MMKV.defaultMMKV setDate:value forKey:key];
}

// 设置Object类型
+ (BOOL)qm_setObject:(id)value
              forKey:(NSString * _Nonnull)key {
    if (!key || key.length <= 0) {
        return NO;
    }
    return [MMKV.defaultMMKV setObject:value forKey:key];
}

// 获取NSString类型
+ (nullable NSString*)qm_getString:(NSString * _Nonnull)key {
    return [MMKV.defaultMMKV getStringForKey:key];
}

// 获取Integer类型
+ (NSInteger)qm_getInteger:(NSString * _Nonnull)key {
    NSInteger value = [MMKV.defaultMMKV getInt64ForKey:key];
    return value;
}

// 获取Double值
+ (double)qm_getDouble:(NSString * _Nonnull)key {
    return [MMKV.defaultMMKV getDoubleForKey:key];
}

// 获取Float值
+ (float)qm_getFloat:(NSString * _Nonnull)key {
    return [MMKV.defaultMMKV getFloatForKey:key];
}

// 获取BOOL类型
+ (BOOL)qm_getBool:(NSString * _Nonnull)key {
    return [MMKV.defaultMMKV getBoolForKey:key];
}

// 获取NSData类型
+ (nullable NSData*)qm_getData:(NSString * _Nonnull)key {
    return [MMKV.defaultMMKV getDataForKey:key];
}

// 获取NSDate类型
+ (nullable NSDate*)qm_getDate:(NSString * _Nonnull)key {
    return [MMKV.defaultMMKV getDateForKey:key];
}

/**
 获取Object类型

 @param key 键值
 @param ofClass 类名
 @return 返回Class类型
 */
+ (id)qm_getObject:(NSString * _Nonnull)key ofClass:(Class)ofClass {
    return [MMKV.defaultMMKV getObjectOfClass:ofClass forKey:key];
}

// 根据key清除数据
+ (void)clearWithKey:(NSString * _Nonnull)key {
    [MMKV.defaultMMKV removeValueForKey:key];
}

@end
