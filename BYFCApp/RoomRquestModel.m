//
//  RoomRquestModel.m
//  BYFCApp
//
//  Created by Wangpu_IOS on 15/12/5.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import "RoomRquestModel.h"
#import "PL_Header.h"
static RoomRquestModel*_DefalutRquestModel=nil;
@implementation RoomRquestModel

-(instancetype)init
{
    self=[super init];
    return self;
}
/**
 *  创建一个单例的model
 *
 *  @return 返回一个单例
 */
+(RoomRquestModel*)defalutRquestModel
{
    static dispatch_once_t oncequeu;
    
    dispatch_once(&oncequeu, ^{
        
        _DefalutRquestModel=[[self alloc]init];
    });
    return _DefalutRquestModel;
    
}
/**
 *  解析传过来得字典
 *
 *  @param dic 传过来的字典数据
 */
+(RoomRquestModel*)parsedData_Dictionary:(NSDictionary*)dic
{

    RoomRquestModel*model=[RoomRquestModel defalutRquestModel];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
/**
 *  签赔与独家的请求
 *
 *  @param model 传入的字典整合数据
 *  @param block block回调的值
 */
-(void)signatureRquestModel:(NSDictionary *)model BackValue:(void (^)(id,NSString*Result))block
{
    self.CustomBlockAllType=nil;//先置空这个block以免有上一条的数据
    self.CustomBlockAllType=block;//然后把当前传回来得值给这个block
//    发送post请求
    RoomRquestModel*ParsedModel=[RoomRquestModel parsedData_Dictionary:model];
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><UpdateExclusive xmlns=\"http://tempuri.org/\"><PropertyID>%@</PropertyID><PropertyType>%@</PropertyType><PropertyTrust>%@</PropertyTrust><Price>%@</Price><Date>%@</Date><jsonData>%@</jsonData><userid>%@</userid><token>%@</token></UpdateExclusive></soap:Body></soap:Envelope>",ParsedModel.PropertyID,ParsedModel.PropertyType,ParsedModel.PropertyTrust,ParsedModel.Price,ParsedModel.Date,ParsedModel.jsonData,ParsedModel.userid,ParsedModel.token];
    
    
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
            if ([[element name] isEqualToString:@"UpdateExclusive"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                
                self.CustomBlockAllType([element stringValue],[self ExclusiveBalckResult:element.stringValue]);
            }
            else
            {
                NSString * string = [element stringValue];
                /**
                 *  这个你block携带了两个值过去
                 1.返回的正常值
                 2.转换后返回的值
                 */
                self.CustomBlockAllType(string,[self ExclusiveBalckResult:string]);
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];

    
    
    
}
/**
 *  独家与签赔返回值得处理
 *
 *  @param str    请求的返回值
 *  @param Result 转换后的值
 */
-(NSString*)ExclusiveBalckResult:(NSString*)str
{
    if ([str isEqualToString:@"OK1"]) {
        
         return @"成功独家";
    }else if ([str isEqualToString:@"OK2"])
    {
        return @"成功签赔";
        
    }else if ([str isEqualToString:@"OK3"])
    {
        return @"流程审核已发起";
        
    }
    else if ([str isEqualToString:@"OK4"])
    {
        return @"取消独家成功";
        
    }
    else if ([str isEqualToString:@"OK5"])
    {
        return @"取消签赔成功";
        
    }else if ([str isEqualToString:@"ERR1"])
    {
         return @"流程编号存入出错";
        
    }else if ([str isEqualToString:@"ERR2"])
    {
        return @"审核正在处理中，不可发起流程";
        
    }else if ([str isEqualToString:@"ERR3"])
    {
        return @"操作失败，未能发起流程";
        
    }else if ([str isEqualToString:@"ERR4"])
    {
        return @"操作失败";
        
    }else if ([str isEqualToString:@"ERR5"])
    {
        return @"业务员无权取消";
        
    }else if ([str isEqualToString:@"ERR6"])
    {
        return @"非激活人上级无权取消";
        
    }else if ([str isEqualToString:@"exception"])
    {
        return @"奔溃性的错误";
    }
    
    return @"没有对应值";

}
/**
 *  钥匙添加的请求
 *
 *  @param model 传入的字典整合数据
 *  @param block block回调的值
 */

-(void)AddProKeyRquestModel:(NSDictionary *)model BackValue:(void (^)(id, NSString *))block
{
    self.CustomBlockAllType=nil;//先置空这个block以免有上一条的数据
    self.CustomBlockAllType=block;//然后把当前传回来得值给这个block
    //    发送post请求
    RoomRquestModel*ParsedModel=[RoomRquestModel parsedData_Dictionary:model];
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><AddProKey xmlns=\"http://tempuri.org/\"><PropertyID>%@</PropertyID><HouseKey>%@</HouseKey><WhereKey>%@</WhereKey><PasswordKey>%@</PasswordKey><ContactMess>%@</ContactMess><CheckInUserId>%@</CheckInUserId><Remark>%@</Remark><jsonData>%@</jsonData><userid>%@</userid><token>%@</token></AddProKey></soap:Body></soap:Envelope>",ParsedModel.PropertyID,ParsedModel.HouseKey,ParsedModel.WhereKey,ParsedModel.PasswordKey,ParsedModel.ContactMess,ParsedModel.CheckInUserId,ParsedModel.Remark,ParsedModel.jsonData,ParsedModel.userid,ParsedModel.token];
    
    
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
            if ([[element name] isEqualToString:@"UpdateExclusive"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                
                self.CustomBlockAllType([element stringValue],[self AddProKeyBalckResult:element.stringValue]);
            }
            else
            {
                NSString * string = [element stringValue];
                /**
                 *  这个你block携带了两个值过去
                 1.返回的正常值
                 2.转换后返回的值
                 */
                self.CustomBlockAllType(string,[self AddProKeyBalckResult:string]);
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
    
    
    
}
/**
 *  钥匙添加
 *
 *  @param str    请求的返回值
 *  @param Result 转换后的值
 */
-(NSString*)AddProKeyBalckResult:(NSString*)str
{
    if ([str isEqualToString:@"OK1"]) {
        
        return @"流程审核已发起";
    }else if ([str isEqualToString:@"OK2"])
    {
        return @"保存成功";
        
    }else if ([str isEqualToString:@"ERR1"])
    {
        return @"输入的备注信息中包含了关键字";
        
    }else if ([str isEqualToString:@"ERR2"])
    {
        return @"输入的备注信息中包含了电话号码";
        
    }
    else if ([str isEqualToString:@"ERR3"])
    {
        return @"流程编号存入出错";
        
    }
    else if ([str isEqualToString:@"ERR4"])
    {
        return @"该房源的钥匙审核正在处理中，不可发起流程";
        
    }
    else if ([str isEqualToString:@"ERR5"])
    {
        return @"操作失败，未能发起流程";
        
    }
    else if ([str isEqualToString:@"ERR6"])
    {
        return @"保存失败";
        
    }else if ([str isEqualToString:@"exception"])
    {
        return @"奔溃性的错误";
    }
    
    return @"";
    
}
/**
 *  钥匙管理查询
 *
 *  @param model 传入的字典整合数据
 *  @param block block回调的值
 */
-(void)GetHouseKeyListRquestModel:(NSDictionary *)model BackValue:(void (^)(id, NSString *))block
{
    self.CustomBlockAllType=nil;//先置空这个block以免有上一条的数据
    self.CustomBlockAllType=block;//然后把当前传回来得值给这个block
    //    发送post请求
    RoomRquestModel*ParsedModel=[RoomRquestModel parsedData_Dictionary:model];
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetHouseKeyList xmlns=\"http://tempuri.org/\"><PropertyID>%@</PropertyID><userid>%@</userid><token>%@</token></GetHouseKeyList></soap:Body></soap:Envelope>",ParsedModel.PropertyID,ParsedModel.userid,ParsedModel.token];
    
    
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
            if ([[element name] isEqualToString:@"UpdateExclusive"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                
                self.CustomBlockAllType([element stringValue],[self GetHouseKeyListBalckResult:element.stringValue]);
            }
            else
            {
                NSString * string = [element stringValue];
                /**
                 *  这个你block携带了两个值过去
                 1.返回的正常值
                 2.转换后返回的值
                 */
                self.CustomBlockAllType(string,[self GetHouseKeyListBalckResult:string]);
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
    
    
    
}
/**
 *  钥匙管理查询
 *
 *  @param str    请求的返回值
 *  @param Result 转换后的值
 */
-(NSString*)GetHouseKeyListBalckResult:(NSString*)str
{
     if ([str isEqualToString:@"exception"])
    {
        return @"奔溃性的错误";
    }
    
    return @"";
    
}
/**
 *  查询B层经理下的所有分行|分行E层业务员
 *
 *  @param model 传入的字典整合数据
 *  @param block block回调的值
 */

-(void)GetSelectYB_BranchRquestModel:(NSDictionary *)model BackValue:(void (^)(NSMutableArray*))block
{
//    self.CustomBlockNotType=nil;//先置空这个block以免有上一条的数据
    self.allTypeBlock=block;//然后把当前传回来得值给这个block
    //    发送post请求
    RoomRquestModel*ParsedModel=[RoomRquestModel parsedData_Dictionary:model];
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetSelectYB_Branch xmlns=\"http://tempuri.org/\"><WhereKey>%@</WhereKey><userid>%@</userid><token>%@</token></GetSelectYB_Branch></soap:Body></soap:Envelope>",ParsedModel.WhereKey,ParsedModel.userid,ParsedModel.token];
    
    
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
            
            if ([element.name isEqualToString:@"GetSelectYB_BranchResponse"]) {
                //NSLog(@"+++++%@",[element stringValue]);
                
              
            }
            else
            {
                NSString * string = [element stringValue];
                
                
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
                   PL_ALERT_SHOW(@"奔溃性的错误");
                    
                    return;
                }else
                {
                    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
                    NSArray * roomArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    NSMutableArray * resultArray= [NSMutableArray arrayWithArray:roomArr];
                    self.allTypeBlock(resultArray);
                }

                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        PL_ALERT_SHOW(@"数据加载失败，请检查网络");
        
        
        
    }];
    
    
    
    
}
@end
