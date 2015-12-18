//
//  HolidayListViewController.m
//  BYFCApp
//
//  Created by PengLee on 15/11/17.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import "HolidayListViewController.h"
#import "PL_Header.h"
#import "XJSubViewController.h"
@interface HolidayListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *listTableView;
    NSMutableArray *arrayData;
    NSIndexPath *indexPath2;

}
@end

@implementation HolidayListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"请假申请历史";
    arrayData = [NSMutableArray array];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationController.navigationBarHidden=NO;
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    UIImageView *heng=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH,1)];
    heng.image=[UIImage imageNamed:@"heng_hong.png"];
    [self.view addSubview:heng];
    listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT)];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    [self.view addSubview:listTableView];
    listTableView.tableFooterView = [[UITableView alloc]initWithFrame:CGRectZero];
    [self tableViewLine];
    [self requestData];
   
}

//tableView15像素删除
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
//删除15像素线
-(void)tableViewLine
{
    if ([listTableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [listTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([listTableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [listTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)requestData
{
    PL_PROGRESS_SHOW;
    arrayData = [NSMutableArray array];
    [[MyRequest defaultsRequest]GetAskForLeaveGroup_Listmode:_modeStr userid:[PL_USER_STORAGE objectForKey:PL_USER_USERID] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] string:^(NSMutableArray *array) {
        NSString *str = [array objectAtIndex:0];
        if ([str isEqual:@"[]"]) {
            PL_ALERT_SHOW(@"暂无请假记录");
        }
        else if ([str isEqual:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
        }
        
        else  if ([str isEqual:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        else
        {
            [arrayData addObjectsFromArray:array];
            [listTableView reloadData];
        }
        PL_PROGRESS_DISMISS;
    }];
}
-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellId";
    HolidayListViewCell *cell = (HolidayListViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HolidayListViewCell" owner:self options:nil] lastObject];
    }
    HolidayListMode *listMode = arrayData[indexPath.row];
    [cell cellLoadData:listMode];
    return cell;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([_modeStr isEqualToString:@"2"])
    {
        return YES;
    }
    return NO;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([_modeStr isEqualToString:@"2"])
    {
    return UITableViewCellEditingStyleDelete;

    }
    return UITableViewCellEditingStyleNone;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要撤销吗？" delegate:self cancelButtonTitle:@"放弃" otherButtonTitles:@"撤销", nil];
        [alertView show];
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_modeStr isEqualToString:@"2"]) {
        
    }else
    {
        HolidayListViewCell*cell=(HolidayListViewCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
        XJSubViewController*xjvc=[XJSubViewController new];
        xjvc.SummarStr=cell.summaryStr.text;
        xjvc.ReasonLabelStr=cell.reasonStr.text;
        xjvc.presosIdStr=cell.processIDStr.text;
        
        [self.navigationController pushViewController:xjvc animated:YES];
    }
   
    
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        HolidayListMode *model=arrayData[indexPath2.row];
        [[MyRequest defaultsRequest]backoutHoliDayUserid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] Token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] processId:model.processId Type:@"1" Date:model.StartDate string:^(NSString *str) {
            if ([str isEqualToString:@"OK"]) {
                PL_ALERT_SHOW(@"撤销成功");
                
                [listTableView deselectRowAtIndexPath:indexPath2 animated:YES];
                [arrayData removeObjectAtIndex:indexPath2.row];
                [listTableView reloadData];
                
            }else if ([str isEqualToString:@"1"])
            {
                PL_ALERT_SHOW(@"撤销失败");
            }else if ([str isEqualToString:@"2"])
            {
                PL_ALERT_SHOW(@"因流程状态问题，未执行撤销");
            }else if([str isEqualToString:@"3"])
            {
                PL_ALERT_SHOW(@"所选日期小于当前日期");
            }else if ([str isEqualToString:@"4"])
            {
                PL_ALERT_SHOW(@"已审核请假申请不能撤销");
            }
            else if([str isEqualToString:@"exception"])
            {
                PL_ALERT_SHOW(@"服务器异常");
            }
            else
            {
                PL_ALERT_SHOW(@"请求超时");
            }
        }];
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    indexPath2=indexPath;
    return @"撤销申请";
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
