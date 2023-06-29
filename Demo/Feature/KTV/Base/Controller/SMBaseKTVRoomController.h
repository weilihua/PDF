//
//  SMBaseKTVRoomController.h
//  Demo
//
//  Created by weilihua on 2022/11/4.
//

#import <UIKit/UIKit.h>
#import "SMBaseKTVRoomView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMBaseKTVRoomController : UIViewController<SMBaseKTVRoomViewDelegate>

@property(nonatomic, assign)NSInteger roomId;
@property(nonatomic, strong)SMBaseKTVRoomView *roomView;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
