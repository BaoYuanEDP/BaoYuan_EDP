//
//  XJSubViewController.h
//  BYFCApp
//
//  Created by 王鹏 on 15/8/28.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XJSubViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *StarTime;
@property (weak, nonatomic) IBOutlet UITextField *EndTime;
@property (weak, nonatomic) IBOutlet UIButton *TypebtnLabel;
@property (weak, nonatomic) IBOutlet UILabel *TypeNotfationLabel;

@property(nonatomic,copy)NSString*ValueStr;
@property(nonatomic,strong)NSString*TypeStrPush;
@property (weak, nonatomic) IBOutlet UIImageView *advancedimage;
@property (weak, nonatomic) IBOutlet UIImageView *postponeimage;
@property (weak, nonatomic) IBOutlet UIImageView *successorimage;


@property(nonatomic,copy)NSString*ValueStr2;
@property(nonatomic,copy)NSString*Reasonstr;
@property(nonatomic,copy)NSString*statrt;
@property(nonatomic,copy)NSString*name;
@property(nonatomic,copy)NSString *oldSaveNoStr;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell3;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell4;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell7;
@property (weak, nonatomic) IBOutlet UITableView *MainTableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell8;
@property (strong, nonatomic) IBOutlet UIView *HeaderView;
@property(nonatomic,strong)NSString*SummarStr;
@property(nonatomic,strong)NSString*ReasonLabelStr;
@property(nonatomic,strong)NSString*presosIdStr;
@property (weak, nonatomic) IBOutlet UITableView *tableViewList;

@property (weak, nonatomic) IBOutlet UITableView *tabelview;
@property (weak, nonatomic) IBOutlet UILabel *StarTimerLabel;
@property (weak, nonatomic) IBOutlet UILabel *EndTimerLabel;
@property (weak, nonatomic) IBOutlet UILabel *starTimerNotfaction;
@property (weak, nonatomic) IBOutlet UILabel *endTimerNotifaction;
@property (weak, nonatomic) IBOutlet UIView *StartTimeContentView;
@property (weak, nonatomic) IBOutlet UIView *EndTimeContentView;

@end
