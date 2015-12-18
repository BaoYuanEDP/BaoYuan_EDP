//
//  GoOutApplyListViewController.m
//  BYFCApp
//
//  Created by PengLee on 15/7/17.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "GoOutApplyListViewController.h"
#import "PL_Header.h"
#import "GoOutApplyListCell.h"
@interface GoOutApplyListViewController ()<UIAlertViewDelegate>
{
    UITableView *_tableView;
    GoOutApplyListCell *Cell;
    NSIndexPath*_indexPath;
    NSString*CellgooutDate;
    NSString*Procesid;
    NSString *isHuoMianStr;
}
@end

@implementation GoOutApplyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"外出及豁免申请列表";
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    [_tableView setEditing:!_tableView.editing animated:YES];
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    // backItemBnt.backgroundColor=[UIColor redColor];
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.automaticallyAdjustsScrollViewInsets = NO;
       _page = 1;
    isHuoMianStr = @"2";
    [self creatTableView];
    [self requestObj];
    [self setupRefresh];
    [self UITableViewLine];
    
}
//下啦刷新上拉加载
- (void)setupRefresh
{
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    _tableView.headerPullToRefreshText = @"下拉刷新";
    _tableView.headerReleaseToRefreshText = @"松开刷新";
    _tableView.headerRefreshingText = @"正在刷新中";
    
    _tableView.footerPullToRefreshText = @"上拉加载更多数据";
    _tableView.footerReleaseToRefreshText = @"松开加载更多数据";
    _tableView.footerRefreshingText = @"正在加载中";
}
- (void)headerRereshing
{
    _page = 1;
    //        [_arrayData removeAllObjects];
    [self requestObj];
    [_tableView headerEndRefreshing];
}
- (void)footerRereshing
{
    PL_PROGRESS_SHOW;
    _page ++;
    NSString *strNum = [NSString stringWithFormat:@"%ld",(long)_page];
    [[MyRequest defaultsRequest]GetGoOutListStartIndex:strNum userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] string:^(NSMutableArray *array) {

        
        NSString *str = [array objectAtIndex:0];
        if ([str isEqual:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }else if ([str isEqual:@"[]"]){
            PL_ALERT_SHOWNOT_OKAND_YES(@"没有更多了!");
            PL_PROGRESS_DISMISS;
            _page--;
        }
        else
        {
            [_arrayData addObjectsFromArray:array];
            [_tableView reloadData];
            PL_PROGRESS_DISMISS;
        }
        
    }];
    [_tableView footerEndRefreshing];
}

//tableView15像素删除
- (void)UITableViewLine
{
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (void)requestObj
{
    _arrayData = [[NSMutableArray alloc]init];
    PL_PROGRESS_SHOW;
    NSString *strNum = [NSString stringWithFormat:@"%ld",(long)_page];
    [[MyRequest defaultsRequest]GetGoOutListStartIndex:strNum userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] string:^(NSMutableArray *array) {
                   NSString *str = [array objectAtIndex:0];
        
        if ([str isEqual:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }else if ([str isEqual:@"[]"]){
            PL_ALERT_SHOWNOT_OKAND_YES(@"暂无外出申请数据!");
            PL_PROGRESS_DISMISS;
        }
        else
        {
            [_arrayData addObjectsFromArray:array];
            [_tableView reloadData];
       
            PL_PROGRESS_DISMISS;
        }
        
    }];
    
}

#pragma mark -----自定义返回按钮方法
-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)creatTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, PL_WIDTH, PL_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - tableView代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cellID";
    Cell= (GoOutApplyListCell *)[tableView dequeueReusableCellWithIdentifier:cellName];
    if(Cell == nil)
    {
        Cell = [[[NSBundle mainBundle] loadNibNamed:@"GoOutApplyListCell" owner:self options:nil] lastObject];
        Cell.selectionStyle=UITableViewCellSelectionStyleNone;
       
        
            }
    if (_arrayData.count > 0) {
        [Cell cellData:_arrayData[indexPath.row]];
                 }
     return Cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64.0f;
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
-(NSString*)ComTimer
{
    
    NSDateFormatter * dateFormatter2= [[NSDateFormatter alloc]init];
    dateFormatter2.dateFormat = @"HH:mm";
    NSDate*date3=[[NSDate alloc]init];

    NSString*locaTimer=[dateFormatter2 stringFromDate:date3];
    
    return locaTimer;
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
    
    GoOutApplyListCellModel*model=_arrayData[indexPath.row];
    if([isHuoMianStr isEqualToString:@"3"])
    {
        CellgooutDate=[ [model.data substringToIndex:10]stringByAppendingFormat:@" %@:00",model.StartTime ];
    }
    else
    {
        CellgooutDate= [[model.data substringToIndex:10]stringByAppendingFormat:@" 00:00:00"];
    }
    
    if([model.timeBuck isEqualToString:@"1"]||[model.timeBuck isEqualToString:@"2"])
    {
        isHuoMianStr = @"3";
    }
    UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要撤销吗？" delegate:self cancelButtonTitle:@"放弃" otherButtonTitles:@"撤销", nil];
    [alertView show];

//    NSDateFormatter * dateFormatter2= [[NSDateFormatter alloc]init];
//    dateFormatter2.dateFormat = @"yyyy-MM-dd";
//    NSString*str=[[dateFormatter2 stringFromDate:[NSDate date]]substringToIndex:10];
//    if ([str compare:CellgooutDate]==NSOrderedDescending)
//    {
//            PL_ALERT_SHOW(@"时间已过,不可以撤销");
//      }else if([str compare:CellgooutDate]==NSOrderedAscending)
//    {
//        [alertView show];
//    }else
//    {
//        NSString* strMedth=[self ComTimer];
//        NSString*strdate=model.StartTime;
//        if ([strMedth compare:strdate]==NSOrderedAscending) {
//            [alertView show];
//        }else
//        {
//            PL_ALERT_SHOW(@"时间已过,不可以撤销");
//        }
//       }
//    

    }
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CGPoint indexPoint=[touch locationInView:_tableView];
    _indexPath=[_tableView indexPathForRowAtPoint:indexPoint];
    
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    _indexPath=indexPath;
    return @"撤销申请";
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        
        GoOutApplyListCellModel *model = _arrayData[_indexPath.row];
        Procesid=model.ProcessId;
        [[MyRequest defaultsRequest]getGoulistbackoutUserid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] Token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] processId:Procesid Type:isHuoMianStr Date:CellgooutDate string:^(NSString *str) {
            if ([str isEqualToString:@"OK"]) {
                PL_ALERT_SHOW(@"撤销成功");
                [_tableView beginUpdates];
                [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
                [_arrayData removeObjectAtIndex:_indexPath.row];
                
                [_tableView endUpdates];
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
            else if ([str isEqualToString:@"exception"]) {
                PL_ALERT_SHOW(@"服务器异常");
            }
            else
            {
                PL_ALERT_SHOW(@"请求超时");

            }
        }];
    }
}

@end
