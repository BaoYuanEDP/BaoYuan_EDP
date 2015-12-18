//
//  SingleHoulidayModel.h
//  BYFCApp
//
//  Created by 王鹏 on 15/11/6.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleHoulidayModel : NSObject
@property(nonatomic,strong)NSString*Type_Str;
@property(nonatomic,strong)NSString*End_Time;
@property(nonatomic,strong)NSString*Star_Time;
+(SingleHoulidayModel*)TransferDictionary:(NSDictionary*)DIC;
+(SingleHoulidayModel*)RecstTypeString:(NSDictionary*)DIC;
+(SingleHoulidayModel*)holidayList:(NSDictionary*)dic;
@end
