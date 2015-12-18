//
//  KeyBook_Header.m
//  BYFCApp
//
//  Created by Wangpu_IOS on 15/12/17.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import "KeyBook_Header.h"

@implementation KeyBook_Header
+(KeyBook_Header *)AddSubHeaderView_KeyBook

{
    KeyBook_Header*Header=[[UINib nibWithNibName:@"KeyBook_Header" bundle:nil]instantiateWithOwner:self options:nil].lastObject;
    
    return Header;
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
