//
//  DicArrayUTF8Log.m
//  BYFCApp
//
//  Created by Wangpu_IOS on 15/12/6.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSDictionary (log)

-(NSString*)descriptionWithLocale:(id)locale
{
    NSMutableString*str=[NSMutableString string];
    
    [str appendString:@"\n字典开始{\n"];
   
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id  obj, BOOL *  stop) {
        [str appendFormat:@"\t%@ = %@\n",key,obj];
        
    }];
    
    [str appendString:@"}字典结束"];

    
    return str;
    
}

@end
@implementation NSArray (log)

-(NSString*)descriptionWithLocale:(id)locale

{
    NSMutableString*str=[NSMutableString string];
    
    [str appendString:@"\n数组开始["];
   
    
    [self enumerateObjectsUsingBlock:^(id  obj, NSUInteger idx, BOOL * stop) {
       
        [str appendFormat:@"\t%@\n",obj];
        
        
           }];
     [str appendString:@"]数组结束"];
  
    return str;
    
}

@end