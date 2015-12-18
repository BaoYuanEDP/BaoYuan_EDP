//
//  Custom_Popover7.m
//  BYFCApp
//
//  Created by 王鹏 on 15/12/15.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import "Custom_Popover7.h"
#import "PL_Header.h"
@implementation Custom_Popover7

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.BackgrounView=[[UIView alloc]initWithFrame:CGRectMake(20, 40, PL_WIDTH-40,400)];
        UIView*HeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.BackgrounView.frame.size.width, 40)];
        HeaderView.backgroundColor=[UIColor grayColor];
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 120, 20)];
        label.text=@"上传保管钥匙协议书";
        label.font=[UIFont systemFontOfSize:12.0];
        [HeaderView addSubview:label];
        self.XXButoon=[[UIButton alloc]initWithFrame:CGRectMake(HeaderView.frame.size.width-30, 10, 25, 25)];
        [self.XXButoon setBackgroundImage:[UIImage imageNamed:@"取消1.png"] forState:0];
        [HeaderView addSubview:self.XXButoon];
        [self.BackgrounView addSubview:HeaderView];
        self.BackgrounView.userInteractionEnabled=YES;
        
        self.userInteractionEnabled=YES;
        
        self.BackgrounView.layer.cornerRadius=8;
        self.BackgrounView.layer.masksToBounds=YES;
        
        self.MainTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, self.BackgrounView.frame.size.width, self.BackgrounView.frame.size.height-80) style:UITableViewStyleGrouped];
        self.MainTableView.layer.cornerRadius=8;
        self.MainTableView.layer.masksToBounds=YES;

        _MainTableView.delegate=self;
        _MainTableView.dataSource=self;
        [self.BackgrounView addSubview:_MainTableView];
        [self addSubview:self.BackgrounView];
        
       
    }
    
    return self;
    
}
-(VisitingCard_Header *)VisitingCard
{
    if (!_VisitingCard) {
        _VisitingCard=[VisitingCard_Header AddSubHeaderView_VisitingCard];
        
    }
    return _VisitingCard;
    
}
-(ID_Card_Header *)ID_Card
{
    if (!_ID_Card) {
        _ID_Card=[ID_Card_Header AddSubHeaderView_ID_Card];
        
    }
    return _ID_Card;
}
-(KeyBook_Header *)KeyBook
{
    if (!_KeyBook) {
        _KeyBook=[KeyBook_Header AddSubHeaderView_KeyBook];
    }
    return _KeyBook;
}
-(UpCommit_Footer *)UpCommit
{
    if (!_UpCommit) {
        _UpCommit=[UpCommit_Footer AddSubHeaderView_UpCommit];
    }
    return _UpCommit;
}
+(Custom_Popover7*)InitWithCutom_Popover7
{
    Custom_Popover7*Cuton7=[[Custom_Popover7 alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
//    [[UINib nibWithNibName:@"Custom_Popover7" bundle:nil]instantiateWithOwner:self options:nil].lastObject;
   
    return Cuton7;
    
}


- (void)drawRect:(CGRect)rect {
    
//    self.MainTableView.rowHeight=0.01;
    
//    _MainTableView.delegate=self;
//    _MainTableView.dataSource=self;
//    _MainTableView.bounces=NO;
////    _MainTableView.contentOffset=CGPointMake(0, 35);
////    _MainTableView.contentSize=CGSizeMake(self.BackgrounView.frame.size.width, 960);
//    _MainTableView.showsVerticalScrollIndicator=NO;
//    _MainTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
//    _MainTableView.contentInset =UIEdgeInsetsMake(0, 0, 0, 0);
    
    Sel=0;
//    [self.MainTableView reloadData];
    
   
}

#pragma mark TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return [self.Delegate TableView:tableView CellForRowAtIndexPath:indexPath];

            break;
            case 1:
            return [self.Delegate TableView:tableView CellForRowAtIndexPath:indexPath];
            break;
            case 2:
            return [self.Delegate TableView:tableView CellForRowAtIndexPath:indexPath];

        default:
            break;
    }
    return nil;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return self.VisitingCard;
            
            break;
            case 1:
            return self.ID_Card;
            break;
            case 2:
            return self.KeyBook;
        default:
            break;
    }
    return nil;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==2) {
        return self.UpCommit;
        
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0.01;
            break;
          case 1:
            return 0.01;
            break;
            case 2:
            return 90;
        default:
            break;
    }
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 90;
            break;
            case 1:
            return 90;
            break;
            case 2:
            return 90;
        default:
            break;
    }
    
    return 0.01;
}
-(void)RowHeight:(CGFloat)height
{
    [self.MainTableView beginUpdates];
    self.MainTableView.rowHeight=height;
    
    Sel=1;
    [self.MainTableView endUpdates];
}
-(void)RowHeight1:(CGFloat)height
{
    [self.MainTableView beginUpdates];
    Sel=0;
    Height1=height;
    [self.MainTableView endUpdates];
}
-(void)RowHeight2:(CGFloat)height
{
    Sel=0;
    [self.MainTableView beginUpdates];
    Height2=height;
    [self.MainTableView endUpdates];

}
-(void)RowHeight3:(CGFloat)height
{
    Sel=0;
    [self.MainTableView beginUpdates];
    Height3=height;
     _MainTableView.contentSize=CGSizeMake(self.BackgrounView.frame.size.width, 1000);
    [self.MainTableView endUpdates];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!Sel==1) {
        
    switch (indexPath.section) {
        case 0:
          return  Height1;
            break;
            case 1:
            return Height2;
            break;
            case 2:
            return Height3;
        default:
            break;
    }
    
    }else
    {
        return self.MainTableView.rowHeight;
    }
    return 0.1;
    
}
@end
