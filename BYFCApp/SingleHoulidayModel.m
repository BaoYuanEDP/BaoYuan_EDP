//
//  SingleHoulidayModel.m
//  BYFCApp
//
//  Created by 王鹏 on 15/11/6.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "SingleHoulidayModel.h"

@implementation SingleHoulidayModel

+(SingleHoulidayModel*)TransferDictionary:(NSDictionary *)DIC
{
    SingleHoulidayModel*model=[SingleHoulidayModel new];
    
    
    if ([DIC[@"Type"] isEqualToString:@"1"])  {
        model.Type_Str=@"事假";
    }
    else if ([DIC[@"Type"] isEqualToString:@"3"])  {
        
        model.Type_Str = @"婚假";
    }
    else if ([DIC[@"Type"] isEqualToString:@"4"])  {
        model.Type_Str = @"产假";
    }
    else if ([DIC[@"Type"] isEqualToString:@"5"])  {
        model.Type_Str = @"丧假";
    }
    else if ([DIC[@"Type"] isEqualToString:@"18"])  {
        model.Type_Str = @"产检假";
    }
    else if ([DIC[@"Type"] isEqualToString:@"8"])  {
        model.Type_Str = @"哺乳假";
    }
    else if ([DIC[@"Type"] isEqualToString:@"9"])  {
        
        model.Type_Str = @"调休";
    }
    else if ([DIC[@"Type"] isEqualToString:@"10"])  {
        
        model.Type_Str = @"无薪病假";
    }
    else if ([DIC[@"Type"] isEqualToString:@"12"])  {
        
        model.Type_Str = @"陪产假";
    }
    else if ([DIC[@"Type"] isEqualToString:@"14"])  {
        model.Type_Str = @"其他";
    }else if ([DIC[@"Type"] isEqualToString:@"2"])  {
        model.Type_Str = @"有薪病假";
    }
    else if ([DIC[@"Type"] isEqualToString:@"15"])  {
        model.Type_Str = @"年假";
    }
    

    model.Star_Time=DIC[@"StartDate"];
    model.End_Time=DIC[@"EndDate"];
//      [model setValuesForKeysWithDictionary:DIC];
    return model;
       
}
+(SingleHoulidayModel *)RecstTypeString:(NSDictionary *)DIC
{
    SingleHoulidayModel*model=[SingleHoulidayModel new];
   
        if ([DIC[@"Type"] isEqualToString:@"1"])  {
            model.Type_Str=@"事假";
        }
        else if ([DIC[@"Type"] isEqualToString:@"3"])  {
            
            model.Type_Str = @"婚假";
        }
        else if ([DIC[@"Type"] isEqualToString:@"4"])  {
            model.Type_Str = @"产假";
        }
        else if ([DIC[@"Type"] isEqualToString:@"5"])  {
            model.Type_Str = @"丧假";
        }
        else if ([DIC[@"Type"] isEqualToString:@"18"])  {
            model.Type_Str = @"产检假";
        }
        else if ([DIC[@"Type"] isEqualToString:@"8"])  {
            model.Type_Str = @"哺乳假";
        }
        else if ([DIC[@"Type"] isEqualToString:@"9"])  {
            
            model.Type_Str = @"调休";
        }
        else if ([DIC[@"Type"] isEqualToString:@"10"])  {
            
            model.Type_Str = @"无薪病假";
        }
        else if ([DIC[@"Type"] isEqualToString:@"12"])  {
            
            model.Type_Str = @"陪产假";
        }
        else if ([DIC[@"Type"] isEqualToString:@"14"])  {
            model.Type_Str = @"其他";
        }else if ([DIC[@"Type"] isEqualToString:@"2"])  {
            model.Type_Str = @"有薪病假";
        }
        else if ([DIC[@"Type"] isEqualToString:@"15"])  {
            model.Type_Str = @"年假";
        }

    model.Star_Time=DIC[@"StartDate"];
    model.End_Time=DIC[@"EndDate"];
    
       
    
    
    return model;
}
+(SingleHoulidayModel *)holidayList:(NSDictionary *)dic
{
    SingleHoulidayModel*model=[SingleHoulidayModel new];
    model.Type_Str = dic[@"Character01"];
    model.Star_Time = dic[@"StartDate"];
    model.End_Time = dic[@"EndDate"];
    return model;
}
@end
