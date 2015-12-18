//
//  RecordTableViewCell.h
//  BYFCApp
//
//  Created by zzs on 15/4/21.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *recordImage;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowLabel;

@end
