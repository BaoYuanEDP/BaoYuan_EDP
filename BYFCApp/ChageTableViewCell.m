//
//  ChageTableViewCell.m
//  BYFCApp
//
//  Created by PengLee on 15/5/19.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "ChageTableViewCell.h"

@implementation ChageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
     self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
