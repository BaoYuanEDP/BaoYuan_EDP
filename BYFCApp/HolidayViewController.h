//
//  HolidayViewController.h
//  BYFCApp
//
//  Created by zzs on 15/3/12.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HolidayViewController : UIViewController
//
@property (strong, nonatomic) IBOutlet UIView *headerView;
//确认提交
- (IBAction)sureBtnAction:(id)sender;
//取消提交
- (IBAction)cancelBtnAction:(id)sender;
//
@property (weak, nonatomic) IBOutlet UITableView *holidayTableView;
//
@property (strong, nonatomic) IBOutlet UITableViewCell *cell1;
//选择请假信息的小View
@property (strong, nonatomic) IBOutlet UIView *pushView;
//请假类型
@property (weak, nonatomic) IBOutlet UIButton *btnLabel1;
//开始时间
@property (weak, nonatomic) IBOutlet UIButton *btnLabel2;
//结束时间
@property (weak, nonatomic) IBOutlet UIButton *btnLabel3;

//请选择按钮
@property (weak, nonatomic) IBOutlet UIButton *selectBtn1;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn2;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn3;
//请选择按钮点击事件
- (IBAction)selectBtn1Action:(id)sender;
- (IBAction)selectBtn2Action:(id)sender;
- (IBAction)selectBtn3Action:(id)sender;
//小View提交
- (IBAction)upAction:(id)sender;
//小View取消
- (IBAction)dismissAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *User;
@property (weak, nonatomic) IBOutlet UILabel *Code;
@property (weak, nonatomic) IBOutlet UILabel *moneyHour;
@property (weak, nonatomic) IBOutlet UILabel *yearHour;
@property (weak, nonatomic) IBOutlet UILabel *tiaoxiuHour;
@property (strong, nonatomic) IBOutlet UITableView *StyleTableView;
@end
