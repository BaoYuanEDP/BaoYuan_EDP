//
//  MyphoneTableViewCell.h
//  BYFCApp
//
//  Created by PengLee on 15/5/7.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyphoneTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *typeImagview;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *dailPersonLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@property (weak, nonatomic) IBOutlet UILabel *customLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *yewuTypeLabel;
@end
