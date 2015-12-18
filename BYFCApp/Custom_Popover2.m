//
//  Custom_Popover2.m
//  BYFCApp
//
//  Created by 王鹏 on 15/12/4.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import "Custom_Popover2.h"

@implementation Custom_Popover2

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(Custom_Popover2 *)initiCustom_Popover2
{
    Custom_Popover2*Custom2=[[NSBundle mainBundle]loadNibNamed:@"Custom_Popover2" owner:self options:nil].lastObject;
    return Custom2;
}
@end
