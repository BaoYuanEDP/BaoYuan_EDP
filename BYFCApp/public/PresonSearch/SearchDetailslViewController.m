//
//  SearchDetailslViewController.m
//  BYFCApp
//
//  Created by heaven on 15-7-9.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "SearchDetailslViewController.h"

@interface SearchDetailslViewController ()

@end

@implementation SearchDetailslViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"员工详情联系表";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.hidesBackButton = YES;
    UIButton * backBnt = [UIButton buttonWithType:UIButtonTypeSystem];
    [backBnt setBackgroundImage:[UIImage imageNamed:BY_BACK_IAMGE] forState:UIControlStateNormal];
    backBnt.frame = CGRectMake(10, 12, 16, 23);
    [backBnt addTarget:self action:@selector(viewReturn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self UIInit];
}
- (void)UIInit
{
    _name.text = @"";
    _persionNum.text = @"";
    _zhiwei.text = @"";
    _quyu.text = @"";
    _fenbu.text = @"";
    _phoneNum.text = @"";
    _phone.text = @"";
    _chunchen.text = @"";
    _youbian.text = @"";
    _dianziyouxiang.text = @"";
    _dizhi.text = @"";
    _name.text = _model.name;
    _persionNum.text = _model.personNum;
    _zhiwei.text = _model.Position;
    _quyu.text = _model.area;
    _fenbu.text = _model.Branch;
    _phoneNum.text = _model.phoneNum;
    _phone.text = _model.DeptTel;
    _chunchen.text = _model.Fax;
    _youbian.text = _model.DeptZip;
    _dianziyouxiang.text = _model.FulEmail;
    _dizhi.text = _model.Dizhi;
    NSString *strPhoneNum = [NSString stringWithFormat:@"%@",_phoneNum.text];
    NSString *strPhone = [NSString stringWithFormat:@"%@",_phone.text];
    if ([strPhoneNum isEqualToString:@""]) {
        [_phone1 setImage:[UIImage imageNamed:@""]];
    }else
    {
        [_phone1 setImage:[UIImage imageNamed:@"打电话图标.png"]];
    }
    if ([strPhone isEqualToString:@""]) {
        [_phone2 setImage:[UIImage imageNamed:@""]];
    }else
    {
        [_phone2 setImage:[UIImage imageNamed:@"打电话图标.png"]];
    }
}

- (IBAction)phoneNum:(UIButton *)sender {
    [self dialPhoneNumber:_phoneNum.text];
}
- (IBAction)phone:(UIButton *)sender {
    [self dialPhoneNumber:_phone.text];
}
- (void)dialPhoneNumber:(NSString *)aPhoneNumber
{
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",aPhoneNumber]];
    if ( !_phoneCallWebView ) {
        _phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    }
    [_phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
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
