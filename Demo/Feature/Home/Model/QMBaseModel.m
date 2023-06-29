//
//  QMBaseModel.m
//  StarMaker
//
//  Created by weilihua on 27/2/18.
//  Copyright © 2018年 uShow. All rights reserved.
//

#import "QMBaseModel.h"

@implementation QMBaseModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
    NSLog(@"");
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    id obj = [self yy_modelInitWithCoder:aDecoder];
    return obj;
}

- (id)copyWithZone:(NSZone *)zone {
    return [self yy_modelCopy];
}

- (NSUInteger)hash {
    return [self yy_modelHash];
}

- (BOOL)isEqual:(id)object {
    return [self yy_modelIsEqual:object];
}

- (NSString *)description {
    return [self yy_modelDescription];
}

@end
