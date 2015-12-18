//
//  GoOutApplyListCell.m
//  BYFCApp
//
//  Created by PengLee on 15/7/17.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "GoOutApplyListCell.h"

@implementation GoOutApplyListCell
- (void)cellData:(GoOutApplyListCellModel *)model
{
    [self cellInit];
    _goOutPeriod.text = model.timeBuck;
    _goOutData.text = [model.data substringToIndex:10];
    _address.text = model.goOutAdress;
    _event.text = model.remark;
    _check.text = model.result;
  
    
    
    
    if ([model.timeBuck isEqualToString:@"4"]) {
        
        _goOutPeriod.text=@"上午外出";
    }else if ([model.timeBuck isEqualToString:@"5"])
    {
        _goOutPeriod.text=@"下午外出";
        
    }else if([model.timeBuck isEqualToString:@"0"])
    {
        _goOutPeriod.text=@"工作外出";
    }else if ([model.timeBuck isEqualToString:@"1"])
    {
        _goOutPeriod.text=@"上午豁免";
    }else if ([model.timeBuck isEqualToString:@"2"])
    {
        _goOutPeriod.text=@"下午豁免";
    }else if ([model.timeBuck isEqualToString:@"6"])
    {
        _goOutPeriod.text=@"全天外出";
     }
    if([model.result isEqualToString:@"0"])
    {
        _check.text = @"审核中";
        _check.textColor = [UIColor orangeColor];
        
    }
    else if([model.result isEqualToString:@"1"])
    {
        
        _check.text = @"通过";
        _check.textColor = [UIColor greenColor];
    }
    else
    {
        _check.text = @"驳回";
        _check.textColor = [UIColor redColor];
    }

}
- (void)cellInit
{
    _goOutData.text = @"";
    _goOutPeriod.text = @"";
    _event.text = @"";
    _check.text = @"";
    _address.text = @"";
    
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
   [super setSelected:selected animated:animated];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
