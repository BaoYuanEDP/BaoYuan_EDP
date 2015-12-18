//
//  UIView+TextEX.m
//  BYFCApp
//
//  Created by PengLee on 15/2/11.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "UIView+TextEX.h"

@implementation UIView (TextEX)
- (UIView *)firstResponder
{
    for (UIView * v  in self.subviews)
    {
        if ([v isFirstResponder])
        {
            return v;
        }
        else{
            UIView * sv = [v firstResponder];
            
            if (sv )
            {
                return sv;
                
            }
        }
    }
    return nil;
}

@end
