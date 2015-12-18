//
//  HoliDayEdityViewController.h
//  BYFCApp
//
//  Created by 王鹏 on 15/8/28.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HoliDayEdityViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
//存放请求的销假申请数据
@property(nonatomic,strong)NSMutableArray*arrayData;
@property(nonatomic,strong)NSMutableArray *jsonData;
@property(nonatomic,strong)NSString *reason;
//存放提交销假申请的数据
@property (weak, nonatomic) IBOutlet UIButton *sureBut;
@property (weak, nonatomic) IBOutlet UIButton *cancelBut;
@property(nonatomic,strong)NSMutableArray *arrData;
@end
