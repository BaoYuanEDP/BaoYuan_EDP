//
//  ID_Card_Header.m
//  BYFCApp
//
//  Created by Wangpu_IOS on 15/12/17.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import "ID_Card_Header.h"

@implementation ID_Card_Header



+(ID_Card_Header *)AddSubHeaderView_ID_Card
{
    ID_Card_Header*Header=[[UINib nibWithNibName:@"ID_Card_Header" bundle:nil]instantiateWithOwner:self options:nil].lastObject;
    
    return Header;
    
    
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
