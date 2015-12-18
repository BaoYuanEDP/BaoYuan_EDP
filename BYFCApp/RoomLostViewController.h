//
//  RoomLostViewController.h
//  BYFCApp
//
//  Created by PengLee on 15/8/11.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomLostViewController : UIViewController
//下拉按钮
@property (weak, nonatomic) IBOutlet UIButton *dropBtn;
//下拉按钮方法
- (IBAction)btnAction:(id)sender;
//行政区
@property (weak, nonatomic) IBOutlet UILabel *area;
//小区名
@property (weak, nonatomic) IBOutlet UITextField *districtName;
//楼盘地址
@property (weak, nonatomic) IBOutlet UITextField *louPanAddress;
//确认提交按钮方法
- (IBAction)sureAction:(id)sender;
//行政区边框
@property (weak, nonatomic) IBOutlet UITextField *textField1;
//区域数组
@property(nonatomic,strong)NSArray *arrayData;
@property (weak, nonatomic) IBOutlet UITextField *beiZhuTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *outLayoutHeight;
@property (weak, nonatomic) IBOutlet UIImageView *xialaImage;

@end
