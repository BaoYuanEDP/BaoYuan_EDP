//
//  HIstoryCell.h
//  BYFCApp
//
//  Created by PengLee on 15/1/20.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HIstoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (weak, nonatomic) IBOutlet UILabel *xingqi;
@property (weak, nonatomic) IBOutlet UILabel *shangbanL;
@property (weak, nonatomic) IBOutlet UILabel *timerOn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xiabanlABLE;
@property (weak, nonatomic) IBOutlet UILabel *XiabanTimerLable;
@property (weak, nonatomic) IBOutlet UILabel *stratCheck;
@property (weak, nonatomic) IBOutlet UILabel *endCheck;

@end
