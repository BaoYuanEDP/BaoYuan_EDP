//
//  VisterInfo.h
//  BYFCApp
//
//  Created by PengLee on 15/5/20.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VisterInfo : NSObject
@property(nonatomic,strong) NSString *ageString;
@property(nonatomic,strong) NSString *areaIDString;
@property(nonatomic,strong) NSString *areaNameString;
@property(nonatomic,strong) NSString *countFString;
@property(nonatomic,strong) NSString *countNumString;
@property(nonatomic,strong) NSString *countTString;
@property(nonatomic,strong) NSString *custIDString;
@property(nonatomic,strong) NSString *custLevelString;
@property(nonatomic,strong) NSString *custNameString;
@property(nonatomic,strong) NSString *custTelString;
@property(nonatomic,strong) NSString *districtNameString;
@property(nonatomic,strong) NSString *empCodeString;
@property(nonatomic,strong) NSString *empNameString;
@property(nonatomic,strong) NSString *flagNeedString;
@property(nonatomic,strong) NSString *flagprivateString;
@property(nonatomic,strong) NSString *flagRecommandString;
@property(nonatomic,strong) NSString *flagSchoolString;
@property(nonatomic,strong) NSString *lastDateDisPlayString;
@property(nonatomic,strong) NSString *priceString;
@property(nonatomic,strong) NSString *propertyTypeString;
@property(nonatomic,strong) NSString *rowNumString;
@property(nonatomic,strong) NSString *regDateString;
@property(nonatomic,strong) NSString *sexString;
@property(nonatomic,strong) NSString *squareString;
@property(nonatomic,strong) NSString *statusString;
@property(nonatomic,strong) NSString *tradeString;
@property(nonatomic,strong) NSString *unitNameString;
@property(nonatomic,strong) NSString *isClick;

+(VisterInfo *)loadVisterInfoFromDictionary:(NSDictionary *)dictionary;
-(NSDictionary *)transSelfToAdictionary:(VisterInfo *)vister;
@end
