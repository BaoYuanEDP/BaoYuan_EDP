//
//  HolidayCell.h
//  BYFCApp
//
//  Created by PengLee on 15/11/4.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleHoulidayModel.h"
@interface HolidayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *TypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *Satr_label;
@property (weak, nonatomic) IBOutlet UILabel *End_label;
-(void)cellForListModel:(SingleHoulidayModel *)model;
@end
