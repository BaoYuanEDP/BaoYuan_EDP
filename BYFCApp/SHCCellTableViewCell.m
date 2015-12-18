//
//  SHCCellTableViewCell.m
//  BYFCApp
//
//  Created by PengLee on 15/8/21.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "SHCCellTableViewCell.h"

@implementation SHCCellTableViewCell

- (void)awakeFromNib {
    _lab1.hidden = YES;
    _lab2.hidden = YES;
    _label3.hidden = YES;
    _label4.hidden = YES;
    _label5.hidden = YES;
    _label6.hidden = YES;
    _label7.hidden = YES;
    _label8.hidden = YES;
    _shoujia.hidden = YES;
    _saleTextField.hidden = YES;
    _rentTextField.hidden = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
