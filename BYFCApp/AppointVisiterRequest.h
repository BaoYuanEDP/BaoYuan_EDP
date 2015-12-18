//
//  AppointVisiterRequest.h
//  BYFCApp
//
//  Created by zzs on 14/12/4.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PL_Header.h"
@protocol PersonDelegate2;

@interface AppointVisiterRequest : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate,NSXMLParserDelegate>
{
    NSMutableData       * _resultData;
    NSXMLParser         * _xmlParser;
    NSMutableString     * _soapResults;
    BOOL                recordResults;
    //
    NSURLConnection      *connection;
    
    //id delegate;
    
}

@property(nonatomic,copy)void (^block)(NSDictionary * dict);
@property(nonatomic,copy)NSMutableString * string;
@property(nonatomic,assign)id<PersonDelegate2>delegate;

+(instancetype)allocWithZone:(struct _NSZone *)zone;
+(instancetype)defaultsRequest;
-(void)getWebServiceData:( void (^)(NSDictionary * dict) )block CustID:(NSString *)CustID userid:(NSString *)userid TOken:(NSString *)TOken;

-(BOOL)isLoginCheckTokenExist;
-(void)disConnect;


@end
@protocol PersonDelegate2 <NSObject>

@optional
-(void)compareResults:(NSMutableString  *)string   dict:(NSDictionary *)dictonry;
@end
