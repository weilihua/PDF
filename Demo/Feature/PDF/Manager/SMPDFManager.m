//
//  SMPDFManager.m
//  Demo
//
//  Created by weilihua on 2023/6/29.
//

#import "SMPDFManager.h"
#import "SMDownloadTask.h"
#import "FCFileManager.h"
#import "NSString+Crypto.h"
#import <PDFKit/PDFKit.h>

@implementation SMPDFManager

#pragma mark -
#pragma mark Public Method

/// 获取配置信息
+ (void)getConfig:(void(^)(SMConfig* config))resultBlock {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"json"];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableLeaves error:nil];
    SMConfig *config = [SMConfig yy_modelWithJSON:dict];
    if (resultBlock) {
        resultBlock(config);
    }
}

/// 通过url获取PDF
/// - Parameters:
///   - url: 链接
///   - progress: 进度
///   - resultBlock: 结果
+ (void)getPdfWithUrl:(NSString *)url
             progress:(void(^)(CGFloat progress))progress
          resultBlock:(void(^)(BOOL success, NSData *data))resultBlock {
    NSString *path = [self filePath:url];
    if ([FCFileManager existsItemAtPath:path]) {
        NSData *data = [FCFileManager readFileAtPathAsData:path];
        if (!data) {
            if (resultBlock) {
                resultBlock(YES, data);
            }
            return;
        }
    }
    [SMDownloadTask.new downloadWithURL:url
                               filePath:path
                          progressBlock:progress
                            finishBlock:^(NSString * _Nullable location) {
        NSData *data = [FCFileManager readFileAtPathAsData:location];
        if (resultBlock) {
            resultBlock(YES, data);
        }
    } errorBlock:^(NSError * _Nullable error) {
        if (resultBlock) {
            resultBlock(NO, nil);
        }
    }];
    
}

/// 通过path获取PDF
/// - Parameters:
///   - url: 本地路径
///   - resultBlock: 结果
+ (void)getPdfWithPath:(NSString *)path
           resultBlock:(void(^)(BOOL success, NSData *data))resultBlock {
    if ([FCFileManager existsItemAtPath:path]) {
        NSData *data = [FCFileManager readFileAtPathAsData:path];
        if (resultBlock) {
            resultBlock(YES, data);
        }
    } else {
        if (resultBlock) {
            resultBlock(NO, nil);
        }
    }
}


/// 通过图片创建PDF
/// - Parameters:
///   - images: 图片
///   - resultBlock: 结果
+ (void)createPdfWithImages:(NSArray<UIImage*>*)images
                resultBlock:(void(^)(BOOL success, NSString *path))resultBlock {
    if (!images || images.count == 0) {
        if (resultBlock) {
            resultBlock(NO, nil);
        }
        return;
    }
    NSInteger time = [[NSDate date] timeIntervalSince1970];
    NSString *name = [NSString stringWithFormat:@"%ld.pdf", (long)time];
    NSString *path = [[self pdfPath] stringByAppendingPathComponent:name];
    if ([FCFileManager existsItemAtPath:path]) {
        [FCFileManager removeItemAtPath:path];
    }
    go(^{
        PDFDocument *document = [PDFDocument new];
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            PDFPage *page = [[PDFPage alloc] initWithImage:obj];
            [document insertPage:page atIndex:idx];
        }];
        if ([document writeToFile:path]) {
            if (resultBlock) {
                resultBlock(YES, path);
            }
        } else {
            if (resultBlock) {
                resultBlock(NO, nil);
            }
        }
    });
}

#pragma mark -
#pragma mark Privete Method

+ (NSString *)filePath:(NSString *)url {
    NSString *fileName = [NSString stringWithFormat:@"%@",[url stringToMD5]];
    NSString *path = [[self pdfPath] stringByAppendingPathComponent:fileName];
    return path;
}

+ (NSString*)pdfPath {
    NSString *path = [[self rootPath] stringByAppendingPathComponent:@"PDF"];
    // 如果目录不存在则创建文件夹
    if (![FCFileManager existsItemAtPath:path]) {
        [FCFileManager createDirectoriesForPath:path];
    }
    return path;
}

+ (NSString *)rootPath {
    NSString *path = [FCFileManager pathForDocumentsDirectoryWithPath:@"Storage"];
    // 如果目录不存在则创建文件夹
    if (![FCFileManager existsItemAtPath:path]) {
        [FCFileManager createDirectoriesForPath:path];
    }
    return path;
}

@end
