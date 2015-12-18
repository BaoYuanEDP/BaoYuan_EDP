//
//  HolidayCustomCell.m
//  BYFCApp
//
//  Created by zzs on 15/3/27.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "HolidayCustomCell.h"
#import "PL_Header.h"

@implementation HolidayCustomCell

-(void)cellLoadData:(XJViewModel *)model
{
    _name.text = model.name;
//    _bianhao.text=model.bianhao;
    _date.text = [NSString stringWithFormat:@"%@  到  %@",model.startDate,model.endDate];
    NSString*str=[model.startDate stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSString*STR1=[model.endDate stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    _date.text = [NSString stringWithFormat:@"%@  到  %@",str ,STR1];

    
    _reason.text=model.reason;
    if ([model.type isEqualToString:@"事假"])  {
        _image.image=[UIImage imageNamed:@"shijia.png"];
    }
    else if ([model.type isEqualToString:@"婚假"])  {
        _image.image=[UIImage imageNamed:@"hunjia.png"];
    }
    else if ([model.type isEqualToString:@"产假"])  {
        _image.image=[UIImage imageNamed:@"chanjia.png"];
    }
    else if ([model.type isEqualToString:@"丧假"])  {
        _image.image=[UIImage imageNamed:@"sangjia.png"];
    }
    else if ([model.type isEqualToString:@"哺乳假"])  {
        _image.image=[UIImage imageNamed:@"purujia.png"];
    }
    else if ([model.type isEqualToString:@"调休"])  {
        _image.image=[UIImage imageNamed:@"tiaoxiu.png"];
    }
    else if ([model.type isEqualToString:@"无薪病假"])  {
        _image.image=[UIImage imageNamed:@"wuxinbingjia.png"];
    }
    else if ([model.type isEqualToString:@"陪产假"])  {
        _image.image=[UIImage imageNamed:@"peichanjia.png"];
    }
    else if ([model.type isEqualToString:@"其他"])  {
        _image.image=[UIImage imageNamed:@"qita.png"];
    }else if ([model.type isEqualToString:@"有薪病假"])  {
        _image.image=[UIImage imageNamed:@"youxinbingjia.png"];
    }else if ([model.type isEqualToString:@"年假"])  {
        _image.image=[UIImage imageNamed:@"nianjia.png"];
    }
    

    if ([model.flag isEqualToString:@"0"]) {
        _bianhao.text=@"审核中";
        _bianhao.textColor = [UIColor orangeColor];
    }else if ([model.flag isEqualToString:@"1"])
    {
        _bianhao.text=@"通过";
        _bianhao.textColor = [UIColor greenColor];

    }else if ([model.flag isEqualToString:@"2"])
    {
        _bianhao.text=@"驳回";
        _bianhao.textColor = [UIColor redColor];

    }else if ([model.flag isEqualToString:@"3"])
    {
        _bianhao.text=@"未发起流程";
    }
    
}
-(void)initView
{
    _name.text =@"";
    _bianhao.text=@"";
    _date.text =@"";
    _reason.text=@"";
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
