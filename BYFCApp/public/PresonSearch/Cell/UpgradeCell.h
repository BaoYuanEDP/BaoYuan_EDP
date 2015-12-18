//
//  UpgradeCell.h
//  BYFCApp
//
//  Created by heaven on 15-7-10.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PL_Header.h"
@interface UpgradeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *banben;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *tishi;
- (void)cellData:(UpgradeldeModel *)model;
@end
