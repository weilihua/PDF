//
//  SMDownloadTask.m
//  Demo
//
//  Created by weilihua on 2023/6/28.
//  Copyright © 2023 uShow. All rights reserved.
//

#import "SMDownloadTask.h"
#import "QMUserDefaults.h"
#import "NSString+Crypto.h"
#import "QMAsync.h"

@interface SMDownloadTask ()<NSURLSessionDataDelegate>

@property (nonatomic, strong)NSString *url;
@property(nonatomic, copy)NSString *filePath;
@property(nonatomic, copy)NSString *fileFullPath;

@property (nonatomic, strong)NSURLSession *session;
@property (nonatomic, strong)NSURLSessionDataTask *task;

@property (nonatomic, copy) void (^finishBlock)(NSString *location);
@property (nonatomic, copy) void (^progressBlock)(CGFloat progress);
@property (nonatomic, copy) void (^errorBlock)(NSError *error);

// 写文件的流对象
@property (nonatomic, strong) NSOutputStream *stream;

// 文件的总大小
@property (nonatomic, assign) NSInteger totalLength;

@end

@implementation SMDownloadTask

- (void)dealloc {
    NSLog(@">>>>>>>>>>>>>>>>>>>> dealloc");
}

#pragma mark -
#pragma mark Set Method

// URLSession
- (NSURLSession *)session {
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                 delegate:self
                                            delegateQueue:[[NSOperationQueue alloc] init]];

    }
    return _session;
}

// 写入流
- (NSOutputStream *)stream {
    if (!_stream) {
        _stream = [NSOutputStream outputStreamToFileAtPath:self.fileFullPath append:YES];
    }
    return _stream;
}

// 下载任务
- (NSURLSessionDataTask *)task {
    if (!_task) {
        // 创建请求
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
        
        // 设置请求头
        // Range : bytes=xxx-xxx，从已经下载的长度开始到文件总长度的最后都要下载
        NSString *range = [NSString stringWithFormat:@"bytes=%zd-", [self downloadLength]];
        [request setValue:range forHTTPHeaderField:@"Range"];
        
        // 创建一个Data任务
        _task = [self.session dataTaskWithRequest:request];
        _task.priority = NSURLSessionTaskPriorityLow;
    }
    return _task;
}

// 文件夹的路径
- (NSString *)filePath {
    if (_filePath) {
        BOOL isDir = YES;
        BOOL isDirExist = [NSFileManager.defaultManager fileExistsAtPath:_filePath isDirectory:&isDir];
        if (!isDirExist) {
            //路径不存在 创建路径
            [NSFileManager.defaultManager createDirectoryAtPath:_filePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    return _filePath;
}

// 文件全路径
- (NSString *)fileFullPath {
    if (!_fileFullPath) {
        _fileFullPath = [self.filePath stringByAppendingPathComponent:self.url.lastPathComponent];
    }
    return _fileFullPath;
}

#pragma mark -
#pragma mark Private Method

// 已下载文件大小
- (NSInteger)downloadLength {
    NSInteger length = [[[NSFileManager defaultManager] attributesOfItemAtPath:self.fileFullPath error:nil][NSFileSize] integerValue];
    return length;
}

#pragma mark -
#pragma mark Public Method

// 开始下载
- (void)downloadWithURL:(NSString * _Nonnull)url
               filePath:(NSString * _Nonnull)filePath
          progressBlock:(void (^ _Nullable)(CGFloat progress))progressBlock
            finishBlock:(void (^ _Nullable)(NSString * _Nullable location))finishBlock
             errorBlock:(void (^ _Nullable)(NSError * _Nullable error))errorBlock {
    self.url = url;
    self.filePath = filePath;
    
    self.progressBlock = progressBlock;
    self.finishBlock = finishBlock;
    self.errorBlock = errorBlock;
    
    //执行resume保证开始了任务
    [self.task resume];
}

//取消所有的网络请求
- (void)cancel {
    [_task cancel];
    [_session invalidateAndCancel];
    _session = nil;
    self.progressBlock = nil;
    self.errorBlock = nil;
    self.finishBlock = nil;
}

#pragma mark -
#pragma mark NSURLSessionDelegate

// 接收到相应
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSHTTPURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    // 打开流
    [self.stream open];
        
    /* Content-Length字段返回的是服务器对每次客户端请求要下载文件的大小：
     比如首次请求下载文件A，大小为1000byte，那么第一次服务器返回的Content-Length = 1000，
     客户端下载到500byte突然中断，再次请求的range应为“bytes=500-”，那么此时服务器返回的Content-Length为500
     所以对于单个文件进行多次下载的情况（断点续传），计算文件的总大小，必须把服务器返回的content-length加上本地存储的已经下载的文件大小
     */
    self.totalLength = [response.allHeaderFields[@"Content-Length"] integerValue] + [self downloadLength];
    [QMUserDefaults qm_setInteger:self.totalLength forKey:self.url.stringToMD5];
    
    // 接收这个请求，允许接收服务器的数据
    completionHandler(NSURLSessionResponseAllow);
}

// 接收到服务器返回的数据（这个方法可能会被调用N次）
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    // 写入数据
    [self.stream write:data.bytes maxLength:data.length];
    
    float progress = 1.0 * [self downloadLength] / self.totalLength;
    if (self.progressBlock) {
        self.progressBlock(progress);
    }
}

// 请求完毕（成功\失败）
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error) {
        run(^{
            if (self.errorBlock) {
                self.errorBlock(error);
            }
        });
        self.stream = nil;
        self.task = nil;
    }else{
        [QMUserDefaults clearWithKey:self.url.stringToMD5];
        
        run(^{
            if (self.finishBlock) {
                self.finishBlock(self.fileFullPath);
            }
        });
    
        // 关闭流
        [self.stream close];
        self.stream = nil;
        // 清除任务
        self.task = nil;
    }
}

@end
