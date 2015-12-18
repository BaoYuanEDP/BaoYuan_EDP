//
//  WriteMessageCell.m
//  BYFCApp
//
//  Created by PengLee on 15/3/19.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "WriteMessageCell.h"
#import "PL_Header.h"
#define lable_color [UIColor blackColor]
@implementation WriteMessageCell
@synthesize lable1,lable2,lable3,lable4,lable5;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UIView * myView = self;
        int paddint = 0;
        
        lable1 = [[UILabel alloc]init];
        lable1.text = @"  ";
        lable1.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
        lable1.textColor = lable_color;
        lable1.textAlignment = NSTextAlignmentCenter;
        lable1.backgroundColor = [UIColor clearColor];
        [myView addSubview:lable1];
        
        lable2 = [[UILabel alloc]init];
        lable2.text = @"  ";
        lable2.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
        lable2.textColor = lable_color;
        lable2.backgroundColor = [UIColor clearColor];
        lable2.textAlignment = NSTextAlignmentCenter;
        [myView addSubview:lable2];
        lable3 = [[UILabel alloc]init];
        lable3.text = @"  ";
        lable3.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
        lable3.textColor = lable_color;
        lable3.backgroundColor = [UIColor clearColor];
        lable3.textAlignment = NSTextAlignmentCenter;
        [myView addSubview:lable3];
        lable4 = [[UILabel alloc]init];
        lable4.text = @"  ";
        lable4.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
        lable4.textColor = lable_color;
        [myView addSubview:lable4];
        lable4.backgroundColor = [UIColor clearColor];
        lable4.textAlignment = NSTextAlignmentCenter;
        lable5 = [[UILabel alloc]init];
        lable5.text = @"  ";
        lable5.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
        lable5.textColor = lable_color;
        [myView addSubview:lable5];
        lable5.backgroundColor = [UIColor clearColor];
        lable5.textAlignment = NSTextAlignmentCenter;
       
        
        [lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(myView.mas_top).with.offset(paddint);
            make.left.equalTo(myView.mas_left).with.offset(paddint);
            make.bottom.equalTo(myView.mas_bottom).with.offset(0);
            make.right.equalTo(lable2.mas_left);
            make.width.equalTo(@[lable4.mas_width,lable2.mas_width,lable3.mas_width,lable5.mas_width]);
            
            make.height.equalTo(@[lable4.mas_height,lable2.mas_height,lable3.mas_height,lable5.mas_height]);
            // make.height.equalTo(@20);
            
        }];
        [lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(myView.mas_top).offset(paddint);
            make.left.greaterThanOrEqualTo(lable1.mas_right).offset(paddint);
            make.bottom.equalTo(myView.mas_bottom).offset(-paddint);
            make.right.equalTo(lable3.mas_left).offset(0);
            make.width.equalTo(@[lable1.mas_width,lable4.mas_width,lable3.mas_width,lable5.mas_width]);
            make.height.equalTo(@[lable1.mas_height,lable4.mas_height,lable3.mas_height,lable5.mas_height]);
            
        }];
        [lable3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(myView.mas_top).offset(paddint);
            make.left.greaterThanOrEqualTo(lable2.mas_right).offset(0);
            make.bottom.equalTo(myView.mas_bottom).offset(-paddint);
            make.right.equalTo(lable4.mas_left).offset(0);
            make.width.equalTo(@[lable1.mas_width,lable2.mas_width,lable4.mas_width,lable5.mas_width]);
            make.height.equalTo(@[lable1.mas_height,lable2.mas_height,lable4.mas_height,lable5.mas_height]);
            
        }];
        [lable4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(myView.mas_top).offset(paddint);
            make.left.greaterThanOrEqualTo(lable3.mas_right).offset(0);
            make.bottom.equalTo(myView.mas_bottom).offset(-paddint);
            make.right.equalTo(lable5.mas_left).offset(0);
            make.width.equalTo(@[lable1.mas_width,lable2.mas_width,lable3.mas_width,lable5.mas_width]);
            make.height.equalTo(@[lable1.mas_height,lable2.mas_height,lable3.mas_height,lable5.mas_height]);
            
        }];
        [lable5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(myView.mas_top).offset(paddint);
            make.left.greaterThanOrEqualTo(lable4.mas_right).offset(paddint);
            
            make.bottom.equalTo(myView.mas_bottom).offset(-paddint);
            make.right.equalTo(myView.mas_right).offset(-paddint);
            make.width.equalTo(@[lable1.mas_width,lable2.mas_width,lable3.mas_width,lable4.mas_width]);
            make.height.equalTo(@[lable1.mas_height,lable2.mas_height,lable3.mas_height,lable4.mas_height]);
            
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
