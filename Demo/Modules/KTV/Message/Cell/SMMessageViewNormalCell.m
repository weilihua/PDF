//
//  SMMessageViewNormalCell.m
//  Demo
//
//  Created by weilihua on 2022/11/5.
//

#import "SMMessageViewNormalCell.h"
#import <Masonry/Masonry.h>

@interface SMMessageViewNormalCell ()

@property(nonatomic, strong)UILabel *lbMsg;

@end

@implementation SMMessageViewNormalCell

- (void)initView {
    [super initView];
    
    self.lbMsg = [[UILabel alloc] init];
    self.lbMsg.backgroundColor = UIColor.redColor;
    self.lbMsg.textColor = UIColor.yellowColor;
    self.lbMsg.font = [UIFont systemFontOfSize:15];
    [self.lbMsg sizeToFit];
    [self.contentView addSubview:self.lbMsg];
    [self.lbMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(16);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)updateData:(SMMessage *)msg {
    [super updateData:msg];
    self.lbMsg.text = msg.content;
}

@end
