//
//  VisterInfo.m
//  BYFCApp
//
//  Created by PengLee on 15/5/20.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "VisterInfo.h"

@implementation VisterInfo
@synthesize ageString;



+(VisterInfo *)loadVisterInfoFromDictionary:(NSDictionary *)dic
{
    VisterInfo *roominfo = [VisterInfo new];
    roominfo.areaNameString = dic[@"AreaName"];
    roominfo.ageString = [dic objectForKey:@"Age"];
    roominfo.areaIDString = dic[@"AreaID"];
    roominfo.areaNameString = dic[@"AreaName"];
    roominfo.countFString = dic[@"CountF"];
    roominfo.countNumString = dic[@"CountNum"];
    roominfo.countTString = dic[@"CountT"];
    roominfo.custIDString = dic[@"CustID"];
    roominfo.custLevelString = dic[@"CustLevel"];
    roominfo.custNameString = dic[@"CustName"];
    roominfo.custTelString = dic[@"CustTel"];
    roominfo.districtNameString = dic[@"DistrictName"];
    roominfo.empCodeString = dic[@"EmpCode"];
    roominfo.empNameString = dic[@"EmpName"];
    roominfo.flagNeedString = dic[@"FlagNeed"];
    roominfo.flagprivateString = dic[@"FlagPrivate"];
    roominfo.flagRecommandString = dic[@"FlagRecommand"];
    roominfo.flagSchoolString = dic[@"FlagSchool"];
    roominfo.lastDateDisPlayString = dic[@"LastDateDisplay"];
    roominfo.priceString = dic[@"Price"];
    roominfo.propertyTypeString = dic[@"PropertyType"];
    roominfo.rowNumString = dic[@"ROWNUM"];
    roominfo.regDateString = dic[@"RegDate"];
    roominfo.sexString = dic[@"Sex"];
    roominfo.squareString = dic[@"Square"];
    roominfo.statusString = dic[@"Status"];
    roominfo.tradeString = dic[@"Trade"];
    roominfo.unitNameString = dic[@"UnitName"];
    roominfo.isClick        = @"NO";
      return roominfo;
}
-(NSDictionary *)transSelfToAdictionary:(VisterInfo *)vister
{
    NSDictionary *dic = @{@"Age":vister.ageString,@"AreaID":vister.areaIDString,@"AreaName":vister.areaNameString,@"CountF":vister.countFString,@"CountNum":vister.countFString,@"CountT":vister.countTString,@"CustID":vister.custIDString,@"CustLevel":vister.custLevelString,@"CustName":vister.custNameString,@"CustTel":vister.custTelString,@"DistrictName":vister.districtNameString,@"EmpCode":vister.empCodeString,@"EmpName":vister.empNameString,@"FlagNeed":vister.flagNeedString,@"FlagPrivate":vister.flagprivateString,@"FlagRecommand":vister.flagRecommandString,@"FlagSchool":vister.flagSchoolString,@"LastDateDisplay":vister.lastDateDisPlayString,@"Price":vister.priceString,@"PropertyType":vister.propertyTypeString,@"ROWNUM":vister.rowNumString,@"RegDate":vister.regDateString,@"Sex":vister.sexString,@"Square":vister.squareString,@"Status":vister.statusString,@"Trade":vister.tradeString,@"UnitName":vister.unitNameString,@"isClick":vister.isClick};
    return dic;
}
@end
