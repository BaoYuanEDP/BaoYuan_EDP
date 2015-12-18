//
//  HoliDayRevamTableViewController.m
//  BYFCApp
//
//  Created by 王鹏 on 15/8/28.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "HoliDayRevamViewController.h"
#import "MyRequest.h"
#import "HolidaySubCell.h"
@interface HoliDayRevamViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIWindow*win;
}


@end

@implementation HoliDayRevamViewController
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:YES];
//    [self postRequest];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"销假申请";
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    UIButton*LeftBut=[[UIButton alloc]initWithFrame:CGRectMake(30, 40, 10, 20)];
    [LeftBut setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal ];
    [LeftBut addTarget:self action:@selector(LeftButA) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*leftBar=[[UIBarButtonItem alloc]initWithCustomView:LeftBut];
    self.navigationItem.leftBarButtonItem=leftBar;
    
     [self postRequest];
    
   }
-(void)LeftButA
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return _arrayData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
       HolidaySubCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"HolidaySubCell" owner:self options:nil]lastObject];
        
    
       cell.TimerLabel.text=_arrayData[indexPath.row][@"WorkDay"];
        cell.ATypeLabel.text=_arrayData[indexPath.row][@"ATypeName"];
        cell.MTypeLabel.text=_arrayData[indexPath.row][@"MTypeName"];
        cell.ATpyeBut.tag=indexPath.row;
        cell.MTypeBut.tag=indexPath.row;
        [cell.ATpyeBut addTarget:self action:@selector(But:) forControlEvents:UIControlEventTouchUpInside];
         [cell.MTypeBut  addTarget:self action:@selector(But:) forControlEvents:UIControlEventTouchUpInside];
    }
        return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.0;
    
    
}
-(void)But:(UIButton*)sender
{
            if (sender.tag==0) {
            sender.selected=!sender.selected;
            }
            if (sender.tag) {
                sender.selected=!sender.selected;
            }
    
}



//请求数据
-(void)postRequest
{
        _arrayData = [NSMutableArray array];
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]holiDayGetRequestUserid:[PL_USER_STORAGE objectForKey:PL_USER_USERID] Token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSMutableArray *array) {
        PL_PROGRESS_DISMISS;
       
        
        
        [_arrayData addObjectsFromArray:array];
        [self.tableview reloadData];

        
        
        
        
        
        
        
    }];
    
    
    
}
@end
