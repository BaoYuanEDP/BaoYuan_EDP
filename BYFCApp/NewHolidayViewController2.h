//
//  NewHolidayViewController2.h
//  BYFCApp
//
//  Created by PengLee on 15/9/1.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewHolidayViewController2 : UIViewController
{
    //请假类型
    NSMutableArray *styleArr;
}
@property(nonatomic,strong)NSMutableArray *array;

@property(nonatomic,strong)UITableView *typeTableView;
//推出View
@property(nonatomic,strong) UIView *pushView;
//日期
@property (nonatomic,strong) UIDatePicker *datePicker;

@property (nonatomic,strong) NSString *hourstr;
//提交请假类型返回的数字
@property(nonatomic,strong)NSNumber *numStr;




//确认提交按钮
@property (weak, nonatomic) IBOutlet UIButton *sureBut;
//确认提交按钮事件
- (IBAction)sureButAction:(id)sender;
//取消按钮
@property (weak, nonatomic) IBOutlet UIButton *cancelBut;
//取消提交按钮事件
- (IBAction)cancelButAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell1;
//申请人
@property (weak, nonatomic) IBOutlet UILabel *name;
//员工编号
@property (weak, nonatomic) IBOutlet UILabel *bianhao;
//年假
@property (weak, nonatomic) IBOutlet UILabel *yearHour;
//有薪病假
@property (weak, nonatomic) IBOutlet UILabel *moneyHour;
//调休
@property (weak, nonatomic) IBOutlet UILabel *tiaoXiuHour;

@property (strong, nonatomic) IBOutlet UITableViewCell *cell2;
//请假类型
@property (weak, nonatomic) IBOutlet UILabel *type;
//请选择1
@property (weak, nonatomic) IBOutlet UILabel *select1;

@property (strong, nonatomic) IBOutlet UITableViewCell *cell3;
//开始时间
@property (weak, nonatomic) IBOutlet UILabel *startTime;
//请选择2
@property (weak, nonatomic) IBOutlet UILabel *select2;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell4;
//结束时间
@property (weak, nonatomic) IBOutlet UILabel *endTime;
//请选择3
@property (weak, nonatomic) IBOutlet UILabel *select3;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell5;
//请假事由输入框
@property (weak, nonatomic) IBOutlet UITextView *printTextView;
//请输入
@property (weak, nonatomic) IBOutlet UILabel *select4;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell6;
@property (weak, nonatomic) IBOutlet UIImageView *upImage;
- (IBAction)upButAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *StarTimeCellContentView;
@property (weak, nonatomic) IBOutlet UIView *EndTimeCellContentView;
@property (nonatomic) BOOL isStart;


@end
