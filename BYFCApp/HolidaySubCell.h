//
//  HolidayCell.h
//  BYFCApp
//
//  Created by 王鹏 on 15/8/28.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HolidaySubCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *TimerLabel;
@property (weak, nonatomic) IBOutlet UILabel *ATypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *MTypeLabel;
@property (weak, nonatomic) IBOutlet UIButton *ATpyeBut;
@property (weak, nonatomic) IBOutlet UIButton *MTypeBut;
@property (weak, nonatomic) IBOutlet UILabel *MTypeName;
@property (weak, nonatomic) IBOutlet UILabel *ATypeName;
@end
