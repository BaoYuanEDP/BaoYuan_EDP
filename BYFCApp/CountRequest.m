//
//  CountRequest.m
//  BYFCApp
//
//  Created by zzs on 14/12/24.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import "CountRequest.h"
#import "PL_Header.h"
static CountRequest *_defaultRequest=nil;
@implementation CountRequest

+(instancetype)defaultsRequest
{
    
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _defaultRequest = [[[self class]alloc]init];
        
    });
    return _defaultRequest;
    
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
    if ([elementName isEqualToString:@"GetLegelPropertiesResult"])
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
-(void)parser:(NSXMLParser *)parser didEndElement:(NSMutableString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"GetLegelPropertiesResult"])
    {
        recordResults = NO;
        //NSLog(@"soap==%@",_soapResults);
        self.blockCall(_soapResults);
        _soapResults = nil;
        self.blockCall = nil;
    }
}
@end
