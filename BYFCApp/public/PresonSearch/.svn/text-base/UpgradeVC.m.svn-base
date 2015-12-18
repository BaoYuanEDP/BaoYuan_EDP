//
//  UpgradeVC.m
//  BYFCApp
//
//  Created by heaven on 15-7-10.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "UpgradeVC.h"

@interface UpgradeVC ()

@end

@implementation UpgradeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"版本更新日志";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.hidesBackButton = YES;
    UIButton * backBnt = [UIButton buttonWithType:UIButtonTypeSystem];
    [backBnt setBackgroundImage:[UIImage imageNamed:BY_BACK_IAMGE] forState:UIControlStateNormal];
    backBnt.frame = CGRectMake(10, 12, 16, 23);
    [backBnt addTarget:self action:@selector(viewReturn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _arrayData = [[NSMutableArray alloc]init];
    [self requestObj];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    [self UITableViewLine];
    // Do any additional setup after loading the view from its nib.
}
- (void)requestObj
{
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest] GetUpgradeLog:@"1" userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] backInfoMessage:^(NSMutableArray *array) {
        NSLog(@"%@",array);
        [_arrayData addObjectsFromArray:array];
        [_tableView reloadData];
        PL_PROGRESS_DISMISS;
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
        UpgradeCell *cell = (UpgradeCell *)[tableView dequeueReusableCellWithIdentifier:strID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"UpgradeCell" owner:self options:nil] lastObject];
        }
        [cell cellData:_arrayData[indexPath.row]];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
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
