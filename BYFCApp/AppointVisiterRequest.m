//
//  AppointVisiterRequest.m
//  BYFCApp
//
//  Created by zzs on 14/12/4.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import "AppointVisiterRequest.h"
#import "JSON.h"
@implementation AppointVisiterRequest
static  AppointVisiterRequest * __defaultRequest=nil;
@synthesize delegate;

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
    //    @synchronized(self){
    //        __defaultRequest = [[MyRequest alloc]init];
    //
    //    }
    //    return __defaultRequest;
    
}
-(void)getWebServiceData:( void (^)(NSDictionary * dict) )block CustID:(NSString *)CustID userid:(NSString *)userid TOken:(NSString *)TOken
{
    self.block = block;
    NSString *soapMsg=[NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetCustomersListDetail xmlns=\"http://tempuri.org/\"><CustID>%@</CustID><userid>%@</userid><token>%@</token></GetCustomersListDetail></soap:Body></soap:Envelope>",@"071116150326B81E90ACF64A053E3F08",@"",[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"]];
    NSURL *url=[NSURL URLWithString:PL_USER_PRICE_LOE_HEIGHT_URL];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    NSString *msgLength=[NSString stringWithFormat:@"%lu",(unsigned long)[soapMsg length]];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/GetCustomersListDetail" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
//    NSURLConnection *connection=[NSURLConnection connectionWithRequest:request delegate:self];
    
    //如果连接已经建好，则初始化data
       
    
}
-(void)disConnect
{
    [connection cancel];
    
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
    [_resultData appendData:data];
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *theXML = [[NSString alloc] initWithBytes: [_resultData mutableBytes] length:[_resultData length] encoding:NSUTF8StringEncoding];
    NSLog(@"====%@",theXML);
    _xmlParser = [[NSXMLParser alloc]initWithData:_resultData];
    [_xmlParser setDelegate:self];
    [_xmlParser setShouldResolveExternalEntities:YES];
    [_xmlParser parse];
    _resultData  = nil;
    [self disConnect];
    
}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"GetCustomersListDetailResult"])
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
    if (recordResults)
    {
        [_soapResults appendString:string];
        
    }
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"GetCustomersListDetailResult"])
    {
        recordResults = FALSE;
        _string  = _soapResults;
        NSLog(@"soap=======%@",_soapResults);
        //_string  = _soapResults;
        SBJSON *json=[[SBJSON alloc]init];
        NSArray *array=[json objectWithString:_soapResults error:nil];
        NSDictionary *soapDic=[array objectAtIndex:0];
        //字典写入文件
        //        NSArray *pathArr=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        //        NSString *dataPath=[pathArr objectAtIndex:0];
        //        NSString *filePath=[dataPath stringByAppendingPathComponent:@"soapfile.plist"];
        //        [soapDic writeToFile:filePath atomically:YES];
        if ([self.delegate respondsToSelector:@selector(compareResults: dict:)])
        {
            [self.delegate compareResults:_soapResults dict:soapDic ];
            
            
        }
        self.block(soapDic);
        
        //    }
        _soapResults = nil;
        
    }
    
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