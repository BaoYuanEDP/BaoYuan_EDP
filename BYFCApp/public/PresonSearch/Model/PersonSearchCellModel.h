//
//  PersonSearchCellModel.h
//  BYFCApp
//
//  Created by heaven on 15-7-9.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonSearchCellModel : NSObject
//请求数量
@property (strong, nonatomic) NSString *rowNum;
//姓名
@property (strong, nonatomic) NSString *name;
//性别
@property (strong, nonatomic) NSString *six;
//员工编号
@property (strong, nonatomic) NSString *personNum;
//手机号
@property (strong, nonatomic) NSString *phoneNum;
//区域
@property (strong, nonatomic) NSString *area;
//部门
@property (strong, nonatomic) NSString *ment;
//分行
@property (strong, nonatomic) NSString *Branch;
//职位
@property (strong, nonatomic) NSString *Position;
//电话
@property (strong, nonatomic) NSString *DeptTel;
//传真
@property (strong, nonatomic) NSString *Fax;
//邮编
@property (strong, nonatomic) NSString *DeptZip;
//电子邮箱
@property (strong, nonatomic) NSString *FulEmail;
//地址
@property (strong, nonatomic) NSString *Dizhi;
@end
@interface UpgradeldeModel : NSObject
//版本
@property (nonatomic, strong) NSString *Version;
//时间
@property (nonatomic, strong) NSString *time;
//更新提示
@property (nonatomic, strong) NSString *UpgradeLog;
//更新类型的flig
@property(nonatomic,strong)NSString*UpgradeType;
//详情
@property(nonatomic,strong)NSString*UpgradeModule;


@end