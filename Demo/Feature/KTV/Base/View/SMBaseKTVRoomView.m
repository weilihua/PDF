//
//  SMBaseKTVRoomView.m
//  Demo
//
//  Created by weilihua on 2022/11/4.
//

#import "SMBaseKTVRoomView.h"
#import "SMMessageView.h"

@interface SMBaseKTVRoomView ()

@property(nonatomic, strong)UIImageView *loadImageView;
@property(nonatomic, strong)UIView *contentView;
@property(nonatomic, strong)SMMessageView *msgView;

@end

@implementation SMBaseKTVRoomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.contentView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.contentView];
    
    UIButton *btnChat = [UIButton buttonWithType:UIButtonTypeCustom];
    btnChat.frame = CGRectMake(40, 260, 100, 25);
    [btnChat setTitle:@"聊天房" forState:UIControlStateNormal];
    [btnChat setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [btnChat addTarget:self action:@selector(btnChatEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnChat];
    
    UIButton *btnGame = [UIButton buttonWithType:UIButtonTypeCustom];
    btnGame.frame = CGRectMake(240, 260, 100, 25);
    [btnGame setTitle:@"游戏房" forState:UIControlStateNormal];
    [btnGame setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [btnGame addTarget:self action:@selector(btnGameEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnGame];
    
    [self initMsgView];
    
    self.loadImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.loadImageView.image = [UIImage imageNamed:@"ktv_loading_mask"];
    self.loadImageView.hidden = YES;
    [self addSubview:self.loadImageView];
}

- (void)initMsgView {
    self.msgView = [SMMessageView new];
    self.msgView.backgroundColor = UIColor.greenColor;
    [self addSubview:self.msgView];
    
    [self relayoutMsg];
}

- (void)showLoadView {
    self.loadImageView.hidden = NO;
}

- (void)hiddenLoadView {
    self.loadImageView.hidden = YES;
}

#pragma mark -
#pragma mark Public Method

- (void)addContentView:(UIView *)view {
    if (view) {
        [view removeFromSuperview];
    }
    [self.contentView addSubview:view];
}

- (void)relayoutMsg {
    [self makeMsgConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(20);
        make.bottom.equalTo(self).offset(-40);
        make.width.equalTo(@200);
        make.height.equalTo(@200);
    }];
}

- (NSArray *)makeMsgConstraints:(void(^)(MASConstraintMaker *make))block {
    self.msgView.translatesAutoresizingMaskIntoConstraints = NO;
    MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithView:self.msgView];
    block(constraintMaker);
    return [constraintMaker install];
}

- (void)insertMsg:(SMMessage *)msg {
    [self.msgView insertMsg:msg];
}

- (void)reloadData:(NSArray<SMMessage*>*)msgs {
    self.msgView.msgs = [msgs mutableCopy];
}

#pragma mark -
#pragma mark Button Event

- (void)btnChatEvent:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(roomViewDidSwitchRoom:)]) {
        [self.delegate roomViewDidSwitchRoom:SMRoomTypeChat];
    }
}

- (void)btnGameEvent:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(roomViewDidSwitchRoom:)]) {
        [self.delegate roomViewDidSwitchRoom:SMRoomTypeGame];
    }
}

@end
