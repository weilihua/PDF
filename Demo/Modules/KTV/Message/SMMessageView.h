//
//  SMMessageView.h
//  Demo
//
//  Created by weilihua on 2022/11/5.
//

#import <UIKit/UIKit.h>
#import "SMMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMMessageView : UIView

@property(nonatomic, strong)NSMutableArray<SMMessage*> *msgs;

- (void)insertMsg:(SMMessage *)msg;

@end

NS_ASSUME_NONNULL_END
