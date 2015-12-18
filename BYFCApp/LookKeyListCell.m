//
//  LookKeyListCell.m
//  单个demo
//
//  Created by 王鹏 on 15/12/8.
//  Copyright © 2015年 王鹏. All rights reserved.
//

#import "LookKeyListCell.h"
#import "LookKeySubCell.h"
#import "RoomVC_ViewModel.h"
@implementation LookKeyListCell

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    
    

    
    
    
    return self;
}
- (void)awakeFromNib {
   
       self.ReceiveKeyArray=[RoomVC_ViewModel DefalutRoomVC].LookKeyArray;
    for (NSArray*ar in self.ReceiveKeyArray) {
        
        for (NSArray*arr in ar) {
            [self.DataArray addObject:arr];
        }
    }
    self.SubCell.delegate=self;
    self.SubCell.dataSource=self;
     }
-(NSMutableArray*)DataArray
{
    if (!_DataArray) {
        _DataArray=[NSMutableArray array];
    }
    return _DataArray;
}
-(NSMutableArray*)ReceiveKeyArray
{
    if (!_ReceiveKeyArray) {
        _ReceiveKeyArray=[NSMutableArray array];
       

    }
    return _ReceiveKeyArray;
}
/**
 *  获取数组的方法
 *
 *  @param KeyArry 数组
 */


#pragma mark--SubCellTableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.DataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LookKeySubCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UINib nibWithNibName:@"LookKeySubCell" bundle:nil]instantiateWithOwner:self options:nil].lastObject;
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell AddObjectsKeySubCellArray:self.DataArray[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
