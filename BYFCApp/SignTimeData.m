//
//  SignTimeData.m
//  BYFCApp
//
//  Created by PengLee on 15/2/2.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "SignTimeData.h"

@implementation SignTimeData
@synthesize signDAY,signDutySignTime,signOffDutySignTime,signSignTime;


+ (SignTimeData *)loadReloadDataFromDict:(NSDictionary *)dict
{
#warning 错误奔溃！！
    SignTimeData * signData = [[SignTimeData alloc]init];
    signData.signDAY = [NSString stringWithFormat:@"%@",dict[@"DAY"]];
    signData.signDutySignTime = dict[@"DutySignTime"];
    signData.signOffDutySignTime = dict[@"OffDutySignTime"];
    signData.signSignTime = dict[@"SignTime"];
    signData.startCheck=dict[@"DutySignTimeCheck"];
    signData.endCheck=dict[@"OffDutySignTimeCheck"];

   // NSLog(@"%@--%@ %@ %@",signDAY,signDutySignTime,signOffDutySignTime,signSignTime);
    
    
    
    return signData;
    
}
- (NSString *)description
{
    NSLog(@"%@",self.signDAY);
    
    return [NSString stringWithFormat:@"%@",self.signDAY];
    
}
@end
