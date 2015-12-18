//
//  HolidayCustomCell.h
//  BYFCApp
//
//  Created by zzs on 15/3/27.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJViewModel.h"
@interface HolidayCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *bianhao;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *reason;
-(void)cellLoadData:(XJViewModel *)model;
@end
