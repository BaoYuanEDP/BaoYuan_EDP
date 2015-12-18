//
//  PortListTableViewCell.m
//  BYFCApp
//
//  Created by zzs on 15/7/20.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "PortListTableViewCell.h"

@implementation PortListTableViewCell
-(void)loadData:(PortListViewCellModel *)model
{
    [self cellInit];
    
    _applyDate.text = [model.aDate substringToIndex:10];
    if ([model.cStatus isEqualToString:@"0"]) {
        _checkStatus.text = @"审核中";
        _checkStatus.textColor = [UIColor orangeColor];
        if([model.activeName isKindOfClass:[NSNull class]])
        {
            _activityName.text = @"";
        }
        else
        {
            _activityName.text = [NSString stringWithFormat:@"(%@)",model.activeName];

        }
    }
    else if([model.cStatus isEqualToString:@"1"])
    {
        _checkStatus.text = @"通过";
        _checkStatus.textColor = [UIColor greenColor];
        _activityName.text = @"";
    }
    else
    {
        _checkStatus.text = @"驳回";
        _checkStatus.textColor = [UIColor redColor];
        _activityName.text = @"";
    }
    _price.text = [NSString stringWithFormat:@"%@元",model.pPrice];
    _webName.text = [NSString stringWithFormat:@"[%@]",model.wName];
    _registerType.text = model.rType;
}
-(void)cellInit
{
    _activityName.text = @"";
    _applyDate.text = @"";
    _checkStatus.text = @"";
    _price.text = @"";
    _webName.text = @"";
    _registerType.text = @"";
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
