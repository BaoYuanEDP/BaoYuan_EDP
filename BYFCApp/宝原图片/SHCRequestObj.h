//
//  SHCRequestObj.h
//  DemorRequest
//
//  Created by heaven on 15/7/22.
//  Copyright (c) 2015年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHCRequsetSender.h"
@interface SHCRequestObj : NSObject
+(instancetype)defaultsRequest;
//接收任意类型的数据block
@property(nonatomic,copy) void (^allTypeBlock)(id obj);
@property(nonatomic,copy) void (^allErrorBlock)(id error);
- (void)UrlRequrst:(NSString *)url urlSender:(NSString *)urlS urlNext:(NSString *)urlN requestDic:(id)dic returnObj:(void (^)(id obj))block returnError:(void (^)(id error))bloclError;
@end
