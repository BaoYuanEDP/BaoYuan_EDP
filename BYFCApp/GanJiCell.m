//
//  GanJiCell.m
//  BYFCApp
//
//  Created by zzs on 15/4/2.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "GanJiCell.h"
#import "PL_Header.h"
@implementation GanJiCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initView];
    }
    return self;
}
-(void)initView
{
    
    _lab1=[[UILabel alloc]initWithFrame:CGRectMake(20, 3, PL_WIDTH/3+30, 30)];
    _lab1.font=[UIFont systemFontOfSize:13];
    [self addSubview: _lab1];
    _lab2=[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_lab1.frame)-7,PL_WIDTH/3+30, 30)];
    _lab2.font=[UIFont systemFontOfSize:13];
    [self addSubview: _lab2];
    _lab3=[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_lab2.frame)-7,PL_WIDTH-20, 30)];
    _lab3.font=[UIFont systemFontOfSize:13];
    [self addSubview: _lab3];
    _lab4=[[UILabel alloc]initWithFrame:CGRectMake(_lab1.frame.size.width+20, 3,PL_WIDTH/3, 30)];
    _lab4.font=[UIFont systemFontOfSize:13];
    [self addSubview: _lab4];
    _lab5=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_lab4.frame), CGRectGetMaxY(_lab4.frame)-7,PL_WIDTH/3+50, 30)];
    _lab5.font=[UIFont systemFontOfSize:13];
    [self addSubview: _lab5];
    _lab6=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_lab4.frame), CGRectGetMaxY(_lab5.frame)-7,PL_WIDTH/3+50, 30)];
    _lab6.font=[UIFont systemFontOfSize:13];
    [self addSubview: _lab6];
    _lab33=[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_lab3.frame)-7,PL_WIDTH/3+200, 30)];
    _lab33.font=[UIFont systemFontOfSize:13];
    [self addSubview: _lab33];
    _lab7=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_lab4.frame), CGRectGetMaxY(_lab6.frame)-7,PL_WIDTH/3+50, 30)];
    _lab7.font=[UIFont systemFontOfSize:13];
    [self addSubview: _lab7];
    
    _button=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH-50, 5, 30, 30)];
    //_button.backgroundColor=[UIColor greenColor];
    //    [_button setImage:[UIImage imageNamed:@"no_checked33.png"] forState:UIControlStateNormal];
    //    [_button setImage:[UIImage imageNamed:@"checked33.png"] forState:UIControlStateSelected];
    // [_button addTarget:self action:@selector(SelectClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
