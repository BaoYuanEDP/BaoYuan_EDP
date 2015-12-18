//
//  GetHouseImage.m
//  BYFCApp
//
//  Created by zzs on 15/1/4.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "GetHouseImage.h"
#import "PL_Header.h"
static GetHouseImage *_defaultRequest=nil;
@implementation GetHouseImage

+(instancetype)defaultsRequest
{
    
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _defaultRequest = [[[self class]alloc]init];
        
    });
    return _defaultRequest;
    
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    _defaultRequest = [super allocWithZone:zone ];
    
    return _defaultRequest;
    
}
-(void)GetDetailHouseImage:(void (^)(NSMutableString * string))block PropertyId:(NSString *)PropertyId mode:(NSString *)MODE  userid:(NSString *)userid token:(NSString *)token{
    self.allTypeBlock = nil;
    
    self.allTypeBlock = block;
    NSString * soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetDetailHouseImage xmlns=\"http://tempuri.org/\"><PropertyId>%@</PropertyId><userid>%@</userid><token>%@</token></GetDetailHouseImage></soap:Body></soap:Envelope>",PropertyId,userid,token];
    
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
                
                self.allTypeBlock(string);
                
                
                NSLog(@"+++++%@",signArray);
                
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
    //self.delegate = nil;
    
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
        NSLog(@"====%@",theXML);
        _xmlParser = [[NSXMLParser alloc]initWithData:_resultData];
        
        [_xmlParser setDelegate:self];
        [_xmlParser setShouldResolveExternalEntities:YES];
        [_xmlParser parse];
        _resultData  = nil;
        
    });
    
    
    
    
    
}
#pragma mark ---XML解析
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    _soapResults = nil;
#pragma mark  =========
    if ([elementName isEqualToString:@"GetDetailHouseImageResult"])
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
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"GetDetailHouseImageResult"])
    {
        recordResults = NO;
        //NSLog(@"soap==%@",_soapResults);
        if (![_soapResults isEqualToString:@"[]"])
        {
            self.blockCall(_soapResults);
        }
        
        _soapResults = nil;
        self.blockCall = nil;
    }
    
}
@end
