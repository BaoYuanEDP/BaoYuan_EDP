//
//  HolidayListViewCell.h
//  BYFCApp
//
//  Created by PengLee on 15/11/17.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HolidayListMode.h"
@interface HolidayListViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *processIDStr;
@property (weak, nonatomic) IBOutlet UILabel *summaryStr;
@property (weak, nonatomic) IBOutlet UILabel *reasonStr;
-(void)cellLoadData:(HolidayListMode *)model;

@end
