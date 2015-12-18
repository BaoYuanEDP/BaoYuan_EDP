//
//  PersonSearchViewController.m
//  BYFCApp
//
//  Created by heaven on 15-7-8.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "PersonSearchViewController.h"
#import "PL_Header.h"
@interface PersonSearchViewController ()<UITextFieldDelegate,UIAlertViewDelegate>

@end

@implementation PersonSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"员工联系表";
    _textFiled.delegate = self;
    self.navigationItem.hidesBackButton = YES;
    UIButton * backBnt = [UIButton buttonWithType:UIButtonTypeSystem];
    [backBnt setBackgroundImage:[UIImage imageNamed:BY_BACK_IAMGE] forState:UIControlStateNormal];
    backBnt.frame = CGRectMake(10, 12, 16, 23);
    [backBnt addTarget:self action:@selector(viewReturn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewReturn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [_textFiled becomeFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    self.view.frame = CGRectMake(0, -60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [UIView commitAnimations];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [_textFiled resignFirstResponder];
    self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [UIView commitAnimations];
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
//查询按钮
- (IBAction)searchAction:(UIButton *)sender {
    if (_textFiled.text.length == 0) {
        UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"您好" message:@"内容不能为空,请重新输入！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [aler show];
    }else if (_textFiled.text.length >0 && _textFiled.text.length < 2){
        UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"您好" message:@"内容不能小于两个字,请重新输入！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [aler show];
    }else
    {
        PersonSearchListVC *persionVC = [[PersonSearchListVC alloc] initWithNibName:@"PersonSearchListVC" bundle:nil];
        persionVC.strText = self.textFiled.text;
        [self.navigationController pushViewController:persionVC animated:YES];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [_textFiled resignFirstResponder];
    self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [UIView commitAnimations];}
@end
