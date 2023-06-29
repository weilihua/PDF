//
//  SMMessageViewBaseCell.m
//  Demo
//
//  Created by weilihua on 2022/11/5.
//

#import "SMMessageViewBaseCell.h"

@implementation SMMessageViewBaseCell

#pragma mark -
#pragma mark System Method

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark -
#pragma mark Private Method

// 初始化视图
- (void)initView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
}

- (void)updateData:(SMMessage *)msg {
    
}
@end
