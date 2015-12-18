//
//  HolidayListViewCell.m
//  BYFCApp
//
//  Created by PengLee on 15/11/17.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import "HolidayListViewCell.h"

@implementation HolidayListViewCell
-(void)cellLoadData:(HolidayListMode *)model
{
    _processIDStr.text = [NSString stringWithFormat:@"流程编号:%@",model.processId];
    _processIDStr.font = [UIFont systemFontOfSize:11.0f];
    _reasonStr.text = [NSString stringWithFormat:@"原因:%@",model.reason];
    _reasonStr.font = [UIFont systemFontOfSize:11.0f];
    
    NSString *str = [model.summary stringByReplacingOccurrencesOfString:@":00:00" withString:@"时"];
    _summaryStr.text = [NSString stringWithFormat:@"摘要:%@",str];
    _summaryStr.font = [UIFont systemFontOfSize:11.0f];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
