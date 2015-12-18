//
//  NSString+Extetion.m
//  遍历字符串
//
//  Created by PengLee on 15/1/8.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "NSString+Extetion.h"
#import <CoreText/CoreText.h>
@implementation NSString (Extetion)
- (NSMutableAttributedString *)changeDigitialColor:(NSString *)string
{
    
    
    NSMutableAttributedString * attriString = [[NSMutableAttributedString alloc]init];
    NSString * tempString = nil;
    NSArray * digitail = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    
    
    for (int i=0; i<[string length]; i++)
    {
        //遍历字符串
        tempString = [string substringWithRange:NSMakeRange(i, 1)];

    if ([tempString isEqualToString:@"0"]||[tempString isEqualToString:@"1"]||[tempString isEqualToString:digitail[2]]||[tempString isEqualToString:digitail[3]]||[tempString isEqualToString:digitail[4]]||[tempString isEqualToString:digitail[5]]||[tempString isEqualToString:digitail[6]]||[tempString isEqualToString:digitail[7]]||[tempString isEqualToString:digitail[8]]||[tempString isEqualToString:digitail[9]]|| [tempString isEqualToString:@"-"]||[tempString isEqualToString:@"/"])
            {
               // NSLog(@"%@---%d",tempString,i);
        NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
                [dict setValue:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName];
                
    NSAttributedString * attribute = [[NSAttributedString alloc]initWithString:tempString attributes:dict];
        [attriString appendAttributedString:attribute];
        continue;
    
        }
        [attriString appendAttributedString:[[NSAttributedString alloc]initWithString:tempString attributes:@{[UIFont systemFontOfSize:12]:NSFontAttributeName,[UIColor blackColor]:NSForegroundColorAttributeName}]];
            
             
        }
    
    
    
   // }
    
    return attriString;
    
}
@end
