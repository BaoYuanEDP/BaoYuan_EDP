//
//  XJViewController.m
//  BYFCApp
//
//  Created by zzs on 15/3/26.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "XJViewController.h"
#import "PL_Header.h"
#import "HolidayCustomCell.h"
#import "XJSubViewController.h"
@interface XJViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    UIView*MainView;
    UIDatePicker*datePicker;
    UITextField*StarTextFiled;
    UITextField*EndTextFiled;
    NSIndexPath *indexPath2;
  
}

@end

@implementation XJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"休假申请";
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
    table=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heng.frame), PL_WIDTH, PL_HEIGHT-64) style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    // table.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
 //    [table setEditing:!table.editing animated:YES];
    [self.view addSubview:table];
    [self tableViewLine];
    [self request];
    [self setupRefresh ];
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    table.editing =editing;
    
    
}
//下啦刷新上拉加载
- (void)setupRefresh
{
    [table addHeaderWithTarget:self action:@selector(headerRereshing)];
    
       
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    table.headerPullToRefreshText = @"下拉刷新";
    table.headerReleaseToRefreshText = @"松开刷新";
    table.headerRefreshingText = @"正在刷新中";
    
    table.footerPullToRefreshText = @"上拉加载更多数据";
    table.footerReleaseToRefreshText = @"松开加载更多数据";
    table.footerRefreshingText = @"正在加载中";
}
- (void)headerRereshing
{

    //        [_arrayData removeAllObjects];
    [self request];
    [table headerEndRefreshing];
}
-(void)request
{  PL_PROGRESS_SHOW;
    _arryData = [NSMutableArray array];
    [[MyRequest defaultsRequest]afGetEveryDaylLeaveList:[PL_USER_STORAGE objectForKey:PL_USER_NAME] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] string:^(NSMutableArray *array) {
          NSString *str = [array objectAtIndex:0];
        if ([str isEqual:@"[]"]) {
            PL_ALERT_SHOW(@"暂无请假记录");
            PL_PROGRESS_DISMISS;
        }
        else if ([str isEqual:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
            PL_PROGRESS_DISMISS;
        }
        
        else  if ([str isEqual:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        else
        {
            [_arryData addObjectsFromArray:array];
            [table reloadData];
            PL_PROGRESS_DISMISS;
        }
       
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arryData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"cell";
    HolidayCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"HolidayCustomCell" owner:self options:nil] lastObject];
    }
    if (_arryData.count>0) {
        [cell cellLoadData:_arryData[indexPath.row]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
           }
   
    return cell;
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
    if ([table respondsToSelector:@selector(setSeparatorInset:)])
    {
        [table setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([table respondsToSelector:@selector(setLayoutMargins:)])
    {
        [table setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)rightClick
{
    
}
-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击到Cell");
   
    
    XJSubViewController*xjvc=[[XJSubViewController alloc]init];
    XJViewModel *model = _arryData[indexPath.row];
    xjvc.ValueStr=model.startDate;
    xjvc.ValueStr2=model.endDate;
    xjvc.Reasonstr=model.reason;
    xjvc.TypeStrPush=model.type;
    xjvc.statrt=model.flag;
    xjvc.name=model.name;
    xjvc.oldSaveNoStr = model.bianhao;
    if(![model.flag isEqualToString:@"1"])
    {
        PL_ALERT_SHOW(@"未通过审核,不能进行修改");
    }
    else
    {
        [self.navigationController pushViewController:xjvc animated:YES];

    }


}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
             UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要撤销吗？" delegate:self cancelButtonTitle:@"放弃" otherButtonTitles:@"撤销", nil];
        [alertView show];
      
     
    }
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  
    UITouch *touch = [touches anyObject];
    CGPoint indexPoint=[touch locationInView:table];
    indexPath2=[table indexPathForRowAtPoint:indexPoint];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        XJViewModel*model=_arryData[indexPath2.row];
//                NSString*Date=[model.startDate stringByReplacingOccurrencesOfString:@"T" withString:@" "];
              [[MyRequest defaultsRequest]backoutHoliDayUserid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] Token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] processId:model.bianhao Type:@"1" Date:model.startDate string:^(NSString *str) {
            if ([str isEqualToString:@"OK"]) {
                PL_ALERT_SHOW(@"撤销成功");
                
                [table deselectRowAtIndexPath:indexPath2 animated:YES];
                [_arryData removeObjectAtIndex:indexPath2.row];
                [table reloadData];

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
@end
