//
//  RoomData.h
//  BYFCApp
//
//  Created by PengLee on 14/12/4.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface RoomData : NSObject
@property(strong,nonatomic)NSString * roomSource;
@property(strong,nonatomic)NSString * roomCode;
@property(strong,nonatomic)NSString * roomDistrictName; //区域
@property(strong,nonatomic)NSString * roomAreaName; //片区
@property(strong,nonatomic)NSString * roomEasterName; //小区名
@property(strong,nonatomic)NSString * roomTrade; //出租出售
@property(strong,nonatomic)NSString * roomPriceFrom;
@property(strong,nonatomic)NSString * roomPriceTo;
@property(strong,nonatomic)NSString * roomRentPriceFrom;
@property(strong,nonatomic)NSString * roomRentPriceTo;

@property(strong,nonatomic)NSString *roomStartIndex;
@property(strong,nonatomic)NSString *roomPageSize;
@property(strong,nonatomic)NSString *roomMode;
@property(strong,nonatomic)NSString *roomPropertyId;
@property(strong,nonatomic)NSString * roomUserID;
@property(strong,nonatomic)NSString * roomToken;
@property(strong,nonatomic)NSString * roomAddress;

@property(strong,nonatomic)NSString * roomBuildingName; //楼栋号
@property(strong,nonatomic)NSString * roomFLOOR;
@property(strong,nonatomic)NSString * roomROOMNO; //房屋号
@property(strong,nonatomic)NSString * roomStatus;

@property(strong,nonatomic)NSString * roomCountW;
@property(strong,nonatomic)NSString * roomCountY;
@property(strong,nonatomic)NSString * roomROOMSTYLE; //室/房 -厅-卫-阳
@property(strong,nonatomic)NSString * roomSquare; //房屋面积
@property(strong,nonatomic)NSString * roomPriceUnit;
@property(strong,nonatomic)NSNumber * roomPRICE; //价格
@property(strong,nonatomic)NSString * roomUnitName;
@property(strong,nonatomic)NSString * roomRentPriceUnit;
@property(strong,nonatomic)NSString * roomRentPrice;
@property(strong,nonatomic)NSString * roomRentUnitName;
@property(strong,nonatomic)NSString * roomROWNUM;
//地图经纬度
@property(strong,nonatomic)NSString * roomXBaidu;
@property(strong,nonatomic)NSString * roomYBaidu;
//主人电话
@property(strong,nonatomic)NSString * roomOwnerTel;
@property (strong,nonatomic)NSString * roomonerName;

@property(strong,nonatomic)NSString * roomFiveYearsOnlyOne;
@property(strong,nonatomic)NSString * roomHouseKey;
//记录
@property(strong,nonatomic)NSString * roomHouseMarks;  //是否为经理推荐等
//朝向
@property(strong,nonatomic)NSString * roomPropertyType;
//有图无图
@property(strong,nonatomic)NSString * roomImageType;
//交易状态
@property(strong,nonatomic)NSString * roomJiaoYiType;

//图片
@property(strong,nonatomic)UIImage  * roomImageContent;
//
@property(strong,nonatomic)NSString * roomIpMode;

@property(strong,nonatomic)NSString * address;

@property(strong,nonatomic)NSString * recommend;

@property(strong,nonatomic)NSString * fastsell;

@property(strong,nonatomic)NSString * school;
//满两年
@property(nonatomic,strong)NSString*TwoYears;
//独家
@property(nonatomic,strong)NSString*Exclusive;
//钥匙
@property(nonatomic,strong)NSString*KeyHome;
//签赔
@property(nonatomic,strong)NSString *propertyTrust;
//房屋状况
@property(nonatomic,strong)NSString *propertyOccupy;
//物业归属
@property(nonatomic,strong)NSString *propertyOwn1;
//业主联系方式
@property(nonatomic,strong)NSString *custTel;
//员工编号
@property(nonatomic,strong)NSString *userCode;
//有效
@property(nonatomic,strong)NSString *status1;
//有效筛选条件
@property(nonatomic,strong)NSString *statusLimit;
//自定义有效时间的开始时间
@property(nonatomic,strong)NSString *effectiveDateFrom;
//自定义有效时间的结束时间
@property(nonatomic,strong)NSString *effectiveDateTo;
//室
@property(strong,nonatomic)NSString * roomCountF;
//厅
@property(strong,nonatomic)NSString * roomCountT;
//
@property(strong,nonatomic)NSString * propertyDirection;
//房屋面积
@property(strong,nonatomic)NSString * roomSquareFrom;
@property(strong,nonatomic)NSString * roomSquareTo;
//房源类型出租出售租售
@property(strong,nonatomic)NSString * trade;



+ (RoomData *)loadRoomDataFromDictionary:(NSDictionary *)dictionary;

@end
@interface roomAreaPlace : NSObject
@property(nonatomic,strong)NSString * areaDistrictId;
@property(nonatomic,strong)NSString * areaDistrictName;

+ (roomAreaPlace *)loadRoomResourceDict:(NSDictionary *)dictionary;


@end
@interface roomPianQuPlace : NSObject
@property(nonatomic,strong)NSString * areaAreaID;
@property(nonatomic,strong)NSString * areaAreaName;


@end
#pragma mark --添加房源对象
@interface RoomHouseSouseData : NSObject
//经纪人ID
@property(nonatomic,assign)NSInteger        house_Broker_id;
//小区ID
@property(nonatomic,assign)NSInteger        house_Comm_id;
@property(nonatomic,strong)NSString     *   house_userDefined;
@property(nonatomic,assign)NSInteger        house_trade_type;
@property(nonatomic,assign)float            house_area;
@property(nonatomic,strong)NSString     *   house_Rooms;
@property(nonatomic,assign)float            house_price;
@property(nonatomic,strong)NSString     *   house_floor;
@property(nonatomic,assign)NSInteger        house_year;
@property(nonatomic,assign)NSInteger        house_fitment;
@property(nonatomic,assign)NSInteger        house_style;
@property(nonatomic,strong)NSString     *   house_exposure;
@property(nonatomic,strong)NSString     *   house_title;
@property(nonatomic,strong)NSString     *   house_description;
@property(nonatomic,assign)NSInteger        house_for_lease;
@property(nonatomic,assign)NSInteger        house_equipment;
@property(nonatomic,strong)NSString     *   house_houseCard;
@property(nonatomic,strong)NSString     *   house_rent_deposit_and_cycle;
@property(nonatomic,assign)NSInteger        house_share_rent;
@property(nonatomic,assign)NSInteger        house_stype;
@property(nonatomic,assign)NSInteger        house_shareType;
@property(nonatomic,assign)NSInteger        house_shareSex;
@property(nonatomic,assign)NSInteger        house_rentType;


+ (RoomHouseSouseData *)loadRoomHouseSouseFromDictionary:(NSDictionary *)dict;




@end
@interface RoomRevisInfo : NSObject
@property(nonatomic,strong) NSString *fastSellString;
@property(nonatomic,strong) NSString *recommendString;
@property(nonatomic,strong) NSString *schoolString;
@property(nonatomic,strong) NSString *statusString;
@property(nonatomic,strong) NSString *properIDString;
@property(nonatomic,strong) NSString *houseMarksString;
@property(nonatomic,strong) NSString * priceString;
@property(nonatomic,strong) NSString * rentpriceString;
@property(nonatomic,strong) NSString * daysString;
@property(nonatomic,strong) NSString * decorationString;
@property(nonatomic,strong) NSString *custom;
@end

