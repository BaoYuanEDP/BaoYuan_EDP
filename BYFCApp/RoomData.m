//
//  RoomData.m
//  BYFCApp
//
//  Created by PengLee on 14/12/4.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import "RoomData.h"

@implementation RoomData
@synthesize roomCode;
@synthesize roomAreaName;
@synthesize roomCountF;
@synthesize roomDistrictName;
@synthesize roomEasterName;
@synthesize roomPriceFrom;
@synthesize roomPriceTo;
@synthesize roomRentPriceFrom;
@synthesize roomRentPriceTo;
@synthesize roomSquareFrom;
@synthesize roomSquareTo;
@synthesize roomToken;
@synthesize roomTrade;
@synthesize roomUserID;
@synthesize roomBuildingName;
@synthesize roomCountT;
@synthesize roomCountW;
@synthesize roomCountY;
@synthesize roomFLOOR;
@synthesize roomMode;
@synthesize roomPageSize;
@synthesize roomPRICE;
@synthesize roomPriceUnit;
@synthesize roomPropertyId;
@synthesize roomRentPrice;
@synthesize roomRentPriceUnit;
@synthesize roomRentUnitName;
@synthesize roomROOMNO;
@synthesize roomROOMSTYLE;
@synthesize roomROWNUM;
@synthesize roomSquare;
@synthesize roomStartIndex;
@synthesize roomStatus;
@synthesize roomUnitName;
@synthesize roomFiveYearsOnlyOne;
@synthesize roomHouseKey;
@synthesize roomHouseMarks;
@synthesize roomOwnerTel;
@synthesize roomXBaidu;
@synthesize roomYBaidu;
@synthesize roomPropertyType;
@synthesize roomImageContent;
@synthesize roomIpMode;



+ (RoomData *)loadRoomDataFromDictionary:(NSDictionary *)dictionary
{
    RoomData * roomdata = [RoomData new];
    
    return roomdata;
    
}
@end
@implementation roomAreaPlace

@synthesize areaDistrictId;
@synthesize areaDistrictName;
+ (roomAreaPlace *)loadRoomResourceDict:(NSDictionary *)dictionary
{
    roomAreaPlace * room = [[roomAreaPlace alloc]init];
    room.areaDistrictId = dictionary[@""];
    room.areaDistrictName = dictionary[@""];
    return room;
    
    
}

@end
@implementation roomPianQuPlace

@synthesize areaAreaID;
@synthesize areaAreaName;


@end
@implementation RoomHouseSouseData
@synthesize house_area,house_Broker_id,house_Comm_id,house_description,house_equipment,house_exposure,house_fitment,house_floor,house_for_lease,house_houseCard,house_price,house_rent_deposit_and_cycle,house_rentType,house_share_rent,house_shareSex,house_shareType,house_Rooms,house_style,house_stype,house_title,house_trade_type,house_userDefined,house_year;

+ (RoomHouseSouseData *)loadRoomHouseSouseFromDictionary:(NSDictionary *)dict
{
    RoomHouseSouseData * houseData = [RoomHouseSouseData alloc];
    
    return houseData;
    
}

@end
@implementation RoomRevisInfo
@end
