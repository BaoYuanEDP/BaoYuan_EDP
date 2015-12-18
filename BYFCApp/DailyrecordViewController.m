//
//  DailyrecordViewController.m
//  BYFCApp
//
//  Created by PengLee on 15/12/2.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import "DailyrecordViewController.h"
#import "PL_Header.h"
@interface DailyrecordViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * tableViewList;
    NSArray *arrayTitle;
    UITableView *mainTableView;
    NSMutableArray *arrayData;
    NSMutableDictionary *arrayDictList;
    NSArray *arrayUpgrade;
    NSArray *arrayADD;
}
@end

@implementation DailyrecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"版本更新日志";
    self.view.backgroundColor = [UIColor blackColor];
    arrayTitle = @[@"版本信息",@"新增功能",@"功能优化"];
    arrayData = [NSMutableArray array];
    [self VersionLogRequest];
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    // backItemBnt.backgroundColor=[UIColor redColor];
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT) style:UITableViewStylePlain];
    mainTableView.delegate =self;
    mainTableView.dataSource = self;
    [self.view addSubview:mainTableView];
    // Do any additional setup after loading the view.
}
-(void)VersionLogRequest
{
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]GetUpgradeLog:@"1" userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] backInfoMessage:^(NSMutableArray *array) {
        if ([array[0] isEqual:@"[]"]) {
            PL_ALERT_SHOW(@"暂无数据");
        }
        else
        {
            [arrayData addObjectsFromArray:array];
        }
        
        [tableViewList reloadData];
        [mainTableView reloadData];
        PL_PROGRESS_DISMISS;
    }];
    
    
    
}
-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - tableView代理
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView == tableViewList)
    {
        if (section == 0) {
            return arrayTitle[section];
        }
        if (section == 1) {
            return arrayTitle[section];
        }
        if (section == 2) {
            return arrayTitle[section];
        }
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == tableViewList) {
        return 3;
    }
    else
    {
        return 1;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == mainTableView)
    {
        static NSString *cellName = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            
        }
        arrayDictList = [NSMutableDictionary dictionary];
        arrayDictList = [NSMutableDictionary dictionaryWithDictionary:arrayData[indexPath.row]];
        arrayADD = [NSArray array];
        arrayADD = [arrayDictList[@"UpgradeLogAdd"] componentsSeparatedByString:@"|"];
        arrayUpgrade = [NSArray array];
        arrayUpgrade = [arrayDictList[@"UpgradeLogModify"] componentsSeparatedByString:@"|"];
        tableViewList = [[UITableView alloc] initWithFrame:CGRectMake(0,0, PL_WIDTH,arrayADD.count*30+arrayUpgrade.count*30+30*3+30) style:UITableViewStyleGrouped];
        tableViewList.delegate = self;
        tableViewList.dataSource = self;
        tableViewList.backgroundColor = [UIColor whiteColor];
        tableViewList.scrollEnabled = NO;
        [cell addSubview:tableViewList];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, arrayADD.count*30+arrayUpgrade.count*30+30*3+30, PL_WIDTH, 1)];
        imageView.image = [UIImage imageNamed:@"hengxian.png"];
        [cell addSubview:imageView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(tableView == tableViewList)
    {
        static NSString *cellName1 = @"cellID1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName1];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName1];
        }
        if(indexPath.section == 0)
        {
            if(indexPath.row == 0)
            {
                cell.textLabel.text  = [NSString stringWithFormat:@"版本号:%@        更新时间:%@ ",arrayDictList[@"Version"],arrayDictList[@"CreateDate"]];
                cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
            }
            else if(indexPath.row == 1)
            {
                cell.textLabel.text  = [NSString stringWithFormat:@"更新时间:%@",arrayDictList[@"CreateDate"]];
                cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
            }
        }
        else if(indexPath.section == 1)
        {
            cell.textLabel.text = arrayADD[indexPath.row];
            if([arrayADD[indexPath.row] isEqualToString:@""])
            {
                cell.textLabel.text = @"无";
            }
            cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
        }
        else if(indexPath.section == 2)
        {
            cell.textLabel.text = arrayUpgrade[indexPath.row];
            if([arrayUpgrade[indexPath.row] isEqualToString:@""])
            {
                cell.textLabel.text = @"无";
                
            }
            cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tableViewList) {
        return 30;
    }
    else if(tableView == mainTableView)
    {
        return arrayADD.count*30+arrayUpgrade.count*30+30*3+30;
        
        //        return arrayADD.count*30+arrayUpgrade.count*30+30*3+30*2;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == tableViewList) {
        if (section == 0) {
            return 1;
        }
        else if(section == 1)
        {
            return arrayADD.count;
        }
        else if(section == 2)
        {
            return arrayUpgrade.count;
        }
    }
    else if(tableView == mainTableView)
    {
        return arrayData.count;
    }
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView == tableViewList)
    {
        return 30;
    }
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView == tableViewList)
    {
        if (section == 0)
        {
            UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
            headerView.text = @"   版本信息";
            headerView.backgroundColor = PL_CUSTOM_COLOR(224, 224, 224, 1);
            return headerView;
        }
        return nil;
    }
    return nil;
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
