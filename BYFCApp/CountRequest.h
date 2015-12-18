//
//  CountRequest.h
//  BYFCApp
//
//  Created by zzs on 14/12/24.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountRequest : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate,NSXMLParserDelegate>
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
@property(nonatomic,copy)NSMutableString * string;
//-(id)init;
+(CountRequest *)defaultsRequest;

#pragma mark  有效房源数量
-(void)GetLegelProperties:(void (^)(NSMutableString * string))block EstateID:(NSString *)EstateID userid:(NSString *)userid token:(NSString *)token;
@end
