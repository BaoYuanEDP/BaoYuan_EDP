//
//  PersonSearchCellTableViewCell.m
//  BYFCApp
//
//  Created by heaven on 15-7-9.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "PersonSearchCellTableViewCell.h"

@implementation PersonSearchCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)cellData:(PersonSearchCellModel *)model
{
    [self cellInit];
    NSLog(@"%@",model.six);
    _name.text = model.name;
    _personNum.text = model.personNum;
    _phoneNum.text = model.phoneNum;
    _area.text = model.Position;
    _ment.text = model.Branch;
    NSString *strPhone = [NSString stringWithFormat:@"%@",_phoneNum];
    NSString *strSex = [NSString stringWithFormat:@"%@",model.six];
    if ([strSex isEqualToString:@"1"]) {
        [_nameSex setImage:[UIImage imageNamed:@"头像男.png"]];
    }else
    {
        [_nameSex setImage:[UIImage imageNamed:@"头像女.png"]];
    }
    if ([strPhone isEqualToString:@""]) {
        [_phone setImage:[UIImage imageNamed:@""]];
    }else
    {
        [_phone setImage:[UIImage imageNamed:@"打电话图标.png"]];
    }
}
- (void)cellInit
{
    _name.text = @"";
    _personNum.text = @"";
    _phoneNum.text = @"";
    _area.text = @"";
    _ment.text = @"";
}
- (IBAction)btnActionPhone:(UIButton *)sender {
    [self dialPhoneNumber:_phoneNum.text];
}
- (void)dialPhoneNumber:(NSString *)aPhoneNumber
{
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",aPhoneNumber]];
    if ( !_phoneCallWebView ) {
        _phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    }
    [_phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
