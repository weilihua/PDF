//
//  SMPDFViewController.m
//  Demo
//
//  Created by weilihua on 2023/6/28.
//

#import "SMPDFViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "SMPDFView.h"

@interface SMPDFViewController ()<SMPDFViewDelegate,NSURLSessionDataDelegate>

@property(nonatomic, strong)SMPDFView *pdfView;
@property(nonatomic, strong)NSURLSession *session;
@property(nonatomic, strong)NSURLSessionDataTask *task;
@property(nonatomic, copy)NSString *url;
@property(nonatomic, strong)NSMutableData *data;
// 文件的总大小
@property (nonatomic, assign) NSInteger totalLength;
@property(nonatomic, copy)void(^resultBlock)(BOOL success);

@end

@implementation SMPDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = UIColor.whiteColor;
    self.pdfView = [[SMPDFView alloc] initWithFrame:self.view.bounds];
    self.pdfView.delegate = self;
    [self.view addSubview:self.pdfView];
}

- (void)downloadPdfWithURL:(NSString *)url
               resultBlock:(void(^)(BOOL success))resultBlock {
    //执行resume保证开始了任务
    self.url = url;
    self.resultBlock = resultBlock;
    [self.task resume];
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

// 下载任务
- (NSURLSessionDataTask *)task {
    if (!_task) {
        // 创建请求
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
        // 创建一个Data任务
        _task = [self.session dataTaskWithRequest:request];
        _task.priority = NSURLSessionTaskPriorityLow;
    }
    return _task;
}

- (NSMutableData *)data {
    if (!_data) {
        _data = [NSMutableData new];
    }
    return _data;
}

#pragma mark -
#pragma mark SMPDFViewDelegate

- (void)pdfViewDidDownloadPdf {
    NSString *url = @"https://www.yaziwenku.com/download/583/?tmstv=1687918332";
    [self downloadPdfWithURL:url resultBlock:^(BOOL success) {
        
    }];
}

#pragma mark -
#pragma mark NSURLSessionDelegate

// 接收到相应
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSHTTPURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    // 接收这个请求，允许接收服务器的数据
    completionHandler(NSURLSessionResponseAllow);
}

// 接收到服务器返回的数据（这个方法可能会被调用N次）
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    [self.data appendData:data];
}

// 请求完毕（成功\失败）
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error) {
        self.data = nil;
        self.task = nil;
        if (self.resultBlock) {
            self.resultBlock(NO);
        }
    }else{
        // 清除任务
        self.task = nil;
        if (self.resultBlock) {
            self.resultBlock(YES);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.pdfView loadData:self.data];
        });
    }
}

@end
