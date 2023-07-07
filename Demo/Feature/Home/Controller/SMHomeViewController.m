//
//  SMHomeViewController.m
//  Demo
//
//  Created by weilihua on 2022/11/4.
//

#import "SMHomeViewController.h"
#import "SMKTVChatRoomController.h"
#import "SMOCRViewController.h"
#import "SMPDFHomeController.h"

@interface SMHomeViewController ()

@end

@implementation SMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    [self initView];
}

- (void)initView {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 200, 60, 25);
    [button setTitle:@"KTV" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnChatEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *btnOCR = [UIButton buttonWithType:UIButtonTypeCustom];
    btnOCR.frame = CGRectMake(260, 200, 60, 25);
    [btnOCR setTitle:@"OCR" forState:UIControlStateNormal];
    [btnOCR setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [btnOCR addTarget:self action:@selector(btnOCREvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnOCR];
    
    UIButton *btnPDF = [UIButton buttonWithType:UIButtonTypeCustom];
    btnPDF.frame = CGRectMake(100, 300, 60, 25);
    [btnPDF setTitle:@"PDF" forState:UIControlStateNormal];
    [btnPDF setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [btnPDF addTarget:self action:@selector(btnPDFEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPDF];
}

- (void)btnChatEvent:(UIButton *)sender {
    SMKTVChatRoomController *vc = [SMKTVChatRoomController new];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btnOCREvent:(UIButton *)sender {
    SMOCRViewController *vc = [SMOCRViewController new];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btnPDFEvent:(UIButton *)sender {
    SMPDFHomeController *vc = [SMPDFHomeController new];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
