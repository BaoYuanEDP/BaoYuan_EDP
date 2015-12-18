//
//  PersonSearchListVC.m
//  BYFCApp
//
//  Created by heaven on 15-7-9.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "PersonSearchListVC.h"

@interface PersonSearchListVC ()

@end

@implementation PersonSearchListVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"员工联系表";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.hidesBackButton = YES;
    UIButton * backBnt = [UIButton buttonWithType:UIButtonTypeSystem];
    [backBnt setBackgroundImage:[UIImage imageNamed:BY_BACK_IAMGE] forState:UIControlStateNormal];
    backBnt.frame = CGRectMake(10, 12, 16, 23);
    [backBnt addTarget:self action:@selector(viewReturn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _page = 1;
    [self requestObj];
    [self setupRefresh];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    [self UITableViewLine];
    // Do any additional setup after loading the view from its nib.
}
//下啦刷新上拉加载
- (void)setupRefresh
{
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerReleaseToRefreshText = @"松开刷新";
    self.tableView.headerRefreshingText = @"房源正在刷新中";
    
    self.tableView.footerPullToRefreshText = @"上拉加载更多数据";
    self.tableView.footerReleaseToRefreshText = @"松开加载更多数据";
    self.tableView.footerRefreshingText = @"房源正在加载中";
}
- (void)headerRereshing
{
        _page = 1;
//        [_arrayData removeAllObjects];
        [self requestObj];
        [self.tableView headerEndRefreshing];
}
- (void)footerRereshing
{
        PL_PROGRESS_SHOW;
        _page ++;
        NSString *strNum = [NSString stringWithFormat:@"%ld",(long)_page];
        [[MyRequest defaultsRequest] getEmpInfoList:_strText index:strNum userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] backInfoMessage:^(NSMutableArray *array) {
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
        [self.tableView footerEndRefreshing];
}
- (void)requestObj
{
        _arrayData = [[NSMutableArray alloc]init];
        PL_PROGRESS_SHOW;
        NSString *strNum = [NSString stringWithFormat:@"%ld",(long)_page];
        [[MyRequest defaultsRequest] getEmpInfoList:_strText index:strNum userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] backInfoMessage:^(NSMutableArray *array) {
            NSString *str = [array objectAtIndex:0];
            if ([str isEqual:@"NOLOGIN"]) {
                PL_PROGRESS_DISMISS;
                ViewController *login=[[ViewController alloc]init];
                [self.navigationController pushViewController:login animated:YES];
            }else if ([str isEqual:@"[]"]){
                PL_ALERT_SHOWNOT_OKAND_YES(@"没有更多了!");
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
//tableView15像素删除
- (void)UITableViewLine
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark -UITableView dataSourceDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strID = @"ID";
        _cell = (PersonSearchCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:strID];
        if (_cell == nil) {
            _cell = [[[NSBundle mainBundle] loadNibNamed:@"PersonSearchCellTableViewCell" owner:self options:nil] lastObject];
        }
    if (_arrayData.count > 0) {
        [_cell cellData:_arrayData[indexPath.row]];
    }
        return _cell;
}
#pragma mark -UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        SearchDetailslViewController *searchVC = [[SearchDetailslViewController alloc] initWithNibName:@"SearchDetailslViewController" bundle:nil];
        searchVC.model = _arrayData[indexPath.row];
        [self.navigationController pushViewController:searchVC animated:YES];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewReturn
{
    [self.navigationController popViewControllerAnimated:YES];
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