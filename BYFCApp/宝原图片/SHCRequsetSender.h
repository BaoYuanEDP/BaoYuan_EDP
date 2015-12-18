//
//  SHCRequsetSender.h
//  BYFCSAPP
//
//  Created by heaven on 15/7/23.
//  Copyright (c) 2015年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Tool.h"

@interface SHCRequsetSender : NSObject
+(instancetype)defaultsRequest;
//接收任意类型的数据block
@property(nonatomic,copy) void (^allTypeBlock)(id obj);
@property(nonatomic,copy) void (^allErrorBlock)(id error);
- (void)UrlReqursts:(NSString *)url requestStrs:(NSString *)str returnObjs:(void (^)(id obj))blocks returnError:(void (^)(id error))bloclErrors;
@end
