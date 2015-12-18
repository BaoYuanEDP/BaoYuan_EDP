//
//  VisitingCard_Header.m
//  BYFCApp
//
//  Created by Wangpu_IOS on 15/12/17.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import "VisitingCard_Header.h"

@implementation VisitingCard_Header


+(VisitingCard_Header*)AddSubHeaderView_VisitingCard
{
    VisitingCard_Header*Header=[[UINib nibWithNibName:@"VisitingCard_Header" bundle:nil]instantiateWithOwner:self options:nil].lastObject;
    
    return Header;
    
    
    
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
