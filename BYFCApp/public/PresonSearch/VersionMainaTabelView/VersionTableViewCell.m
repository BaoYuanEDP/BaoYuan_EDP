//
//  VersionTableViewCell.m
//  VersionMainaTabelView
//
//  Created by Wangpu_IOS on 15/11/26.
//  Copyright © 2015年 Wangpu_IOS. All rights reserved.
//

#import "VersionTableViewCell.h"
#import "VersionListSubCell.h"
#include "PersonSearchCellModel.h"
@implementation VersionTableViewCell
//lazy LoadingNib
-(UINib *)Loadnib
{
    if (!_Loadnib) {
        _Loadnib=[UINib nibWithNibName:@"VersionListSubCell" bundle:nil];
    }
    return _Loadnib;
}
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
//InitializeTableViewCell
- (void)awakeFromNib {
    
    self.VersionTableViewCell.delegate=self;
    self.VersionTableViewCell.dataSource=self;
    self.VersionTableViewCell.scrollEnabled=NO;
    self.VersionTableViewCell.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
   
    
    
   
    
}
-(void)CellData_Row:(UpgradeldeModel*)model
{
    VersionListSubCell*cell=[[VersionListSubCell alloc]init];
    cell.VersionLabel.text=model.Version;
    cell.CreateDate.text=model.time;
    
    
    
    
    
}
#pragma mark--VersionTableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
            case 1:
            return 3;
            break;
            case 2:
            return 3;
        default:
            break;
    }
    return 0;
}
#pragma mark-LoadingVersionListSubCell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        VersionListSubCell*SubCell=[tableView dequeueReusableCellWithIdentifier:@"SubCell"];
        if (!SubCell) {
            SubCell=[[self.Loadnib instantiateWithOwner:self options:nil]
                     lastObject];
            
        }
        SubCell.selectionStyle=UITableViewCellSelectionStyleNone;
        SubCell.VersionLabel.text=@"dfsd";
//        SubCell.CreateDate.text=self.SubDataArray[indexPath.row][@"CreateDate"];
//        [self CellData_Row:self.SubDataArray[indexPath.row]];
        return SubCell;
    }else if (indexPath.section==1)
    {
        UITableViewCell*SubCell_Append=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SubCellAppend"];
//        SubCell_Append.textLabel.text=self.SubDataArray[indexPath.row];
        SubCell_Append.textLabel.font=[UIFont systemFontOfSize:12];
        SubCell_Append.selectionStyle=UITableViewCellSelectionStyleNone;
        return SubCell_Append;

    }else if (indexPath.section==2)
    {
        UITableViewCell*SubCell_Repair=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SubCellRepair"];
//        SubCell_Repair.textLabel.text=self.SubDataArray[indexPath.row];
        SubCell_Repair.textLabel.font=[UIFont systemFontOfSize:12];
        SubCell_Repair.selectionStyle=UITableViewCellSelectionStyleNone;
        return SubCell_Repair;

    }
    
    
    return nil;
    
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"版本信息";
            break;
            case 1:
            return @"新增功能";
            break;
            case 2:
            return @"功能优化";
        default:
            break;
    }
    return @"";
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 92;
            break;
            case 1:
            return 30;
            break;
            case 2:
            return 30;
        default:
            break;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 25;
            break;
            case 1:
            return 20;
            break;
            case 2:
            return 20;
        default:
            break;
    }
    return 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        
        UIView*FirstView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
        FirstView.backgroundColor=[UIColor lightGrayColor];
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 25)];
        label.text=@"版本信息";
        label.font=[UIFont fontWithName:@"Arial-BoldMT" size:15];
        [FirstView addSubview:label];
        return FirstView;
        
    }else if (section==1)
    {
        UIView*FirstView=[[UIView alloc]init];
        FirstView.backgroundColor=[UIColor orangeColor];
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 20)];
        label.text=@"新增功能:";
        label.font=[UIFont fontWithName:@"Arial-BoldMT" size:13];
        [FirstView addSubview:label];
        return FirstView;

        
    }else if (section==2)
    {
        UIView*FirstView=[[UIView alloc]init];
        FirstView.backgroundColor=[UIColor colorWithRed:56/255 green:255/255 blue:165/255 alpha:0.8];
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 20)];
        label.text=@"优化功能:";
        label.font=[UIFont fontWithName:@"Arial-BoldMT" size:13];
        [FirstView addSubview:label];
        return FirstView;

        
    }
    return nil;
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
