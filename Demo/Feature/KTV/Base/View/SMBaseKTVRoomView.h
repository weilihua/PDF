//
//  SMBaseKTVRoomView.h
//  Demo
//
//  Created by weilihua on 2022/11/4.
//

#import <UIKit/UIKit.h>
#import "SMRoom.h"
#import "SMMessage.h"
#import <Masonry/Masonry.h>
NS_ASSUME_NONNULL_BEGIN

@protocol SMBaseKTVRoomViewDelegate <NSObject>

@optional

- (void)roomViewDidSwitchRoom:(SMRoomType)type;

@end

@interface SMBaseKTVRoomView : UIView

@property(nonatomic, weak)id<SMBaseKTVRoomViewDelegate> delegate;

- (void)showLoadView;

- (void)hiddenLoadView;

- (void)addContentView:(UIView *)view;

- (NSArray *)makeMsgConstraints:(void(^)(MASConstraintMaker *make))block;

- (void)relayoutMsg;

- (void)insertMsg:(SMMessage *)msg;

- (void)reloadData:(NSArray<SMMessage*>*)msgs;

@end

NS_ASSUME_NONNULL_END
