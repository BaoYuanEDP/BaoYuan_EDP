//
//  CardLookViewCell.h
//  BYFCApp
//
//  Created by PengLee on 15/7/23.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardLookViewCellModel.h"
@interface CardLookViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *place;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *date;
-(void)cellLoadData:(CardLookViewCellModel *)model;
@end
