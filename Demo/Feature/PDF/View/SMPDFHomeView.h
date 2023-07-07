//
//  SMPDFHomeView.h
//  Demo
//
//  Created by weilihua on 2023/7/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMPDFHomeView : UIView

@property(nonatomic, copy)void(^makePdfBlock)(void);

- (void)showLoadView;

- (void)hiddenLoadView;

@end

NS_ASSUME_NONNULL_END
