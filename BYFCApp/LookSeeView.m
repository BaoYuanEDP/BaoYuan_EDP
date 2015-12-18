//
//  LookSeeView.m
//  BYFCApp
//
//  Created by PengLee on 15/5/28.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "LookSeeView.h"
#import "PL_Header.h"
@interface LookSeeView()
{
    NSInteger pageCount;
    NSString * _custName;
    NSString * _custIDString;
    UIAlertView *alert;
    UITextField*te;
    UIDatePicker*dateP;
    NSDictionary *dic;
    NSDictionary *dic3;
    
}
@property (weak, nonatomic) IBOutlet UITableView *dataSourceTableView;
@property (weak, nonatomic) IBOutlet UITextField *searchNameTextField;
@property (strong, nonatomic) NSMutableArray *dataSourcesArray;

@property (strong, nonatomic) NSMutableArray *resultArray;
@property (strong, nonatomic)NSString *compnString;
@property(nonatomic,strong)NSMutableArray*TimeArray;
@property(nonatomic,strong)NSMutableDictionary*NameDic;

@end

@implementation LookSeeView

-(NSMutableArray *)dataSourcesArray
{
    if (!_dataSourcesArray) {
        _dataSourcesArray = [[NSMutableArray alloc]init];
    }
    return _dataSourcesArray;
}
-(NSMutableArray*)TimeArray
{
    
    if (!_TimeArray) {
        _TimeArray=[[NSMutableArray alloc]init];
        
    }
    return _TimeArray;
    
}
-(NSMutableDictionary *)NameDic
{
    if (!_NameDic) {
        _NameDic=[[NSMutableDictionary alloc]init];
    }
    return _NameDic;
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       self =  [[NSBundle mainBundle]loadNibNamed:@"LookSeeView" owner:self options:nil].lastObject;
        self.dataSourcesArray = [[NSMutableArray alloc]init];
        self.dataSourceTableView.delegate = self;
        self.dataSourceTableView.dataSource = self;
        self.dataSourceTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [self postGoSeeCustList];
        self.resultArray = [[NSMutableArray alloc]init];
                [self setupRefresh];
        self.frame = frame;
        self.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.7];
            }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    pageCount = 1;

    

    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourcesArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseStr = @"cellReuseid";
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseStr];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseStr];
    }
    if (_dataSourcesArray.count > 0) {
          dic = _dataSourcesArray[indexPath.row];
        NSString *telString = dic[@"CustTel"];
        _compnString = [telString componentsSeparatedByString:@"|"].firstObject;
        cell.textLabel.text = dic[@"CustName"];
        cell.detailTextLabel.text = _compnString;
       }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dic3 = self.dataSourcesArray[indexPath.row];
    _custIDString = dic3[@"CustID"];
    alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"是否带看:%@",dic3[@"CustName"]]
        delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle=UIAlertViewStylePlainTextInput;
    te=[alert textFieldAtIndex:0];
       te.delegate=self;
    
   te.placeholder=@"请输入约看时间";
    if (PL_HEIGHT>=736) {
     
 dateP=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 520, PL_WIDTH, 216)];
     }else if(PL_HEIGHT>=667)
    {
           dateP=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 450, PL_WIDTH, 216)];
    }
       else  if (PL_HEIGHT>=568)
    {
         dateP=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,370, PL_WIDTH, 216)];
    }else
    {
        dateP=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 325, PL_WIDTH, 216)];

        
    }
        
    
   
    dateP.backgroundColor=[UIColor whiteColor];
    [dateP addTarget:self action:@selector(ClickTimer) forControlEvents:UIControlEventValueChanged];
//    dateP.datePickerMode=UIDatePickerModeTime;
    [alert.window addSubview:dateP];
    
    NSDate*date=dateP.date;
    NSDateFormatter*datef=[[NSDateFormatter alloc]init];
    [datef setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    te.text=[datef stringFromDate:date];

    
               [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==alertView.firstOtherButtonIndex) {
        UITextField*text=[alertView textFieldAtIndex:0];
        text.backgroundColor=[UIColor whiteColor];
    }
   
    
       if (buttonIndex == 1)
    {
        NSDate*date=[[NSDate alloc]init];
        NSDateFormatter*datef=[[NSDateFormatter alloc]init];
        datef.dateFormat=@"yyyy-MM-dd HH:mm";
        
        NSString*daste=[datef stringFromDate:date];
        if ( [self compareTime1:daste Time:te.text]) {
            
            PL_ALERT_SHOW(@"时间不可以小于30分钟");
        }else
        {
            PL_PROGRESS_SHOW;
            [[MyRequest defaultsRequest]afSetGoSee:self.propertyIDString CustID:_custIDString Source:@"ios" AppointmentTime:te.text userID:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSString *str) {
                PL_PROGRESS_DISMISS;
                NSLog(@"str:%@",str);
                
                
                if ([str isEqualToString:@"OK"])
                {
                    PL_ALERT_SHOW(@"添加带看成功");
                    [self getREquest];

                    [self fadeOut];
                }
                else if ([str isEqualToString:@"ERR"])
                {
                    
                    PL_ALERTVIEW_SHOW(@"添加带看失败");
                }else
                {
                    
                    PL_ALERTVIEW_SHOW(@"奔溃性的错误");
                }
                
                
                
                
            }];
            
         }
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    
        NSLog(@"启动点击");
[alert.window addSubview:dateP];
    
}
-(void)ClickTimer
{
    NSDateFormatter*dateF=[[NSDateFormatter alloc]init];
    [dateF setDateFormat:@"yyyy-MM-dd HH:mm"];
    te.text=[dateF stringFromDate:dateP.date];
  
    NSUserDefaults*userd=[NSUserDefaults standardUserDefaults];
    [userd setObject:te.text forKey:@"Looktext"];
    
    
}

- (IBAction)clickSearchButton:(UIButton *)sender
{
   

        pageCount = 1;
        [self.dataSourcesArray removeAllObjects];
        _custName = self.searchNameTextField.text.length == 0 ?@"": self.searchNameTextField.text;
        [self.searchNameTextField resignFirstResponder];
        [self postGoSeeCustList];
    
    
  
}
#pragma mrak 保存数据准备发送通知
-(void)getREquest
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"LookSeeView" object:nil];
    
    
    self.NameDic[@"time"]=te.text;
    self.NameDic[@"content"]=[NSString stringWithFormat:@"%@ %@",self.EstStr,self.FloorStr];
     [self.TimeArray addObject:self.NameDic];
    NSArray * array = self.TimeArray;
    NSUserDefaults*UserDefaults2=[NSUserDefaults standardUserDefaults];
    [UserDefaults2 setObject:array  forKey:@"RoomData"];
    [UserDefaults2 synchronize];
    
    
    
}
#pragma mark -- 加载数据
-(void)postGoSeeCustList
{
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]afGetGoSeeCustListWithCustName:_custName.length == 0 ? @"" : _custName StartIndex:[NSString stringWithFormat:@"%ld",(long)pageCount] completeBack:^(NSString *str) {
        PL_PROGRESS_DISMISS;
        if ([str isEqualToString:@"NOLOGIN"])
        {
           
            PL_ALERT_SHOW(@"登录失效，请重新登陆");
                   }
        else if ([str isEqualToString:@"[]"] )
        {
            PL_ALERT_SHOW(@"暂无数据");
            pageCount--;
        }
        else if ([str isEqualToString:@"exception"])
        {
            PL_ALERT_SHOW(@"服务器异常");
            pageCount--;
        }
        else
        {
            SBJSON *json = [[SBJSON alloc]init];
            NSArray *array = [json objectWithString:str error:nil];
            [self.dataSourcesArray addObjectsFromArray:array];
        }
        [self.dataSourceTableView reloadData];
        [self.dataSourceTableView headerEndRefreshing];
        [self.dataSourceTableView footerEndRefreshing];
    }];
}
#pragma mark --上啦下拉刷新
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    // [table addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    [self.dataSourceTableView addHeaderWithTarget:self action:@selector(headerRereshingC)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    //    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.dataSourceTableView addFooterWithTarget:self action:@selector(footerRereshingC)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.dataSourceTableView.headerPullToRefreshText = @"下拉刷新";
    self.dataSourceTableView.headerReleaseToRefreshText = @"松开刷新";
    self.dataSourceTableView.headerRefreshingText = @"客源正在刷新中";
    
    self.dataSourceTableView.footerPullToRefreshText = @"上拉加载更多数据";
    self.dataSourceTableView.footerReleaseToRefreshText = @"松开加载更多数据";
    self.dataSourceTableView.footerRefreshingText = @"客源正在加载中";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshingC
{
    pageCount = 1;
    [self.dataSourcesArray removeAllObjects];
    [self postGoSeeCustList];
}

- (void)footerRereshingC
{
    pageCount ++ ;
    [self postGoSeeCustList];

}



-(void)addSelfInAView:(UIView *)sup
{
    [sup.window addSubview:self];
    [self bringSubviewToFront:sup.window];
    [self fadeIn];
}
- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.4, 1.4);
    self.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}
- (void)fadeOut
{
    [UIView animateWithDuration:.25 animations:^{
        self.transform = CGAffineTransformMakeScale(1.4, 1.4);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}
- (BOOL) compareTime1:(NSString*)str Time:(NSString*)str3
{
    
    NSDateFormatter * dateFormatter2= [[NSDateFormatter alloc]init];
    dateFormatter2.dateFormat = @"yyyy-MM-dd HH:mm";
    
    NSDate*date3=[[NSDate alloc]init];
    
    date3 = [dateFormatter2 dateFromString:str3];
    NSDate * date = [[NSDate alloc]init];
    date = [dateFormatter2 dateFromString:str];
    //    判断30分钟以内的
    NSTimeInterval ti = [date3 timeIntervalSinceDate:date];
    if (ti <=1800) {
        return YES;
    }
    return NO;
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self clearTel:nil];
}
- (void)clearTel:(UIGestureRecognizer *)tap
{
    [self fadeOut];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
