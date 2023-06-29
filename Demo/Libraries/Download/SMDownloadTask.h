//
//  SMDownloadTask.h
//  Demo
//
//  Created by weilihua on 2023/6/28.
//  Copyright © 2023 uShow. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMDownloadTask : NSObject

@property (nonatomic, strong, readonly)NSString *url;

/// 初始化一个下载任务（支持断点续传）
/// @param url 下载url
/// @param filePath 保存到文件夹的路径（不含文件名和后缀）
/// @param progressBlock 进度block
/// @param finishBlock 完成block
/// @param errorBlock 错误block
- (void)downloadWithURL:(NSString * _Nonnull)url
               filePath:(NSString * _Nonnull)filePath
          progressBlock:(void (^ _Nullable)(CGFloat progress))progressBlock
            finishBlock:(void (^ _Nullable)(NSString * _Nullable location))finishBlock
             errorBlock:(void (^ _Nullable)(NSError * _Nullable error))errorBlock;

// 取消所有的网络请求
- (void)cancel;

@end

NS_ASSUME_NONNULL_END
