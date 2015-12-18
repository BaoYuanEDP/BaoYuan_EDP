//
//  LookAboutAddView.m
//  BYFCApp
//
//  Created by zzs on 15/5/28.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "LookAboutAddView.h"
#import "PL_Header.h"

@interface LookAboutAddView()<UITextFieldDelegate>
{

    //保存页数
    NSInteger pageCount;
    //保存楼盘名称
    NSString *_estateNameStr;
    //保存楼栋号
    NSString *_buildingNameStr;
    //保存房号
    NSString *_roomNoStr;
    //房源ID
    NSString *_propertyID;
    
    UIDatePicker*dateP;
    
    UITextField*TextFile;
    UIAlertView *alert;
    NSDictionary *dictdata;
    NSUserDefaults*userda;
    NSMutableArray*arrytime;
    NSMutableArray*arrayEstate;
}

@property (strong, nonatomic) NSMutableArray *dataSourcesArray;
@property (nonatomic,strong) AutocompletionTableView *autoCompleter;
@property (nonatomic,strong) NSMutableArray *spellArray;
@property (strong, nonatomic) NSMutableArray *dataSourcesArray2;

@property(nonatomic,strong)NSMutableDictionary*NameDic;
@property(nonatomic,strong)NSMutableArray*TimerArray;
@end


@implementation LookAboutAddView
-(NSMutableArray *)spellArray
{
    if (!_spellArray) {
        _spellArray = [[NSMutableArray alloc]init];
    }
    return _spellArray;
}
-(NSMutableDictionary *)NameDic
{
    if (!_NameDic) {
        _NameDic=[[NSMutableDictionary alloc]init];
        
    }
    return _NameDic;
}
-(NSMutableArray *)TimerArray
{
    if (!_TimerArray) {
        _TimerArray=[[NSMutableArray alloc]init];
        
    }
    return _TimerArray;
}
-(NSMutableArray *)dataSourcesArray{

    if (_dataSourcesArray ==nil) {
        _dataSourcesArray = [[NSMutableArray alloc]init];
    }
    return _dataSourcesArray;
}
-(NSMutableArray*)dataSourcesArray2
{
    if (!_dataSourcesArray2) {
        _dataSourcesArray2=[[NSMutableArray array]init];
       
    }
    
    return _dataSourcesArray2;
    
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self =  [[NSBundle mainBundle]loadNibNamed:@"LookAboutAddView" owner:self options:nil].lastObject;
        self.frame = frame;
        self.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.7];
        LookRoomListTableView.delegate = self;
        LookRoomListTableView.dataSource = self;
        pageCount = 0;
        
//        [EstateNameTextField addTarget:self.autoCompleter action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
        
        [self setupRefresh];
    }
    return self;
}
- (AutocompletionTableView *)autoCompleter
{
    NSLog(@"%s",__FUNCTION__);
    if (!_autoCompleter)
    {
        NSMutableDictionary *options = [NSMutableDictionary dictionaryWithCapacity:1];
        [options setValue:[NSNumber numberWithBool:YES] forKey:ACOCaseSensitive];
        [options setValue:nil forKey:ACOUseSourceFont];
        
        _autoCompleter = [[AutocompletionTableView alloc]initWithTextField:EstateNameTextField inView:self withOptions:options];
        
//        _autoCompleter = [[AutocompletionTableView alloc] initWithTextField:EstateNameTextField inViewController:nil withOptions:options];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[MyRequest defaultsRequest] afCompleteLink_user:[PL_USER_STORAGE objectForKey:PL_USER_NAME] user_Token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSString *  obj) {
                
                NSLog(@"+++++++++++==========%@",obj);
                NSString * completeString = obj;
                if (completeString &&  completeString.length && [completeString isKindOfClass:[NSString class]])
                {
                    NSData * datas = [completeString dataUsingEncoding:NSUTF8StringEncoding];
                    NSArray * arra = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingMutableContainers error:nil];
                    
                    if (arra.count>0)
                    {
                        for (NSDictionary * dict  in arra)
                        {
                            
                            NSString * easterName = dict[@"EstateName"];
                            
                            [self.spellArray addObject:easterName];
                            
                            
                            
                        }
                        _autoCompleter.suggestionsDictionary = self.spellArray;
                        
                        
                        
                    }
                }
                
                
                //                for (NSString *item in spellArray) {
                //                    NSLog(@"%@",item);
                //                }
                
            }];
            
        });
        
        
    }
    return _autoCompleter;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataSourcesArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //static NSString *flag = @"cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flag];
    [tableView registerNib:[UINib nibWithNibName:@"LookAboutRoomTableViewCell" bundle:nil] forCellReuseIdentifier:@"flag"];
    
    LookAboutRoomTableViewCell *lookCell = [tableView dequeueReusableCellWithIdentifier:@"flag"];
    
    NSDictionary *dict = [_dataSourcesArray objectAtIndex:indexPath.row];
    
    lookCell.EstateName.text = [dict objectForKey:@"EstateName"];
    
    lookCell.BuildingName.text = [NSString stringWithFormat:@"%@栋%@室",[dict objectForKey:@"BuildingName"],[dict objectForKey:@"RoomNo"]];
    lookCell.SQUARE.text =[NSString stringWithFormat:@"%@㎡" ,[dict objectForKey:@"SQUARE"]];
    
    return lookCell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    dictdata = [_dataSourcesArray objectAtIndex:indexPath.row];
    _propertyID = dictdata[@"PROPERTYID"];
  
    
    
    alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"是否带看:%@ %@栋%@室",dictdata[@"EstateName"],dictdata[@"BuildingName"],dictdata
                                                             [@"RoomNo"]]delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle=UIAlertViewStylePlainTextInput;
    TextFile=[alert textFieldAtIndex:0];
    TextFile.delegate=self;
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
   
    
    NSDate*date2=dateP.date;
    NSDateFormatter*datef2=[[NSDateFormatter alloc]init];
    [datef2 setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    TextFile.text=[datef2 stringFromDate:date2];
        [alert show];
   userda=[NSUserDefaults standardUserDefaults];
}
-(void)ClickTimer
{
    NSDateFormatter*dateF=[[NSDateFormatter alloc]init];
    [dateF setDateFormat:@"yyyy-MM-dd HH:mm"];
   TextFile.text=[dateF stringFromDate:dateP.date];
    
    
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [TextFile resignFirstResponder];
    
    [alert.window addSubview:dateP];
    
    
    
    
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
      NSDateFormatter*dateform=[[NSDateFormatter alloc]init];
      dateform.dateFormat=@"yyyy-MM-dd HH:mm";
      NSString*LocaDte=[dateform stringFromDate:date];

      if ( [self compareTime1:LocaDte Time:TextFile.text]) {
                       PL_ALERT_SHOW(@"时间不可以小于30分钟");
      }else
      {
  PL_PROGRESS_SHOW;
[[MyRequest defaultsRequest]afSetGoSee:_propertyID CustID:_CustID Source:@"ios" AppointmentTime:TextFile.text userID:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSString *str) {
    PL_PROGRESS_DISMISS;
    NSLog(@"str:%@",str);
    if ([str isEqualToString:@"OK"])
    {
        
        PL_ALERT_SHOW(@"添加带看成功");
        
        [self postRequest];
        [self fadeOut];
    }
    else if ([str isEqualToString:@"ERR"])
    {
        
        PL_ALERTVIEW_SHOW(@"添加带看失败");
    }else{
        
        PL_ALERTVIEW_SHOW(@"房源ID或客源ID不存在");
    }
    

}];
      }
    
      }
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
    if (ti <1800) {
        return YES;
    }
    return NO;
    
}

-(void)isTextField{

    if (EstateNameTextField.text ==nil) {
        EstateNameTextField.text = @"";
        _estateNameStr = EstateNameTextField.text;
    }
    else
    {
        _estateNameStr = EstateNameTextField.text;
    }
    if (BuildingNameTextField.text ==nil) {
        BuildingNameTextField.text = @"";
        _buildingNameStr = BuildingNameTextField.text;
    }
    else
    {
        _buildingNameStr = BuildingNameTextField.text;
    }
    
    if (RoomNoTextField.text ==nil) {
        RoomNoTextField.text = @"";
        _roomNoStr = RoomNoTextField.text;
    }
    else
    {
        _roomNoStr = RoomNoTextField.text;
    }
    

}

-(void) postFirst{
    
  // [self isTextField];
    _roomNoStr = @"";
     pageCount = 2;
    [[MyRequest defaultsRequest]afGetGoSeePropertyListEstateName:_estateNameStr BuildingName:_buildingNameStr RoomNo:_roomNoStr StartIndex:[NSString stringWithFormat:@"%ld",(long)pageCount] completeBack:^(NSString *str) {
        
        NSLog(@"wocanima");
        
        SBJSON *json = [[SBJSON alloc]init];
      //  self.dataSourcesArray = [json objectWithString:str error:nil];
        [self.dataSourcesArray addObjectsFromArray:[json objectWithString:str error:nil]];
        [LookRoomListTableView  reloadData];
        
       // [LookRoomListTableView headerEndRefreshing];
    }];
    
}

-(void)postRoomLookList
{
    
      [self isTextField];
    NSLog(@"%@",_roomNoStr);
    
    NSLog(@"%@",_buildingNameStr);
    NSLog(@">>>>>>>%@",_estateNameStr);

    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]afGetGoSeePropertyListEstateName:_estateNameStr BuildingName:_buildingNameStr RoomNo:_roomNoStr  StartIndex:[NSString stringWithFormat:@"%ld",(long)pageCount] completeBack:^(NSString *str) {

        
        NSLog(@"%@",_estateNameStr);
        
        NSLog(@"%@",_buildingNameStr);
        
        NSLog(@"%@",_roomNoStr);
        
        NSLog(@"%@",[NSString stringWithFormat:@"%ld",(long)pageCount]);


        
        
        
        
        NSLog(@"%@",str);
        if ([str isEqualToString:@"NOLOGIN"])
        {
//            ViewController *login=[[ViewController alloc]init];
            PL_ALERT_SHOW(@"登录失效，请重新登陆");
        }
        else if ([str isEqualToString:@"[]"] )
        {
            
            PL_ALERT_SHOW(@"暂无数据");
           // [self.dataSourcesArray removeAllObjects];
        }
        else if ([str isEqualToString:@"exception"])
        {
            PL_ALERT_SHOW(@"服务器异常");
            [self.dataSourcesArray removeAllObjects];
        }
        else
        {
            SBJSON *json = [[SBJSON alloc]init];
            //self.dataSourcesArray = [json objectWithString:str error:nil];
            [self.dataSourcesArray addObjectsFromArray:[json objectWithString:str error:nil]];
            [LookRoomListTableView  reloadData];
            
            
        }
 
        PL_PROGRESS_DISMISS;
    }];
    
}
- (IBAction)searchButton:(UIButton *)sender {
    [EstateNameTextField resignFirstResponder];
    if([EstateNameTextField.text isEqualToString:@""] || EstateNameTextField.text == nil){
        PL_ALERT_SHOW(@"楼盘名称不能为空");
    }else{
        [_dataSourcesArray removeAllObjects];
        pageCount = 1;
        [self postRoomLookList];
    }
   

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [EstateNameTextField resignFirstResponder];
}

-(void)addSelfInAView:(UIView *)sup
{
    [sup.window addSubview:self];
    [self bringSubviewToFront:sup.window];
     [self postFirst];
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
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self clearTel:nil];
}
- (void)clearTel:(UIGestureRecognizer *)tap
{
    [self fadeOut];
}


#pragma mark --上啦下拉刷新
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    // [table addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    [LookRoomListTableView addHeaderWithTarget:self action:@selector(headerRereshingLA)];
    //#warning 自动刷新(一进入程序就下拉刷新)
        //[LookRoomListTableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [LookRoomListTableView addFooterWithTarget:self action:@selector(footerRereshingLA)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    LookRoomListTableView.headerPullToRefreshText = @"下拉刷新";
    LookRoomListTableView.headerReleaseToRefreshText = @"松开刷新";
    LookRoomListTableView.headerRefreshingText = @"客源正在刷新中";
    
    LookRoomListTableView.footerPullToRefreshText = @"上拉加载更多数据";
    LookRoomListTableView.footerReleaseToRefreshText = @"松开加载更多数据";
    LookRoomListTableView.footerRefreshingText = @"客源正在加载中";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshingLA
{
    pageCount ++;
    [self postRoomLookList];
    [LookRoomListTableView headerEndRefreshing];
}

- (void)footerRereshingLA
{
    pageCount ++ ;
    [self postRoomLookList];
    [LookRoomListTableView footerEndRefreshing];
    
}


-(void)postRequest
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"LookSeeView" object:nil];
      self.NameDic[@"Time"]=TextFile.text;
    self.NameDic[@"Content"]=[NSString stringWithFormat:@"%@ %@号%@室",dictdata[@"EstateName"],dictdata[@"BuildingName"],dictdata
                              [@"RoomNo"]];
    [self.TimerArray addObject:self.NameDic];
    NSUserDefaults*user3=[NSUserDefaults standardUserDefaults];
    [user3 setObject:self.TimerArray forKey:@"flowdirectionData"];
}



@end
