//
//  CardLookViewCell.m
//  BYFCApp
//
//  Created by PengLee on 15/7/23.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "CardLookViewCell.h"

@implementation CardLookViewCell
-(void)cellLoadData:(CardLookViewCellModel *)model
{
    [self initData];
    _date.text = [model.addTime substringToIndex:10];
    _number.text = model.printNumber;
    _name.text = model.userName;
    _place.text = model.branch;
}
-(void)initData
{
    _date.text = @"";
    _number.text = @"";
    _name.text = @"";
    _place.text = @"";
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
