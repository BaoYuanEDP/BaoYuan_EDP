//
//  HoliDayEdityViewController.m
//  BYFCApp
//
//  Created by 王鹏 on 15/8/28.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "HoliDayEdityViewController.h"
#import "HolidaySubCell.h"
#import "MyRequest.h"
#import "PL_Header.h"
@interface HoliDayEdityViewController ()<UIAlertViewDelegate,UITextFieldDelegate>
{
    UITextField*textfild;
}
@end

@implementation HoliDayEdityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"销假申请";
    _jsonData = [NSMutableArray array];
    _sureBut.hidden = YES;
    _cancelBut.hidden = YES;
    UIButton*LeftBut=[[UIButton alloc]initWithFrame:CGRectMake(30, 40, 10, 20)];
    [LeftBut setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal ];
    [LeftBut addTarget:self action:@selector(LeftButA) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*leftBar=[[UIBarButtonItem alloc]initWithCustomView:LeftBut];
    self.navigationItem.leftBarButtonItem=leftBar;
    _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self postRequest];
    UIImageView *heng=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, PL_WIDTH,1)];
    heng.image=[UIImage imageNamed:@"heng_hong.png"];
    [self.view addSubview:heng];
    _reason = @"";

   
}
-(void)LeftButA
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HolidaySubCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"HolidaySubCell" owner:self options:nil]lastObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        cell.TimerLabel.text=_arrayData[indexPath.row][@"WorkDay"];
        cell.ATypeLabel.text=_arrayData[indexPath.row][@"ATypeName"];
        cell.MTypeLabel.text=_arrayData[indexPath.row][@"MTypeName"];
        if ([cell.ATypeLabel.text isEqualToString:@""]) {
            cell.ATpyeBut.enabled = NO;
        }
        if([cell.MTypeLabel.text isEqualToString:@""])
        {
            cell.MTypeBut.enabled = NO;
        }
        if ([[_arrayData[indexPath.row][@"AType_Flag"]stringValue]isEqualToString:@"1"]) {
            cell.ATpyeBut.enabled = NO;
        }
        if ([[_arrayData[indexPath.row][@"MType_Flag"]stringValue]isEqualToString:@"1"]) {
            cell.MTypeBut.enabled = NO;
        }
        cell.ATpyeBut.tag=indexPath.row;
        cell.MTypeBut.tag=indexPath.row+10000;
        [cell.ATpyeBut addTarget:self action:@selector(CheckBoxBut:) forControlEvents:UIControlEventTouchUpInside];
        [cell.MTypeBut addTarget:self action:@selector(CheckBoxBut:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.0;
}
-(void)CheckBoxBut:(UIButton*)sender
{
    sender.selected=!sender.selected;
    if (sender.tag<10000) {
        
        NSLog(@"%@",_jsonData);
        if(sender.selected)
        {
            [_arrData[sender.tag<10000?sender.tag:sender.tag-10000] setValue: [NSNumber numberWithInt:1] forKey:@"AType_Flag"];
            NSLog(@"%@",_arrData[sender.tag<10000?sender.tag:sender.tag-10000]);
        }
        else
        {
            [_arrData[sender.tag<10000?sender.tag:sender.tag-10000] setValue: [NSNumber numberWithInt:0] forKey:@"AType_Flag"];
            
        }
    }
    else
    {
        if(sender.selected)
        {
            [_arrData[sender.tag<10000?sender.tag:sender.tag-10000] setValue: [NSNumber numberWithInt:1] forKey:@"MType_Flag"];
            NSLog(@"%@",_arrData[sender.tag<10000?sender.tag:sender.tag-10000]);
        }
        else
        {
            [_arrData[sender.tag<10000?sender.tag:sender.tag-10000] setValue:[NSNumber numberWithInt:0] forKey:@"MType_Flag"];
        }
        
    }
    
}

//请求数据
-(void)postRequest
{
    _arrayData = [NSMutableArray array];
    _arrData = [NSMutableArray array];
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]holiDayGetRequestUserid:[PL_USER_STORAGE objectForKey:PL_USER_USERID] Token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSMutableArray *array) {
        PL_PROGRESS_DISMISS;
        
        if([array isEqual:@"exception"])
        {
            PL_ALERT_SHOW(@"奔溃性的错误");
        }
        else if(array.count==0)
        {
            PL_ALERT_SHOW(@"暂无数据");
        
        }
        else if ([[array firstObject] isEqual:@"[]"])
        {
            PL_ALERT_SHOW(@"暂无数据");
        }
        else
        {
            for (NSDictionary *dic in array) {
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                [dict setValue:dic[@"WorkDay"] forKey:@"WorkDay"];
                [dict setValue:dic[@"MTypeName"] forKey:@"MTypeName"];
                [dict setValue:dic[@"MType_Flag"] forKey:@"MType_Flag"];
                [dict setValue:dic[@"ATypeName"] forKey:@"ATypeName"];
                [dict setValue:dic[@"AType_Flag"] forKey:@"AType_Flag"];
                [dict setValue:dic[@"Attendance_ID"] forKey:@"Attendance_ID"];
                [_arrData addObject:dict];
            }
            [_arrayData addObjectsFromArray:array];
            _cancelBut.hidden = NO;
            _sureBut.hidden = NO;
            [self.tableview reloadData];
        }
    }];
}
- (IBAction)SureButAction:(UIButton *)sender {
    
    _jsonData = [NSMutableArray array];
    _reason = textfild.text;
    for(int i=0;i<_arrData.count;i++)
    {
        HolidaySubCell *cell = (HolidaySubCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell.ATpyeBut.selected||cell.MTypeBut.selected) {
            [_jsonData addObject:_arrData[i]];
        }
    }
    if(_jsonData.count==0)
    {
        PL_ALERT_SHOW(@"请至少选择一项");
    }
    else
    {
        UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"请输入理由"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"放弃"
                                              otherButtonTitles:@"确定", nil];
        alertView.alertViewStyle=UIAlertViewStylePlainTextInput;
        textfild=[alertView textFieldAtIndex:0];
        textfild.placeholder=@"请输入";
        textfild.delegate = self;
        alertView.delegate=self;
        [alertView show];
    }
}
//提交
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    _jsonData = [NSMutableArray array];
//    _reason = textfild.text;
//    for(int i=0;i<_arrData.count;i++)
//    {
//        HolidaySubCell *cell = (HolidaySubCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//        if (cell.ATpyeBut.selected||cell.MTypeBut.selected) {
//            [_jsonData addObject:_arrData[i]];
//        }
//    }

    if (buttonIndex==1) {
        if([textfild.text isEqualToString:@""])
        {
            PL_ALERT_SHOW(@"请填写销假理由");
        }
        else
        {
            PL_PROGRESS_SHOW;
            NSData *jsonDatas = [NSJSONSerialization dataWithJSONObject:_jsonData options:NSJSONWritingPrettyPrinted error:nil];
            NSLog(@"********%@",[[NSString alloc]initWithData:jsonDatas encoding:NSUTF8StringEncoding]);
            [[MyRequest defaultsRequest] resumptionLeaveJsonData:[[NSString alloc]initWithData:jsonDatas encoding:NSUTF8StringEncoding] Reason:textfild.text userid:[PL_USER_STORAGE objectForKey:PL_USER_USERID] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSString *string) {
                PL_PROGRESS_DISMISS;
                if([string isEqualToString:@"1"])
                {
                    PL_ALERT_SHOW(@"申请的信息已存在");
                }
                else if([string isEqualToString:@"2"])
                {
                    PL_ALERT_SHOW(@"请勾选需要销假的假期进行提交");
                }
                else if([string isEqualToString:@"3"])
                {
                    PL_ALERT_SHOW(@"提交失败");
                }
                else if([string isEqualToString:@"4"])
                {
                    PL_ALERT_SHOW(@"数据保存失败，请联系IT部");
                }
                else if([string isEqualToString:@"OK"])
                {
                    PL_ALERT_SHOW(@"已成功发起流程,请等待审核");
                    for(int i=0;i<_arrData.count;i++)
                    {
                        HolidaySubCell *cell = (HolidaySubCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                        if (cell.ATpyeBut.selected) {
                            cell.ATpyeBut.enabled = NO;
                            cell.ATpyeBut.selected = NO;
                        }
                        if (cell.MTypeBut.selected) {
                            cell.MTypeBut.enabled = NO;
                            cell.MTypeBut.selected = NO;

                        }
                    }
                    
                }
                else if([string isEqualToString:@"exception"])
                {
                    PL_ALERT_SHOW(@"服务器异常,请稍后再试");
                }
                else
                {
                    PL_ALERT_SHOW(@"请求超时");
                }
            }];

        }
    }
}
- (IBAction)CanleButAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
