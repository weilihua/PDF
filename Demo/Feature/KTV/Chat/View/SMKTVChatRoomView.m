//
//  SMKTVChatRoomView.m
//  Demo
//
//  Created by weilihua on 2022/11/4.
//

#import "SMKTVChatRoomView.h"

@interface SMKTVChatRoomView()

@property(nonatomic, strong)UIView *chatView;
@property(nonatomic, strong)UIImageView *bgImageView;

@end

@implementation SMKTVChatRoomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initChatView];
    }
    return self;
}

- (void)initChatView {
    self.chatView = [[UIView alloc] initWithFrame:self.bounds];
    [self addContentView:self.chatView];
    
    self.bgImageView = [UIImageView new];
    self.bgImageView.image = [UIImage imageNamed:@"ktv_icon_chat_bg"];
    [self.chatView addSubview:self.bgImageView];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

@end
