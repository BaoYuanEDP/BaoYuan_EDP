//
//  Utility+Encrypt.m
//  TCTravel_IPhone
//
//  Created by Tracy－jun on 14/11/13.
//
//

#import "Utility+Encrypt.h"
//#import "TCDateFormatter.h"

@implementation Utility (Encrypt)

/*---------------------个人信息加密---------------------*/
//手机电话加密
+(NSString *)encryptPhoneNum:(NSString *)_phoneNum{
    if ([_phoneNum length]>3) {
        NSString *firstNum  = [_phoneNum substringToIndex:3];
        NSString *secondNum = @"";
        if ([_phoneNum length]>7) {
            secondNum = [_phoneNum substringFromIndex:7];
        }
        return [NSString stringWithFormat:@"%@****%@",firstNum,secondNum];
    }else{
        return @"";
    }
}
//判断座机
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    //判断电话区号后面没有－号表达式
    NSString *MOBILE = @"^1(3[0-9]|5[0-9]|8[0-9])\\d{8}$";
    //判断电话区号后面有－号表达式
    NSString *USUALMOBILE = @"(\\d{2,5}-\\d{7,8}(-\\d{1,})?)|(13\\d{9})|(159\\d{8})";
    //判断是否是有效电话号码表达式
    NSString *PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *Usualregextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", USUALMOBILE];
    NSPredicate *regextesPhs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        ||([regextesPhs evaluateWithObject:mobileNum] == YES)||([Usualregextestmobile evaluateWithObject:mobileNum] == YES))
    {
        //有效电话或者手机号
        return YES;
    }
    else
    {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您输入的电话或者手机号码无效,请检查是否输入有误！！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertview show];
        return NO;
    }
}

//证件号加密
+(NSString *)encryptCertNo:(NSString *)_certNo{
    if ([_certNo length]>2) {
        NSString *firstMes   = [_certNo substringToIndex:1];
        NSInteger iNum       = [_certNo length];
        NSString *thirdMes   = [_certNo substringFromIndex:iNum-1];
        NSString *secondeMes = @"";
        for (int i=0; i<iNum-2; i++) {
            secondeMes = [NSString stringWithFormat:@"%@*",secondeMes];
        }
        return [NSString stringWithFormat:@"%@%@%@",firstMes,secondeMes,thirdMes];
    }else{
        return _certNo;
    }
}

//邮箱加密
+(NSString *)encryptEmail:(NSString *)_email{
    NSRange range         = [_email rangeOfString:@"@"];
    NSString *strbehindAt = [_email substringFromIndex:range.location];//@后部分
    NSString *strBeforeAt = [_email substringToIndex:range.location-1];//@前部分
    if ([strBeforeAt length]>2) {
        NSString *firstMes = [strBeforeAt substringToIndex:1];
        NSInteger iNum = [strBeforeAt length];
        NSString *thirdMes = [strBeforeAt substringFromIndex:iNum-1];
        NSString *secondMes = @"";
        for (int i=0; i<iNum-2; i++) {
            secondMes = [NSString stringWithFormat:@"%@*",secondMes];
        }
        return [NSString stringWithFormat:@"%@%@%@%@",firstMes,secondMes,thirdMes,strbehindAt];
    }else{
        return _email;
    }
}

//验证用户名
+ (BOOL)checkPersonName:(NSString *)str{
    //    NSString * regex = @"^(?:[\\u4e00-\\u9fa5]*[a-zA-Z]*\\•?\\·?)+$";
    NSString * regex = @"^(?:[\\u4e00-\\u9fa5]*[a-zA-Z]*)+$";
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [prd evaluateWithObject:str];
}

//验证用户名是否有重复字符 规则：包含四个及四个以上连续出现的字符,返回YES，否则返回NO
+ (BOOL)checkPersonNameRepetition:(NSString *)str
{
    NSString * regex = @"^.*(.)\\1{3}.*$";
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [prd evaluateWithObject:str];
}

+ (BOOL)checkIDCard:(NSString *)str{
    //max 2013年以后，15位身份证失效
    if (str==nil||str.length<=0) {
        return NO;
    }
    return checkIDfromchar((char *)[[str uppercaseString] UTF8String]);
}

+(BOOL)checkInterContactNameRule:(NSString *)name
{
    NSString * regex        = @"(^[A-Za-z]*$)";
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:name];
}

//验证用户填写订单时的姓名
+(NSString *)checkUserName:(NSString *)str
{
    NSString *_strErr=@"";
    
    // 全字母 ok
    NSString *regexnext = @"^[A-Za-z]+$";
    NSPredicate *predicatenext = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexnext];
    if ([predicatenext evaluateWithObject:str]) {
        return _strErr;
    }
    
    if ([str isEqualToString:@"先生"]||[str isEqualToString:@"小姐"]||[str isEqualToString:@"女士"]) {
        _strErr=@"姓名中不能含有“先生”、“女士”或“小姐”字词";
    }
    
    if (str.length<=1) {
        _strErr=@"姓名过短，请输入正确姓名";
    }
    
    //不能含有数字或标点符号  @"^[\u4e00-\u9fa5]+$"
    NSString *regex= @"^[a-zA-Z_\u4e00-\u9fa5]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![predicate evaluateWithObject:str]) {
        _strErr=@"姓名中不能含有除汉字、字母以外的其它字符";
    }
    
    return _strErr;
}

+(BOOL)checkNineNumofAtoZandatozRule:(NSString *)name
{
    NSString * regex = @"^[A-Za-z]{8,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:name];
    return isMatch;
}

+(BOOL)isPhoneNumber:(NSString *)phoneNumber
{
    if ([phoneNumber length]==0||phoneNumber==nil||phoneNumber.length<11) {
        return NO;
    }
    NSString *Regex = @"^(13[0-9]|15[0-9]|18[0-9]|17[0-9]|147)\\d{8}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [emailTest evaluateWithObject:phoneNumber];
}

+ (BOOL)isZipCodeNumber:(NSString *)zipCodeNumber{
    if (zipCodeNumber == nil || [zipCodeNumber isEqualToString:@""]) {
        return NO;
    }
    NSString *Regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *zipTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return[zipTest evaluateWithObject:zipCodeNumber];
}

+(BOOL)checkStringChineseEnglish:(NSString *)_str{
    BOOL bNotChinese=NO;
    for (int i =0; i<_str.length; i++) {
        if ([[_str substringWithRange:NSMakeRange(i,1)] dataUsingEncoding:NSASCIIStringEncoding])
        {
            bNotChinese=YES;
        }
        else if (bNotChinese)
        {
            return NO;
        }
    }
    return YES;
}

+(BOOL)checkStringIsChinese:(NSString *)_string
{
    BOOL bChinese=YES;
    for (int i =0; i<_string.length; i++)
    {
        if ([[_string substringWithRange:NSMakeRange(i,1)] dataUsingEncoding:NSASCIIStringEncoding])
        {
            return NO;
        }
        else
        {
            bChinese=YES;
        }
    }
    return bChinese;
}


int checkIDfromchar (const char *sPaperId)
{
    if( 18 != strlen(sPaperId)) return 0;  //检验长度
    long lSumQT =0;
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };   //加权因子
    char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};  //校验码
    //校验数字
    for (int i=0; i<18; i++){
        if ( !isdigit(sPaperId[i]) && !('X' == sPaperId[i] && 17 == i) ) {
            return 0;
        }
    }
    //验证最末的校验码
    for (int i=0; i<=16; i++)  {
        lSumQT += (sPaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != sPaperId[17] ){
        return 0;
    }
    return 1;
}

//判断邮箱是否合法
+(BOOL)validateEmail:(NSString*)email{
    
    if( (0 != [email rangeOfString:@"@"].length) &&  (0 != [email rangeOfString:@"."].length) )
    {
        NSMutableCharacterSet *invalidCharSet = [[[NSCharacterSet alphanumericCharacterSet] invertedSet]mutableCopy];
        [invalidCharSet removeCharactersInString:@"_-"];
        
        NSRange range1 = [email rangeOfString:@"@" options:NSCaseInsensitiveSearch];
        
        // If username part contains any character other than "."  "_" "-"
        
        NSString *usernamePart = [email substringToIndex:range1.location];
        NSArray *stringsArray1 = [usernamePart componentsSeparatedByString:@"."];
        for (NSString *string in stringsArray1) {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet: invalidCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        
        NSString *domainPart = [email substringFromIndex:range1.location+1];
        NSArray *stringsArray2 = [domainPart componentsSeparatedByString:@"."];
        
        for (NSString *string in stringsArray2) {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:invalidCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        
        return YES;
    }
    else // no ''@'' or ''.'' present
        return NO;
}

/*  返回信用卡有效期的年份
 *  返回参数：当前年份往后二十年内
 *
 */
+(NSMutableArray *)getCreditCardExpiryYearArray
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    NSTimeZone *zone=[NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:zone];
    [formatter setDateFormat:@"yyyy"];
    NSInteger year=[[formatter stringFromDate:[NSDate date]] intValue];
    
    NSMutableArray *returnArray=[[NSMutableArray alloc] init];
    for (int i=0; i<20; i++) {
        NSString *strYear=[NSString stringWithFormat:@"%d年",(int)(year+i)];
        [returnArray addObject:strYear];
    }
    
    return returnArray;
}

/*
 *  返回信用卡有效期的月份
 *  返回参数：当月往后到年底
 */

//+(NSMutableArray *)getCreditCardExpiryMonthArray:(NSInteger)_index{
//    if (_index == 0) {
//        NSInteger month = [[TCDateFormatter dateToStringCustom:[NSDate date] formatString:def_Month] integerValue];
//        NSMutableArray *returnArray=[[NSMutableArray alloc] init];
//        for (int i = (int)month; i<=12; i++) {
//            if (i<=9) {
//                NSString *strMonth=[NSString stringWithFormat:@"0%d月",i];
//                [returnArray addObject:strMonth];
//            }else{
//                NSString *strMonth=[NSString stringWithFormat:@"%d月",i];
//                [returnArray addObject:strMonth];
//            }
//        }
//        return returnArray;
//    }else{
//        NSMutableArray *returnArray=[[NSMutableArray alloc] initWithObjects:@"01月",@"02月",@"03月",@"04月",@"05月",@"06月",@"07月",@"08月",@"09月",@"10月",@"11月",@"12月", nil];
//        return returnArray;
//    }
//}


@end
