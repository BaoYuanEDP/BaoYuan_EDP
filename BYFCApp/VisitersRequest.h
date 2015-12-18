//
//  VisitersRequest.h
//  BYFCApp
//
//  Created by zzs on 14/12/3.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PL_Header.h"
#import "RoomData.h"
#import "CustFollowListData.h"
#import "CustomersFollowData.h"
#import "VisiterData.h"
@protocol RoomPersonDelegate;

@interface VisitersRequest : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate,NSXMLParserDelegate>
{
    NSMutableData       * _resultData;
    NSXMLParser         * _xmlParser;
    NSMutableString     * _soapResults;
    BOOL                recordResults;
    //
    NSURLConnection      *connection;
    
    //id delegate;
    
}
@property(nonatomic,copy)void (^block)(id  dict);
@property(nonatomic,copy) void (^allTypeBlock)(id obj);
//

@property(nonatomic,copy)NSMutableString * string;
@property(nonatomic,assign)id<RoomPersonDelegate>delegate;
//片区数组
@property(nonatomic,strong)void(^blockPianquArray)(NSMutableArray * pianquArray);


+(instancetype)allocWithZone:(struct _NSZone *)zone;
+(instancetype)defaultsRequest;


-(void)postuserID:(NSString *)userID XZText:(NSString *)XZText PText:(NSString *)PText  TradeTF:(NSString *)TradeTF PriceLow:(NSString *)PriceLow PriceHigh:(NSString *)PriceHigh PepleTF:(NSString *)PepleTF TOken:(NSString *)TOken;
//请求区域行政区列表，以及片区列表
-(void)requestAreaInfoMessage:(NSString *)areaKind  roomDistrictId:(NSString *)districtId roomDisName:(NSString *)districetName  userName:(NSString *)userid userTokne:(NSString * )token  backInfoMessage:(void (^)(NSMutableArray * array))block  string:(void (^)(NSString * string))block1;
-(BOOL)isLoginCheckTokenExist;
-(void)disConnect;
-(void)getRoomInfoEasterList:(RoomData *)roomInfo   backInfoMessage:(void (^)(NSMutableString * string))block;

//客源列表
-(void)getCustomList:(VisiterData *)customInfo   backInfoMessage:(void (^)(NSMutableString * string))block;
//客源跟进列表
-(void)GetCustFollow:(CustFollowListData *)followList   backInfoMessage:(void (^)(NSMutableString * string))block;
#pragma mark 房源跟进列表
-(void)GetPropertyContactList:(void (^)(NSMutableString * string))block PropertyId:(NSString *)PropertyId userid:(NSString *)userid token:(NSString *)token;

#pragma mark  楼盘详情
-(void)GetEstateDetail:(void (^)(NSMutableString * string))block EstateID:(NSString *)EstateID userid:(NSString *)userid token:(NSString *)token;

#pragma mark  有效房源数量
-(void)GetLegelProperties:(void (^)(NSMutableString * string))block EstateID:(NSString *)EstateID userid:(NSString *)userid token:(NSString *)token;

-(void)getAddCustomersFollow:(CustomersFollowData *)follow   backInfoMessage:(void (^)(NSMutableString * string))block;
@end
@protocol RoomPersonDelegate <NSObject>

@optional
-(void)compareResults:(NSMutableString  *)string   dict:(NSDictionary *)dictonry;
-(void)retuPianquarray:(NSMutableArray * )array;


@end
