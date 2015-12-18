//
//  GetHouseImage.h
//  BYFCApp
//
//  Created by zzs on 15/1/4.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetHouseImage : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate,NSXMLParserDelegate>
{
    NSMutableData       * _resultData;
    NSXMLParser         * _xmlParser;
    NSMutableString     * _soapResults;
    BOOL                recordResults;
    //
    NSURLConnection      *connection;
    //RoomData            *roomSourceInfo;
    
    //id delegate;
    
}

@property(nonatomic,copy)void (^blockCall)(NSMutableString * string);
//接收任意类型的数据block
@property(nonatomic,copy) void (^allTypeBlock)(id obj);
@property(nonatomic,copy)NSMutableString * string;
+(instancetype)allocWithZone:(struct _NSZone *)zone;
//-(id)init;
+(GetHouseImage *)defaultsRequest;

-(void)GetDetailHouseImage:(void (^)(NSMutableString * string))block PropertyId:(NSString *)PropertyId  mode:(NSString *)MODE userid:(NSString *)userid token:(NSString *)token;
-(void)disConnect;

@end
