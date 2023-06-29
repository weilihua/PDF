//
//  SMPDFView.h
//  Demo
//
//  Created by weilihua on 2023/6/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SMPDFViewDelegate <NSObject>

@optional

- (void)pdfViewDidDownloadPdf;

@end

@interface SMPDFView : UIView

@property(nonatomic, weak)id<SMPDFViewDelegate> delegate;

/// 加载数据
- (void)loadData:(NSData*)data;

@end

NS_ASSUME_NONNULL_END
