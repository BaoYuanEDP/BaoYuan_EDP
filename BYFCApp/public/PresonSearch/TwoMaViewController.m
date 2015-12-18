//
//  TwoMaViewController.m
//  BYFCApp
//
//  Created by PengLee on 15/9/15.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "TwoMaViewController.h"
#import "PL_Header.h"
@interface TwoMaViewController ()

@end

@implementation TwoMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.hidesBackButton = YES;
    UIButton * backBnt = [UIButton buttonWithType:UIButtonTypeSystem];
    [backBnt setBackgroundImage:[UIImage imageNamed:BY_BACK_IAMGE] forState:UIControlStateNormal];
    backBnt.frame = CGRectMake(10, 12, 16, 23);
    [backBnt addTarget:self action:@selector(viewReturn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;

}
- (void)viewReturn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
