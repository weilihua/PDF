//
//  SMPDFHomeController.m
//  Demo
//
//  Created by weilihua on 2023/7/5.
//

#import "SMPDFHomeController.h"
#import "SMPDFViewController.h"
#import "SMPDFHomeView.h"
#import "SMPDFPage.h"
#import "SMPDFManager.h"

@interface SMPDFHomeController ()

@property(nonatomic, strong)SMPDFHomeView *homeView;
@property(nonatomic, strong)NSMutableArray<SMPDFPage*> *pages;
@property(nonatomic, strong)SMConfig *config;

@end

@implementation SMPDFHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}

#pragma mark -
#pragma mark Privete Method

/// 初始化视图
- (void)initView {
    self.view.backgroundColor = UIColor.whiteColor;
    self.homeView = [[SMPDFHomeView alloc] initWithFrame:self.view.bounds];
    @weakify(self)
    self.homeView.makePdfBlock = ^{
        @strongify(self)
        [self.homeView showLoadView];
        [self setupPDFBookData];
    };
    [self.view addSubview:self.homeView];
}

/// 获取配置信息
- (void)initData {
    [SMPDFManager getConfig:^(SMConfig * _Nonnull config) {
        self.config = config;
    }];
}

- (void)setupPDFBookData {
    [self.pages removeAllObjects];
    
    for (NSInteger index = 0; index < 200; index++) {
        SMPDFPage *page = [SMPDFPage new];
        page.index = index;
        page.imageURL = [NSString stringWithFormat:@"https://book.pep.com.cn/1211001302181/files/mobile/%ld.jpg?230217144108",(index+1)];
        [self.pages addObject:page];
    }
    
    dispatch_group_t group = dispatch_group_create();
    
    [self.pages enumerateObjectsUsingBlock:^(SMPDFPage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_group_enter(group);
        [SDWebImageDownloader.sharedDownloader downloadImageWithURL:[NSURL URLWithString:obj.imageURL] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            obj.image = image;
            dispatch_group_leave(group);
        }];
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self createPDF];
    });
}

- (void)createPDF {
    NSMutableArray *images = [NSMutableArray new];
    [self.pages enumerateObjectsUsingBlock:^(SMPDFPage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.image) {
            [images addObject:obj.image];
        }
    }];
    
    [SMPDFManager createPdfWithImages:images resultBlock:^(BOOL success, NSString * _Nonnull path) {
        run(^{
            if (success) {
                @weakify(self)
                [SMPDFManager getPdfWithPath:path resultBlock:^(BOOL success, NSData * _Nonnull data) {
                    @strongify(self)
                    [self.homeView hiddenLoadView];
                    if (success) {
                        [self gotoPDFWithData:data];
                    } else {
                        NSLog(@"error");
                    }
                }];
            }
        });
    }];
}

- (void)gotoPDFWithData:(NSData*)data {
    SMPDFViewController *vc = [SMPDFViewController new];
    vc.data = data;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark Getter

- (NSMutableArray *)pages {
    if (!_pages) {
        _pages = [NSMutableArray new];
    }
    return _pages;
}


@end
