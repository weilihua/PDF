//
//  SMPDFView.m
//  Demo
//
//  Created by weilihua on 2023/6/28.
//

#import "SMPDFView.h"
#import <PDFKit/PDFKit.h>
#import <Masonry/Masonry.h>

@interface SMPDFView ()<PDFViewDelegate,PDFDocumentDelegate>

@property(nonatomic, strong)UIButton *btnAdd;
@property(nonatomic, strong)PDFView *pdfView;
@property(nonatomic, strong)PDFDocument *pdfDocument;

@end

@implementation SMPDFView

#pragma mark -
#pragma mark Privete Method

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

/// 初始化视图
- (void)initView {
    [self addSubview:self.pdfView];
    [self.pdfView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(64+34);
        make.leading.trailing.bottom.equalTo(self);
    }];
    
    self.btnAdd = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.btnAdd addTarget:self
                    action:@selector(btnAddEvent:)
          forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnAdd];
    
    [self.btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self);
        make.top.equalTo(@(20+34));
        make.height.equalTo(@44);
        make.width.equalTo(@60);
    }];
}

#pragma mark -
#pragma mark Public Method

/// 加载数据
- (void)loadData:(NSData*)data {
    if (!data) {
        return;
    }
    
    self.pdfDocument = [[PDFDocument alloc] initWithData:data];
    self.pdfDocument.delegate = self;
    self.pdfView.document = self.pdfDocument;
    self.pdfView.delegate = self;
}

#pragma mark -
#pragma mark Button Event

- (void)btnAddEvent:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pdfViewDidDownloadPdf)]) {
        [self.delegate pdfViewDidDownloadPdf];
    }
}

#pragma mark -
#pragma mark PDFViewDelegate

- (void)PDFViewWillClickOnLink:(PDFView *)sender withURL:(NSURL *)url {
    
}

#pragma mark -
#pragma mark PDFDocumentDelegate

#pragma mark -
#pragma mark Getter && Setter

- (PDFView *)pdfView {
    if (!_pdfView) {
        _pdfView = [[PDFView alloc] initWithFrame:self.bounds];
        _pdfView.autoScales = YES;
        _pdfView.userInteractionEnabled = YES;
        _pdfView.displaysAsBook = YES;
    }
    return _pdfView;
}

@end
