//
//  SMMessageViewBaseCell.h
//  Demo
//
//  Created by weilihua on 2022/11/5.
//

#import <UIKit/UIKit.h>
#import "SMMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMMessageViewBaseCell : UITableViewCell

// 初始化视图
- (void)initView;

// 更新数据
- (void)updateData:(SMMessage *)msg;

@end

NS_ASSUME_NONNULL_END
