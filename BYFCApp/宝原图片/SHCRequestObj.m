//
//  SHCRequestObj.m
//  DemorRequest
//
//  Created by heaven on 15/7/22.
//  Copyright (c) 2015年 Sun. All rights reserved.
//

#import "SHCRequestObj.h"
@implementation SHCRequestObj
static  SHCRequestObj * __defaultRequest=nil;
+(instancetype)defaultsRequest
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __defaultRequest = [[[self class]alloc]init];
        
    });
    return __defaultRequest;
}
- (void)UrlRequrst:(NSString *)url urlSender:(NSString *)urlS urlNext:(NSString *)urlN requestDic:(id)dic returnObj:(void (^)(id obj))block returnError:(void (^)(id error))bloclError
{
    NSMutableDictionary *p = [NSMutableDictionary dictionary];
    [p setValue:dic forKey:@"p"];
    NSString *parameters = [self dictionaryToJson:p];
    NSString *strUrl =[NSString stringWithFormat:@"%@/%@/%@",url,urlS,urlN];
    [[SHCRequsetSender defaultsRequest] UrlReqursts:strUrl requestStrs:parameters returnObjs:block returnError:bloclError];
    
}
- (NSString*)dictionaryToJson:(NSMutableDictionary *)dic
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end
