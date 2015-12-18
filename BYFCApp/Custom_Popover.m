//
//  Custom_Popover.m
//  BYFCApp
//
//  Created by Wangpu_IOS on 15/12/3.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import "Custom_Popover.h"

@implementation Custom_Popover

+(Custom_Popover*)initCustomView
{
    Custom_Popover*Custom=[[NSBundle mainBundle]loadNibNamed:@"Custom_Popover" owner:self options:nil].lastObject;
    
    return Custom;
    
}
/**
 *  初始化重载其他东西的话
 *
 *  @param rect <#rect description#>
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (!self) {
//        写代码
    }
    return self;
    
}
- (void)drawRect:(CGRect)rect {
    
}


@end
