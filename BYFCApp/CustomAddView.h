//
//  CustomAddView.h
//  BYFCApp
//
//  Created by PengLee on 15/3/17.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PL_Header.h"
@protocol CustomDelegate;

@interface CustomAddView : UIView<UITableViewDataSource,UITableViewDelegate>

{
    UITableView * _tableView1;
    UITableView * _tableView2;
    UIView * _bagroundView;
    NSString * _cacheEstateString;
    NSMutableArray *arrayStr;
    
    
    
}
@property (strong,nonatomic)NSArray * arrayR;
@property (strong,nonatomic)NSMutableArray * table2Array;
@property (weak,nonatomic)id <CustomDelegate>delegate;

- (id)initWithArray:(NSArray *)array;
- (void)showInView:(UIView *)myView animation:(BOOL)animation;

@end
@protocol CustomDelegate <NSObject>

@optional
- (void)didSelRowIndexPath:(NSIndexPath *)indexPath titleName:(NSString *)string xingzhengqu:(NSString *)string1;
//一级行政区域；
-(void)didSelectRowIndexPath:(NSIndexPath *)indexPath administrativeArea:(NSString *)adminnistat;
//二级行政区域
-(void)didSelectRowIndexPath:(NSIndexPath *)indexPath sadministativeArea:(NSString *)adminnistat;
//传areaid
-(void)didSelectRowIndexPath:(NSIndexPath *)indexPath AreaID:(NSString *)areaID;

@end