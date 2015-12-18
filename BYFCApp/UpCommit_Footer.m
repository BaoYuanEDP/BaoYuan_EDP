//
//  UpCommit_Footer.m
//  BYFCApp
//
//  Created by Wangpu_IOS on 15/12/17.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import "UpCommit_Footer.h"

@implementation UpCommit_Footer

+(UpCommit_Footer *)AddSubHeaderView_UpCommit
{
    UpCommit_Footer*Footer=[[UINib nibWithNibName:@"UpCommit_Footer" bundle:nil]instantiateWithOwner:self options:nil].lastObject;
    return Footer;
    
}
- (void)drawRect:(CGRect)rect {
    
}


@end
