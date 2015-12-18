//
//  PriceRangeData.h
//  BYFCApp
//
//  Created by zzs on 14/12/12.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PriceRangeData : NSObject

@property(nonatomic,strong)NSString *PriceType;
@property(nonatomic,strong)NSString *userid;
@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)NSString * priceUp;
@property(nonatomic,strong)NSString * priceDown;
@property(nonatomic,strong)NSString * priceUnit;

@end
