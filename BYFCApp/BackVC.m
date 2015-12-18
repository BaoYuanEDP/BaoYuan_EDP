//
//  BackVC.m
//  BYFCApp
//
//  Created by PengLee on 15/3/6.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "BackVC.h"
#import "PL_Header.h"
@interface BackVC ()

@end

@implementation BackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"公司简介";
    self.navigationItem.hidesBackButton = YES;
    UIButton * backBnt = [UIButton buttonWithType:UIButtonTypeSystem];
    [backBnt setBackgroundImage:[UIImage imageNamed:BY_BACK_IAMGE] forState:UIControlStateNormal];
     backBnt.frame = CGRectMake(10, 12, 16, 23);
    [backBnt addTarget:self action:@selector(viewReturn) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backBnt];
    
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.automaticallyAdjustsScrollViewInsets = NO;
    WebView * view = [[WebView alloc]initWithPoint:CGRectGetMaxY(self.navigationController.navigationBar.frame) loadURL:BY_NEWS_URL] ;
        
    
    [self.view addSubview:view];

    
    
    
    
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
