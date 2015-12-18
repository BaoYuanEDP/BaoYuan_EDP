//
//  GoOutApplyViewController2.h
//  BYFCApp
//
//  Created by 王鹏 on 15/7/24.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoOutApplyViewController2 : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,UITextViewDelegate>
//申请人
@property (weak, nonatomic) IBOutlet UILabel *staName;
//员工编号
@property (weak, nonatomic) IBOutlet UILabel *staNum;
//确认提交
@property (weak, nonatomic) IBOutlet UIButton *SureBut;
//取消申请
@property (weak, nonatomic) IBOutlet UIButton *CanlceBut;
//外出日期
@property (strong, nonatomic) IBOutlet UILabel *DateLabel;

//背景视图1
@property (weak, nonatomic) IBOutlet UIView *backgoundView;
//背景视图2
@property (weak, nonatomic) IBOutlet UIView *backgoundView2;
//外出地点输入框
@property (weak, nonatomic) IBOutlet UITextField *textfile1;
//外出事由输入框
@property (weak, nonatomic) IBOutlet UITextView *textView2;
//请选择1
@property (weak, nonatomic) IBOutlet UILabel *ButLabel;
@property (weak, nonatomic) IBOutlet UILabel *EngTimerLabel;

@property (weak, nonatomic) IBOutlet UILabel *StarLabel;
//文本视图标签
@property (weak, nonatomic) IBOutlet UILabel *EndLabel;
//外出申请按钮选中状态图片
@property (weak, nonatomic) IBOutlet UIImageView *image1;
//特殊豁免申请按钮选中状态图片
@property (weak, nonatomic) IBOutlet UIImageView *image2;
//外出申请按钮
@property (weak, nonatomic) IBOutlet UIButton *goOutBtn;
//特殊豁免申请按钮
@property (weak, nonatomic) IBOutlet UIButton *specialBtn;
- (IBAction)goOutAction:(id)sender;
- (IBAction)specialAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *StarTextFile;
@property (weak, nonatomic) IBOutlet UITextField *EndTextFile;
@property (weak, nonatomic) IBOutlet UILabel *textfileLabel;
@property (weak, nonatomic) IBOutlet UIButton *GoOutBut;
@property(nonatomic,strong)UIDatePicker* datePicker2;
@property(nonatomic)BOOL isFlag;
@property (weak, nonatomic) IBOutlet UILabel *textViewLabel;
@property (weak, nonatomic) IBOutlet UILabel *StarTimerLabel;
@property (strong, nonatomic) IBOutlet UIButton *imageAM;
@property (strong, nonatomic) IBOutlet UIButton *imagePM;
@property (weak, nonatomic) IBOutlet UIView *BigBackgoundView;
@property (weak, nonatomic) IBOutlet UIImageView *AmImage;
@property (weak, nonatomic) IBOutlet UIImageView *Pmimage;

//时间选择器
@property (weak, nonatomic) IBOutlet UILabel *starlabelshow;
@property (weak, nonatomic) IBOutlet UILabel *endLabelShow;

@property(nonatomic,strong)UIDatePicker*datePicker;
@end
