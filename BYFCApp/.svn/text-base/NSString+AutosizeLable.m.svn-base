//
//  NSString+AutosizeLable.m
//  BYFCApp
//
//  Created by PengLee on 15/3/30.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "NSString+AutosizeLable.h"

@implementation NSString (AutosizeLable)
+ (CGSize)getSizeWithWidth:(CGFloat)width content:(NSString *)str font:(NSInteger)font
{
    
    if (str.length == 0 || !str) {
        
        return CGSizeZero;
    }
    
    
    NSDictionary * attDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor blackColor],[UIFont systemFontOfSize:font], nil] forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName,NSFontAttributeName, nil]];
    
    
    NSAttributedString * attStr = [[NSAttributedString alloc]initWithString:str attributes:attDic];
    NSRange range = NSMakeRange(0, attStr.length);
    NSDictionary * dic = [attStr attributesAtIndex:0 effectiveRange:&range];
    
    //
    CGRect  rect = [str boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:Nil];
    return rect.size;
}

@end
