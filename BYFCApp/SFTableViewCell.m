//
//  SFTableViewCell.m
//  BYFCApp
//
//  Created by PengLee on 15/4/2.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "SFTableViewCell.h"
#import "PL_Header.h"
#define cell_top_inset 10
#define cell_bottom_inset 10
#define gray_color [[UIColor blackColor]colorWithAlphaComponent:1]
@implementation SFTableViewCell
@synthesize temp1,temp2,temp3;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UILabel * toplineLable = [[UILabel alloc]init];
        toplineLable.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:pl_alpha];
        [self addSubview:toplineLable];
        [toplineLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(@1);
            make.top.equalTo(@(cell_top_inset));
            
            
        }];
        UILabel * lable1 = [[UILabel alloc]init];
        lable1.text = @"店铺房源";
        lable1.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
        lable1.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lable1];
        UILabel * lable2 = [[UILabel alloc]init];
        lable2.text = @"急售房";
        lable2.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
        lable2.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lable2];
        UILabel * lable3 = [[UILabel alloc]init];
        lable3.text = @"新推房";
        lable3.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
        lable3.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lable3];
        UILabel * lable4 = [[UILabel alloc]init];
        lable4.text = @"放心房";
        lable4.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
        lable4.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lable4];
       [lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.mas_left);
           make.height.equalTo(@30);
           make.right.equalTo(lable2.mas_left);
           make.top.equalTo(toplineLable.mas_bottom).with.offset(0);
           make.width.equalTo(@[lable2.mas_width,lable3.mas_width,lable4.mas_width]);
           make.height.equalTo(@[lable2.mas_height,lable3.mas_height,lable4.mas_height]);
           make.centerY.equalTo(@[lable2.mas_centerY,lable3.mas_centerY,lable4.mas_centerY]);
       }];
        [lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(lable1.mas_right);
            make.right.equalTo(lable3.mas_left);
            make.width.equalTo(@[lable1.mas_width,lable3.mas_width,lable4.mas_width]);
            make.height.equalTo(@[lable1.mas_height,lable3.mas_height,lable4.mas_height]);
            make.centerY.equalTo(@[lable1.mas_centerY,lable3.mas_centerY,lable4.mas_centerY]);
        }];
        [lable3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(lable2.mas_right);
            make.right.equalTo(lable4.mas_left);
            make.width.equalTo(@[lable1.mas_width,lable2.mas_width,lable4.mas_width]);
            make.height.equalTo(@[lable1.mas_height,lable2.mas_height,lable4.mas_height]);
            make.centerY.equalTo(@[lable1.mas_centerY,lable2.mas_centerY,lable4.mas_centerY]);
        }];
        [lable4 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(lable3.mas_right);
            make.right.equalTo(self.mas_right);
            make.width.equalTo(@[lable1.mas_width,lable2.mas_width,lable3.mas_width]);
            make.height.equalTo(@[lable1.mas_height,lable2.mas_height,lable3.mas_height]);
            make.centerY.equalTo(@[lable1.mas_centerY,lable2.mas_centerY,lable3.mas_centerY]);
        }];
        UILabel * middleLable =[[UILabel alloc]init];
        middleLable.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:pl_alpha];
        [self addSubview:middleLable];
        [middleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(@1);
            make.top.equalTo(lable1.mas_bottom);
            
        }];
       _dianpuLable = [[UILabel alloc]init];
       
        _dianpuLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
        _dianpuLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_dianpuLable];
        _jishoufangLable = [[UILabel alloc]init];
       
        _jishoufangLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
        _jishoufangLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_jishoufangLable];
        _xintuiFLable = [[UILabel alloc]init];
       
        _xintuiFLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
        _xintuiFLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_xintuiFLable];
        _fangxinfangLable = [[UILabel alloc]init];
       
        _fangxinfangLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
        _fangxinfangLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_fangxinfangLable];
        [_dianpuLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.height.equalTo(@35);
            make.right.equalTo(_jishoufangLable.mas_left);
            make.top.equalTo(middleLable.mas_bottom).with.offset(0);
            make.width.equalTo(@[_jishoufangLable.mas_width,_xintuiFLable.mas_width,_fangxinfangLable.mas_width]);
            make.height.equalTo(@[_jishoufangLable.mas_height,_xintuiFLable.mas_height,_fangxinfangLable.mas_height]);
            make.centerY.equalTo(@[_jishoufangLable.mas_centerY,_xintuiFLable.mas_centerY,_fangxinfangLable.mas_centerY]);
        }];
        [_jishoufangLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_dianpuLable.mas_right);
            make.right.equalTo(_xintuiFLable.mas_left);
            make.width.equalTo(@[_dianpuLable.mas_width,_xintuiFLable.mas_width,_fangxinfangLable.mas_width]);
            make.height.equalTo(@[_dianpuLable.mas_height,_xintuiFLable.mas_height,_fangxinfangLable.mas_height]);
            make.centerY.equalTo(@[_dianpuLable.mas_centerY,_xintuiFLable.mas_centerY,_fangxinfangLable.mas_centerY]);
        }];
        [_xintuiFLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_jishoufangLable.mas_right);
            make.right.equalTo(_fangxinfangLable.mas_left);
            make.width.equalTo(@[_jishoufangLable.mas_width,_jishoufangLable.mas_width,_fangxinfangLable.mas_width]);
            make.height.equalTo(@[_jishoufangLable.mas_height,_jishoufangLable.mas_height,_fangxinfangLable.mas_height]);
            make.centerY.equalTo(@[_jishoufangLable.mas_centerY,_jishoufangLable.mas_centerY,_fangxinfangLable.mas_centerY]);
        }];
        [_fangxinfangLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_xintuiFLable.mas_right);
            make.right.equalTo(self.mas_right);
            make.width.equalTo(@[_jishoufangLable.mas_width,_jishoufangLable.mas_width,_xintuiFLable.mas_width]);
            make.height.equalTo(@[_jishoufangLable.mas_height,_jishoufangLable.mas_height,_xintuiFLable.mas_height]);
            make.centerY.equalTo(@[_jishoufangLable.mas_centerY,_jishoufangLable.mas_centerY,_xintuiFLable.mas_centerY]);
        }];
        UILabel * line3 = [[UILabel alloc]init];
        line3.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:pl_alpha];
        [self addSubview:line3];
        [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(@1);
            make.top.equalTo(_dianpuLable.mas_bottom);
            
        }];
        UILabel * xinfangFreeLable = [[UILabel alloc]init];
        xinfangFreeLable.text = @"新房免佣";
        xinfangFreeLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
        xinfangFreeLable.textAlignment = NSTextAlignmentCenter;
        xinfangFreeLable.textColor = gray_color;
        [self addSubview:xinfangFreeLable];
        [xinfangFreeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line3.mas_bottom);
            make.centerX.equalTo(_dianpuLable.mas_centerX);
            make.width.equalTo(_dianpuLable.mas_width);
            make.height.equalTo(_dianpuLable.mas_height);
        }];
        UILabel * refeshLable = [[UILabel alloc]init];
        refeshLable.text = @"刷新次数(次/天)";
        refeshLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
        refeshLable.textAlignment = NSTextAlignmentCenter;
        refeshLable.textColor = gray_color;
        [self addSubview:refeshLable];
        UILabel * taocanPriceLable = [[UILabel alloc]init];
        taocanPriceLable.text = @"套餐价格(元/月)";
        taocanPriceLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
        taocanPriceLable.textAlignment = NSTextAlignmentCenter;
        taocanPriceLable.textColor = gray_color;
        [self addSubview:taocanPriceLable];
        [refeshLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line3.mas_bottom);
            make.left.equalTo(xinfangFreeLable.mas_right);
            make.right.equalTo(taocanPriceLable.mas_left);
            make.width.equalTo(@[taocanPriceLable.mas_width]);
            make.height.equalTo(xinfangFreeLable.mas_height);
            make.centerY.equalTo(@[xinfangFreeLable.mas_centerY,taocanPriceLable.mas_centerY]);
        }];
        [taocanPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line3.mas_bottom);
            make.left.equalTo(refeshLable.mas_right);
            make.right.equalTo(self.mas_right);
            make.width.equalTo(@[refeshLable.mas_width]);
            make.height.equalTo(refeshLable.mas_height);
            make.centerY.equalTo(@[xinfangFreeLable.mas_centerY,refeshLable.mas_centerY]);
        }];
        UILabel * line4 = [[UILabel alloc]init];
        line4.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:pl_alpha];
        [self addSubview:line4];
        [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(xinfangFreeLable.mas_bottom);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(@1);
        }];
        NSMutableArray * arrayLable = [NSMutableArray array];
       // NSArray * lableContent = [NSArray arrayWithObjects:_tempLable1,_tempLable2,_tempLable3 ,nil];
       
        
        
        
        
        for (int i=0; i<3; i++)
        {
            UILabel * sf_lable1 = [[UILabel alloc]init];
           // sf_lable1.text = _lableArrayTitle[i];
            sf_lable1.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
            sf_lable1.textAlignment = NSTextAlignmentCenter;
           
            [self addSubview:sf_lable1];
            [arrayLable addObject:sf_lable1];
            
        }
        [arrayLable[0] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line4.mas_bottom);
            make.centerX.equalTo(xinfangFreeLable.mas_centerX);
            make.height.equalTo(xinfangFreeLable.mas_height);
            make.width.equalTo(xinfangFreeLable.mas_width);
            
            
        }];
        temp1 = arrayLable[0];
        temp2 = arrayLable[1];
        temp3 = arrayLable[2];
        
        [temp2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line4.mas_bottom);
            make.left.equalTo(temp1.mas_right);
            make.right.equalTo(temp3.mas_left);
            make.height.equalTo(temp1.mas_height);
            make.width.equalTo(@[temp3.mas_width]);
            make.centerY.equalTo(@[temp1.mas_centerY,temp3.mas_centerY]);
            
        }];
        [temp3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(temp2.mas_right);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(temp2.mas_height);
            make.width.equalTo(@[temp2.mas_width]);
            make.centerY.equalTo(@[temp1.mas_centerY,temp2.mas_centerY]);
        }];
        UILabel * line5 = [[UILabel alloc]init];
        line5.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:pl_alpha];
        [self addSubview:line5];
        [line5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(temp1.mas_bottom);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(@1);
            
        }];
        UILabel * sxLable1 = [[UILabel alloc]init];
        sxLable1.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:pl_alpha];
        [self addSubview:sxLable1];
        [sxLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_dianpuLable.mas_right);
            make.width.equalTo(@1);
            make.top.equalTo(toplineLable.mas_bottom);
            make.bottom.equalTo(line5.mas_top);
            
        }];
        UILabel * sxLable2 = [[UILabel alloc]init];
        sxLable2.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:pl_alpha];
        [self addSubview:sxLable2];
        [sxLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_jishoufangLable.mas_right);
            make.width.equalTo(@1);
            make.top.equalTo(toplineLable.mas_bottom);
            make.bottom.equalTo(line3.mas_top);
            
        }];
        UILabel * sxLable3 = [[UILabel alloc]init];
        sxLable3.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:pl_alpha];
        [self addSubview:sxLable3];
        [sxLable3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_xintuiFLable.mas_right);
            make.width.equalTo(@1);
            make.top.equalTo(toplineLable.mas_bottom);
            make.bottom.equalTo(line3.mas_top);
            
        }];
        UILabel * sxLable4 = [[UILabel alloc]init];
        sxLable4.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:pl_alpha];
        [self addSubview:sxLable4];
        [sxLable4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(temp2.mas_right);
            make.width.equalTo(@1);
            make.top.equalTo(line3.mas_bottom);
            make.bottom.equalTo(line5.mas_top);
            
        }];
        UIView * leftView = [[UIView alloc]init];
        leftView.backgroundColor = [UIColor clearColor];
        [self addSubview:leftView];
        _applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //_applyButton.backgroundColor = [UIColor blueColor];
        _applyButton.backgroundColor=[UIColor colorWithRed:12.0/255.0 green:136.0/255.0 blue:255.0/255.0 alpha:1];
        [_applyButton setTitle:@"申请" forState:UIControlStateNormal ];
        
        _applyButton.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        [self addSubview:_applyButton];
        
        
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.top.equalTo(line5.mas_bottom);
            make.right.equalTo(_applyButton.mas_left);
            make.height.equalTo(@80);
            make.width.equalTo(@[_applyButton.mas_width]);
             make.centerY.equalTo(@[_applyButton.mas_centerY]);
        }];
        [_applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftView.mas_right);
            make.top.equalTo(line5.mas_bottom);
            make.right.equalTo(self.mas_right);
            
            make.height.equalTo(leftView.mas_height);
            make.width.equalTo(@[leftView.mas_width]);
            make.centerY.equalTo(@[leftView.mas_centerY]);
            
        }];
        UIView * redioView = [[UIView alloc]init];
        redioView.backgroundColor = [UIColor clearColor];
        [leftView addSubview:redioView];
        [redioView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(leftView).insets(UIEdgeInsetsMake(cell_bottom_inset,2*cell_top_inset, cell_bottom_inset, 2*cell_top_inset));
        }];
        _redioButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _redioButton1.backgroundColor = [UIColor clearColor];
       
        
        [redioView addSubview:_redioButton1];
        _rediaoButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _rediaoButton2.backgroundColor = [UIColor clearColor];
        [redioView addSubview:_rediaoButton2];
        UILabel * buttonTtitle1 = [[UILabel alloc]init];
        buttonTtitle1.text = @"公费申请";
        buttonTtitle1.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
        [redioView addSubview:buttonTtitle1];
        UILabel * buttonTtitle2 = [[UILabel alloc]init];
        buttonTtitle2.text = @"自费申请";
        buttonTtitle2.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
        [redioView addSubview:buttonTtitle2];
       // _rediaoButton2.selected = !_redioButton1.selected;
        
        [_redioButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(redioView.mas_left).with.offset(cell_top_inset);
            make.top.equalTo(redioView.mas_top).with.offset(cell_top_inset/2);
            make.width.equalTo(@25);
            //make.height.equalTo(@25);
            make.height.equalTo(@[_rediaoButton2.mas_height]);
            make.centerX.equalTo(_rediaoButton2.mas_centerX);
            make.bottom.equalTo(_rediaoButton2.mas_top).with.offset(-cell_top_inset/2);
            
                              
        }];
        [_rediaoButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_redioButton1.mas_left);
            make.top.equalTo(_redioButton1.mas_bottom).with.offset(0);
            make.width.equalTo(_redioButton1.mas_width);
            make.height.equalTo(@[_redioButton1.mas_height]);
            
            make.centerX.equalTo(_redioButton1.mas_centerX);
            make.bottom.equalTo(redioView.mas_bottom).offset(-cell_top_inset/2);
            
            
            
        }];
        [buttonTtitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_redioButton1.mas_right);
            make.right.equalTo(redioView.mas_right).offset(-cell_top_inset);
            make.centerY.equalTo(_redioButton1.mas_centerY);
            
        }];
        [buttonTtitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_rediaoButton2.mas_right);
            make.right.equalTo(redioView.mas_right).offset(-cell_top_inset);
            make.centerY.equalTo(_rediaoButton2.mas_centerY);
            
        }];
        UILabel * line6 = [[UILabel alloc]init];
        line6.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:pl_alpha];
        [self addSubview:line6];
        [line6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(leftView.mas_bottom);
            make.height.equalTo(@1);
        }];
       
        
        
        
        
        
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
