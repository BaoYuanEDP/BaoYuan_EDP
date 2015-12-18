//
//  NSString+TestPhoneNum.m
//  BYFCApp
//
//  Created by PengLee on 15/3/18.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "NSString+TestPhoneNum.h"

@implementation NSString (TestPhoneNum)
- (BOOL)checkPhoneNumberInPut
{
    //所有手机号
//    NSString * Moble = @"^1(3[0-9]|5[0-35-9]|8[025-9]|7[7|0])\\d{8}$";
//    //中国移动
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    //中国联通
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    //中国电信
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//    //小灵通或者固话
//     NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    //数字
    NSString *number = @"^\\d+";
    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Moble];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//     NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    NSPredicate *regextestNum = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
//    BOOL res1 = [regextestmobile evaluateWithObject:self];
//    BOOL res2 = [regextestcm evaluateWithObject:self];
//    BOOL res3 = [regextestcu evaluateWithObject:self];
//    BOOL res4 = [regextestct evaluateWithObject:self];
//     BOOL res5 = [regextestphs evaluateWithObject:self];
//    
    BOOL res6 = [regextestNum evaluateWithObject:self];
    if (res6)
    {
        return YES;
        
    }
    else
    {
        return NO;
    }
    
    
    
    
    
    
    return NO;
}
@end
