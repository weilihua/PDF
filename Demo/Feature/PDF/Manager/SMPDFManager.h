//
//  SMPDFManager.h
//  Demo
//
//  Created by weilihua on 2023/6/29.
//

#import <Foundation/Foundation.h>
#import "SMConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMPDFManager : NSObject

/// 获取配置信息
/// - Parameter resultBlock: 结果
+ (void)getConfig:(void(^)(SMConfig* config))resultBlock;

/// 通过url获取PDF
/// - Parameters:
///   - url: 链接
///   - progress: 进度
///   - resultBlock: 结果
+ (void)getPdfWithUrl:(NSString *)url
             progress:(void(^)(CGFloat progress))progress
          resultBlock:(void(^)(BOOL success, NSData *data))resultBlock;

/// 通过path获取PDF
/// - Parameters:
///   - url: 本地路径
///   - resultBlock: 结果
+ (void)getPdfWithPath:(NSString *)path
           resultBlock:(void(^)(BOOL success, NSData *data))resultBlock;


/// 通过图片创建PDF
/// - Parameters:
///   - images: 图片
///   - resultBlock: 结果
+ (void)createPdfWithImages:(NSArray<UIImage*>*)images
                resultBlock:(void(^)(BOOL success, NSString *path))resultBlock;

@end

NS_ASSUME_NONNULL_END
