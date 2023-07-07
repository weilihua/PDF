//
//  SMPDFHomeView.m
//  Demo
//
//  Created by weilihua on 2023/7/5.
//

#import "SMPDFHomeView.h"

@interface SMPDFHomeView ()

@property(nonatomic, strong)UIButton *btnOK;
@property(nonatomic, strong)UIActivityIndicatorView *loadView;

@end

@implementation SMPDFHomeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.btnOK = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnOK setTitle:@"生成PDF"
                forState:UIControlStateNormal];
    [self.btnOK setTitleColor:UIColor.whiteColor
                     forState:UIControlStateNormal];
    [self.btnOK setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [self.btnOK addTarget:self
                   action:@selector(btnOKEvent:)
         forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnOK];
    
    [self.btnOK mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-20);
        make.width.equalTo(@160);
        make.height.equalTo(@28);
    }];
    
    self.loadView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    self.loadView.color = UIColor.grayColor;
    self.loadView.frame = CGRectMake(0, 0, 40, 40);
    self.loadView.center = self.center;
    [self addSubview:self.loadView];
    self.loadView.hidesWhenStopped = YES;
    self.loadView.hidden = YES;
    
    [self.loadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(20);
        make.width.height.equalTo(@40);
    }];
}

#pragma mark -
#pragma mark Public Method

- (void)showLoadView {
    self.loadView.hidden = NO;
    [self.loadView startAnimating];
}

- (void)hiddenLoadView {
    [self.loadView stopAnimating];
}

#pragma mark -
#pragma mark Button Event

- (void)btnOKEvent:(UIButton *)sender {
    if (self.makePdfBlock) {
        self.makePdfBlock();
    }
}

@end
