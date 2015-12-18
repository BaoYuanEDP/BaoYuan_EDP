//
//  RoomLostViewController.m
//  BYFCApp
//
//  Created by PengLee on 15/8/11.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "RoomLostViewController.h"
#import "PL_Header.h"
@interface RoomLostViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableView1;
}
@end

@implementation RoomLostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"房源缺失登记";
    self.navigationController.navigationBarHidden = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.arrayData = @[@"黄浦区",@"静安区",@"长宁区",@"徐汇区",@"闸北区",@"虹口区",@"普陀区",@"杨浦区",@"浦东新区",@"宝山区",@"闵行区",@"松江区",@"奉贤区",@"嘉定区",@"金山区",@"青浦区",@"崇明区"];
    _textField1.userInteractionEnabled = NO;
    _districtName.delegate = self;
    _louPanAddress.delegate = self;
    _beiZhuTextField.delegate = self;
    _louPanAddress.layer.cornerRadius = 5.0f;
    _louPanAddress.layer.borderWidth = 1;
    _louPanAddress.layer.borderColor = [UIColor blackColor].CGColor;
    _districtName.layer.cornerRadius = 5.0f;
    _districtName.layer.borderWidth = 1;
    _districtName.layer.borderColor = [UIColor blackColor].CGColor;
    _textField1.layer.cornerRadius = 5.0f;
    _textField1.layer.borderWidth = 1;
    _textField1.layer.borderColor = [UIColor blackColor].CGColor;
    _beiZhuTextField.layer.cornerRadius = 5.0f;
    _beiZhuTextField.layer.borderWidth = 1;
    _beiZhuTextField.layer.borderColor = [UIColor blackColor].CGColor;
}
-(void)createTbaleView
{
    tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(_dropBtn.frame), PL_WIDTH-80,PL_HEIGHT/2)];
    tableView1.layer.borderWidth = 1;
    tableView1.layer.borderColor = [UIColor grayColor].CGColor;
    tableView1.layer.cornerRadius = 10;
    tableView1.delegate = self;
    tableView1.dataSource = self;
    [self.view addSubview:tableView1];
}
-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.view.frame = CGRectMake(0, -64, PL_WIDTH, PL_HEIGHT);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_districtName resignFirstResponder];
    [_louPanAddress resignFirstResponder];
    [_beiZhuTextField resignFirstResponder];
     self.view.frame = CGRectMake(0, 64, PL_WIDTH, PL_HEIGHT-64);
}
#pragma mark - tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
//        if (self.arrayData.count>0)
//        {
//            roomAreaPlace * area1 = self.arrayData[indexPath.row];
//            cell.textLabel.text = [NSString stringWithFormat:@"%@",area1.areaDistrictName];
//        }
//
    cell.textLabel.text = self.arrayData[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _area.text = self.arrayData[indexPath.row];
    _dropBtn.selected = NO;
    tableView1.hidden = YES;
    _xialaImage.image = [UIImage imageNamed:@"xiala.png"];
//    [_dropBtn setImage:[UIImage imageNamed:@"dropdown.png"] attributeTitle:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAction:(id)sender {
   
    if (_dropBtn.selected == NO) {
         NSLog(@"下拉菜单");
        [self createTbaleView];
        tableView1.hidden = NO;
        _xialaImage.image = [UIImage imageNamed:@"shangjiantou.png"];
        _dropBtn.selected = YES;
//        [[MyRequest defaultsRequest]requestAreaInfoMessage:@"1" roomDistrictId:@"" roomDisName:@"" mode:@"0" userName:[PL_USER_STORAGE objectForKey:PL_USER_NAME] userTokne:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] backInfoMessage:^(NSMutableArray *array) {
//            PL_PROGRESS_DISMISS;
//            for (roomAreaPlace * are in array)
//            {
//                NSLog(@"%@",are.areaDistrictName) ;
//                
//            }
//            
//            if (array.count>0)
//            {
//                self.arrayDate = [NSMutableArray arrayWithArray:array];
//                tableView1.frame = CGRectMake(40, CGRectGetMaxY(_dropBtn.frame)+10, PL_WIDTH-80, self.arrayDate.count>=7?(PL_HEIGHT/2):tableView1.rowHeight*(self.arrayDate.count +1));
//                [tableView1 reloadData];
//                
//            }
//            else
//            {
//                tableView1.frame = CGRectMake(0, CGRectGetMaxY(_dropBtn.frame), PL_WIDTH, tableView1.rowHeight*(self.arrayDate.count+1));
//                
//                [tableView1 reloadData];
//            }
//            
//            
//        }];
    }else
    {
         NSLog(@"上拉菜单");
        tableView1.hidden = YES;
        _xialaImage.image = [UIImage imageNamed:@"xiala.png"];
        _dropBtn.selected = NO;
    }
}
- (IBAction)sureAction:(id)sender {
    NSLog(@"确认提交");
    NSLog(@"%@",_area.text);
    NSLog(@"%@",_districtName.text);
    NSLog(@"%@",_louPanAddress.text);
    if([_area.text isEqualToString:@"行政区"])
    {
        PL_ALERT_SHOW(@"请选择区域");
    }
    else if([_districtName.text isEqualToString:@""])
    {
        PL_ALERT_SHOW(@"请输入小区名");
    }
    else if([_louPanAddress.text isEqualToString:@""])
    {
        PL_ALERT_SHOW(@"请输入楼盘地址");
    }
    else{
        PL_PROGRESS_RUN;
        [[MyRequest defaultsRequest]roomLostEstateName:_districtName.text EstateAddress:_louPanAddress.text DistrictName:_area.text userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME]  token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(id obj) {
            NSLog(@"%@",obj);
            PL_PROGRESS_DISMISS;
            NSString *string=obj;
            if ([string isEqualToString:@"OK"]) {
                PL_ALERT_SHOW(@"提交成功");
                _districtName.text = @"";
                _louPanAddress.text = @"";
                _area.text = @"行政区";
                _xialaImage.image = [UIImage imageNamed:@"xiala.png"];
                _beiZhuTextField.text = @"";
            }
            else if ([string isEqualToString:@"exception"]) {
                PL_ALERT_SHOW(@"对不起,服务器异常");
            }
            else  if ([string isEqualToString:@"ERR"]) {
                PL_ALERT_SHOW(@"提交失败");
            }
            else if ([string isEqualToString:@"1"])
            {
                PL_ALERT_SHOW(@"本套房源数据已被登记过");
            }
            
        }];

    
    }
}
#pragma mark textFileDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [_districtName resignFirstResponder];
        [_louPanAddress resignFirstResponder];
        [_beiZhuTextField resignFirstResponder];
        self.view.frame = CGRectMake(0,64, PL_WIDTH, PL_HEIGHT-64);
    }
  
    return YES;
}
@end
