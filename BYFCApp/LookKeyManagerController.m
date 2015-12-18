//
//  ViewController.m
//  单个demo
//
//  Created by 王鹏 on 15/12/8.
//  Copyright © 2015年 王鹏. All rights reserved.
//

#import "LookKeyManagerController.h"
#import "LookKeyListCell.h"
#import "CycleScrollView.h"
#import "RoomVC_ViewModel.h"
@interface LookKeyManagerController ()<UITableViewDataSource,UITableViewDelegate>
{
    
CycleScrollView*CyScrollViewInit;
    
    
}

@end

@implementation LookKeyManagerController
-(NSMutableArray *)ImageViewArray
{
    if (!_ImageViewArray) {
        _ImageViewArray=[NSMutableArray array];
    }
    return _ImageViewArray;
}
-(NSMutableArray*)KeyArray
{
    if (!_KeyArray) {
        _KeyArray=[NSMutableArray array];
    }
    return _KeyArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
        [self.KeyArray addObjectsFromArray:[RoomVC_ViewModel DefalutRoomVC].LookKeyArray];
        [self.ImageViewArray addObjectsFromArray:[RoomVC_ViewModel DefalutRoomVC].DowdloadImageArray];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CyScrollViewInit=[[CycleScrollView alloc]initWithFrame:CGRectMake(10,2, PL_WIDTH-20, 300)];
    CyScrollViewInit.layer.masksToBounds=YES;
    CyScrollViewInit.layer.borderWidth=2;
    CyScrollViewInit.layer.borderColor=[UIColor grayColor].CGColor;
    
    [CyScrollViewInit cycleDirection:CycleDirectionLandscape pictures:self.ImageViewArray];
    [self.ScroolViewBackGround addSubview:CyScrollViewInit];
    [self ConfigurationAllSubView];

    
}
- (IBAction)ExitSelfView:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)ConfigurationAllSubView
{
  
   
    self.MaintTabeleView.dataSource=self;
    self.MaintTabeleView.delegate=self;
}
#pragma mark--TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
           LookKeyListCell*cell=[tableView dequeueReusableCellWithIdentifier:@"LookCell"];
        if (!cell) {
            cell=[[UINib nibWithNibName:@"LookKeyListCell" bundle:nil]instantiateWithOwner:self options:nil].lastObject;
       
              }
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        return 229;

    }
    return 0;
    }
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(40, 0, 100, 30)];
                label.textColor=[UIColor redColor];
        label.text=@"   钥匙保管情况";
        label.font=[UIFont fontWithName:@"HiraKakuProN-W3" size:13];
        return label;
        
    }else if (section==1)
    {
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(40, 0, 100, 30)];
               label.textColor=[UIColor redColor];
        label.text=@"   钥匙托管协议书|胸卡";
        label.font=[UIFont fontWithName:@"HiraKakuProN-W3" size:13];
        return label;

    }
    
    
    return nil;
}


-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.ScroolViewBackGround;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0.1;
            break;
            case 1:
            return 229;
        default:
            break;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 30;
            break;
            case 1:
            return 30;
        default:
            break;
    }
    return 0;
}
@end
