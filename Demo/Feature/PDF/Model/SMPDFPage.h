//
//  SMPDFPage.h
//  Demo
//
//  Created by weilihua on 2023/7/6.
//

#import "QMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMPDFPage : QMBaseModel

@property(nonatomic, assign)NSInteger index;
@property(nonatomic, copy)NSString *imageURL;
@property(nonatomic, strong)UIImage *image;

@end

NS_ASSUME_NONNULL_END
