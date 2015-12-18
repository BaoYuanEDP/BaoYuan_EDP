//
//  PersonSearchCellTableViewCell.h
//  BYFCApp
//
//  Created by heaven on 15-7-9.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "PersonSearchCellModel.h"

@interface PersonSearchCellTableViewCell : UITableViewCell
//姓名
@property (weak, nonatomic) IBOutlet UILabel *name;
//员工编号
@property (weak, nonatomic) IBOutlet UILabel *personNum;
//手机号
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
//职位
@property (weak, nonatomic) IBOutlet UILabel *area;
//部门
@property (weak, nonatomic) IBOutlet UILabel *ment;
@property (weak, nonatomic) IBOutlet UIImageView *phone;
@property (weak, nonatomic) IBOutlet UIImageView *nameSex;

@property (nonatomic, strong)UIWebView *phoneCallWebView;
- (void)cellData:(PersonSearchCellModel *)model;
//拨打电话
- (void)dialPhoneNumber:(NSString *)aPhoneNumber;
@end
