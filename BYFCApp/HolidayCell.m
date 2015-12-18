//
//  HolidayCell.m
//  BYFCApp
//
//  Created by PengLee on 15/11/4.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "HolidayCell.h"

@implementation HolidayCell
-(void)cellForListModel:(SingleHoulidayModel *)model
{
    _TypeLabel.text = @"";
    _Satr_label.text = @"";
    _End_label.text =   @"";
    _TypeLabel.text = [NSString stringWithFormat:@"%@",model.Type_Str];
    _Satr_label.text = [NSString stringWithFormat:@"%@",model.Star_Time];
    _End_label.text =[NSString stringWithFormat:@"%@",model.End_Time];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
