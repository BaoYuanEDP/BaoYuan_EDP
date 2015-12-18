//
//  CardLookViewController.m
//  BYFCApp
//
//  Created by PengLee on 15/7/23.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "CardLookViewController.h"
#import "PL_Header.h"
@interface CardLookViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation CardLookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"名片申请列表";
    self.navigationController.navigationBarHidden=NO;
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    _page = 1;
    // backItemBnt.backgroundColor=[UIColor redColor];
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    [self creatTableView];
    [self requestUI];
    [self setUpRefresh];
}
-(void)creatTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    [self tableViewLine];
}
-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)requestUI
{
    [_arrData removeAllObjects];
    _arrData = [[NSMutableArray alloc] init];
    PL_PROGRESS_SHOW;
    NSString *strIndex = [NSString stringWithFormat:@"%ld",(long)_page];
    [[MyRequest defaultsRequest] CardLookStartIndex:strIndex userid:[PL_USER_STORAGE objectForKey: PL_USER_NAME] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] string:^(NSMutableArray *array) {
        NSString *str = [array objectAtIndex:0];
        if([str isEqual:@"NOLOGIN"]){
            ViewController *login = [[ViewController alloc] init];
            [self.navigationController pushViewController:login animated:YES];
        }
        else if([str isEqual:@"[]"]){
            PL_ALERT_SHOWNOT_OKAND_YES(@"没有更多了");
            PL_PROGRESS_DISMISS;
        }
        else
        {
            [_arrData addObjectsFromArray:array];
            [_tableView reloadData];
            PL_PROGRESS_DISMISS;
        }
    }];
}
-(void)setUpRefresh
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
    [self requestUI];
    [_tableView headerEndRefreshing];
}
- (void)footerRereshing
{
    PL_PROGRESS_SHOW;
    _page ++;
    NSString *strIndex = [NSString stringWithFormat:@"%ld",(long)_page];
    [[MyRequest defaultsRequest] CardLookStartIndex:strIndex userid:[PL_USER_STORAGE objectForKey: PL_USER_NAME] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] string:^(NSMutableArray *array) {
        NSString *str = [array objectAtIndex:0];
        if([str isEqual:@"NOLOGIN"]){
            ViewController *login = [[ViewController alloc] init];
            [self.navigationController pushViewController:login animated:YES];
        }
        else if([str isEqual:@"[]"]){
            PL_ALERT_SHOWNOT_OKAND_YES(@"没有更多了");
            PL_PROGRESS_DISMISS;
            _page--;
        }
        else
        {
            [_arrData addObjectsFromArray:array];
            [_tableView reloadData];
            PL_PROGRESS_DISMISS;
        }
    }];

}
//删除15像素线
-(void)tableViewLine
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

#pragma mark tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cellID";
    CardLookViewCell *cell = (CardLookViewCell *)[tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell == nil)
    {
         cell = [[[NSBundle mainBundle] loadNibNamed:@"CardLookViewCell" owner:self options:nil] lastObject];
        
    }
    [cell cellLoadData:_arrData[indexPath.row]];
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
