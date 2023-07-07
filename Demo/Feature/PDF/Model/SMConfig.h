//
//  SMConfig.h
//  Demo
//
//  Created by weilihua on 2023/7/7.
//

#import "QMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SMBookType_YW = 0,
    SMBookType_SX,
    SMBookType_YX,
    SMBookType_KX,
    SMBookType_DF,
    SMBookType_YY,
    SMBookType_MS,
} SMBookType;

@interface SMBook : QMBaseModel

@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *key;
@property(nonatomic, assign)SMBookType type;
@property(nonatomic, assign)NSInteger pages;
@property(nonatomic, copy)NSString *timestamp;

@end

@interface SMGrade : QMBaseModel

@property(nonatomic, copy)NSString *name;
@property(nonatomic, strong)NSArray<SMBook*> *books;

@end

@interface SMConfig : QMBaseModel

@property(nonatomic, copy)NSString *url;
@property(nonatomic, copy)NSString *path;
@property(nonatomic, copy)NSString *thumb;
@property(nonatomic, strong)NSArray<SMGrade*> *grades;

@end

NS_ASSUME_NONNULL_END
