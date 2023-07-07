//
//  SMPDFViewController.m
//  Demo
//
//  Created by weilihua on 2023/6/28.
//

#import "SMPDFViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "SMPDFManager.h"
#import "SMPDFView.h"


@interface SMPDFViewController ()<SMPDFViewDelegate,NSURLSessionDataDelegate>

@property(nonatomic, strong)SMPDFView *pdfView;
@property(nonatomic, copy)NSString *url;
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
    
    if (self.data) {
        [self.pdfView loadData:self.data];
    }
}

#pragma mark -
#pragma mark Set Method



#pragma mark -
#pragma mark SMPDFViewDelegate

- (void)pdfViewDidDownloadPdf {
    // https://book.pep.com.cn/1211001302181/files/mobile/15.jpg?230217144108
    @weakify(self)
    NSString *url = @"https://www.yaziwenku.com/download/583/?tmstv=1687918332";
    [SMPDFManager getPdfWithUrl:url
                       progress:^(CGFloat progress) {
        NSLog(@"pdf progress:%.2f",progress);
    } resultBlock:^(BOOL success, NSData * _Nonnull data) {
        @strongify(self)
        if (self.resultBlock) {
            self.resultBlock(YES);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.pdfView loadData:data];
        });
    }];
}

@end
