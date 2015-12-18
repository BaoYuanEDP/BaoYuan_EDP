//
//  VersionTableViewController.m
//  VersionMainaTabelView
//
//  Created by Wangpu_IOS on 15/11/26.
//  Copyright © 2015年 Wangpu_IOS. All rights reserved.
//

#import "VersionTableViewController.h"
#import  "VersionTableViewCell.h"
#import "PL_Header.h"

@interface VersionTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UINib*LoadNib;
//列表里面的子数组
@property(nonatomic,strong)NSMutableArray*SubDataArray;
//版本号的数组
@property(nonatomic,strong)NSMutableArray*VersionArray;
@end

@implementation VersionTableViewController
-(UINib *)LoadNib
{
    if (!_LoadNib) {
        _LoadNib=[UINib nibWithNibName:@"VersionTableViewCell" bundle:nil];
    }
    return _LoadNib;
}
//Lazy LoadingSubDataArray
-(NSMutableArray *)SubDataArray
{
    if (!_SubDataArray) {
        _SubDataArray=[NSMutableArray array];
    }
    return _SubDataArray;
}
-(NSMutableArray *)VersionArray
{
    if (!_VersionArray) {
        _VersionArray=[NSMutableArray array];
    }
    return _VersionArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"版本更新日志";
    self.navigationItem.hidesBackButton = YES;
    UIButton * backBnt = [UIButton buttonWithType:UIButtonTypeSystem];
    [backBnt setBackgroundImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
    backBnt.frame = CGRectMake(10, 12, 16, 23);
    [backBnt addTarget:self action:@selector(viewReturn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    [self InitializeTabelView];
    }
//initialize
-(void)InitializeTabelView
{
    [self VersionLogRequest];
    self.VersionMainTabelView.delegate=self;
    self.VersionMainTabelView.dataSource=self;
    self.VersionMainTabelView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        
    
}
-(void)VersionLogRequest
{
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]GetUpgradeLog:@"1" userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] backInfoMessage:^(NSMutableArray *array) {

        PL_PROGRESS_DISMISS;
    }];

    

}
- (void)viewReturn
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark--TabelViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

#pragma mark--LoadingVersionTableViewCell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        VersionTableViewCell*VersionCell=[tableView dequeueReusableCellWithIdentifier:@"VerSionCell"];
        if (!VersionCell) {
            VersionCell=[[self.LoadNib instantiateWithOwner:self options:nil]lastObject];
            VersionCell.SubDataArray=self.SubDataArray;
            VersionCell.VersionArray=self.VersionArray;
        }
    
        return VersionCell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat Count=self.SubDataArray.count;
    return 340;
    
}
@end
