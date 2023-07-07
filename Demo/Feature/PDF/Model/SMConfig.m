//
//  SMConfig.m
//  Demo
//
//  Created by weilihua on 2023/7/7.
//

#import "SMConfig.h"

@implementation SMBook

@end

@implementation SMGrade

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
        @"books" : SMBook.class,
    };
}

@end

@implementation SMConfig

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
        @"grades" : SMGrade.class,
    };
}

@end
