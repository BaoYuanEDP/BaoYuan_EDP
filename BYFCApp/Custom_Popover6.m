//
//  Custom_Popover6.m
//  BYFCApp
//
//  Created by 王鹏 on 15/12/7.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import "Custom_Popover6.h"

@implementation Custom_Popover6
+(Custom_Popover6 *)initWithCustomView6
{
    Custom_Popover6*custon6=[[UINib nibWithNibName:@"Custom_Popover6" bundle:nil]instantiateWithOwner:self options:nil].lastObject;
    
    return custon6;
    
    
    
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.Sure.layer.masksToBounds=YES;
    self.Sure.layer.cornerRadius=4;
}

@end
