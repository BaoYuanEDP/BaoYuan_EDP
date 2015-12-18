//
//  NoticeCell.m
//  BYFCApp
//
//  Created by PengLee on 15/1/22.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "NoticeCell.h"
#import "PL_Header.h"
@implementation NoticeCell
@synthesize activityLable,timerLable,jishuLable;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        activityLable = [[UILabel alloc]init];
        //activityLable.text = @"活动1";
        activityLable.textColor = [UIColor whiteColor];
        activityLable.numberOfLines = 0;
        activityLable.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
        [self addSubview:activityLable];
        [activityLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.centerY.equalTo(self.mas_centerY);
            make.width.equalTo(@(PL_WIDTH/3-10));
            make.height.greaterThanOrEqualTo(@25);
            
        }];
        jishuLable = [[UILabel alloc]init];
        //jishuLable.text = @"技术部SD";
        jishuLable.textColor = [UIColor whiteColor];
        jishuLable.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
        [self addSubview:jishuLable];
        [jishuLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.greaterThanOrEqualTo(self.mas_centerX).with.offset(30);
            make.centerY.equalTo(self.mas_centerY);
            make.width.greaterThanOrEqualTo(activityLable.mas_width);
            make.height.equalTo(activityLable.mas_height);
            
        }];
        timerLable = [[UILabel alloc]init];
       // timerLable.text = @"2015-03-03";
        timerLable.textColor = [UIColor whiteColor];
        timerLable.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
        [self addSubview:timerLable];
        [timerLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.greaterThanOrEqualTo(self.mas_right).with.offset(-100);
            make.centerY.equalTo(self.mas_centerY);
            make.width.greaterThanOrEqualTo(@80);
            make.height.equalTo(activityLable.mas_height);
            
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
