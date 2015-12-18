//
//  VisiterData.h
//  BYFCApp
//
//  Created by zzs on 14/12/5.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VisiterData : NSObject
@property(strong,nonatomic)NSString * userid;
@property(strong,nonatomic)NSString * CustLevel;
@property(strong,nonatomic)NSString * DistrictName;
@property(strong,nonatomic)NSString * AreaId;
//@property(strong,nonatomic)NSString *AreaName;
@property(strong,nonatomic)NSString * Trade;
@property(strong,nonatomic)NSString * PriceMin;
@property(strong,nonatomic)NSString * PriceMax;
@property(strong,nonatomic)NSString * FlagPrivate;
@property(strong,nonatomic)NSString * StartIndex;
@property(strong,nonatomic)NSString * token;
@property(strong,nonatomic)NSString * FlagRecommand;
@property(strong,nonatomic)NSString * FlagNeed;
@property(strong,nonatomic)NSString * FlagSchool;
@property(nonatomic,strong)NSString * flagSubs;
@property(nonatomic,strong)NSString * subUserCode;
@property(nonatomic,strong)NSString * telephoneNumberString;
@property(nonatomic,strong)NSString * pubTypeString;
@property(nonatomic,strong)NSString * jiaoYiString;
@property(nonatomic,strong)NSString * getAllString;
@property(nonatomic,strong)NSString * directFlgString;


@end
