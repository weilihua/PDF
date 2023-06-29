//
//  SMKTVGameRoomView.m
//  Demo
//
//  Created by weilihua on 2022/11/4.
//

#import "SMKTVGameRoomView.h"

@interface SMKTVGameRoomView ()

@property(nonatomic, strong)UIView *gameView;
@property(nonatomic, strong)UIImageView *bgImageView;

@end

@implementation SMKTVGameRoomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initGameView];
    }
    return self;
}

- (void)initGameView {
    self.gameView = [[UIView alloc] initWithFrame:self.bounds];
    [self addContentView:self.gameView];
    
    self.bgImageView = [UIImageView new];
    self.bgImageView.image = [UIImage imageNamed:@"ktv_icon_stage_bg"];
    [self.gameView addSubview:self.bgImageView];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)relayoutMsg {
    [self makeMsgConstraints:^(MASConstraintMaker * _Nonnull make) {
        make.leading.equalTo(self).offset(20);
        make.bottom.equalTo(self).offset(-40);
        make.width.equalTo(@300);
        make.height.equalTo(@300);
    }];
}

@end
