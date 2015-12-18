//
//  MoreVisterViewController.m
//  BYFCApp
//
//  Created by PengLee on 15/5/6.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "MoreVisterViewController.h"
#import "PL_Header.h"
@interface MoreVisterViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{

    UITextField *searchTextField;
    UITableView *stableView;
}
@end

@implementation MoreVisterViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [stableView reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"筛选";
    _pubTypeString = @"";
    _jiaoyiTypeStr = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(5, 65, self.view.frame.size.width-70, 30)];
    //searchTextField.backgroundColor = [UIColor redColor];
    if([_isPrivate isEqualToString:@"1"])
    {
        _arr = @[@"客源类型",@"交易状态"];
    }
    else if([_isPrivate isEqualToString:@"0"])
    {
        _arr = @[@"客源类型",@"交易状态",@"公司公客",@"大区公客",@"总监公客",@"组别公客",@"区经公客"];
    }
    searchTextField.placeholder = @"请输入要搜索的电话号码";
    _typeStr = @"";
    _jiaoyiStr = @"";
    searchTextField.layer.masksToBounds = YES;
    
    searchTextField.layer.cornerRadius = 5;
    searchTextField.delegate=self;
    searchTextField.layer.borderWidth =2;
    searchTextField.layer.borderColor = [UIColor orangeColor].CGColor;
   //searchTextField.backgroundColor = [UIColor yellowColor];
   searchTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:searchTextField];
//    UIButton *typeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 115, self.view.frame.size.width, 50)];
//    [self.view addSubview:typeBtn];
    
    stableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 95, self.view.frame.size.width - 60, 300)];
    [self.view addSubview:stableView];
    stableView.delegate = self;
    stableView.dataSource = self;
    stableView.bounces = NO;
    stableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    UITableViewCellAccessoryDisclosureIndicator

//    typeBtn.backgroundColor = [UIColor whiteColor];
//    [typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    
//    [typeBtn setTitle:@"类型" forState:UIControlStateNormal];
//    [typeBtn addTarget:self action:@selector(clickTypeBtn) forControlEvents:UIControlEventTouchUpInside];
//
   
    
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(viewSureClick:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuse"];
    }
    cell.textLabel.text = _arr[indexPath.row];
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = _typeStr;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.row == 1) {
        cell.detailTextLabel.text = _jiaoyiStr;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
        
//    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        VisterTypeViewController *visterTypeVc = [[VisterTypeViewController alloc]init];
        visterTypeVc.moreVC = self;
        [self.navigationController pushViewController:visterTypeVc animated:YES];
    }
    else if(indexPath.row == 1)
    {
        JiaoYiTypeViewController *vc =[[JiaoYiTypeViewController alloc] init];
        vc.moreVC = self;
        [self.navigationController pushViewController:vc animated:YES];

    }
    else if(indexPath.row>1)
    {
        _pubTypeString = [NSString stringWithFormat:@"%ld",(unsigned long)indexPath.row-1];
    }
  }

- (void)viewSureClick:(UIBarButtonItem *)bar
{
//    if (!searchTextFixeld.text.length) {
//        PL_ALERT_SHOW(@"请输入电话号码");
//        return;
//    }
//    else
//    {
//        if ([searchTextField.text checkPhoneNumberInPut] || searchTextField.text.length == 0)
//        {
//            
//            if ([self.delegate respondsToSelector:@selector(transformTel:)]) {
//                [self.delegate transformTel:searchTextField.text];
//            }
//        }
//        else
//        {
//            PL_ALERT_SHOW(@"请输入正确的手机号码或者固话");
//            return;
//        }
//    }
    if ([searchTextField.text checkPhoneNumberInPut] ||searchTextField.text.length == 0)
    {
        
        if ([self.delegate respondsToSelector:@selector(transformTel:)]) {
            [self.delegate transformTel:searchTextField.text];
        }
    }
    else
    {
        PL_ALERT_SHOW(@"请输入正确的手机号码或者固话");
        return;
    }
    if ([self.delegate respondsToSelector:@selector(transformPubType:)]) {
        [self.delegate transformPubType:_pubTypeString];
    }
    if ([self.delegate respondsToSelector:@selector(transformtopStr3:)]) {
        [self.delegate transformtopStr3:_typeStr];
    }
    if ([self.delegate respondsToSelector:@selector(transformJiaoYiStr:)]) {
        [self.delegate transformJiaoYiStr:_jiaoyiStr];
    }
    UIView * view =self.navigationController.view.superview;
    if (view &&  [view isKindOfClass:[MoreMenuVC class]])
    {
        MoreMenuVC * more = (MoreMenuVC *)view;
        [more dismissView ];
    
    }
    if ([self.delegate respondsToSelector:@selector(freshCustomeList)]) {
        [self.delegate freshCustomeList];
    }

}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [searchTextField  resignFirstResponder];
    }
    return YES;
}
-(void)clickTypeBtn{
    VisterTypeViewController *visterTypeVc = [[VisterTypeViewController alloc]init];
    [self.navigationController pushViewController:visterTypeVc animated:YES];
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
