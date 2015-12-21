//
//  MyRequest.m
//  BYFCApp
//
//  Created by PengLee on 14/12/2.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import "MyRequest.h"
#import "JSON.h"
#import "XMLReader.h"
#import "Tool.h"
#import "TrainingModel.h"
static  MyRequest * __defaultRequest=nil;
@implementation MyRequest

@synthesize delegate;


-(instancetype)init
{
    if (self = [super init])
    {
        
    }
    return self;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        __defaultRequest =   [super allocWithZone:zone];
        
    });
    return __defaultRequest;
    
    
}
+(instancetype)defaultsRequest
{
    
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        __defaultRequest = [[[self class]alloc]init];
        
    });
    return __defaultRequest;
    
}
+ (AppDelegate *)AppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
    
}
+ (NETWORK_TYPE_TEST)checkNetWorking
{
    if ([[MyRequest AppDelegate ] isEnableWIFI])
    {
        return NETWORK_TYPE_TEST_WIFI;
    }
    else if ([[MyRequest AppDelegate] isEnable3g])
    {
        return NETWORK_TYPE_TEST_3G|NETWORK_TYPE_TEST_4G|NETWORK_TYPE_TEST_5G;
        
    }
    return NETWORK_TYPE_TEST_NONE;
    
}
+ (BOOL)firstLunch
{
    if (![PL_USER_STORAGE boolForKey:APP_EVER_LAUNCH_AGAIN])
    {
        [PL_USER_STORAGE setBool:YES forKey:APP_FIRST_LAUNCH];
        [PL_USER_STORAGE setBool:YES forKey:APP_EVER_LAUNCH_AGAIN];
        [PL_USER_STORAGE synchronize];
        return YES;
        
    }
    else
    {
        [PL_USER_STORAGE setBool:NO forKey:APP_FIRST_LAUNCH];
        return NO;
        
    }
    
    
    
    return NO;
    
    
}


#pragma mark --约看房源列表
-(void)afGetGoSeePropertyListEstateName:(NSString *)estateName BuildingName:(NSString *)buildingName RoomNo:(NSString *)roomNo  StartIndex:(NSString *)startIndex completeBack:(void (^)(NSString *str))block
{
    self.blockString = nil;
    self.blockString = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetGoSeePropertyList xmlns=\"http://tempuri.org/\"><EstateName>%@</EstateName><BuildingName>%@</BuildingName><RoomNo>%@</RoomNo><StartIndex>%@</StartIndex><userid>%@</userid><token>%@</token></GetGoSeePropertyList></soap:Body></soap:Envelope>",estateName,buildingName,roomNo,startIndex,[PL_USER_STORAGE objectForKey:PL_USER_USERID],[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_ROOMLIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.blockString(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}





#pragma mark --约看客源列表
-(void)afGetGoSeeCustListWithCustName:(NSString *)custName StartIndex:(NSString *)startIndex completeBack:(void (^)(NSString *str))block
{
    self.blockString = nil;
    self.blockString = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetGoSeeCustList xmlns=\"http://tempuri.org/\"><CustName>%@</CustName><StartIndex>%@</StartIndex><userid>%@</userid><token>%@</token></GetGoSeeCustList></soap:Body></soap:Envelope>",custName,startIndex,[PL_USER_STORAGE objectForKey:PL_USER_USERID],[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_ROOMLIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.blockString(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}
#pragma mark -- GetHouseValueUpd
-(void)afGetHouseValueUpd:(NSString *)propertyID completeBack:(void (^)(NSString *str))block
{
    self.blockString = nil;
    self.blockString = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetHouseValueUpd xmlns=\"http://tempuri.org/\"><PropertyID>%@</PropertyID><userid>%@</userid><token>%@</token></GetHouseValueUpd></soap:Body></soap:Envelope>",propertyID,[PL_USER_STORAGE objectForKey:PL_USER_USERID],[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_KEYUAN_LIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.blockString(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}

#pragma mark -- 获取房客源筛选下属的员工编号
-(void)afGetSubordinateNewuserCode:(NSString *)userCode FLG:(NSString *)flg Status:(NSString *)status ShowLevel:(NSString *)showLevel completeBack:(void (^)(NSString *str))block
{
    self.blockString = nil;
    self.blockString = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetSubordinate  xmlns=\"http://tempuri.org/\"><userCode>%@</userCode><FLG>%@</FLG><Status>%@</Status><ShowLevel>%@</ShowLevel></GetSubordinate></soap:Body></soap:Envelope>",userCode,flg,status,showLevel];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_KEYUAN_LIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.blockString(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.userInfo);
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}
//-(void)afGetSubordinateNewuserCode:(NSString *)userCode DutyCode:(NSString *)dutyCode StartIndex:(NSString *)startIndex completeBack:(void (^)(NSString *str))block
//{
//    self.blockString = nil;
//    self.blockString = block;
//    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetSubordinateNew xmlns=\"http://tempuri.org/\"><userCode>%@</userCode><DutyCode>%@</DutyCode><StartIndex>%@</StartIndex></GetSubordinateNew></soap:Body></soap:Envelope>",userCode,dutyCode,startIndex];
//
//
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
//    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
//    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
//        return soapMessage;
//    }];
//    [manager POST:PL_USER_KEYUAN_LIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
//        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
//        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
//        GDataXMLElement * xml = [doc rootElement ];
//        NSArray * array = [xml children];
//        for (int i=0; i<array.count; i++)
//        {
//            //根据标签名判断
//            GDataXMLElement * element = array[i];
//            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
//                //NSLog(@"+++++%@",[element stringValue]);
//                self.allTypeBlock([element stringValue]);
//            }
//            else
//            {
//
//                NSString * string = [element stringValue];
//
//                self.blockString(string);
//
//
//            }
//        }
//
//
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//
//        NSLog(@"%@",error);
//        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
//
//
//
//    }];
//
//}




#pragma mark -- 获取房源修改前的数据
-(void)afGetHouseValueUpdWithPropertyID:(NSString *)propertyID completeBack:(void (^)(NSString *str))block
{
    self.blockString = nil;
    self.blockString = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetHouseValueUpd xmlns=\"http://tempuri.org/\"><PropertyID>%@</PropertyID><userid>%@</userid><token>%@</token></GetHouseValueUpd></soap:Body></soap:Envelope>",propertyID,[PL_USER_STORAGE objectForKey:PL_USER_USERID],[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_ROOMLIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                NSLog(@":::::::::%@",string);
                
                self.blockString(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}

#pragma MARK --获取部门信息
-(void)afGetDeptFromSnapshotWithUnitCode:(NSString *)unitCode SpaceLevel:(NSString *)spaceLevel DutyCode:(NSString *)dutycode completeBack:(void (^)(NSString *str))block
{
    
    
    self.blockString = nil;
    self.blockString = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetDeptFromSnapshot xmlns=\"http://tempuri.org/\"><UnitCode>%@</UnitCode><SpaceLevel>%@</SpaceLevel><DutyCode>%@</DutyCode></GetDeptFromSnapshot></soap:Body></soap:Envelope>",unitCode,spaceLevel,dutycode];
    
    NSLog(@"%@",soapMessage);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_KEYUAN_LIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.blockString(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}

#pragma mark --房源请求跟进列表
-(void)afGetFollowListDistrictName:(NSString *)districtName AreaName:(NSString *)areaName FollowDateFrom:(NSString *)followDateFrom FollowDateTo:(NSString *)followDateTo FlagSubs:(NSString*)flagsubs SubUserCode:(NSString *)subUserCode  StartIndex:(NSString *)startindex completeBack:(void (^)(NSString *str))block
{
    self.blockString = nil;
    self.blockString = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetFollowList xmlns=\"http://tempuri.org/\"><DistrictName>%@</DistrictName><AreaName>%@</AreaName><FollowDateFrom>%@</FollowDateFrom><FollowDateTo>%@</FollowDateTo><FlagSubs>%@</FlagSubs><SubUserCode>%@</SubUserCode><StartIndex>%@</StartIndex><userid>%@</userid><token>%@</token></GetFollowList></soap:Body></soap:Envelope>",districtName,areaName,followDateFrom,followDateTo,flagsubs,subUserCode,startindex,[PL_USER_STORAGE objectForKey:PL_USER_USERID],[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]];
    
    NSLog(@"--\n%@",[PL_USER_STORAGE objectForKey:PL_USER_USERID]);
    NSLog(@"---\n%@",[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_ROOMLIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.blockString(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
}




#pragma mark --添加约看结果
-(void)afSetgoSeeRecordWithGoSeeID:(NSString *)goseeID RecordReMark:(NSString *)recordMark DateTime:(NSString *)dateTime Type:(NSString *)type  completeBack:(void (^)(NSString *str))block
{
    self.blockString = nil;
    self.blockString = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SetGoSeeRecord xmlns=\"http://tempuri.org/\"><GoSeeID>%@</GoSeeID><RecordRemark>%@</RecordRemark><DateTime>%@</DateTime><Type>%@</Type><Source>%@</Source><userid>%@</userid><token>%@</token></SetGoSeeRecord></soap:Body></soap:Envelope>",goseeID,recordMark,dateTime,type,@"ios",[PL_USER_STORAGE objectForKey:PL_USER_USERID],[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_ROOMLIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.blockString(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
    
}
#pragma mark 撤销假期列表

-(void)holiDayGetRequestUserid:(NSString *)userid Token:(NSString *)token completeBack:(void (^)(NSMutableArray *))block
{
    self.allTypeBlock=nil;
    self.allTypeBlock = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetAttendance_List xmlns=\"http://tempuri.org/\"><userid>%@</userid><token>%@</token></GetAttendance_List></soap:Body></soap:Envelope>",userid,token];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_GETATTENDANCE_LIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                
                NSArray * signArray = [[element stringValue] JSONValue];
                self.allTypeBlock(signArray);
                
                NSLog(@"+++++%@",signArray);
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
    }];
}

#pragma mark --请求跟进列表
-(void)afGetFollowListTrade:(NSString *)trade FollowType:(NSString *)followtype FollowWay:(NSString *)followway FollowDateFrom:(NSString *)followdatefrom FollowDateTo:(NSString *)followdateto FlagSubs:(NSString*)flagsubs SubUserCode:(NSString *)subUserCode StartIndex:(NSString *)startindex completeBack:(void (^)(NSString *str))block
{
    self.blockString = nil;
    self.blockString = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetFollowList xmlns=\"http://tempuri.org/\"><Trade>%@</Trade><FollowType>%@</FollowType><FollowWay>%@</FollowWay><FollowDateFrom>%@</FollowDateFrom><FollowDateTo>%@</FollowDateTo><FlagSubs>%@</FlagSubs><SubUserCode>%@</SubUserCode><StartIndex>%@</StartIndex><userid>%@</userid><token>%@</token></GetFollowList></soap:Body></soap:Envelope>",trade,followtype,followway,followdatefrom,followdateto,flagsubs,subUserCode,startindex,[PL_USER_STORAGE objectForKey:PL_USER_USERID],[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]];
    
    NSLog(@"--\n%@",[PL_USER_STORAGE objectForKey:PL_USER_USERID]);
    NSLog(@"---\n%@",[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_KEYUAN_LIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.blockString(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
}




#pragma mark --获取约看结果
-(void)afGetGoSeeRecordWithGoSeeID:(NSString *)goseeid completeBack:(void (^)(NSString *str))block
{
    self.blockString = nil;
    self.blockString = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetGoSeeRecord xmlns=\"http://tempuri.org/\"><GoSeeID>%@</GoSeeID><userid>%@</userid><token>%@</token></GetGoSeeRecord></soap:Body></soap:Envelope>",goseeid,[PL_USER_STORAGE objectForKey:PL_USER_USERID],[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_ROOMLIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.blockString(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
}

#pragma mark --约看列表
-(void)afGetGoSeeListWithDistrictName:(NSString *)districtName AreaName:(NSString *)areaName EstateName:(NSString *)estateName DateFrom:(NSString *)dateFrom DateTo:(NSString *)dateTo FlagSubs:(NSString *)flagSubs SubUserCode:(NSString *)subUserCode StartIndex:(NSString *)startIndex completeBack:(void (^)(NSString *str))block
{
    self.blockString = nil;
    self.blockString = block;
    
    
    
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetGoSeeList xmlns=\"http://tempuri.org/\"><DistrictName>%@</DistrictName><AreaName>%@</AreaName><EstateName>%@</EstateName><DateFrom>%@</DateFrom><DateTo>%@</DateTo><FlagSubs>%@</FlagSubs><SubUserCode>%@</SubUserCode><StartIndex>%@</StartIndex><userid>%@</userid><token>%@</token></GetGoSeeList></soap:Body></soap:Envelope>",districtName,areaName,estateName,dateFrom,dateTo,flagSubs,subUserCode,startIndex,[PL_USER_STORAGE objectForKey:PL_USER_USERID],[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]];
    NSLog(@"%@",soapMessage);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_ROOMLIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.blockString(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
}

#pragma mark --添加约看
- (void)afSetGoSee:(NSString*)propertyID CustID:(NSString*)custID Source:(NSString*)source AppointmentTime:(NSString*)appointmentTime  userID:(NSString *)userId userToken:(NSString *)token completeBack:(void (^)(NSString *str))block
{
    self.allTypeBlock = block;
    
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SetGoSee xmlns=\"http://tempuri.org/\"><PropertyID>%@</PropertyID><CustID>%@</CustID><Source>%@</Source><AppointmentTime>%@</AppointmentTime><userid>%@</userid><token>%@</token></SetGoSee></soap:Body></soap:Envelope>",propertyID,custID,source,appointmentTime,userId,token];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_ROOMLIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}



#pragma mark --5.21客源列表
-(void)afXYGetCustomListWithVist:(VisiterData *)customInfo ComPleteBack:(void(^)(NSMutableString *str))block
{
    self.allTypeBlock=block;
    
    NSString *soapMsg=[NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetCustomList xmlns=\"http://tempuri.org/\"><userid>%@</userid><CustLevel>%@</CustLevel><DistrictName>%@</DistrictName><AreaId>%@</AreaId><Trade>%@</Trade><PriceMin>%@</PriceMin><PriceMax>%@</PriceMax><FlagPrivate>%@</FlagPrivate><FlagRecommand>%@</FlagRecommand><FlagNeed>%@</FlagNeed><FlagSchool>%@</FlagSchool><Phone>%@</Phone><StartIndex>%@</StartIndex><FlagSubs>%@</FlagSubs><SubUserCode>%@</SubUserCode><PubType>%@</PubType><Status>%@</Status><GetAll>%@</GetAll><DirectFlg>%@</DirectFlg><token>%@</token></GetCustomList></soap:Body></soap:Envelope>",customInfo.userid,customInfo.CustLevel,customInfo.DistrictName,customInfo.AreaId,customInfo.Trade,customInfo.PriceMin,customInfo.PriceMax,customInfo.FlagPrivate,customInfo.FlagRecommand,customInfo.FlagNeed,customInfo.FlagSchool,customInfo.telephoneNumberString,customInfo.StartIndex,customInfo.flagSubs,customInfo.subUserCode,customInfo.pubTypeString,customInfo.jiaoYiString,customInfo.getAllString,customInfo.directFlgString,customInfo.token];
    NSLog(@"token=======%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"]);
    NSURL *url=[NSURL URLWithString:PL_USER_KEYUAN_LIST];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMsg length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/GetCustomList" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *customListconnection=[NSURLConnection connectionWithRequest:request delegate:self];
    [customListconnection start];
    
}

#pragma mark -- 客源转移
-(void)afSetCustMoveWithCustID:(NSString *)custid ToEmpCode:(NSString *)toempcode ToUnitCode:(NSString *)tounitcode FrFlagPrivate:(NSString *)frflagPrivate ToFlagPrivate:(NSString *)toflagPrivate  CompleteBack:(void (^)(NSString *str))block
{
    self.blockString = nil;
    self.blockString= block;
    
    NSLog(@"%@,%@,%@,%@,%@,%@,%@,%@",custid,toempcode,tounitcode,frflagPrivate,toflagPrivate,@"ios",[PL_USER_STORAGE objectForKey:PL_USER_USERID],[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]);
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SetCustMove xmlns=\"http://tempuri.org/\"><CustID>%@</CustID><ToEmpCode>%@</ToEmpCode><ToUnitCode>%@</ToUnitCode><FrFlagPrivate>%@</FrFlagPrivate><ToFlagPrivate>%@</ToFlagPrivate><FromPort>%@</FromPort><userid>%@</userid><token>%@</token></SetCustMove></soap:Body></soap:Envelope>",custid,toempcode,tounitcode,frflagPrivate,toflagPrivate,@"ios",[PL_USER_STORAGE objectForKey:PL_USER_USERID],[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_KEYUAN_LIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.blockString(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",operation.response);
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
    
}
#pragma mark --客源信息修改
- (void)afSetCustUpdate:(VisiterUpdate *)visiterUpdate  completeBack:(void (^)(NSString *str))block
{
    self.allTypeBlock = block;
    
    
    //    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetSupFromUserCode xmlns=\"http://tempuri.org/\"><userId>%@</userId><token>%@</token></GetSupFromUserCode></soap:Body></soap:Envelope>", userId,token];
    
    
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SetCustUpdate xmlns=\"http://tempuri.org/\"><CustID>%@</CustID><DistrictName>%@</DistrictName><AreaID>%@</AreaID><CountF>%@</CountF><CountT>%@</CountT><SquareMin>%@</SquareMin><SquareMax>%@</SquareMax><PriceMin>%@</PriceMin><PriceMax>%@</PriceMax><RentalMin>%@</RentalMin><RentalMax>%@</RentalMax><FromPort>%@</FromPort><userid>%@</userid><token>%@</token></SetCustUpdate></soap:Body></soap:Envelope>", visiterUpdate.CustID,   visiterUpdate.DistrictName,visiterUpdate.AreaID,visiterUpdate.CountF,visiterUpdate.CountT,visiterUpdate.SquareMin,visiterUpdate.SquareMax,visiterUpdate.PriceMin,visiterUpdate.PriceMax,visiterUpdate.RentalMin,visiterUpdate.RentalMax,visiterUpdate.FromPort,visiterUpdate.userid,visiterUpdate.token];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_UPDATE_LEVEL_URL parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}



#pragma mark --查询上级编号
- (void)afGetSupFromUserCode:(NSString *)userId userToken:(NSString *)token completeBack:(void (^)(NSString *str))block
{
    self.allTypeBlock = block;
    
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetSupFromUserCode xmlns=\"http://tempuri.org/\"><userId>%@</userId><token>%@</token></GetSupFromUserCode></soap:Body></soap:Envelope>", userId,token];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_UPDATE_LEVEL_URL parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}


#pragma mark -----最新拨打电话
- (void)afDialCustTelephone:(NSString *)CameraNumber   CustPhone:(NSString *)CustPhone   ID:(NSString *)ID   Type:(NSString *)Type FromCode:(NSString *)FromCode  userid:(NSString *)userId  userToken:(NSString *)token  completeBack:(void (^)(NSMutableString *str))block
{
    self.allTypeBlock = block;
    
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><DialCustTelephone xmlns=\"http://tempuri.org/\"><CameraNumber>%@</CameraNumber><CustPhone>%@</CustPhone><ID>%@</ID><Type>%@</Type><FromCode>%@</FromCode><userId>%@</userId><token>%@</token></DialCustTelephone></soap:Body></soap:Envelope>", CameraNumber,CustPhone,ID,Type,FromCode,userId,token];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_UPDATE_LEVEL_URL parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}
#pragma mark --查询电话号码
-(void)afGetPhoneID:(NSString *)ID type:(NSString *)type completeBack:(void (^)(NSMutableString *str))block
{
    self.allTypeBlock = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body> <GetPhone xmlns=\"http://tempuri.org/\"><ID>%@</ID><Type>%@</Type><userid>%@</userid><token>%@</token></GetPhone></soap:Body></soap:Envelope>",ID,type,[PL_USER_STORAGE objectForKey:PL_USER_USERID],[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_UPDATETELEPHONE parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
    
    
}

#pragma mark --更新电话号码
-(void)afSetPhoneUpdOrInsID:(NSString *)ID OldPhone:(NSString *)oldPhone NewPhone:(NSString *)newPhone Mode:(NSString *)mode completeBack:(void (^)(NSMutableString *))block
{
    self.allTypeBlock = block;
    NSLog(@"ID %@,OLD %@,NEW %@,MODE %@,USERID %@,TOKEN %@",ID,oldPhone,newPhone,mode,[PL_USER_STORAGE objectForKey:PL_USER_USERID],[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]);
    
    
    
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SetPhoneUpdOrIns xmlns=\"http://tempuri.org/\"><ID>%@</ID><OldPhone>%@</OldPhone><NewPhone>%@</NewPhone><mode>%@</mode><userid>%@</userid><token>%@</token></SetPhoneUpdOrIns></soap:Body></soap:Envelope>",ID,oldPhone,newPhone,mode,[PL_USER_STORAGE objectForKey:PL_USER_USERID],[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_UPDATETELEPHONE parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
    
}


#pragma mark --获取通话记录
- (void)afGetPhoneHistory:(NSString *)IO   Time:(NSString *)time Type:(NSString *)Type  FlagSubs:(NSString *)FlagSubs SubUserCode:(NSString *)SubUserCode  SubPhone:(NSString *)phone SubDutyCode:(NSString *)SubDutyCode  StarIndex:(NSString *)Index  userid:(NSString *)userId  userToken:(NSString *)token  completeBack:(void (^)(NSMutableString *str))block
{
    self.allTypeBlock = block;
    
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetPhoneHistory xmlns=\"http://tempuri.org/\"><IO>%@</IO><Time>%@</Time><Type>%@</Type><FlagSubs>%@</FlagSubs><SubUserCode>%@</SubUserCode><SubPhone>%@</SubPhone><SubDutyCode>%@</SubDutyCode><StartIndex>%@</StartIndex><userId>%@</userId><token>%@</token></GetPhoneHistory></soap:Body></soap:Envelope>", IO,time,Type,FlagSubs,SubUserCode,phone,SubDutyCode,Index,userId,token];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_UPDATE_LEVEL_URL parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}


#pragma mark --获取上级
- (void)afGetSupFromSnapshot:(NSString *)userId userToken:(NSString *)token completeBack:(void (^)(NSString *str))block
{
    self.allTypeBlock = block;
    
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetSupFromSnapshot xmlns=\"http://tempuri.org/\"><userId>%@</userId><token>%@</token></GetSupFromSnapshot></soap:Body></soap:Envelope>", userId,token];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_UPDATE_LEVEL_URL parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}
#pragma mark 请求下级
- (void)afGetSubFromSnapshot:(NSString *)userCode FLG:(NSString *)fLG  Status:(NSString *)status ShowLevel:(NSString *)showLevel completeBack:(void (^)(NSString *str))block
{
    self.allTypeBlock = block;
    
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetSubordinate xmlns=\"http://tempuri.org/\"><userCode>%@</userCode><FLG>%@</FLG><Status>%@</Status><ShowLevel>%@</ShowLevel></GetSubordinate></soap:Body></soap:Envelope>",userCode,fLG,status,showLevel];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_UPDATE_LEVEL_URL parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}

#pragma mark 登录接口
-(void)getWebServiceData:(void (^)(NSMutableString * string))block userName:(NSString *)name userPass:(NSString *)password
{
    self.allTypeBlock = block;
    // [[ShowActivityLoad shareDefault]showStatusAndSolidbg];
    //[connection cancel];
    
    NSString *soapMsg=[NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><Login xmlns=\"http://tempuri.org/\"><userid>%@</userid><pwd>%@</pwd><device>%@</device></Login></soap:Body></soap:Envelope>",name,password,@"ios"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMsg.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMsg;
    }];
    [manager POST:PL_USER_NOTICE_LIST parameters:soapMsg success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                
                // NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                self.allTypeBlock(string);
                
                
                
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        NSLog(@"%@",error);
        
        
    }];
    
    
}
-(void)afgetWebServiceUserName:(NSString *)name userPass:(NSString *)password backInfo:(void (^)(NSMutableString *))block
{
    
    self.allTypeBlock= nil;
    self.allTypeBlock = block;
    
    
    NSString *soapMsg=[NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><Login xmlns=\"http://tempuri.org/\"><userid>%@</userid><pwd>%@</pwd><device>%@</device></Login></soap:Body></soap:Envelope>",name,password,@"ios"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMsg.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMsg;
    }];
    [manager POST:PL_USER_ROOMLIST parameters:soapMsg success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                // NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                self.allTypeBlock(string);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
    }];
    
}
-(void)afgetWebServiceData:( void (^)(NSMutableString * string) )block userName:(NSString * )name userPass:(NSString *)password
{
    self.allTypeBlock= nil;
    self.allTypeBlock = block;
    NSString *soapMsg=[NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><Login xmlns=\"http://tempuri.org/\"><userid>%@</userid><pwd>%@</pwd><device>%@</device></Login></soap:Body></soap:Envelope>",name,password,@"ios"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMsg.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMsg;
    }];
    [manager POST:PL_USER_ROOMLIST parameters:soapMsg success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                
                // NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                self.allTypeBlock(string);
                
                
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}
#pragma mark --公告列表接口
- (void)getNoticeList:(NSString *)statedIndex page:(NSString *)pagesize userName:(NSString *)user passToken:(NSString *)token call:(void (^)(NSArray *array))block
{
    self.blockArray = block;
    
    
    
    NSString *soapMsg=[NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetNoticeList xmlns=\"http://tempuri.org/\"><StartIndex>%@</StartIndex><PageSize>%@</PageSize><userid>%@</userid><token>%@</token></GetNoticeList></soap:Body></soap:Envelope>",statedIndex,pagesize,user,token];
    NSURL *url=[NSURL URLWithString:PL_USER_NOTICE_LIST];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMsg length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/GetNoticeList" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    connection=[NSURLConnection connectionWithRequest:request delegate:self];
    
    //如果连接已经建好，则初始化data
    if( connection )
    {
        
        
    }
    else
    {
        NSLog(@"theConnection is NULL");
    }
    
}
#pragma mark 修改密码
-(void)changePassWord:(void (^)(NSMutableString * string))block userid:(NSString *)userid userPass:(NSString *)password token:(NSString *)token NewPwd:(NSString *)NewPwd
{
    self.blockCall = block;
    NSString *soapMsg=[NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><ChangePassWord xmlns=\"http://tempuri.org/\"><userid>%@</userid><token>%@</token><Pwd>%@</Pwd><NewPwd>%@</NewPwd></ChangePassWord></soap:Body></soap:Envelope>",userid,password,token,NewPwd];
    NSURL *url=[NSURL URLWithString:PL_USER_NOTICE_LIST];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMsg length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/ChangePassWord" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection * changeConnection=[NSURLConnection connectionWithRequest:request delegate:self];
    [changeConnection start];
}

#pragma mark 更多筛选
-(void)GetPropertyAddChosen:(void (^)(NSMutableString * string))block  PropertyType:(NSString *)PropertyType userid:(NSString *)userid token:(NSString *)token
{
    self.blockCall = block;
    NSString *soapMsg=[NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetPropertyAddChosen xmlns=\"http://tempuri.org/\"><PropertyType>%@</PropertyType><userid>%@</userid><token>%@</token></GetPropertyAddChosen></soap:Body></soap:Envelope>",PropertyType,userid,token];
    NSURL *url=[NSURL URLWithString:PL_USER_ROOMLIST];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMsg length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/GetPropertyAddChosen" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection * chosenConnection=[NSURLConnection connectionWithRequest:request delegate:self];
    [chosenConnection start];
}
#pragma maek 联系人
-(void)getEmpInfoList:(NSString *)text index:(NSString *)StartIndex userid:(NSString *)userid token:(NSString *)token backInfoMessage:(void (^)(NSMutableArray  * array))block
{
    
    self.allTypeBlock = nil;
    self.allTypeBlock = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetEmpInfoList xmlns=\"http://tempuri.org/\"><text>%@</text><StartIndex>%@</StartIndex><userid>%@</userid><token>%@</token></GetEmpInfoList></soap:Body></soap:Envelope>",text,StartIndex,userid,token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_PERSION parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"----------------------------------------->\n%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                // NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                NSMutableArray * resultArray= [[NSMutableArray array] mutableCopy];
                
                if ([string isEqualToString:@"[]"])
                {
                    NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                    if (arr.count)
                    {
                        self.allTypeBlock(arr);
                    }
                    return ;
                }
                if([string isEqualToString:@"exception"])
                {
                    PL_ALERT_SHOWNOT_OKAND_YES(string);
                    
                    return;
                }
                if ([string isEqualToString:@"NOLOGIN"])
                {
                    NSLog(@"token 过期，请重新登录");
                    NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                    if (arr.count)
                    {
                        self.allTypeBlock(arr);
                    }
                }
                else
                {
                    if ((NSNull *)string ==[NSNull null])
                    {
                        NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                        self.allTypeBlock(arr);
                    }
                    else
                    {
                        NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
                        NSArray * roomArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        NSLog(@"array====++++   %@",resultArray);
                        for (NSDictionary *dic in roomArr) {
                            PersonSearchCellModel *model = [[PersonSearchCellModel alloc] init];
                            model.name = [dic objectForKey:@"UserName"];
                            model.personNum = [dic objectForKey:@"UserCode"];
                            model.phoneNum = [dic objectForKey:@"Mobile"];
                            model.area = [dic objectForKey:@"Area"];
                            model.ment = [dic objectForKey:@"Department"];
                            model.Branch = [dic objectForKey:@"Branch"];
                            model.Position = [dic objectForKey:@"Position"];
                            model.DeptTel = [dic objectForKey:@"DeptTel"];
                            model.Fax = [dic objectForKey:@"Fax"];
                            model.DeptZip = [dic objectForKey:@"DeptZip"];
                            model.FulEmail = [dic objectForKey:@"FulEmail"];
                            model.Dizhi = [dic objectForKey:@"DeptAdd"];
                            model.six = [dic objectForKey:@"Sex"];
                            model.rowNum = [dic objectForKey:@"ROWNUM"];
                            [resultArray addObject:model];
                        }
                        self.allTypeBlock(resultArray);
                    }
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
    }];
}
#pragma mark 名片申请查询列表
-(void)CardLookStartIndex:(NSString *)StartIndex userid:(NSString *)userid token:(NSString *)token string:(void (^)(NSMutableArray *array))block
{
    self.allTypeBlock = nil;
    self.allTypeBlock = block;
    NSString *soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetCardApplication xmlns=\"http://tempuri.org/\"><StartIndex>%@</StartIndex><userid>%@</userid><token>%@</token></GetCardApplication></soap:Body></soap:Envelope>",StartIndex,userid,token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFCompoundResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_CARDLOOK parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"----------------------------------------->\n%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                // NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                NSMutableArray * resultArray= [[NSMutableArray array] mutableCopy];
                
                if ([string isEqualToString:@"[]"])
                {
                    NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                    if (arr.count)
                    {
                        self.allTypeBlock(arr);
                    }
                    return ;
                }
                if([string isEqualToString:@"exception"])
                {
                    PL_ALERT_SHOWNOT_OKAND_YES(string);
                    
                    return;
                }
                if ([string isEqualToString:@"NOLOGIN"])
                {
                    NSLog(@"token 过期，请重新登录");
                    NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                    if (arr.count)
                    {
                        self.allTypeBlock(arr);
                    }
                }
                else
                {
                    if ((NSNull *)string ==[NSNull null])
                    {
                        NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                        self.allTypeBlock(arr);
                    }
                    else
                    {
                        NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
                        NSArray * roomArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        NSLog(@"array====++++   %@",resultArray);
                        
                        for (NSDictionary *dic in roomArr) {
                            CardLookViewCellModel *model = [[CardLookViewCellModel alloc] init];
                            model.userName = [dic objectForKey:@"UserName"];
                            model.branch = [dic objectForKey:@"Branch"];
                            model.printNumber = [[dic objectForKey:@"PrintNumber"] stringValue];
                            model.addTime = [dic objectForKey:@"AddDateTime"];
                            [resultArray addObject:model];
                        }
                        self.allTypeBlock(resultArray);
                    }
                }
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
    }];
}

#pragma mark 端口申请查询列表
-(void)PortListStartIndex:(NSString *)StartIndex userid:(NSString *)userid token:(NSString *)token string:(void (^)(NSMutableArray *array))block
{
    self.allTypeBlock = nil;
    self.allTypeBlock = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetInterfaceApplication xmlns=\"http://tempuri.org/\"><StartIndex>%@</StartIndex><userid>%@</userid><token>%@</token></GetInterfaceApplication></soap:Body></soap:Envelope>",StartIndex,userid,token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_PORTLIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"----------------------------------------->\n%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                // NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                NSMutableArray * resultArray= [[NSMutableArray array] mutableCopy];
                
                if ([string isEqualToString:@"[]"])
                {
                    NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                    if (arr.count)
                    {
                        self.allTypeBlock(arr);
                    }
                    return ;
                }
                if([string isEqualToString:@"exception"])
                {
                    PL_ALERT_SHOWNOT_OKAND_YES(string);
                    
                    return;
                }
                if ([string isEqualToString:@"NOLOGIN"])
                {
                    NSLog(@"token 过期，请重新登录");
                    NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                    if (arr.count)
                    {
                        self.allTypeBlock(arr);
                    }
                }
                else
                {
                    if ((NSNull *)string ==[NSNull null])
                    {
                        NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                        self.allTypeBlock(arr);
                    }
                    else
                    {
                        NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
                        NSArray * roomArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        NSLog(@"array====++++   %@",resultArray);
                        
                        for (NSDictionary *dic in roomArr) {
                            PortListViewCellModel *model = [[PortListViewCellModel alloc] init];
                            
                            model.activeName = [dic objectForKey:@"ActivityName"];
                            model.wName = [dic objectForKeyedSubscript:@"WebName"];
                            model.pPrice = [[dic objectForKeyedSubscript:@"PackagePrice"]stringValue];
                            model.rType = [dic objectForKeyedSubscript:@"RegisterType"];
                            model.cStatus = [dic objectForKeyedSubscript:@"CheckStatus"];
                            model.aDate = [dic objectForKeyedSubscript:@"ApplyDate"];
                            [resultArray addObject:model];
                        }
                        self.allTypeBlock(resultArray);
                    }
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
    }];
}

#pragma mark ---单条请假数据提交
-(void)CheckLeaveLeaveType:(NSString *)leaveType StartDate:(NSString *)startDate EndDate:(NSString *)endDate PrevEndDate:(NSString *)prevEndDate userid:(NSString *)userid token:(NSString *)token complteBack:(void (^)(NSString *))block
{
    self.allTypeBlock = nil;
    self.allTypeBlock = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><CheckLeave xmlns=\"http://tempuri.org/\"><LeaveType>%@</LeaveType><StartDate>%@</StartDate><EndDate>%@</EndDate><PrevEndDate>%@</PrevEndDate><userid>%@</userid><token>%@</token></CheckLeave></soap:Body></soap:Envelope>",leaveType,startDate,endDate,prevEndDate,userid,token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_CHNECKLEVA_ONE parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                NSString * string = [element stringValue];
                self.allTypeBlock(string);
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        NSLog(@"%@",error);
        
    }];
}
#pragma mark --多条请假申请
-(void)MultibarHouliDayJsonData:(NSString *)josndata userID:(NSString *)userid Token:(NSString *)token complteBack:(void (^)(NSString *))block
{
    self.allTypeBlock = nil;
    self.allTypeBlock = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SubAskForLeave xmlns=\"http://tempuri.org/\"><jsonData>%@</jsonData><FromPort>%@</FromPort><userid>%@</userid><token>%@</token></SubAskForLeave></soap:Body></soap:Envelope>",josndata,@"ios",userid,token];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%lu",(unsigned long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_MUTIBARHOLIDAY_LIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
    }];
    
    
    
    
    
}
#pragma mark - 销假申请提交
-(void)resumptionLeaveJsonData:(NSString *)jsonData Reason:(NSString *)reason userid:(NSString *)userid token:(NSString *)token completeBack:(void (^)(NSString *))block
{
    self.allTypeBlock = nil;
    self.allTypeBlock = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><ResumptionLeave xmlns=\"http://tempuri.org/\"><jsonData>%@</jsonData><reason>%@</reason><FromPort>%@</FromPort><userid>%@</userid><token>%@</token></ResumptionLeave></soap:Body></soap:Envelope>",jsonData,reason,@"ios",[PL_USER_STORAGE objectForKey:PL_USER_USERID],[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_GETATTENDANCE_LIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
    }];
    
}

#pragma mark ---请假撤销提交
-(void)backoutHoliDayUserid:(NSString *)userid Token:(NSString *)token processId:(NSString *)Prcesssid Type:(NSString *)type Date:(NSString *)date string:(void (^)(NSString *))block
{
    self.allTypeBlock=nil;
    self.allTypeBlock = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><RevokeAskForLeaveAndForget xmlns=\"http://tempuri.org/\"><processId>%@</processId><date>%@</date><type>%@</type><FromPort>%@</FromPort><userid>%@</userid><token>%@</token></RevokeAskForLeaveAndForget></soap:Body></soap:Envelope>",Prcesssid,date,type,@"ios",userid,token];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_GETATTENDANCE_LIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                NSString * string = [element stringValue];
                self.allTypeBlock(string);
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        NSLog(@"%@",error);
        
    }];
    
    
    
    
    
    
}
#pragma mark 外出撤销提交
-(void)getGoulistbackoutUserid:(NSString *)userid Token:(NSString *)token processId:(NSString *)Prcesssid Type:(NSString *)type Date:(NSString *)date string:(void (^)(NSString *))block
{
    self.allTypeBlock=nil;
    self.allTypeBlock = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><RevokeAskForLeaveAndForget xmlns=\"http://tempuri.org/\"><processId>%@</processId><date>%@</date><type>%@</type><FromPort>%@</FromPort><userid>%@</userid><token>%@</token></RevokeAskForLeaveAndForget></soap:Body></soap:Envelope>",Prcesssid,date,type,@"ios",userid,token];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_GETATTENDANCE_LIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                
            }
            else
            {
                NSString * string = [element stringValue];
                self.allTypeBlock(string);
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        NSLog(@"%@",error);
        
    }];
    
    
}
#pragma mark 外出申请查询列表
-(void)GetGoOutListStartIndex:(NSString *)StartIndex userid:(NSString *)userid token:(NSString *)token  string:(void(^)(NSMutableArray * array))block
{
    self.allTypeBlock = nil;
    self.allTypeBlock = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetAskForLeave xmlns=\"http://tempuri.org/\"><StartIndex>%@</StartIndex><userid>%@</userid><token>%@</token></GetAskForLeave></soap:Body></soap:Envelope>",StartIndex,userid,token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_GOOUTAPPLY parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"----------------------------------------->\n%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetAskForLeave"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                // NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                NSMutableArray * resultArray= [[NSMutableArray array] mutableCopy];
                
                NSLog(@"////////%@",resultArray);
                if ([string isEqualToString:@"[]"])
                {
                    NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                    if (arr.count)
                    {
                        self.allTypeBlock(arr);
                    }
                    return ;
                }
                if([string isEqualToString:@"exception"])
                {
                    PL_ALERT_SHOWNOT_OKAND_YES(string);
                    
                    return;
                }
                if ([string isEqualToString:@"NOLOGIN"])
                {
                    NSLog(@"token 过期，请重新登录");
                    NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                    if (arr.count)
                    {
                        self.allTypeBlock(arr);
                    }
                }
                else
                {
                    if ((NSNull *)string ==[NSNull null])
                    {
                        NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                        self.allTypeBlock(arr);
                    }
                    else
                    {
                        NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
                        NSArray * roomArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        NSLog(@"array====++++   %@",resultArray);
                        
                        for (NSDictionary *dic in roomArr) {
                            GoOutApplyListCellModel *model = [[GoOutApplyListCellModel alloc] init];
                            model.data = [dic objectForKey:@"ForgetDate"];
                            model.remark = [dic objectForKey:@"Reason"];
                            model.timeBuck =[dic objectForKey:@"Type"];
                            model.goOutAdress = [dic objectForKey:@"OutofPlace"];
                            model.result = [dic objectForKey:@"ApprovalFlag"];
                            model.ProcessId=[[dic objectForKey:@"ProcessId"] stringValue];
                            model.StartTime=[dic objectForKey:@"StOutTime"];
                            model.EndTime=[dic objectForKey:@"EtOutTime"];
                            
                            [resultArray addObject:model];
                            
                        }
                        self.allTypeBlock(resultArray);
                    }
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
    }];
    
}




#pragma mark--外出申请提交2
-(void)getGoutCommitSaveGoOutUserid:(NSString *)userid Token:(NSString *)token ForgetDate:(NSString *)forgeDate Type:(NSString *)type OutofPlace:(NSString *)outofPlace Reason:(NSString *)reason Summary:(NSString *)summary StartTime:(NSString *)starTime EndTime:(NSString *)endTime string:(void (^)(NSString *))block
{
    self.allTypeBlock = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SaveGoOut xmlns=\"http://tempuri.org/\"><ForgetDate>%@</ForgetDate><type>%@</type><OutofPlace>%@</OutofPlace><Reason>%@</Reason><Summary>%@</Summary><StartTime>%@</StartTime><EndTime>%@</EndTime><FromPort>%@</FromPort><userid>%@</userid><token>%@</token></SaveGoOut></soap:Body></soap:Envelope>",forgeDate,type,outofPlace,reason,summary,starTime,endTime,@"ios",userid,token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_GOTO_URL parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                //NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                // NSLog(@"+++++%@",signArray);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
    
    
    
    
    
    
}

#pragma mark - 获取最新版本号
-(void)GetUpgradeLogNew:(NSString *)mode userid:(NSString *)userid token:(NSString *)token backInfoMessage:(void (^)(NSString *))block
{
    self.allTypeBlock = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetUpgradeLogNew xmlns=\"http://tempuri.org/\"><mode>%@</mode><userid>%@</userid><token>%@</token></GetUpgradeLogNew></soap:Body></soap:Envelope>",mode,userid,token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_UPFRADE parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                //NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                // NSLog(@"+++++%@",signArray);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}

#pragma mark 日志
-(void)GetUpgradeLog:(NSString *)mode userid:(NSString *)userid token:(NSString *)token backInfoMessage:(void (^)(NSMutableArray  * array))block
{
    self.allTypeBlock = nil;
    self.allTypeBlock = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetUpgradeLog xmlns=\"http://tempuri.org/\"><mode>%@</mode><userid>%@</userid><token>%@</token></GetUpgradeLog></soap:Body></soap:Envelope>",mode,userid,token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_UPFRADE parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"----------------------------------------->\n%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                // NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                NSMutableArray * resultArray= [[NSMutableArray array] mutableCopy];
                
                if ([string isEqualToString:@"[]"])
                {
                    NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                    if (arr.count)
                    {
                        self.allTypeBlock(arr);
                    }
                    return ;
                }
                if([string isEqualToString:@"exception"])
                {
                    PL_ALERT_SHOWNOT_OKAND_YES(string);
                    
                    return;
                }
                if ([string isEqualToString:@"NOLOGIN"])
                {
                    NSLog(@"token 过期，请重新登录");
                    NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                    if (arr.count)
                    {
                        self.allTypeBlock(arr);
                    }
                }
                else
                {
                    if ((NSNull *)string ==[NSNull null])
                    {
                        NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                        self.allTypeBlock(arr);
                    }
                    else
                    {
                        NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
                        NSArray * roomArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        for (NSDictionary *dic in roomArr) {
                            
                            [resultArray addObject:dic];
                        }
                        NSLog(@"array====++++   %@",resultArray);
                        self.allTypeBlock(resultArray);
                    }
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
    }];
    
}
#pragma mark 房源列表
-(void)getRoomInfoEasterList:(RoomData *)roomInfo   backInfoMessage:(void (^)(NSMutableArray  * array))block
{
    self.allTypeBlock = nil;
    self.allTypeBlock = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetPropertyList xmlns=\"http://tempuri.org/\"><DistrictName>%@</DistrictName><AreaName>%@</AreaName><EstateName>%@</EstateName><Trade>%@</Trade><PriceFrom>%@</PriceFrom><PriceTo>%@</PriceTo><RentPriceFrom>%@</RentPriceFrom><RentPriceTo>%@</RentPriceTo><CountF>%@</CountF><CountT>%@</CountT><SquareFrom>%@</SquareFrom><SquareTo>%@</SquareTo><StartIndex>%@</StartIndex><PageSize>%@</PageSize><Mode>%@</Mode><IpMode>%@</IpMode><PropertyId>%@</PropertyId><FiveYearsOnlyOne>%@</FiveYearsOnlyOne><HouseKey>%@</HouseKey><HouseMarks>%@</HouseMarks><PropertyType>%@</PropertyType><BuildingName>%@</BuildingName><RoomNo>%@</RoomNo><Address>%@</Address><Recommend>%@</Recommend><FastSell>%@</FastSell><School>%@</School><Picture>%@</Picture><Status>%@</Status><TradeDate>%@</TradeDate><PropertyTrust>%@</PropertyTrust><PropertyOccupy>%@</PropertyOccupy><PropertyOwn1>%@</PropertyOwn1><PropertyDirection>%@</PropertyDirection><CustTel>%@</CustTel><UserCode>%@</UserCode><Status1>%@</Status1><StatusLimit>%@</StatusLimit><EffectiveDateFrom>%@</EffectiveDateFrom><EffectiveDateTo>%@</EffectiveDateTo><userid>%@</userid><token>%@</token></GetPropertyList></soap:Body></soap:Envelope>",roomInfo.roomDistrictName,roomInfo.roomAreaName,roomInfo.roomEasterName,roomInfo.trade,roomInfo.roomPriceFrom,roomInfo.roomPriceTo,roomInfo.roomRentPriceFrom,roomInfo.roomRentPriceTo,roomInfo.roomCountF,roomInfo.roomCountT,roomInfo.roomSquareFrom,roomInfo.roomSquareTo,roomInfo.roomStartIndex,roomInfo.roomPageSize,roomInfo.roomMode,roomInfo.roomIpMode,roomInfo.roomPropertyId,roomInfo.roomFiveYearsOnlyOne,roomInfo.roomHouseKey,roomInfo.roomHouseMarks,roomInfo.roomPropertyType,roomInfo.roomBuildingName,roomInfo.roomROOMNO,roomInfo.address,roomInfo.recommend,roomInfo.fastsell,roomInfo.school,roomInfo.roomImageType,roomInfo.roomJiaoYiType,roomInfo.TwoYears,roomInfo.propertyTrust,roomInfo.propertyOccupy,roomInfo.propertyOwn1,roomInfo.propertyDirection,roomInfo.custTel,roomInfo.userCode,roomInfo.status1,roomInfo.statusLimit,roomInfo.effectiveDateFrom,roomInfo.effectiveDateTo,roomInfo.roomUserID,roomInfo.roomToken];
    NSLog(@":::::::%@",soapMessage);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_ROOMLIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"----------------------------------------->\n%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                // NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                NSMutableArray * resultArray= [[NSMutableArray array] mutableCopy];
                if ([string isEqualToString:@"maintain"]) {
                    PL_ALERT_SHOW(@"系统维护中");
                }
                if ([string isEqualToString:@"[]"])
                {
                    NSLog(@"没有数据");
                    NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                    if (arr.count)
                    {
                        self.allTypeBlock(arr);
                    }
                    return ;
                }
                if([string isEqualToString:@"exception"])
                {
                    PL_ALERT_SHOWNOT_OKAND_YES(string);
                    
                    return;
                }
                if ([string isEqualToString:@"NOLOGIN"])
                {
                    NSLog(@"token 过期，请重新登录");
                    NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                    if (arr.count)
                    {
                        self.allTypeBlock(arr);
                    }
                }
                else
                {
                    if ((NSNull *)string ==[NSNull null])
                    {
                        NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                        
                        self.allTypeBlock(arr);
                        
                        
                        
                    }
                    else
                    {
                        
                        
                        NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
                        NSArray * roomArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        
                        int a=0;
                        
                        for (NSDictionary * dict in roomArr)
                        {
                            RoomData * roomData = [[RoomData alloc]init];
                            roomData.roomDistrictName = [NSString stringWithFormat:@"%@",[dict objectForKey:@"DistrictName"]];
                            roomData.roomAreaName = [dict objectForKey:@"AreaName"];
                            roomData.roomEasterName = [NSString stringWithFormat:@"%@(%@)",[dict objectForKey:@"EstateName"],[dict objectForKey:@"Source"]];
                            roomData.roomBuildingName = [dict objectForKey:@"BuildingName"];
                            roomData.roomonerName = [dict objectForKey:@"OwnerName"];
                            roomData.roomPropertyId = [dict objectForKey:@"PROPERTYID"];
                            roomData.roomFLOOR = [dict objectForKey:@"Floor1"];
                            roomData.roomROOMNO = [dict objectForKey:@"RoomNo"];
                            roomData.roomTrade = [dict objectForKey:@"Trade"];
                            roomData.roomStatus = [dict objectForKey:@"Status"];
                            roomData.roomCountF = [dict objectForKey:@"CountF"];
                            roomData.roomMode = [dict objectForKey:@"Mode"];
                            roomData.TwoYears=[dict objectForKey:@"TwoYear"];
                            roomData.Exclusive=[dict objectForKey:@"PropertyTrust1"];
                            roomData.propertyTrust = [dict objectForKey:@"PropertyTrust"];
                            roomData.KeyHome=[dict objectForKey:@"HouseKey"];
                            roomData.propertyOccupy = [dict objectForKey:@"PropertyOccupy"];
                            //                            roomData.roomCountT = [dict objectForKey:@"CountT"];
                            //                            roomData.roomCountW = [dict objectForKey:@"CountW"];
                            //                            roomData.roomCountY = [dict objectForKey:@"CountY"];
                            roomData.roomROOMSTYLE = [dict objectForKey:@"ROOMSTYLE"];
                            roomData.roomSquare = [dict objectForKey:@"SQUARE"];
                            roomData.roomPriceUnit = [dict objectForKey:@"PriceUnit"];
                            roomData.roomPRICE = [dict objectForKey:@"PRICE"];
                            roomData.roomUnitName = [dict objectForKey:@"MgtCompany"];
                            //                            roomData.roomRentPriceUnit = [dict objectForKey:@"RentPriceUnit"];
                            roomData.roomRentPrice = [dict objectForKey:@"RentPrice"];
                            //                            roomData.roomRentUnitName = [dict objectForKey:@"RentUnitName"];
                            roomData.roomROWNUM = [dict objectForKey:@"ROWNUM"];
                            //                            roomData.roomXBaidu = [dict objectForKey:@"XBaidu"];
                            //                            roomData.roomYBaidu = [dict objectForKey:@"YBaidu"];
                            roomData.roomFiveYearsOnlyOne = [dict objectForKey:@"FiveYearsOnlyOne"];
                            roomData.roomHouseKey = [dict objectForKey:@"HouseKey"];
                            roomData.roomHouseMarks = [dict objectForKey:@"HouseMarks"];
                            //                            roomData.roomOwnerTel = [dict objectForKey:@"OwnerTel"];
                            NSString * strImage = [dict objectForKey:@"ImgUrl"];
                            a++;
                            NSLog(@"++++%d 123456789   ------ %@",a,strImage);
                            if ([strImage isEqualToString:@""]) {
                                roomData.roomImageContent =nil;
                            }
                            //                            if ((NSNull *)strImage ==[NSNull null])
                            //                            {
                            //                                roomData.roomImageContent =nil;
                            //
                            //                            }
                            else
                            {
                                //                                NSData * iamgeDa = [strImage dataUsingEncoding:NSUTF8StringEncoding];
                                //                                NSData * dataImage = [[NSData alloc]initWithBase64EncodedData:iamgeDa options:0];
                                // 获取图片URL转成图片
                                
                                NSData * dataImage = [NSData dataWithContentsOfURL:[NSURL URLWithString:strImage]];
                                
                                UIImage * bgimage = [UIImage imageWithData:dataImage];
                                
                                
                                roomData.roomImageContent = bgimage;
                                
                                
                                
                            }
                            
                            
                            [resultArray addObject:roomData];
                            
                        }
                        NSLog(@"array====++++   %@",resultArray);
                        
                        self.allTypeBlock(resultArray);
                    }
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
    }];
}
#pragma mark 下属客源列表
-(void)getSubCustomList:(VisiterData *)customInfo   backInfoMessage:(void (^)(NSMutableString * string))block
{
    self.allTypeBlock=block;
    
    NSString *soapMsg=[NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetCustomList xmlns=\"http://tempuri.org/\"><userid>%@</userid><CustLevel>%@</CustLevel><DistrictName>%@</DistrictName><AreaId>%@</AreaId><Trade>%@</Trade><PriceMin>%@</PriceMin><PriceMax>%@</PriceMax><FlagPrivate>%@</FlagPrivate><FlagRecommand>%@</FlagRecommand><FlagNeed>%@</FlagNeed><FlagSchool>%@</FlagSchool><Phone>%@</Phone><StartIndex>%@</StartIndex><FlagSubs>%@</FlagSubs><SubUserCode>%@</SubUserCode><PubType>%@</PubType><Status>%@</Status><GetAll>%@</GetAll><DirectFlg>%@</DirectFlg><token>%@</token></GetCustomList></soap:Body></soap:Envelope>",customInfo.userid,customInfo.CustLevel,customInfo.DistrictName,customInfo.AreaId,customInfo.Trade,customInfo.PriceMin,customInfo.PriceMax,customInfo.FlagPrivate,customInfo.FlagRecommand,customInfo.FlagNeed,customInfo.FlagSchool,customInfo.telephoneNumberString,customInfo.StartIndex,customInfo.flagSubs,customInfo.subUserCode,customInfo.pubTypeString,customInfo.jiaoYiString,customInfo.getAllString,customInfo.directFlgString,customInfo.token];
    
    NSLog(@"token=======%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"]);
    NSURL *url=[NSURL URLWithString:PL_USER_KEYUAN_LIST];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMsg length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/GetCustomList" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *customListconnection=[NSURLConnection connectionWithRequest:request delegate:self];
    [customListconnection start];
}


#pragma mark 客源列表
-(void)getCustomList:(VisiterData *)customInfo backInfoMessage:(void (^)(NSMutableString * string))block
{
    self.allTypeBlock=block;
    
    NSString *soapMsg=[NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetCustomList xmlns=\"http://tempuri.org/\"><userid>%@</userid><CustLevel>%@</CustLevel><DistrictName>%@</DistrictName><AreaId>%@</AreaId><Trade>%@</Trade><PriceMin>%@</PriceMin><PriceMax>%@</PriceMax><FlagPrivate>%@</FlagPrivate><FlagRecommand>%@</FlagRecommand><FlagNeed>%@</FlagNeed><FlagSchool>%@</FlagSchool><Phone>%@</Phone><StartIndex>%@</StartIndex><FlagSubs>%@</FlagSubs><SubUserCode>%@</SubUserCode><PubType>%@</PubType><Status>%@</Status><GetAll>%@</GetAll><DirectFlg>%@</DirectFlg><token>%@</token></GetCustomList></soap:Body></soap:Envelope>",customInfo.userid,customInfo.CustLevel,customInfo.DistrictName,customInfo.AreaId,customInfo.Trade,customInfo.PriceMin,customInfo.PriceMax,customInfo.FlagPrivate,customInfo.FlagRecommand,customInfo.FlagNeed,customInfo.FlagSchool,customInfo.telephoneNumberString,customInfo.StartIndex,customInfo.flagSubs,customInfo.subUserCode,customInfo.pubTypeString,customInfo.jiaoYiString,customInfo.getAllString,customInfo.directFlgString,customInfo.token];
    NSLog(@"token=======%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"]);
    NSURL *url=[NSURL URLWithString:PL_USER_KEYUAN_LIST];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMsg length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/GetCustomList" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *customListconnection=[NSURLConnection connectionWithRequest:request delegate:self];
    [customListconnection start];
}
#pragma mark 请求个人信息
-(void)getEmpInfo:(NSString *)userName userToken:(NSString *)token backInfoMessage:(void (^)(id obj))block
{
    self.blockCall = block;
    
    NSString * soapMes = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?> <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetEmpInfo xmlns=\"http://tempuri.org/\"><userid>%@</userid><token>%@</token></GetEmpInfo></soap:Body></soap:Envelope>",userName,token];
    NSURL *url=[NSURL URLWithString:PL_USER_NOTICE_LIST];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMes length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/GetEmpInfo" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMes dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *appointCustomConnection=[NSURLConnection connectionWithRequest:request delegate:self];
    [appointCustomConnection start];
}
#pragma mark --上传图片接口
-(void)uploadImage:(NSString *)propertyID type:(NSString *)photoType phovalue:(NSString *)photoSource photoValue:(NSString *)photoValue imagebytes:(NSString *)bytes userid:(NSString *)userid token:(NSString *)userToken string:(void (^)(NSString *))block
{
    self.blockUploadImage = nil;
    self.blockUploadImage = block;
    NSString * soapString =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><UploadPropertyPic xmlns=\"http://tempuri.org/\"><PropertyID>%@</PropertyID><PhotoType>%@</PhotoType><PhotoSource>%@</PhotoSource><PhotoValue>%@</PhotoValue><imagebytes>%@</imagebytes><userid>%@</userid><token>%@</token></UploadPropertyPic></soap:Body></soap:Envelope>",propertyID,photoType,photoSource,photoValue,bytes,userid,userToken];
    //    NSURL *url=[NSURL URLWithString:PL_USER_ROOMLIST];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapString.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapString;
    }];
    [manager POST:PL_USER_ROOMLIST parameters:soapString success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                
                NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                if ([string isEqualToString:@"[]"])
                {
                    self.blockUploadImage(string);
                    
                }
                else if(string.length)
                {
                    
                    self.blockUploadImage(string);
                }
                
                
                
                NSLog(@"+++++%@",signArray);
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        NSLog(@"%@",error);
        
    }];
    
    
}
#pragma mark 客源详情
-(void)getCustomDetailInfoEasterList:(AppointVisiterData *)customDetailInfo   backInfoMessage:(void (^)(NSMutableString * string))block
{
    self.allTypeBlock = block;
    NSString *soapMsg=[NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetCustomDetail xmlns=\"http://tempuri.org/\"><CustID>%@</CustID><userid>%@</userid><token>%@</token></GetCustomDetail></soap:Body></soap:Envelope>",customDetailInfo.CustID,customDetailInfo.userid,customDetailInfo.token];
    NSURL *url=[NSURL URLWithString:PL_USER_KEYUAN_LIST];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMsg length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/GetCustomDetail" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *CustomDetailConnection=[NSURLConnection connectionWithRequest:request delegate:self];
    [CustomDetailConnection start];
}
#pragma mark 客源跟进列表
-(void)GetCustFollow:(CustFollowListData *)followList   backInfoMessage:(void (^)(NSMutableString * string))block
{
    self.allTypeBlock = block;
    NSString *soapMsg=[NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetCustFollow xmlns=\"http://tempuri.org/\"><CustID>%@</CustID><userid>%@</userid><token>%@</token></GetCustFollow></soap:Body></soap:Envelope>",followList.CustID,followList.userid,followList.token];
    NSURL *url=[NSURL URLWithString:PL_USER_KEYUAN_LIST];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMsg length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/GetCustFollow" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *CustomDetailConnection=[NSURLConnection connectionWithRequest:request delegate:self];
    [CustomDetailConnection start];
}

#pragma mark 价格区间
-(void)getPriceRange:(PriceRangeData *)price   backInfoMessage:(void (^)(NSMutableString * string))block
{
    self.allTypeBlock = block;
    
    NSString *soapMsg=[NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetPriceRange xmlns=\"http://tempuri.org/\"><PriceType>%@</PriceType><userid>%@</userid><token>%@</token></GetPriceRange></soap:Body></soap:Envelope>",price.PriceType,price.userid,price.token];
    NSURL *url=[NSURL URLWithString:PL_USER_ROOMLIST];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMsg length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/GetPriceRange" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *CustomDetailConnection=[NSURLConnection connectionWithRequest:request delegate:self];
    [CustomDetailConnection start];
}
#pragma mark 请求房源图片信息
-(void)getImageInfo:(NSString *)propertyID  proMode:(NSString *)mode userID:(NSString *)userid userToken:(NSString *)userToken callBack:(void (^)(UIImage   * image))iamgeblock string:(void (^)(NSString *))block
{
    self.blockUploadImage = nil;
    self.blockUploadImage = block;
    //  NSBlockOperation * iamge = [NSBlockOperation blockOperationWithBlock:^{
    NSString * soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetHouseImage xmlns=\"http://tempuri.org/\"><PropertyId>%@</PropertyId><Mode>%@</Mode><userid>%@</userid><token>%@</token></GetHouseImage></soap:Body></soap:Envelope>",propertyID,mode,userid,userToken];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_ROOMLIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
            }
            else
            {
                
                NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                if ([string isEqualToString:@"[]"])
                {
                    self.blockUploadImage(string);
                    
                }
                else if(string.length)
                {
                    self.blockUploadImage(string);
                }
                NSLog(@"+++++%@",signArray);
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
    }];
}
#pragma mark 返回房源价格区间
-(void)returnRoomPriceRange:(PriceRangeData *)price callBackArray:(void (^)(NSMutableString * string))block
{
    self.allTypeBlock = block;
    
    NSString *soapMsg=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://as.xmlsoap.org/soap/envelope/\"><soap:Body><GetPriceRange xmlns=\"http://tempuri.org/\"><PriceType>%@</PriceType><userid>%@</userid><token>%@</token></GetPriceRange></soap:Body></soap:Envelope>",price.PriceType,price.userid,price.token];
    NSURL *url=[NSURL URLWithString:PL_USER_ROOMLIST];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMsg length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/GetPriceRange" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *CustomDetailConnection=[NSURLConnection connectionWithRequest:request delegate:self];
    [CustomDetailConnection start];
    
}
#pragma mark 请求行政区
-(void)requestAreaInfoMessage:(NSString *)areaKind roomDistrictId:(NSString *)districtId roomDisName:(NSString *)districetName mode:(NSString *)mode userName:(NSString *)userid userTokne:(NSString *)token backInfoMessage:(void (^)(NSMutableArray * array))block
{
    self.blockAreaArray = block;
    
    
    
    NSString * soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetArea xmlns=\"http://tempuri.org/\"><AreaKind>%@</AreaKind><DistrictId>%@</DistrictId><DistrictName>%@</DistrictName><mode>%@</mode><userid>%@</userid><token>%@</token></GetArea></soap:Body></soap:Envelope>",areaKind,districtId,districetName,mode,userid,token];
    NSURL *url=[NSURL URLWithString:PL_USER_ROOMLIST];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/GetArea" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    connection=[NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
    
}
#pragma mark 客源写跟进
-(void)getAddCustomersFollow:(CustomersFollowData *)follow   backInfoMessage:(void (^)(NSMutableString * string))block
{
    self.blockCall = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\"><soap12:Body><GetAddCustomersFollow xmlns=\"http://tempuri.org/\"><CustID>%@</CustID><FollowType>%@</FollowType><Content>%@</Content><FollowWay>%@</FollowWay><CustLevel>%@</CustLevel><FromPort>%@</FromPort><NewId>%@</NewId><userid>%@</userid><token>%@</token></GetAddCustomersFollow></soap12:Body></soap12:Envelope>",follow.CustID,follow.FollowType,follow.Content,follow.FollowWay,follow.CustLevel,@"ios",follow.FollowID,follow.userid,follow.token];
    NSURL *url=[NSURL URLWithString:PL_USER_KEYUAN_LIST];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/GetAddCustomersFollow" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    connection=[NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}

#pragma mark 房源纠错

-(void)addErrorPropertyPropertyId:(NSString *)propertyId PropertyName:(NSString *)propertyName BuildingNo:(NSString *)buildingNo RoomNo:(NSString *)roomNo ErrorContent:(NSString *)errorContent ContentType:(NSString *)contentType OldValue:(NSString *)oldValue NewValue:(NSString *)newValue userid:(NSString *)userid token:(NSString *)usertoken completBack:(void (^)(id))block
{
    self.allTypeBlock = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><AddErrorPro  xmlns=\"http://tempuri.org/\"><PropertyId>%@</PropertyId><PropertyName>%@</PropertyName><BuildingNo>%@</BuildingNo><RoomNo>%@</RoomNo><ErrorContent>%@</ErrorContent><ContentType>%@</ContentType><OldValue>%@</OldValue><NewValue>%@</NewValue><userid>%@</userid><token>%@</token></AddErrorPro></soap:Body></soap:Envelope>",propertyId,propertyName,buildingNo,roomNo,errorContent,contentType,oldValue,newValue,userid,usertoken];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_ADDERRORPRO parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                //NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
                // NSLog(@"+++++%@",signArray);
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
}
#pragma mark 房源写跟进

-(void)addPropertyContact:(ADDPropertyContactData *)contact   backInfoMessage:(void (^)(NSMutableString * string))block
{
    self.allTypeBlock = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><ADDPropertyContact xmlns=\"http://tempuri.org/\"><PropertyId>%@</PropertyId><Content>%@</Content><FollowType>%@</FollowType><FollowWay>%@</FollowWay><NewId>%@</NewId><userid>%@</userid><token>%@</token></ADDPropertyContact></soap:Body></soap:Envelope>",contact.PropertyId,contact.Content,contact.FollowType, contact.FollowWay,contact.followID,contact.userid,contact.token];
    NSURL *url=[NSURL URLWithString:PL_USER_ROOMLIST];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/ADDPropertyContact" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    connection=[NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}
#pragma mark 房源跟进列表
-(void)GetPropertyContactListPropertyId:(NSString *)PropertyId userid:(NSString *)userid token:(NSString *)token string:(void (^)(NSMutableString *))block
{
    self.allTypeBlock = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\"><soap12:Body><GetPropertyContactList xmlns=\"http://tempuri.org/\"><PropertyId>%@</PropertyId><userid>%@</userid><token>%@</token></GetPropertyContactList></soap12:Body></soap12:Envelope>",PropertyId,userid,token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_ROOMLIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                //NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
                // NSLog(@"+++++%@",signArray);
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
    
    //    self.allTypeBlock = block;
    //    NSString * soapMessage = [NSString stringWithFormat:@"<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\"><soap12:Body><GetPropertyContactList xmlns=\"http://tempuri.org/\"><PropertyId>%@</PropertyId><userid>%@</userid><token>%@</token></GetPropertyContactList></soap12:Body></soap12:Envelope>",PropertyId,userid,token];
    //    NSURL *url=[NSURL URLWithString:PL_USER_ROOMLIST];
    //    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    //    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    //    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //    [request addValue:@"http://tempuri.org/GetPropertyContactList" forHTTPHeaderField:@"SOAPAction"];
    //    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    //    [request setHTTPMethod:@"POST"];
    //    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    //    connection=[NSURLConnection connectionWithRequest:request delegate:self];
    //    [connection start];
    
}

//-(void)GetPropertyContactListPropertyId:(NSString *)PropertyId userid:(NSString *)userid token:(NSString *)token string:(void (^)(NSMutableString *))block
//{
//    self.allTypeBlock = block;
//    NSString * soapMessage = [NSString stringWithFormat:@"<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\"><soap12:Body><GetPropertyContactList xmlns=\"http://tempuri.org/\"><PropertyId>%@</PropertyId><userid>%@</userid><token>%@</token></GetPropertyContactList></soap12:Body></soap12:Envelope>",PropertyId,userid,token];
//    NSURL *url=[NSURL URLWithString:PL_USER_ROOMLIST];
//    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
//    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
//    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [request addValue:@"http://tempuri.org/GetPropertyContactList" forHTTPHeaderField:@"SOAPAction"];
//    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    connection=[NSURLConnection connectionWithRequest:request delegate:self];
//    [connection start];
//}
#pragma mark  楼盘详情
-(void)GetEstateDetail:(void (^)(NSMutableString * string))block EstateID:(NSString *)EstateID userid:(NSString *)userid token:(NSString *)token{
    self.blockCall = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetEstateDetail xmlns=\"http://tempuri.org/\"><EstateID>%@</EstateID><userid>%@</userid><token>%@</token></GetEstateDetail></soap:Body></soap:Envelope>",EstateID,userid,token];
    NSURL *url=[NSURL URLWithString:PL_USER_ROOMLIST];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/GetEstateDetail" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    connection=[NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}

#pragma mark  有效房源数量
-(void)GetLegelProperties:(void (^)(NSMutableString * string))block EstateID:(NSString *)EstateID userid:(NSString *)userid token:(NSString *)token{
    self.blockCall = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetLegelProperties xmlns=\"http://tempuri.org/\"><EstateID>%@</EstateID><userid>%@</userid><token>%@</token></GetLegelProperties></soap:Body></soap:Envelope>",EstateID,userid,token];
    NSURL *url=[NSURL URLWithString:PL_USER_ROOMLIST];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/GetLegelProperties" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    connection=[NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}


#pragma mark 跟进方式请求
-(void)GetFollowWayList:(void (^)(NSMutableString * string))block userid:(NSString *)userid token:(NSString *)token{
    self.allTypeBlock = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetFollowWayList xmlns=\"http://tempuri.org/\"><userid>%@</userid><token>%@</token></GetFollowWayList></soap:Body></soap:Envelope>",userid,token];
    NSURL *url=[NSURL URLWithString:PL_USER_KEYUAN_LIST];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/GetFollowWayList" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    connection=[NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}
#pragma mark  跟进类型
-(void)GetFollowTypeList:(void (^)(NSMutableString * string))block userid:(NSString *)userid token:(NSString *)token{
    self.blockCall = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetFollowTypeList xmlns=\"http://tempuri.org/\"><userid>%@</userid><token>%@</token></GetFollowTypeList></soap:Body></soap:Envelope>",userid,token];
    NSURL *url=[NSURL URLWithString:PL_USER_KEYUAN_LIST];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/GetFollowTypeList" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    connection=[NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}

# pragma mark --房源详情---
-(void)GetPropertyDetail:(void (^)(NSMutableString * string))block PropertyId:(NSString *)PropertyId userid:(NSString *)userid token:(NSString *)token
{
    self.blockCall = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetPropertyDetail xmlns=\"http://tempuri.org/\"><PropertyId>%@</PropertyId><userid>%@</userid><token>%@</token></GetPropertyDetail></soap:Body></soap:Envelope>",PropertyId,userid,token];
    NSURL *url=[NSURL URLWithString:PL_USER_ROOMLIST];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/GetPropertyDetail" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    connection=[NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}
//# pragma mark --房源收藏---
//-(void)CollectProperty:(void (^)(NSMutableString * string))block PropertyId:(NSString *)PropertyId Mode:(NSString *)Mode userid:(NSString *)userid token:(NSString *)token
//{
//    self.blockCall = block;
//    NSString * soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><CollectProperty xmlns=\"http://tempuri.org/\"><PropertyID>%@</PropertyID><Mode>%@</Mode><userid>%@</userid><token>%@</token></CollectProperty></soap:Body></soap:Envelope>",PropertyId,Mode,userid,token];
//    NSURL *url=[NSURL URLWithString:PL_USER_ROOMLIST];
//    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
//    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
//    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [request addValue:@"http://tempuri.org/CollectProperty" forHTTPHeaderField:@"SOAPAction"];
//    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//    connection=[NSURLConnection connectionWithRequest:request delegate:self];
//    [connection start];
//}
#pragma mark -- 房源收藏
-(void)CollectPropertyId:(NSString *)PropertyId Mode:(NSString *)Mode userid:(NSString *)userid token:(NSString *)token string:(void (^)(NSMutableString *))block
{
    self.blockCall = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><CollectProperty xmlns=\"http://tempuri.org/\"><PropertyID>%@</PropertyID><Mode>%@</Mode><userid>%@</userid><token>%@</token></CollectProperty></soap:Body></soap:Envelope>",PropertyId,Mode,userid,token];
    NSURL *url=[NSURL URLWithString:PL_USER_ROOMLIST];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/CollectProperty" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    connection=[NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}

# pragma mark --拨打电话---
-(void)DialCustTelephone:(void (^)(NSMutableString * string))block CameraNumber:(NSString *)CameraNumber CustPhone:(NSString *)CustPhone userid:(NSString *)userid token:(NSString *)token
{
    self.allTypeBlock = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><DialCustTelephone xmlns=\"http://tempuri.org/\"><CameraNumber>%@</CameraNumber><CustPhone>%@</CustPhone><userId>%@</userId><token>%@</token></DialCustTelephone></soap:Body></soap:Envelope>",CameraNumber,CustPhone,userid,token];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_NOTICE_LIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                
                NSArray * signArray = [[element stringValue] JSONValue];
                
                self.allTypeBlock(signArray);
                
                NSLog(@"+++++%@",signArray);
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}
#pragma mark --获取房源指定数据
-(void)afGetHouseValueWithPropertyID:(NSString *)propertyid Name:(NSString *)name call:(void (^)(NSMutableString *str))block
{
    self.allTypeBlock = nil;
    self.allTypeBlock = block;
    NSLog(@"%@,%@,%@",propertyid,[PL_USER_STORAGE objectForKey:PL_USER_USERID],[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]);
    NSString * soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetHouseValue xmlns=\"http://tempuri.org/\"><PropertyID>%@</PropertyID><Name>%@</Name><userid>%@</userid><token>%@</token></GetHouseValue></soap:Body></soap:Envelope>",propertyid,name,[PL_USER_STORAGE objectForKey:PL_USER_USERID],[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]] ;
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_ROOMLIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                
                
                NSString * resultValueString = [element stringValue];
                self.allTypeBlock(resultValueString);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
}

#pragma mark --获取房源特点
-(void)afGetHouseMarksWithPropertyID:(NSString *)propertyid call:(void (^)(NSArray *array))block
{
    
    self.blockNSArray = nil;
    self.blockNSArray = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetHouseMarks xmlns=\"http://tempuri.org/\"><PropertyID>%@</PropertyID><userid>%@</userid><token>%@</token></GetHouseMarks></soap:Body></soap:Envelope>",propertyid,[PL_USER_STORAGE objectForKey:PL_USER_USERID],[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]] ;
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_ROOMLIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                
                NSArray * signArray = [[element stringValue] JSONValue];
                
                //                NSMutableString * resultValueString = [NSMutableString stringWithString:[element stringValue]];
                self.blockNSArray(signArray);
                
                //                NSLog(@"+++++%@",signArray.firstObject[@"FastSell"]);
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}
#pragma mark -- 修改房源特点
-(void)afSetHousMarks:(RoomRevisInfo *)info call:(void (^)(NSMutableString *str))block
{
    self.allTypeBlock = nil;
    self.allTypeBlock = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SetHouseMarks xmlns=\"http://tempuri.org/\"><PropertyID>%@</PropertyID><Recommend>%@</Recommend><FastSell>%@</FastSell><School>%@</School><HouseMarks>%@</HouseMarks><userid>%@</userid><token>%@</token></SetHouseMarks></soap:Body></soap:Envelope>",info.properIDString,info.recommendString,info.fastSellString,info.schoolString,info.houseMarksString,[PL_USER_STORAGE objectForKey:PL_USER_USERID],[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]] ;
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_ROOMLIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                
                
                NSString * resultValueString = [element stringValue];
                self.allTypeBlock(resultValueString);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}
#pragma mark --修改房源有效无效
-(void)SetStatusWithPropertyID:(NSString *)propertyid Status:(NSString *)status LastRentDate:(NSString *)lastRentDate call:(void (^)(NSString *str))block
{
    
    self.blockString = nil;
    self.blockString = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SetStatus xmlns=\"http://tempuri.org/\"><PropertyID>%@</PropertyID><Status>%@</Status><LastRentDate>%@</LastRentDate><userid>%@</userid><token>%@</token></SetStatus></soap:Body></soap:Envelope>",propertyid,status,lastRentDate,[PL_USER_STORAGE objectForKey:PL_USER_USERID],[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]] ;
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_ROOMLIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                
                
                NSString * resultValueString = [element stringValue];
                self.blockString(resultValueString);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
    }];
}
#pragma mark --修改房源需求
-(void)afSetHouseUpdate:(RoomRevisInfo *)info call:(void (^)(NSString *str))block
{
    self.blockNeedString = nil;
    self.blockNeedString = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SetHouseUpdate xmlns=\"http://tempuri.org/\"><PropertyID>%@</PropertyID><Price>%@</Price><RentPrice>%@</RentPrice><Days>%@</Days><Decoration>%@</Decoration><Trade>%@</Trade><userid>%@</userid><token>%@</token></SetHouseUpdate></soap:Body></soap:Envelope>",info.properIDString,info.rentpriceString,info.priceString,info.daysString,info.decorationString,info.custom,[PL_USER_STORAGE objectForKey:PL_USER_USERID],[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]] ;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_ROOMLIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                
                
                NSString * resultValueString = [element stringValue];
                self.blockNeedString(resultValueString);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}



#pragma mark --获取房源收藏列表接口

-(void)getPropertyCollectid:(NSString *)userId token:(NSString *)userToken call:(void (^)(NSMutableString *))block
{
    self.blockCall = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetPropertyCollections xmlns=\"http://tempuri.org/\"><userid>%@</userid><token>%@</token></GetPropertyCollections></soap:Body></soap:Envelope>",userId,userToken] ;
    
    
    NSURL *url=[NSURL URLWithString:PL_USER_ROOMLIST];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/GetPropertyCollections" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    connection=[NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
    
}
#pragma mark --客户打卡签到接口
- (void)getSignTimer:(NSString *)signTimer gprsX:(NSString *)x gprs:(NSString *)y userName:(NSString *)user token:(NSString *)token callBack:(void (^)(NSString *))block
{
    self.blockCall = block;
    [connection cancel];
    NSString * soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetUserIsTarget xmlns=\"http://tempuri.org/\"><gpsX>%@</gpsX><gpsY>%@</gpsY><userid>%@</userid><token>%@</token></GetUserIsTarget></soap:Body></soap:Envelope>",x,y,user,token];
    
    
    NSURL *url=[NSURL URLWithString:PL_USER_SIGN];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/GetUserIsTarget" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    connection=[NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
    
}

#pragma mark --网站接口
-(void)GetWebSiteList:(void (^)(NSMutableString * string))block WebSiteMode:(NSString *)WebSiteMode userid:(NSString *)userid token:(NSString *)token
{
    self.blockCall = block;
    [connection cancel];
    NSString * soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetWebSiteList xmlns=\"http://tempuri.org/\"><WebSiteMode>%@</WebSiteMode><userid>%@</userid><token>%@</token></GetWebSiteList></soap:Body></soap:Envelope>",WebSiteMode,userid,token] ;
    NSURL *url=[NSURL URLWithString:PL_USER_INTERNET_ROOT_URL];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/GetWebSiteList" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    connection=[NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
    
}

#pragma mark --考勤
- (void)afGetResaultUser:(NSString *)userid userCookie:(NSString *)token call:(void (^)(id obj))block
{   self.allTypeBlock = nil;
    
    self.allTypeBlock = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetHisSinTime xmlns=\"http://tempuri.org/\"><userid>%@</userid><token>%@</token></GetHisSinTime></soap:Body></soap:Envelope>",userid,token];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_SIGN parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                
                NSArray * signArray = [[element stringValue] JSONValue];
                self.allTypeBlock(signArray);
                
                NSLog(@"+++++%@",signArray);
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
    }];
}
//考勤点击切换
- (void)GetRHHisSinTime:(NSString *)userid token:(NSString *)token hCall:(void (^)(id obj))block
{
    self.allTypeBlock = nil;
    self.allTypeBlock = block;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary * dic = @{@"userid":userid,@"token":token};
    NSString *strURL = [NSString stringWithFormat:@"%@/GetRHHisSinTime",PL_USER_SIGNOR];
    [manager GET:strURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSError *parseError = nil;
        NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:result error:&parseError];
        NSDictionary *s =xmlDictionary[@"string"];
        NSString *sk =  s[@"text"];
        if ([sk isEqualToString:@"[]"]) {
            self.allTypeBlock(sk);
        }else
        {
            NSArray *dicts = (NSArray *)[Tool dictionaryWithJsonString:sk];
            self.allTypeBlock(dicts);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
    }];
}

#pragma mark 套餐申请
-(void)setApplication:(WebData *)web   backInfoMessage:(void (^)(NSMutableString * string))block
{
    self.blockCall = block;
    
    NSString *soapMsg=[NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><setApplication xmlns=\"http://tempuri.org/\"><WebName>%@</WebName><RegisterType>%@</RegisterType><PackageID>%@</PackageID><PackagePrice>%@</PackagePrice><PackageType>%@</PackageType><userid>%@</userid><token>%@</token></setApplication></soap:Body></soap:Envelope>",web.WebName,web.RegisterType,web.PackageID,web.PackagePrice,web.PackageType,web.userid,web.token];
    NSURL *url=[NSURL URLWithString:PL_USER_INTERNET_ROOT_URL];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMsg length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/setApplication" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *CustomDetailConnection=[NSURLConnection connectionWithRequest:request delegate:self];
    [CustomDetailConnection start];
}

#pragma mark 名片申请提交
-(void)BusinessCardInfo:(CardData *)card   backInfoMessage:(void (^)(NSMutableString * string))block
{
    self.blockCall = block;
    
    NSString *soapMsg=[NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><BusinessCardInfo xmlns=\"http://tempuri.org/\"><StaffFlag>%@</StaffFlag><Department>%@</Department><Position>%@</Position><Mobile>%@</Mobile><DeptTel>%@</DeptTel><Fax>%@</Fax><DeptZip>%@</DeptZip><Email>%@</Email><DeptAdd>%@</DeptAdd><PrintNumber>%@</PrintNumber><WeChat>%@</WeChat><Company>%@</Company><WebSite>%@</WebSite><Area>%@</Area><Branch>%@</Branch><userid>%@</userid><token>%@</token></BusinessCardInfo></soap:Body></soap:Envelope>",card.StaffFlag,card.Department,card.Position,card.Mobile,card.DeptTel,card.Fax,card.DeptZip,card.Email,card.DeptAdd,card.PrintNumber,card.WeChat,card.Company,card.WebSite,card.Area,card.Branch,card.userid,card.token];
    NSURL *url=[NSURL URLWithString:PL_USER_CARD_CUMMIT_URL];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMsg length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/BusinessCardInfo" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *cardCummitConnection=[NSURLConnection connectionWithRequest:request delegate:self];
    [cardCummitConnection start];
}


#pragma mark --名片申请
-(void)afGetEmpInfo:(NSString *)userid token:(NSString *)token call:(void (^)(id obj))block
{   self.allTypeBlock = nil;
    
    self.allTypeBlock = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetEmpInfo xmlns=\"http://tempuri.org/\"><userid>%@</userid><token>%@</token></GetEmpInfo></soap:Body></soap:Envelope>",userid,token];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_NOTICE_LIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                
                NSArray * signArray = [[element stringValue] JSONValue];
                self.allTypeBlock(signArray);
                
                NSLog(@"+++++%@",signArray);
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
    }];
    
    
    
    
}


#pragma mark --房源推广

- (void)afGetBroked_idLinePeoperty_ID:(NSString *)propertyID user:(NSString *)useerid usertoken:(NSString *)token call:(void (^)(id))block
{
    self.allTypeBlock = nil;
    
    self.allTypeBlock = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><UploadPropertyLink xmlns=\"http://tempuri.org/\"><PropertyID>%@</PropertyID><userid>%@</userid><token>%@</token></UploadPropertyLink></soap:Body></soap:Envelope>",propertyID,useerid,token];
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_ROOMLIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                
                NSArray * signArray = [[element stringValue] JSONValue];
                self.allTypeBlock(signArray);
                
                NSLog(@"+++++%@",signArray);
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}
#pragma mark --房源纠错
- (void)afHandleRoomSourceUserName:(NSString *)name correctStyle:(NSString *)style content:(NSString *)contentstr userToken:(NSString *)token call:(void (^)(id))block
{
    self.allTypeBlock = nil;
    
    self.allTypeBlock = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><CorrectApply xmlns=\"http://tempuri.org/\"><userid>%@</userid><CorrectType>%@</CorrectType><CorrectContent>%@</CorrectContent><token>%@</token></CorrectApply></soap:Body></soap:Envelope>",name,style,contentstr,token];
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_NOTICE_LIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                
                NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
                NSLog(@"+++++%@",signArray);
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
    
}
//- (void)afShareRoomUploadHouseSourceApi_key:(NSString *)appkey houseSourceSign:(NSString *)sign pramas:(RoomHouseSouseData *)houseData callBack:(void (^)(id))block
//{
//    self.allTypeBlock = nil;
//
//    self.allTypeBlock = block;
//    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><UploadHouseResource xmlns=\"http://tempuri.org/\"><common><api_key>%@</api_key><sign>%@</sign></common><param><broker_id>%d</broker_id><comm_id>%d</comm_id><userDefined>%@</userDefined><trade_type>%d</trade_type><area>%f</area><rooms>%@</rooms><price>%f</price><floor>%@</floor><year>%d</year><fitment>%d</fitment><style>%d</style><exposure>%@</exposure><title>%@</title><description>%@</description><for_lease>%d</for_lease><equipment>%d</equipment><rent_deposit_and_cycle>%@</rent_deposit_and_cycle><share_rent>%d</share_rent><stype>%d</stype><shareType>%d</shareType><shareSex>%d</shareSex><rentType>%d</rentType></param></UploadHouseResource></soap:Body></soap:Envelope>",appkey,sign,houseData.house_Broker_id,houseData.house_Comm_id,houseData.house_userDefined,houseData.house_trade_type,houseData.house_area,houseData.house_Rooms,houseData.house_price,houseData.house_floor,houseData.house_year,houseData.house_fitment,houseData.house_style,houseData.house_exposure,houseData.house_title,houseData.house_description,houseData.house_for_lease,houseData.house_equipment,houseData.house_rent_deposit_and_cycle,houseData.house_share_rent,houseData.house_stype,houseData.house_shareType,houseData.house_shareSex,houseData.house_rentType];
//
//
//
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
//    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
//    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
//        return soapMessage;
//    }];
//    [manager POST:PL_USER_ADD_HOUSER_SOURCE parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@,123++++++++ %@", operation.responseString, response);
//        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
//        GDataXMLElement * xml = [doc rootElement ];
//
//        NSArray * array = [xml children];
//        for (int i=0; i<array.count; i++)
//        {
//            //根据标签名判断
//            GDataXMLElement * element = array[i];
//            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
//                NSLog(@"+++++%@",[element stringValue]);
//
//            }
//            else
//            {
//
//                NSArray * signArray = [[element stringValue] JSONValue];
//                self.allTypeBlock(signArray);
//
//                NSLog(@"+++++%@",signArray);
//
//            }
//        }
//
//
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        // NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
//        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
//
//
//    }];
//
//}
#pragma mark --获取精英标志
- (void)afGetEXcellentFlag_userID:(NSString *)userid userToken:(NSString *)token completBack:(void (^)(id))block
{
    self.allTypeBlock = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><getExcellentStaff xmlns=\"http://tempuri.org/\"><userid>%@</userid><token>%@</token></getExcellentStaff></soap:Body></soap:Envelope>",userid,token];
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_CARD_CUMMIT_URL parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
                NSLog(@"+++++%@",signArray);
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}

#pragma mark --修改意向度
- (void)afUpdateCustLevelCustID:(NSString *)CustID CustLevel:(NSString *)CustLevel  userid:(NSString *)userid userToken:(NSString *)token completBack:(void (^)(id))block
{
    self.allTypeBlock = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><UpdateCustLevel xmlns=\"http://tempuri.org/\"><CustID>%@</CustID><CustLevel>%@</CustLevel><FromPort>%@</FromPort><userid>%@</userid><token>%@</token></UpdateCustLevel></soap:Body></soap:Envelope>",CustID,CustLevel,@"ios",userid,token];
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_KEYUAN_LIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
                NSLog(@"+++++%@",signArray);
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}

#pragma mark --全部跟进
- (void)afGetCustFollowCustID:(NSString *)CustID StartIndex:(NSString *)StartIndex  PageSize:(NSString *)PageSize userid:(NSString *)userid userToken:(NSString *)token completBack:(void (^)(id))block
{
    self.allTypeBlock = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetCustFollow xmlns=\"http://tempuri.org/\"><CustID>%@</CustID><StartIndex>%@</StartIndex><PageSize>%@</PageSize><userid>%@</userid><token>%@</token></GetCustFollow></soap:Body></soap:Envelope>",CustID,StartIndex,PageSize,userid,token];
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_ALL_FOLLOW_URL parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
                // NSLog(@"+++++%@",signArray);
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}

#pragma mark --公客
- (void)afCancelPrivateCustID:(NSString *)CustID userid:(NSString *)userid userToken:(NSString *)token completBack:(void (^)(id))block
{
    self.allTypeBlock = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><CancelPrivate xmlns=\"http://tempuri.org/\"><CustID>%@</CustID><FromPort>%@</FromPort><userid>%@</userid><token>%@</token></CancelPrivate></soap:Body></soap:Envelope>",CustID,@"ios",userid,token];
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_UPDATE_LEVEL_URL parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                //                NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
                // NSLog(@"+++++%@",signArray);
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}



#pragma mark --新增客源

- (void)afCustomCreate:(AddData *)addCustomer callBack:(void (^)(NSMutableString * string))block
{
    self.blockCall = nil;
    
    self.allTypeBlock = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><CustomCreate xmlns=\"http://tempuri.org/\"><userid>%@</userid><CustName>%@</CustName><CustLevel>%@</CustLevel><Sex>%@</Sex><BirthYear>%@</BirthYear><CustTel>%@</CustTel><Remark>%@</Remark><Trade>%@</Trade><DistrictName>%@</DistrictName><AreaID>%@</AreaID><CountF>%@</CountF><CountT>%@</CountT><CountW>%@</CountW><SquareMin>%@</SquareMin><SquareMax>%@</SquareMax><PriceMin>%@</PriceMin><PriceMax>%@</PriceMax><RentalMin>%@</RentalMin><RentalMax>%@</RentalMax><Floor>%@</Floor><PropertyDirection>%@</PropertyDirection><FromPort>%@</FromPort><token>%@</token></CustomCreate></soap:Body></soap:Envelope>",addCustomer.userid,addCustomer.CustName,addCustomer.CustLevel,addCustomer.Sex,addCustomer.BirthYear,addCustomer.CustTel,addCustomer.Remark,addCustomer.Trade,addCustomer.DistrictName,addCustomer.AreaID,addCustomer.CountF,addCustomer.CountT,addCustomer.CountW,addCustomer.SquareMin,addCustomer.SquareMax,addCustomer.PriceMin,addCustomer.PriceMax,addCustomer.RentalMin,addCustomer.RentalMax,addCustomer.Floor,addCustomer.PropertyDirection,@"ios",addCustomer.token];
    
    NSURL *url=[NSURL URLWithString:PL_USER_ADD_CUSTOMER];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/CustomCreate" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *addconnection=[NSURLConnection connectionWithRequest:request delegate:self];
    [addconnection start];
    
}
#pragma mark --获取私客数量
- (void)afGetPriviteCount:(NSString *)name userToken:(NSString *)token completeBack:(void (^)(id))block
{
    self.allTypeBlock = block;
    
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetPirvateCount xmlns=\"http://tempuri.org/\"><userid>%@</userid><token>%@</token></GetPirvateCount></soap:Body></soap:Envelope>",name,token];
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_UPDATE_LEVEL_URL parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}

#pragma mark --获取公客数量
- (void)afGetPublicCount:(NSString *)name userToken:(NSString *)token completeBack:(void (^)(id))block
{
    self.allTypeBlock = block;
    
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetPublicCount xmlns=\"http://tempuri.org/\"><userid>%@</userid><token>%@</token></GetPublicCount></soap:Body></soap:Envelope>",name,token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_UPDATE_LEVEL_URL parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}

#pragma mark 请假申请历史
-(void)GetAskForLeaveGroup_Listmode:(NSString *)mode userid:(NSString *)userid token:(NSString *)token string:(void (^)(NSMutableArray *))block
{
    self.allTypeBlock = block;
    
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetAskForLeaveGroup_List  xmlns=\"http://tempuri.org/\"><mode>%@</mode><userid>%@</userid><token>%@</token></GetAskForLeaveGroup_List ></soap:Body></soap:Envelope>",mode,userid,token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_LEAVE_LIST_URL parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                // NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                NSMutableArray * resultArray= [[NSMutableArray array] mutableCopy];
                
                if ([string isEqualToString:@"[]"])
                {
                    NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                    if (arr.count)
                    {
                        self.allTypeBlock(arr);
                    }
                    return ;
                }
                if([string isEqualToString:@"exception"])
                {
                    PL_ALERT_SHOWNOT_OKAND_YES(string);
                    
                    return;
                }
                if ([string isEqualToString:@"NOLOGIN"])
                {
                    NSLog(@"token 过期，请重新登录");
                    NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                    if (arr.count)
                    {
                        self.allTypeBlock(arr);
                    }
                }
                else
                {
                    if ((NSNull *)string ==[NSNull null])
                    {
                        NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                        self.allTypeBlock(arr);
                    }
                    else
                    {
                        NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
                        NSArray * roomArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        NSLog(@"array====++++   %@",resultArray);
                        
                        for (NSDictionary *dic in roomArr) {
                            HolidayListMode *model = [[HolidayListMode alloc] init];
                            model.saveNo = [dic objectForKey:@"SaveNo"];
                            model.processId = [dic objectForKey:@"ProcessId"];
                            model.reason = [dic objectForKey:@"Reason"];
                            model.summary = [dic objectForKey:@"Summary"];
                            model.StartDate = [[dic objectForKey:@"StartDate"] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
                            [resultArray addObject:model];
                        }
                        self.allTypeBlock(resultArray);
                    }
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
    }];
    
}
#pragma mark 请假修改里的请假详情列表
-(void)GetAskForLeave_ListprocessId:(NSString *)processId userid:(NSString *)userid token:(NSString *)token string:(void (^)(NSMutableArray *array))block
{
    self.allTypeBlock = block;
    
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetAskForLeave_List   xmlns=\"http://tempuri.org/\"><processId>%@</processId><userid>%@</userid><token>%@</token></GetAskForLeave_List  ></soap:Body></soap:Envelope>",processId,userid,token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_LEAVE_LIST_URL parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                // NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                NSMutableArray * resultArray= [[NSMutableArray array] mutableCopy];
                
                if ([string isEqualToString:@"[]"])
                {
                    NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                    if (arr.count)
                    {
                        self.allTypeBlock(arr);
                    }
                    return ;
                }
                if([string isEqualToString:@"exception"])
                {
                    PL_ALERT_SHOWNOT_OKAND_YES(string);
                    
                    return;
                }
                if ([string isEqualToString:@"NOLOGIN"])
                {
                    NSLog(@"token 过期，请重新登录");
                    NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                    if (arr.count)
                    {
                        self.allTypeBlock(arr);
                    }
                }
                else
                {
                    if ((NSNull *)string ==[NSNull null])
                    {
                        NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                        self.allTypeBlock(arr);
                    }
                    else
                    {
                        //
                        if ([string isEqualToString:@"1"]||[string isEqualToString:@"exception"]) {
                            
                            [resultArray addObject:string];
                            
                        }else
                        {
                            NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
                            NSArray * roomArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                            NSLog(@"array====++++   %@",resultArray);
                            
                            for (NSDictionary *dic in roomArr) {
                                SingleHoulidayModel *model = [[SingleHoulidayModel alloc] init];
                                model.Type_Str = [dic objectForKey:@"Character01"];
                                model.Star_Time = [dic objectForKey:@"StartDate"];
                                model.End_Time = [dic objectForKey:@"EndDate"];
                                [resultArray addObject:model];
                            }
                        }
                        self.allTypeBlock(resultArray);
                    }
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
    }];
    
}
#pragma mark--培训申请请假提交
-(void)LessonLeaveLessonNo:(NSString*)LessonNo LessonName:(NSString*)LessonName LessonType:(NSString*)LessonType LessonTypeName:(NSString*)LessonTypeName Reason:(NSString*)Reason Userid:(NSString*)Userid Token:(NSString*)Token completeBack:(void (^)(id))block
{
    self.allTypeBlock = block;
    
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><LessonLeave  xmlns=\"http://tempuri.org/\"><LessonNo>%@</LessonNo><LessonName>%@</LessonName><LessonType>%@</LessonType><LessonTypeName>%@</LessonTypeName><Reason>%@</Reason><userid>%@</userid><token>%@</token></LessonLeave  ></soap:Body></soap:Envelope>",LessonNo,LessonName,LessonType,LessonTypeName,Reason,Userid,Token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_leeav parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"LessonLeave"]) {
                NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                //NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
                // NSLog(@"+++++%@",signArray);
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
    
    
    
}
#pragma mark--培训数据查询
-(void)GetLessonListUserid:(NSString*)userid Token:(NSString*)token string:(void (^)(NSMutableArray *))block
{
    self.allTypeBlock = block;
    
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetLessonList xmlns=\"http://tempuri.org/\"><userid>%@</userid><token>%@</token></GetLessonList></soap:Body></soap:Envelope>",userid,token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_GETLIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetLessonList"]) {
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                
                NSString * string = [element stringValue];
                
                NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
                NSArray * roomArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSMutableArray*ResutAttay=[NSMutableArray array];
                for (NSDictionary*dic in roomArr) {
                    TrainingModel*model=[[TrainingModel alloc]init];
                    model.LessonDate=dic[@"LessonDate"];
                    model.LessonName=dic[@"LessonName"];
                    model.LessonTypeName=dic[@"LessonTypeName"];
                    model.LessonNo=dic[@"LessonNo"];
                    model.LessonType=dic[@"LessonType"];
                    
                    [ResutAttay addObject:model];
                    
                }
                
                
                
                self.allTypeBlock(ResutAttay);
                
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
    
}
#pragma mark  请假列表
- (void)afGetEveryDaylLeaveList:(NSString *)name userToken:(NSString *)token string:(void (^)(NSMutableArray *))block
{
    self.allTypeBlock = block;
    
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetEveryDaylLeaveList xmlns=\"http://tempuri.org/\"><userid>%@</userid><token>%@</token></GetEveryDaylLeaveList></soap:Body></soap:Envelope>",name,token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_LEAVE_LIST_URL parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                // NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                NSMutableArray * resultArray= [[NSMutableArray array] mutableCopy];
                
                if ([string isEqualToString:@"[]"])
                {
                    NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                    if (arr.count)
                    {
                        self.allTypeBlock(arr);
                    }
                    return ;
                }
                if([string isEqualToString:@"exception"])
                {
                    PL_ALERT_SHOWNOT_OKAND_YES(string);
                    
                    return;
                }
                if ([string isEqualToString:@"NOLOGIN"])
                {
                    NSLog(@"token 过期，请重新登录");
                    NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                    if (arr.count)
                    {
                        self.allTypeBlock(arr);
                    }
                }
                else
                {
                    if ((NSNull *)string ==[NSNull null])
                    {
                        NSMutableArray * arr = [NSMutableArray arrayWithObjects:string, nil];
                        self.allTypeBlock(arr);
                    }
                    else
                    {
                        NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
                        NSArray * roomArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        NSLog(@"array====++++   %@",resultArray);
                        
                        for (NSDictionary *dic in roomArr) {
                            XJViewModel *model = [[XJViewModel alloc] init];
                            model.type = [dic objectForKey:@"LeaveType"];
                            model.name = [dic objectForKey:@"EmpName"];
                            model.bianhao = [[dic objectForKey:@"ProcessId"] stringValue];
                            model.startDate = [dic objectForKey:@"StartDate"];
                            model.endDate = [dic objectForKey:@"EndDate"];
                            model.reason = [dic objectForKey:@"Reason"];
                            model.flag=[[dic objectForKey:@"ApprovalFlag"] stringValue];
                            [resultArray addObject:model];
                        }
                        self.allTypeBlock(resultArray);
                    }
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
    }];
    
}

#pragma mark  ---选择框

- (void)afGetSelectLeaveInfo:(NSString *)name userToken:(NSString *)token completeBack:(void (^)(id))block
{
    self.allTypeBlock = block;
    
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetSelectLeaveInfo xmlns=\"http://tempuri.org/\"><userid>%@</userid><token>%@</token></GetSelectLeaveInfo></soap:Body></soap:Envelope>",name,token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_LEAVE_LIST_URL parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                NSString * string = [element stringValue];
                self.allTypeBlock(string);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}

#pragma mark --豁免权限
-(void)GetGoutCheckForgetExemptUserid:(NSString*)userid Token:(NSString*)token string:(void (^)(NSString * str))block
{
    self.allTypeBlock=nil;
    self.allTypeBlock=block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><CheckForgetExempt xmlns=\"http://tempuri.org/\"><userid>%@</userid><token>%@</token></CheckForgetExempt></soap:Body></soap:Envelope>",userid,token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_GOTO_URL parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"CheckForgetExempt"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                //NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                // NSLog(@"+++++%@",signArray);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
    
    
    
    
}
#pragma mark ---外出接口
- (void)getSelectForgetDate:(NSString *)date type:(NSString *)timeType OutoPlace:(NSString *)place Reason:(NSString *)reacon Summary:(NSString *)sum userid:(NSString *)userid token:(NSString *)token completeBack:(void (^)(id))block
{
    self.allTypeBlock = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SaveGoOut xmlns=\"http://tempuri.org/\"><ForgetDate>%@</ForgetDate><type>%@</type><OutofPlace>%@</OutofPlace><Reason>%@</Reason><Summary>%@</Summary><userid>%@</userid><token>%@</token></SaveGoOut></soap:Body></soap:Envelope>",date,timeType,place,reacon,sum,userid,token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_GOTO_URL parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                //NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                // NSLog(@"+++++%@",signArray);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}
#pragma mark -- 房源缺失登记
-(void)roomLostEstateName:(NSString *)estateName EstateAddress:(NSString *)estateAddress DistrictName:(NSString *)districtName userid:(NSString *)name token:(NSString *)token  completeBack:(void (^)(id))block
{
    self.allTypeBlock = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetProDataLoseInfo  xmlns=\"http://tempuri.org/\"><EstateName>%@</EstateName><EstateAddress>%@</EstateAddress><DistrictName>%@</DistrictName><userid>%@</userid><token>%@</token></GetProDataLoseInfo></soap:Body></soap:Envelope>",estateName,estateAddress,districtName,name,token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_LOST_URL parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                //NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
                // NSLog(@"+++++%@",signArray);
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
    
}
#pragma mark- 请假申请修改
-(void)updateLeaveLeaveType:(NSString *)leaveType StartDate:(NSString *)startDate EndDate:(NSString *)endDate Reason:(NSString *)reason UpdateType:(NSString *)updateType Hours:(NSString *)hours OldSaveNo:(NSString *)oldSaveNo OldStartDate:(NSString *)oldStartDate ImageFlg:(NSString *)imageFlg Imagebytes:(NSString *)imagebytes userid:(NSString *)name token:(NSString *)token completeBack:(void (^)(id))block
{
    self.allTypeBlock = block;
    
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><UpdateLeave xmlns=\"http://tempuri.org/\"><LeaveType>%@</LeaveType><StartDate>%@</StartDate><EndDate>%@</EndDate><Reason>%@</Reason><UpdateType>%@</UpdateType><Hours>%@</Hours><OldSaveNo>%@</OldSaveNo><OldStartDate>%@</OldStartDate><ImageFlg>%@</ImageFlg><imagebytes>%@</imagebytes><FromPort>%@</FromPort><userid>%@</userid><token>%@</token></UpdateLeave></soap:Body></soap:Envelope>",leaveType,startDate,endDate,reason,updateType,hours,oldSaveNo,oldStartDate,imageFlg,imagebytes,@"ios",name,token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_UPDATELEAVE parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                //NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
                // NSLog(@"+++++%@",signArray);
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
    
}
#pragma mark -----请假申请

- (void)afGetLeaveLeaveType:(NSString *)LeaveType StartDate:(NSString *)StartDate EndDate:(NSString *)EndDate Reason:(NSString *)Reason ImageFlg:(NSString *)imageFlg Imagebytes:(NSString *)imagebytes userid:(NSString *)name token:(NSString *)token  completeBack:(void (^)(id))block
{
    self.allTypeBlock = block;
    
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetLeave xmlns=\"http://tempuri.org/\"><LeaveType>%@</LeaveType><StartDate>%@</StartDate><EndDate>%@</EndDate><Reason>%@</Reason><ImageFlg>%@</ImageFlg><imagebytes>%@</imagebytes><FromPort>%@</FromPort><userid>%@</userid><token>%@</token></GetLeave></soap:Body></soap:Envelope>",LeaveType,StartDate,EndDate,Reason,imageFlg,imagebytes,@"ios",name,token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_LEAVE_LIST_URL parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.allTypeBlock([element stringValue]);
            }
            else
            {
                
                //NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                self.allTypeBlock(string);
                
                
                // NSLog(@"+++++%@",signArray);
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}

- (void)afCompleteLink_user:(NSString *)string user_Token:(NSString *)token completeBack:(void (^)(NSString *  obj))block
{
    self.blockString = block;
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetEstateSpell xmlns=\"http://tempuri.org/\"><userid>%@</userid><token>%@</token></GetEstateSpell></soap:Body></soap:Envelope>",string,token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapMessage.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:PL_USER_ROOMLIST parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"getExcellentStaffResult"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                self.blockString([element stringValue]);
            }
            else
            {
                
                //NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                
                NSLog(@"++++++++++++>>>>>>>>>>>>>>%@",string);
                
                self.blockString(string);
                
                
                // NSLog(@"+++++%@",signArray);
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
}


-(void)disConnect
{
    [connection cancel];
    self.delegate = nil;
    
}
//
#pragma mark NSURLConnection DataDelegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _resultData = [NSMutableData data];
    [_resultData setLength:0];
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_resultData appendData:data];
    });
    
    
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *theXML = [[NSString alloc] initWithBytes: [_resultData mutableBytes] length:[_resultData length] encoding:NSUTF8StringEncoding];
        NSLog(@"====++%@",theXML);
        // PL_PROGRESS_DISMISS;
        
        _xmlParser = [[NSXMLParser alloc]initWithData:_resultData];
        
        [_xmlParser setDelegate:self];
        [_xmlParser setShouldResolveExternalEntities:YES];
        [_xmlParser parse];
        _resultData  = nil;
        
    });
    
    
    
    
    
}




#pragma mark --请假上传图片
-(void)holiDayUpDowloadData:(NSString *)upDataImage userid:(NSString *)userid Token:(NSString *)token uPpic:(void (^)(NSString *))block
{
    self.blockUploadImage = nil;
    self.blockUploadImage = block;
    NSString * soapString =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><UploadLeavePic xmlns=\"http://tempuri.org/\"><imagebytes>%@</imagebytes><userid>%@</userid><token>%@</token></UploadLeavePic></soap:Body></soap:Envelope>",upDataImage,userid,token];
    //    NSURL *url=[NSURL URLWithString:PL_USER_ROOMLIST];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)soapString.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapString;
    }];
    [manager POST:PL_USER_UPLOADLEAVEPIC parameters:soapString success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@,123++++++++ %@", operation.responseString, response);
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithXMLString:operation.responseString options:0 error:nil];
        GDataXMLElement * xml = [doc rootElement ];
        NSArray * array = [xml children];
        for (int i=0; i<array.count; i++)
        {
            //根据标签名判断
            GDataXMLElement * element = array[i];
            if ([[element name] isEqualToString:@"GetHisSinTimeResult"]) {
                NSLog(@"+++++%@",[element stringValue]);
                
            }
            else
            {
                
                NSArray * signArray = [[element stringValue] JSONValue];
                NSString * string = [element stringValue];
                if ([string isEqualToString:@"[]"])
                {
                    self.blockUploadImage(string);
                    
                }
                else if(string.length)
                {
                    
                    self.blockUploadImage(string);
                }
                
                
                
                NSLog(@"+++++%@",signArray);
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        NSLog(@"%@",error);
        
    }];
    
}

#pragma mark ---XML解析
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    _soapResults = nil;
#pragma mark登录
    if ([elementName isEqualToString:@"LoginResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
        
        
    }
#pragma mark -- 公告数据xml 解析
    else if ([elementName isEqualToString:@"GetNoticeListResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
#pragma mark修改密码
    else if([elementName isEqualToString:@"ChangePassWordResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
#pragma mark更多筛选
    else if([elementName isEqualToString:@"GetPropertyAddChosenResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
    //房源列表
    else if([elementName isEqualToString:@"GetPropertyListResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
    //客源列表
    else if([elementName isEqualToString:@"GetCustomListResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
    //客源详情
    else if([elementName isEqualToString:@"GetCustomDetailResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
#pragma mark 房源详情
    else if([elementName isEqualToString:@"GetPropertyDetailResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
    
#pragma mark ---申请提交
    else if ([elementName isEqualToString:@"BusinessCardInfoResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
    
#pragma mark 客源新增
    else if([elementName isEqualToString:@"CustomCreateResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
#pragma mark---跟进方式----
    else if([elementName isEqualToString:@"GetFollowWayListResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
#pragma mark---跟进类型----
    else if([elementName isEqualToString:@"GetFollowTypeListResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
    else if ([elementName isEqualToString:@"GetEmpInfoResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
    //行政区
    else if ([elementName isEqualToString:@"GetAreaResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
    //价格区间
    else if ([elementName isEqualToString:@"GetPriceRangeResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
    //房源图片
    else if ([elementName isEqualToString:@"GetHouseImageResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
    //房源图片
    else if ([elementName isEqualToString:@"CollectPropertyResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
    
#pragma mark 客源写跟进
    else if ([elementName isEqualToString:@"GetAddCustomersFollowResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
    //房源写跟进
    else if ([elementName isEqualToString:@"ADDPropertyContactResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
    
    //客源跟进列表
    else if ([elementName isEqualToString:@"GetCustFollowResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
            
        }
        recordResults  = YES;
    }
    //房源跟进列表
    else if ([elementName isEqualToString:@"GetPropertyContactListResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
            
        }
        recordResults  = YES;
    }
    
    //上传图片返回
    else if([elementName isEqualToString:@"UploadPropertyPicResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
        
        
        
    }
#pragma  mark  楼盘详情
    else if([elementName isEqualToString:@"GetEstateDetailResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
#pragma  mark  有效房源数量
    else if([elementName isEqualToString:@"GetLegelPropertiesResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
    
#pragma  mark  拨打电话
    else if([elementName isEqualToString:@"DialCustTelephoneResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
    else if ([elementName isEqualToString:@"GetPropertyCollectionsResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
#pragma mark --签到开始标签
    else if ([elementName isEqualToString:@"GetUserIsTargetResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
    
#pragma mark --网站xml
    else if ([elementName isEqualToString:@"GetWebSiteListResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
    
#pragma mark --套餐申请xml
    else if ([elementName isEqualToString:@"setApplicationResult"])
    {
        if (!_soapResults)
        {
            _soapResults  = [[NSMutableString alloc]init];
            
        }
        recordResults  = YES;
    }
    
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    // dispatch_async(dispatch_get_main_queue(), ^{
    if (recordResults)
    {
        [_soapResults appendString:string];
        
    }
    
    
}

#pragma mark-------------------------------分割线---------------------
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"LoginResult"])
    {
        
        
        recordResults = NO;
        self.allTypeBlock(_soapResults);
        
    }
#pragma mark --公告数据解析结束
    else if ([elementName isEqualToString:@"GetNoticeListResult"])
    {
        recordResults = NO;
        //NSLog(@"soap==%@",_soapResults);
        //self.blockCall(nil);
        
        SBJSON *json=[[SBJSON alloc]init];
        NSMutableArray *soapDic=[json objectWithString:_soapResults error:nil];
        NSSortDescriptor * descriptor =[[NSSortDescriptor alloc]initWithKey:@"PublishTitle" ascending:YES];
        
        // NSMutableArray * orderArray = [NSMutableArray arrayWithArray:dict];
        NSArray * sortDes = [NSArray arrayWithObject:descriptor];
        
        [soapDic sortedArrayUsingDescriptors:sortDes];
        self.blockArray(soapDic);
        
        
        
        
        
        
    }
    //修改密码
    else if ([elementName isEqualToString:@"ChangePassWordResult"])
    {
        recordResults = NO;
        
        
        self.blockCall(_soapResults);
        
        
        
        
    }
    //申请提交
    else if ([elementName isEqualToString:@"BusinessCardInfoResult"])
    {
        recordResults = NO;
        
        //self.blockCall(_soapResults);
        
        self.blockCall(_soapResults);
        
        
    }
    
#pragma mark 更多筛选
    else if ([elementName isEqualToString:@"GetPropertyAddChosenResult"])
    {
        recordResults = NO;
        
        self.blockCall(_soapResults);
        
        
    }
#pragma mark --房源列表
    else if ([elementName isEqualToString:@"GetPropertyListResult"])
    {
        recordResults = NO;
        _soapResults = nil;
        self.blockArray = nil;
        
        //self.blockCall= nil;
        
    }
    //客源列表
    else if ([elementName isEqualToString:@"GetCustomListResult"])
    {
        recordResults = NO;
        // NSLog(@"soap==%@",_soapResults);
        
        
        self.allTypeBlock(_soapResults);
        
        _soapResults = nil;
        self.blockCall=nil;
    }
    //价格区间
    else if ([elementName isEqualToString:@"GetPriceRangeResult"])
    {
        recordResults = NO;
        // NSLog(@"soap==%@",_soapResults);
        
        self.allTypeBlock(_soapResults);
        
        _soapResults = nil;
        self.blockCall=nil;
    }
    //客源详情
    else if ([elementName isEqualToString:@"GetCustomDetailResult"])
    {
        recordResults = NO;
        //NSLog(@"soap==%@",_soapResults);
        
        self.allTypeBlock(_soapResults);
        
        _soapResults = nil;
        self.blockCall = nil;
        
    }
#pragma mark 房源详情
    else if ([elementName isEqualToString:@"GetPropertyDetailResult"])
    {
#warning 错误崩溃！！
        recordResults = NO;
        // NSLog(@"soap==%@",_soapResults);
        
        self.blockCall(_soapResults);
        
        _soapResults = nil;
        self.blockCall = nil;
        
    }
#pragma mark 房源收藏
    else if ([elementName isEqualToString:@"CollectPropertyResult"])
    {
        recordResults = NO;
        //NSLog(@"soap==%@",_soapResults);
        
        self.blockCall(_soapResults);
        
        _soapResults = nil;
        self.blockCall = nil;
        
    }
#pragma mark---跟进方式结果----
    else if ([elementName isEqualToString:@"GetFollowWayListResult"])
    {
        recordResults = NO;
        //NSLog(@"soap==%@",_soapResults);
        
        self.allTypeBlock(_soapResults);
        
        _soapResults = nil;
        self.blockCall = nil;
        
    }
#pragma mark---跟进类型结果----
    else if ([elementName isEqualToString:@"GetFollowTypeListResult"])
    {
        recordResults = NO;
        //NSLog(@"soap==%@",_soapResults);
        //self.blockCall(_soapResults);
        
        self.blockCall(_soapResults);
        
        _soapResults = nil;
        self.blockCall = nil;
        
    }
    //客源写跟进
    else if ([elementName isEqualToString:@"GetAddCustomersFollowResult"])
    {
        recordResults = NO;
        //NSLog(@"soap==%@",_soapResults);
        
        self.blockCall(_soapResults);
        
        _soapResults = nil;
        self.blockCall = nil;
    }
    //客源跟进列表
    else if ([elementName isEqualToString:@"GetCustFollowResult"])
    {
        recordResults = NO;
        //NSLog(@"soap==%@",_soapResults);
        //self.allTypeBlock(_soapResults);
        
        self.allTypeBlock(_soapResults);
        
        _soapResults = nil;
        self.blockCall = nil;
        
    }
    //房源写跟进
    else if ([elementName isEqualToString:@"ADDPropertyContactResult"])
    {
        recordResults = NO;
        //NSLog(@"soap==%@",_soapResults);
        
        self.allTypeBlock(_soapResults);
        
        
        _soapResults = nil;
        self.blockCall = nil;
    }
    //房源跟进列表
    else if ([elementName isEqualToString:@"GetPropertyContactListResult"])
    {
        recordResults = NO;
        // NSLog(@"soap==%@",_soapResults);
        
        self.allTypeBlock(_soapResults);
        
        
        _soapResults = nil;
        self.blockCall = nil;
        
    }
#pragma mark  楼盘详情
    else if ([elementName isEqualToString:@"GetEstateDetailResult"])
    {
        recordResults = NO;
        NSLog(@"soap==%@",_soapResults);
        
        self.allTypeBlock(_soapResults);
        
        
        _soapResults = nil;
        self.blockCall = nil;
        
    }
#pragma mark  有效房源数量
    else if ([elementName isEqualToString:@"GetLegelPropertiesResult"])
    {
        recordResults = NO;
        NSLog(@"soap==%@",_soapResults);
        //self.blockCall(_soapResults);
        
        self.blockCall(_soapResults);
        
        
        _soapResults = nil;
        self.blockCall = nil;
        
    }
    
#pragma mark  网站结果
    else if ([elementName isEqualToString:@"GetWebSiteListResult"])
    {
        recordResults = NO;
        NSLog(@"soap==%@",_soapResults);
        
        self.blockCall(_soapResults);
        
        _soapResults = nil;
        self.blockCall = nil;
        
    }
    
#pragma mark  网站申请结果
    else if ([elementName isEqualToString:@"setApplicationResult"])
    {
        recordResults = NO;
        NSLog(@"soap==%@",_soapResults);
        
        self.blockCall(_soapResults);
        
        
        _soapResults = nil;
        self.blockCall = nil;
        
    }
    
#pragma mark  新增客源
    else if ([elementName isEqualToString:@"CustomCreateResult"])
    {
        recordResults = NO;
        NSLog(@"soap==%@",_soapResults);
        // self.allTypeBlock(_soapResults);
        
        self.allTypeBlock(_soapResults);
        
        
        _soapResults = nil;
        self.blockCall = nil;
        
    }
#pragma mark  打电话
    else if ([elementName isEqualToString:@"DialCustTelephoneResult"])
    {
        recordResults = NO;
        NSLog(@"soap==%@",_soapResults);
        
        //self.allTypeBlock(_soapResults);
        self.blockCall(_soapResults);
        
        _soapResults = nil;
        self.blockCall = nil;
        
    }
    
    
    else if ([elementName isEqualToString:@"GetEmpInfoResult"])
    {
        recordResults = NO;
        _string  = _soapResults;
        if (self.delegate && [self.delegate respondsToSelector:@selector(compareResults:dict:)])
        {
            [delegate compareResults:_soapResults dict:nil];
            
            
        }
        
        //self.allTypeBlock(_soapResults);
        self.blockCall(_soapResults);
        
        
        self.blockCall = nil;
        self.delegate = nil;
        _soapResults = nil;
        
        
    }
    //行政区
    else if ([elementName isEqualToString:@"GetAreaResult"])
    {
        recordResults = NO;
        
        
        NSData * data = [_soapResults dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSArray * array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray * diction = [NSMutableArray array];
        if (array && [array isKindOfClass:[NSMutableArray class]])
        {
            for (NSDictionary * dict in array)
            {
                roomAreaPlace * areaPlace = [[roomAreaPlace alloc]init];
                areaPlace.areaDistrictId =[dict objectForKey:@"AreaName"];
                areaPlace.areaDistrictName = [dict objectForKey:@"AreaName"];
                [diction addObject:areaPlace];
                
            }
            
        }
        self.blockAreaArray (diction);
        
        
        
        
        
        
    }
    //房源图片
    else if ([elementName isEqualToString:@"GetHouseImageResult"])
    {
        recordResults = NO;
        
        
        if (![_soapResults isEqualToString:@"[]"])
        {
            
            
        }
        else
        {
            self.iamgeBlock(nil);
            
        }
        
        
        self.blockCall(_soapResults);
        
        
        
        
        
        
        
        
    }
    else if ([elementName isEqualToString:@"UploadPropertyPicResult"])
    {
        recordResults = NO;
        
        
        
        self.allTypeBlock(_soapResults);
        
    }
    else if ([elementName isEqualToString:@"GetPropertyCollectionsResult"])
    {
        
        
        self.blockCall(_soapResults);
        
        
    }
    
    
#pragma mark --签到结尾节点
    else if ([elementName isEqualToString:@"GetUserIsTargetResult"])
    {
        
        
        
        self.blockCall(_soapResults);
        
        
    }
    
    [self disConnect];
    
    
    
}
-(BOOL)isLoginCheckTokenExist
{
    if (PL_USER_TOKEN && [PL_USER_STORAGE objectForKey:PL_USER_TOKEN] )
    {
        return YES;
    }
    else
    {
        return NO;
        
    }
}

@end
