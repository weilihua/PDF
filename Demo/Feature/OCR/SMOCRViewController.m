//
//  SMOCRViewController.m
//  Demo
//
//  Created by weilihua on 2023/6/26.
//

#import "SMOCRViewController.h"
#import <VisionKit/VisionKit.h>

@interface SMOCRViewController ()<VNDocumentCameraViewControllerDelegate>

@property(nonatomic, strong)VNDocumentCameraViewController *vc;

@end

@implementation SMOCRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    [self initView];
}

- (void)initView {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 200, 60, 25);
    [button setTitle:@"VN" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnVNEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)btnVNEvent:(UIButton *)sender {
    [self gotoVNVC];
}

- (void)gotoVNVC {
    self.vc = [VNDocumentCameraViewController new];
    self.vc.delegate = self;
    [self.navigationController presentViewController:self.vc animated:YES completion:nil];
}

- (void)documentCameraViewController:(VNDocumentCameraViewController *)controller
                   didFinishWithScan:(VNDocumentCameraScan *)scan {
    
    [self.vc dismissViewControllerAnimated:YES completion:nil];
}

// The delegate will receive this call when the user cancels.
- (void)documentCameraViewControllerDidCancel:(VNDocumentCameraViewController *)controller {
    
}

// The delegate will receive this call when the user is unable to scan, with the following error.
- (void)documentCameraViewController:(VNDocumentCameraViewController *)controller
                    didFailWithError:(NSError *)error {
    
}

@end
