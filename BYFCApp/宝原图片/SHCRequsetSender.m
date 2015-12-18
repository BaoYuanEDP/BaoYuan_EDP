//
//  SHCRequsetSender.m
//  BYFCSAPP
//
//  Created by heaven on 15/7/23.
//  Copyright (c) 2015年 Sun. All rights reserved.
//

#import "SHCRequsetSender.h"

@implementation SHCRequsetSender
static  SHCRequsetSender * __defaultRequest=nil;
+(instancetype)defaultsRequest
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __defaultRequest = [[[self class]alloc]init];
        
    });
    return __defaultRequest;
}
- (void)UrlReqursts:(NSString *)url requestStrs:(NSString *)str returnObjs:(void (^)(id obj))blocks returnError:(void (^)(id error))bloclErrors
{
    NSString *strUrl = [NSString stringWithFormat:@"http://10.55.253.23:8013/WCF/%@",url];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return str;
    }];
    [manager POST:strUrl parameters:str success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dicts = (NSDictionary *)[Tool dictionaryWithJsonString:response];
        blocks(dicts);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        bloclErrors(error);
    }];
}
@end
