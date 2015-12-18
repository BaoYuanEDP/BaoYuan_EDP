//
//  Tool.h
//  适配
//
//  Created by c on 14-7-7.
//  Copyright (c) 2014年 c. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "sys/utsname.h"
@interface Tool : NSObject
/**
 *  根据字的长度计算
 */
+(CGSize)sizeOfStr:(NSString *)str andFont:(UIFont *)font andMaxSize:(CGSize)size andLineBreakMode:(NSLineBreakMode)mode;
/**
 *  颜色显示
 */
#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color;

+(NSString *)stringFromChURL:(NSString *)str;
/**
 *  检查当前设备是什么？
 */
+ (NSString*)getCurrentDeviceModel;
/**
 *  转换成 json 字符串
 */
+ (instancetype )dictionaryWithJsonString:(NSString *)jsonString;
@end











