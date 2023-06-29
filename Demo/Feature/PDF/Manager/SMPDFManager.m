//
//  SMPDFManager.m
//  Demo
//
//  Created by weilihua on 2023/6/29.
//

#import "SMPDFManager.h"
#import "SMDownloadTask.h"

@implementation SMPDFManager

#pragma mark -
#pragma mark Public Method

/// 通过url获取PDF
/// - Parameters:
///   - url: 链接
///   - resultBlock: 结果
+ (void)getPdfWithUrl:(NSString *)url
          resultBlock:(void(^)(BOOL success, NSData *data))resultBlock {
    
}

/// 通过path获取PDF
/// - Parameters:
///   - url: 本地路径
///   - resultBlock: 结果
+ (void)getPdfWithPath:(NSString *)path
           resultBlock:(void(^)(BOOL success, NSData *data))resultBlock {
    
}


/// 通过图片创建PDF
/// - Parameters:
///   - images: 图片
///   - resultBlock: 结果
+ (void)createPdfWithImages:(NSArray<UIImage*>*)images
                resultBlock:(void(^)(BOOL success, NSData *data))resultBlock {
    
}

@end
