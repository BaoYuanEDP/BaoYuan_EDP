//
//  CardViewController.m
//  BYFCApp
//
//  Created by zzs on 15/2/2.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "CardViewController.h"
#import "PL_Header.h"
#import "Comon.h"
#define BFONT [UIFont boldSystemFontOfSize:14]
#define SFONT [UIFont systemFontOfSize:10]

@interface CardViewController ()<UIScrollViewDelegate>
{
    BOOL _enterFre;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *backgroundIMV;
@property (weak, nonatomic) IBOutlet UILabel *webtLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailtLabel;
@property (weak, nonatomic) IBOutlet UILabel *faxtLabel;
@property (weak, nonatomic) IBOutlet UILabel *phonetLabel;
@property (weak, nonatomic) IBOutlet UILabel *codetLabel;
@property (weak, nonatomic) IBOutlet UILabel *addresstLabel;
@end

@implementation CardViewController


- (void)viewDidLayoutSubviews
{
//    if ([[UIDevice currentDevice]respondsToSelector:@selector(setOrientation:)])
//    {
//        [[UIDevice currentDevice]performSelector:@selector(setOrientation:) withObject:(__bridge id)((void *)UIInterfaceOrientationLandscapeLeft)];
//
//    }
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    if ([[UIDevice currentDevice]respondsToSelector:@selector(setOrientation:)])
    {
//        [[UIDevice currentDevice]performSelector:@selector(setOrientation:) withObject:(__bridge id)((void *)UIInterfaceOrientationLandscapeLeft)];
    }

    [[MyRequest defaultsRequest]afGetEmpInfo:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME] token:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN] call:^(id obj) {
        if ([obj isKindOfClass:[NSArray class]])
        {
            _signArray = obj;
            NSLog(@"%@",_signArray);
            NSDictionary *dic=[_signArray objectAtIndex:0];
            _name.text=[dic objectForKey:@"User_Name"];
            _bumen.text=[dic objectForKey:@"Org_Display"];
            _zhiwei.text=[dic objectForKey:@"duty_name"];
            _phone.text=[dic objectForKey:@"User_Phone"];
            _gongsi.text=[dic objectForKey:@"Company"];
            _address.text=[dic objectForKey:@"DeptAdd"];
            _youbian.text=[dic objectForKey:@"DeptZip"];
            _dianhua.text=[NSString stringWithFormat:@"86 21-%@",[dic objectForKey:@"DeptTel"]];
            _chuanzhen.text=[NSString stringWithFormat:@"86 21-%@",[dic objectForKey:@"Fax"]];
            _dianyou.text=[dic objectForKey:@"FulEmail"];
            _wangzhi.text=[dic objectForKey:@"WebSite"];
            
            if (PL_HEIGHT <= 480) {
                _name.font = [UIFont systemFontOfSize:11];
                _bumen.font = [UIFont systemFontOfSize:11];
                _zhiwei.font = [UIFont systemFontOfSize:11];
                _phone.font = [UIFont systemFontOfSize:11];
                _address.font = [UIFont systemFontOfSize:11];
                _youbian.font = [UIFont systemFontOfSize:11];
                _dianhua.font = [UIFont systemFontOfSize:11];
                _chuanzhen.font = [UIFont systemFontOfSize:10];
                _dianyou.font = [UIFont systemFontOfSize:11];
                _wangzhi.font = [UIFont systemFontOfSize:11];

            }
            
            senddate=[NSDate date];
            NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
            [dateformatter setDateFormat:@"yyyy-MM-dd"];
            NSString *  locationString=[dateformatter stringFromDate:senddate];
            _requestDate.text=locationString;
            _requestDate.adjustsFontSizeToFitWidth=YES;
            
            weekStr= [CardViewController weekdayStringFromDate:senddate];
            
            [self getTime];
        }
        else if ([obj isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
        }
        else  if ([obj isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        else if ([obj isEqualToString:@"[]"])
        {
            PL_ALERT_SHOW(@"暂无数据");
        }
    }];
    
   
    
}


+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"Sunday", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

-(void)getTime
{
    
    int addDay=0;
    if ([weekStr isEqualToString:@"周一"]) {
        addDay=9;
        
    }
    else if([weekStr isEqualToString:@"周二"])
    {
         addDay=8;
    }
    else if([weekStr isEqualToString:@"周三"])
    {
        addDay=7;
    }
    else if([weekStr isEqualToString:@"周四"])
    {
        addDay=6;
    }
    else if([weekStr isEqualToString:@"周五"])
    {
        NSDate * nowTime = [NSDate date];
        NSCalendar * cal = [NSCalendar currentCalendar];
        unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
        NSDateComponents * dd = [cal components:unitFlags fromDate:nowTime];
        NSString * hourTime = [NSString stringWithFormat:@"%ld",(long)[dd hour]];
        if ([hourTime integerValue]>=16) {
            addDay=12;
        }
        else
        {
            addDay=5;
        }
        
    }
    else if([weekStr isEqualToString:@"周六"])
    {
        addDay=11;
    }
    else
    {
        addDay=10;
    }
    NSTimeInterval one=24*60*60*addDay;
    theDate=[senddate initWithTimeIntervalSinceNow:+one];
    NSDateFormatter  *dateformatter2=[[NSDateFormatter alloc] init];
    [dateformatter2 setDateFormat:@"yyyy-MM-dd"];
    NSString *  locationString2=[dateformatter2 stringFromDate:theDate];
    _getDate.text=locationString2;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
   // return (interfaceOrientation == UIInterfaceOrientationPortrait);//系统默认不支持旋转功能
    return YES;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
//     self.title=@"名片申请";
    _enterFre = YES;
     self.navigationController.navigationBarHidden=YES;
    //判断电池的位置
    //UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
//    UIApplication *myApp = [UIApplication sharedApplication];
//    [myApp setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:NO];
    
    UIView * toplayoutHei = [[UIView alloc]initWithFrame:CGRectMake(0, 0,PL_HEIGHT, 44)];
    toplayoutHei.backgroundColor = PL_CUSTOM_COLOR(157, 156, 157, 0.5);
    
    [self.view addSubview:toplayoutHei];
    UILabel * shenqingLable = [[UILabel alloc]initWithFrame:CGRectMake(PL_HEIGHT/2-60, 0, 100, 44)];
    shenqingLable.text = @"名片申请";
    shenqingLable.textAlignment = NSTextAlignmentCenter;
    shenqingLable.font = [UIFont boldSystemFontOfSize:PL_DETAIL_BIG_FONT_SIZ+5];
  
    [toplayoutHei addSubview:shenqingLable];
    [[UIApplication sharedApplication]setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:NO];
    CGFloat durtion = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [UIView animateWithDuration:durtion animations:^{
        self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
        
        
        
    }];

     [_countBtn setTitle:[NSString stringWithFormat:@"1"] forState:UIControlStateNormal];
    
    self.navigationController.navigationBarHidden=YES;

    self.view.backgroundColor=[UIColor whiteColor];
    UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(toplayoutHei.frame), CGRectGetWidth(toplayoutHei.frame), 1)];
    line.backgroundColor=[UIColor redColor];
    //[self.view addSubview:line];
//    [PL_USER_STORAGE setValue:[NSString stringWithFormat:@"%hhd",_enterFre] forKey:PL_USER_ENTER];
    
    [PL_USER_STORAGE synchronize];
    UIButton * backBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    backBnt.frame = CGRectMake(25, 12, 20, 25);
    [toplayoutHei addSubview:backBnt];
    [backBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * lookItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lookItemBtn.frame = CGRectMake(PL_HEIGHT-44,0, 44, 44);
    [lookItemBtn setTitle:@"查看" forState:UIControlStateNormal];
    [lookItemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lookItemBtn addTarget:self action:@selector(lookClick) forControlEvents:UIControlEventTouchUpInside];
    [toplayoutHei addSubview:lookItemBtn];
  }
-(void)lookClick
{
    CardLookViewController *vc = [[CardLookViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated
{
   // [PL_USER_STORAGE removeObjectForKey:PL_USER_ENTER];
    
    
    
}
- (void)viewDidDisappear:(BOOL)animated
{
//[PL_USER_STORAGE setValue:@"YES"  forKey:PL_USER_ENTER];
   
    
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
static NSInteger count=1;
- (IBAction)leftClick:(UIButton *)sender {
    
    
    
    
    if (count==1) {
       // sender.selected=NO;
        return;
        //[_countBtn setTitle:@"0" forState:UIControlStateNormal];
    }
    else if (count <=2)
    {
        count--;
        [_countBtn setTitle:[NSString stringWithFormat:@"%ld",(long)count] forState:UIControlStateNormal];
        }
}

- (IBAction)rightClick:(UIButton *)sender {
    
   
     //[_countBtn setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateNormal];
    if (count==2)
    {
//        sender.selected=NO;
        return;
        
        //[_countBtn setTitle:@"4" forState:UIControlStateNormal];
    }
    else if(count>=1)
    {
        count++;
        [_countBtn setTitle:[NSString stringWithFormat:@"%ld",(long)count] forState:UIControlStateNormal];
        
    }
}

- (IBAction)submitClick:(UIButton *)sender {
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"每周只能申请一次，确认要提交吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//    alert.delegate=self;
//    [alert show];
    //每周只能申请一次，确认要提交吗？
    MyAlertView * alert = [[MyAlertView alloc]initWithTitle:@"提示" contentString:@"每周只能申请一次，确认要提交吗?" call:^(id obj) {
        NSLog(@"quren");
        
        [self submitRequest];
        
        
    }];
    [alert showViewAnimation:YES showInView:self.view];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [self submitRequest];
    }
}

-(void)submitRequest
{
    [[MyRequest defaultsRequest]afGetEXcellentFlag_userID:[PL_USER_STORAGE objectForKey:PL_USER_NAME] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completBack:^(id obj) {
        SBJSON *json=[[SBJSON alloc]init];
        
        NSArray *staffArr=[json objectWithString:obj error:nil];
        NSDictionary *staffDic=[staffArr objectAtIndex:0];
        NSString *staffFlag=[staffDic objectForKey:@"StaffFlag"];
        
        NSDictionary *dict=[_signArray objectAtIndex:0];
        CardData *card=[[CardData alloc]init];
        card.StaffFlag=staffFlag;
        card.Department=_bumen.text;
        card.Position=_zhiwei.text;
        card.Mobile=_phone.text;
        card.DeptTel=[dict objectForKey:@"DeptTel"];
        card.Fax=[dict objectForKey:@"Fax"];
        card.DeptZip=[dict objectForKey:@"DeptZip"];
        card.Email=[dict objectForKey:@"FulEmail"];
        card.DeptAdd=[dict objectForKey:@"DeptAdd"];
        card.PrintNumber=_countBtn.titleLabel.text;
        NSLog(@"%@",card.PrintNumber);
        card.WeChat=@"";
        card.Company=[dict objectForKey:@"Company"];
        card.WebSite=[dict objectForKey:@"WebSite"];
        card.Area=[dict objectForKey:@"Level1"];
        card.Branch=[dict objectForKey:@"parentorg_display"];
        card.userid=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
        card.token=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN];
        
        [[MyRequest defaultsRequest]BusinessCardInfo:card backInfoMessage:^(NSMutableString *string) {
            NSLog(@"%@",string);
             [self.navigationController popViewControllerAnimated:YES];
            if ([string isEqualToString:@"OK"]) {
                PL_ALERT_SHOW(@"申请成功");
               
            }else if ([string isEqualToString:@"1"])
            {
                PL_ALERT_SHOW(@"请再次确认信息");
            }
            else if ([string isEqualToString:@"2"])
            {
                PL_ALERT_SHOW(@"对不起，您没有权限申请");
            }
            else if ([string isEqualToString:@"3"])
            {
                PL_ALERT_SHOW(@"本周已申请过，不能再申请");
            }
            else if ([string isEqualToString:@"4"])
            {
                PL_ALERT_SHOW(@"对不起，本周申请数量已满");
            }
            else if ([string isEqualToString:@"5"])
            {
                PL_ALERT_SHOW(@"已超过本周最大申请数量");
            }
            else if ([string isEqualToString:@"exception"]) {
                PL_ALERT_SHOW(@"服务器异常");
            }
            else  if ([string isEqualToString:@"NOLOGIN"]) {
                ViewController *login=[[ViewController alloc]init];
                [self.navigationController pushViewController:login animated:YES];
            }
            else if ([string isEqualToString:@"[]"])
            {
                PL_ALERT_SHOW(@"暂无数据");
            }
            else
            {
                PL_ALERT_SHOW(@"申请失败");
            }
            
        }];
        
    }];

}

@end
