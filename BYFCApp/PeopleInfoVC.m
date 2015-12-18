//
//  PeopleInfoVC.m
//  BYFCApp
//
//  Created by PengLee on 14/12/9.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import "PeopleInfoVC.h"
#import "UMessage.h"
#import "Wechat/WXApiObject.h"
@interface PeopleInfoVC ()<UITableViewDataSource,UITableViewDelegate,PersonDelegate,UMSocialUIDelegate>
{
    HIstoryCell * cell1;
    NewCell *cell2;
    
}
//@property (weak, nonatomic) IBOutlet UIImageView *hongLineImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *emaliLable;
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
@property (weak, nonatomic) IBOutlet UILabel *bumenLable;

@property (weak, nonatomic) IBOutlet UILabel *managerID;
@property (weak, nonatomic) IBOutlet UILabel *yuZhanghuLable;
@property (weak, nonatomic) IBOutlet UILabel *zhiweiLable;
@property(nonatomic,copy)NSString * userName;
@property(nonatomic,copy)NSString * userPass;
@property(nonatomic,copy)NSMutableArray  * infoArray;

@end

@implementation PeopleInfoVC
-(void)compareResults:(NSMutableString *)string dict:(NSDictionary *)dictonry
{
    NSLog(@"string == %@",string);
    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray * arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    
    NSDictionary * dictionary = arr[0];
    self.nameLable.text  = [dictionary objectForKey:@"User_Name"];
    self.nameLable.adjustsFontSizeToFitWidth = YES;
    self.managerID.text = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"User_Code"]];
    
    self.managerID.adjustsFontSizeToFitWidth = YES;
    self.yuZhanghuLable.text = [dictionary objectForKey:@"userid"];
    self.yuZhanghuLable.adjustsFontSizeToFitWidth = YES;
    self.emaliLable.text = [NSString stringWithFormat:@"%@@bypro.com.cn",self.yuZhanghuLable.text];
    
     self.emaliLable.adjustsFontSizeToFitWidth = YES;
    
     self.phoneNum.text = [dictionary objectForKey:@"User_Phone"];
    self.phoneNum.adjustsFontSizeToFitWidth = YES;
    
    self.bumenLable.text = [dictionary objectForKey:@"Org_name"];
    self.bumenLable.adjustsFontSizeToFitWidth =YES;
    self.zhiweiLable.text = [dictionary objectForKey:@"duty_name"];
    self.zhiweiLable.adjustsFontSizeToFitWidth = YES;
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人信息";
    _isEqueToOne = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.kaoqingBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.ronghanBut setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.navigationController.navigationBarHidden = NO;
    self.infoArray = [NSMutableArray  array];
    self.arrayData = [NSMutableArray array];
    self.modelArray = [NSMutableArray array];
    self.historyTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    NSString *  name = [PL_USER_STORAGE objectForKey:PL_USER_NAME];
    NSString * token = [PL_USER_STORAGE objectForKey:PL_USER_TOKEN];
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]getEmpInfo:name userToken:token backInfoMessage:^(id  obj) {
        
        // NSLog(@"id = =%@",obj);
        PL_PROGRESS_DISMISS;
        if([obj isEqual:@"NOLOGIN"])
        {
            ViewController *vc = [[ViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            NSData * data = [obj dataUsingEncoding:NSUTF8StringEncoding];
            NSArray * arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary * dictionary = arr[0];
            self.ronghanL = [dictionary objectForKey:@"Level1"];
            self.strcode = [dictionary objectForKey:@"EncodeUserCode"];
            self.typeCode = [dictionary objectForKey:@"UnitFullCode"];
            self.nameLable.text  = [dictionary objectForKey:@"User_Name"];
            self.nameLable.adjustsFontSizeToFitWidth = YES;
            self.managerID.text = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"User_Code"]];
            [[NSUserDefaults standardUserDefaults]setValue:[dictionary objectForKey:@"DutyTypeName"] forKey:@"DutyTypeName"];
            self.managerID.adjustsFontSizeToFitWidth = YES;
            self.yuZhanghuLable.text = [dictionary objectForKey:@"userid"];
            self.yuZhanghuLable.adjustsFontSizeToFitWidth = YES;
            self.emaliLable.text = [NSString stringWithFormat:@"%@@bypro.com.cn",self.yuZhanghuLable.text];
            
            self.emaliLable.adjustsFontSizeToFitWidth = YES;
            
            self.phoneNum.text = [dictionary objectForKey:@"User_Phone"];
            [[NSUserDefaults standardUserDefaults]setObject: [dictionary objectForKey:@"User_Phone"] forKey:@"User_Phone"];
            [PL_USER_STORAGE setObject:[dictionary objectForKey:@"User_Name"] forKey:@"Name_User"];
            NSLog(@"%@", [dictionary objectForKey:@"User_Phone"]);
            self.phoneNum.adjustsFontSizeToFitWidth = YES;
            self.bumenLable.text = [dictionary objectForKey:@"Org_name"];
            self.bumenLable.adjustsFontSizeToFitWidth =YES;
            self.zhiweiLable.text = [dictionary objectForKey:@"duty_name"];
            self.zhiweiLable.adjustsFontSizeToFitWidth = YES;
            buttonEnable = [dictionary objectForKey:@"Org_Display"];
            if ([buttonEnable isEqualToString:@"信息技术部"])
            {
                zhuxiaoBnt.hidden = NO;
            }
            else
            {
                zhuxiaoBnt.hidden = YES;
            }
            if ([_typeCode rangeOfString:@"KD01.0002.0005"].location !=NSNotFound) {
                _ronghanBut.hidden = NO;
                _lineRH.constant = 130.0f;
            }else
            {
                _ronghanBut.hidden = YES;
                _lineRH.constant = 62.0f;
            }
            

        }
    }];

    if (_isEqueToOne == YES) {
        _signArray = [NSMutableArray array];
        [PL_MYREQUEST_DEFAULT afGetResaultUser:PL_USER_COREDATA_NAME userCookie:PL_USER_COREDATA_TOKEN call:^(id obj) {
            if ([obj isKindOfClass:[NSArray class]])
            {
                _signArray = obj;
                
                           [self.historyTable reloadData];
            }
        }];
    }
       // [MyRequest defaultsRequest].delegate = self;
    UIButton * buttonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLeft.frame = CGRectMake(15, 25, 10, 15);
    //[buttonLeft setBackGroundImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
    [buttonLeft setBackgroundImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
    
    [buttonLeft addTarget:self action:@selector(homeBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * back = [[UIBarButtonItem alloc]initWithCustomView:buttonLeft];
    self.navigationItem.leftBarButtonItem = back;
  [self.bumenLable sizeToFit];
  
    UIView * changeBtn = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    changeBtn.backgroundColor = [UIColor clearColor];
    
    zhuxiaoBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    zhuxiaoBnt.frame = CGRectMake(0,0, 50, 40   );
    [zhuxiaoBnt setTitle:@"切换" forState:UIControlStateNormal];
    [zhuxiaoBnt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    zhuxiaoBnt.titleLabel.font = [UIFont systemFontOfSize:15];
    zhuxiaoBnt.backgroundColor = [UIColor clearColor];
    
    UIButton * changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    changeButton.frame = CGRectMake(50,0,50, 40);
    [changeButton setTitle:@"注销" forState:UIControlStateNormal];
    changeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [changeBtn addSubview:zhuxiaoBnt];
    [changeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [changeBtn addSubview:changeButton];
    [zhuxiaoBnt addTarget:self action:@selector(changeClick) forControlEvents:UIControlEventTouchUpInside];
    [changeButton addTarget:self action:@selector(zhuxiaoBntClick) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]initWithCustomView:changeBtn];
    
    rightBtn.tintColor = [UIColor grayColor];
    
    self.navigationItem.rightBarButtonItem = rightBtn;
    [self showDateLable];
    self.historyTable.delegate =self;
    self.historyTable.dataSource =self;
    self.historyTable.separatorInset = UIEdgeInsetsZero;
    [self tableViewLine];
    
    
}
- (void)requestObj:(NSString *)userid token:(NSString *)tonke
{
    _arrayData = [NSMutableArray array];
  
    [[MyRequest defaultsRequest]GetRHHisSinTime:userid token:tonke hCall:^(id obj) {
        if ([obj isKindOfClass:[NSArray class]])
        {
            _arrayData = obj;
            for (NSDictionary *dic in _arrayData) {
                RHSignTimeData *modelData = [[RHSignTimeData alloc] init];
                modelData.sTime = [dic objectForKey:@"SignTime"];
                modelData.cLength = [dic objectForKey:@"CoordinateLength"];
                NSLog(@"---------%@",modelData.cLength);
                [_modelArray addObject:modelData];
                NSLog(@"%@",modelData);
                NSLog(@"%@",_modelArray);
                
            }
            [_historyTable reloadData];
        }
    }];
}

#pragma mark 切换用户方法
- (void)changeClick
{
//    [PL_USER_STORAGE removeObjectForKey:PL_USER_TOKEN];
//    [PL_USER_STORAGE removeObjectForKey:PL_USER_COOKIES];
//    [PL_USER_STORAGE removeObjectForKey:PL_USER_PASSWORD];
//    [PL_USER_STORAGE synchronize];
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"登录" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert textFieldAtIndex:0].placeholder = @"请输入用户名:";
    alert.tag = 2015;
    [alert show];

}
#pragma mark 注销用户
- (void)zhuxiaoBntClick
{
    //[self zhuxiaoBnt];
    PL_ALERT_SELF_SHOW(@"提醒", @"确定要注销吗？");
}
- (void)didselectRow:(NSInteger)row cellTile:(NSString *)title tableShowDeriction:(TableAnimation)showderiction
{
    NSLog(@"%@",title);
    [[MyRequest defaultsRequest] afgetWebServiceUserName:title userPass:@"" backInfo:^(NSMutableString *string) {
        NSLog(@"123++%@",string);
        if (string.length && ![string isEqualToString:@"[]"] && ![string isEqualToString:@"exception"] && ![string isEqualToString:@"NotLogin"] && ![string isEqualToString:@"NOLOGIN"]&& ![string isEqualToString:@"CATCH"])
        {
            SBJSON * json = [[SBJSON alloc]init];
            NSDictionary * dict = [json objectWithString:string error:nil  ];
            if (dict && dict != nil)
            {
                KeychainItemWrapper * keychin = [[KeychainItemWrapper alloc]initWithIdentifier:@"Gesture" accessGroup:nil];
                [keychin resetKeychainItem];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [PL_USER_STORAGE setValue:title forKey:PL_USER_NAME];
                    [PL_USER_STORAGE setValue:dict[@"UserId"] forKey:PL_USER_USERID];
                    
                    [PL_USER_STORAGE setObject:[NSString stringWithFormat:@"%@",dict[@"UserCode"]] forKey:PL_USER_code];
                    [PL_USER_STORAGE setValue:dict[@"DutyCode"] forKey:PL_USER_DUTYCODE];
                    
                    NSLog(@"duty code %@",dict[@"DutyCode"]);
                    NSLog(@"token %@",dict[@"Token"]);
                    NSString * string1 =[dict objectForKey:PL_USER_TOKEN];
                    [[NSUserDefaults standardUserDefaults]setValue:[dict objectForKey:@"DutyTypeName"] forKey:@"DutyTypeName"];

                    [PL_USER_STORAGE setObject:string1 forKey:PL_USER_TOKEN];
                    [ PL_USER_STORAGE setObject:dict[@"User_Phone"] forKey:PL_USER_PHONEnUM];
                    [PL_USER_STORAGE setObject:[dict objectForKey:@"UserName"] forKey:PL_USER_TRUE_NAME];
                    //[PL_USER_STORAGE setObject:[dict objectForKey:@"UserName"] forKey:@"UserName"];
                    [PL_USER_STORAGE setObject:[dict objectForKey:@"EncodeUserCode"] forKey:@"encode"];
                    [PL_USER_STORAGE synchronize];
                    
                    
                    
                    NSString * user = [PL_USER_STORAGE objectForKey:PL_USER_NAME];
                    NSString * token = [PL_USER_STORAGE objectForKey:PL_USER_TOKEN];
                    
                    NSLog(@"\n\n\n%@",user);
                    NSLog(@"\n\n\n%@",token);
                    NSLog(@"\n\n\n%@",[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE]);
                    
                    PL_PROGRESS_SHOW;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[MyRequest defaultsRequest]getEmpInfo:user userToken:token backInfoMessage:^(id  obj) {
                            // NSLog(@"id = =%@",obj);
                            
                            NSData * data = [obj dataUsingEncoding:NSUTF8StringEncoding];
                            NSArray * arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                            
                            PL_PROGRESS_DISMISS;
                            NSDictionary * dictionary = arr[0];
                            self.strcode = [dictionary objectForKey:@"EncodeUserCode"];
                            
                            self.nameLable.text  = [dictionary objectForKey:@"User_Name"];
                            self.nameLable.adjustsFontSizeToFitWidth = YES;
                            self.managerID.text = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"User_Code"]];
                            
                            self.managerID.adjustsFontSizeToFitWidth = YES;
                            self.yuZhanghuLable.text = [dictionary objectForKey:@"userid"];
                            self.yuZhanghuLable.adjustsFontSizeToFitWidth = YES;
                            self.emaliLable.text = [NSString stringWithFormat:@"%@@bypro.com.cn",self.yuZhanghuLable.text];
                            
                            self.emaliLable.adjustsFontSizeToFitWidth = YES;
                            
                            self.phoneNum.text = [dictionary objectForKey:@"User_Phone"];
                            [[NSUserDefaults standardUserDefaults]setObject: [dictionary objectForKey:@"User_Phone"] forKey:@"User_Phone"];
                            NSLog(@"%@", [dictionary objectForKey:@"User_Phone"]);
                            self.phoneNum.adjustsFontSizeToFitWidth = YES;
                            self.bumenLable.text = [dictionary objectForKey:@"Org_name"];
                            self.bumenLable.adjustsFontSizeToFitWidth =YES;
                            self.zhiweiLable.text = [dictionary objectForKey:@"duty_name"];
                            self.zhiweiLable.adjustsFontSizeToFitWidth = YES;
                            buttonEnable = [dictionary objectForKey:@"Org_Display"];
                            if ([buttonEnable isEqualToString:@"信息技术部"])
                            {
                                zhuxiaoBnt.hidden = NO;
                            }
                            else
                            {
                                zhuxiaoBnt.hidden = YES;
                            }
                            
                        }];
                        
                    });
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [PL_MYREQUEST_DEFAULT afGetResaultUser:dict[@"UserId"]  userCookie:[dict objectForKey:PL_USER_TOKEN] call:^(id obj) {
                            if ([obj isKindOfClass:[NSArray class]])
                            {
                                _signArray = obj;
                                
                                [self.historyTable reloadData];
                                
                            }
                            
                        }];
                        
                    });
                });
                
            }
            
            
        }
        else if([string isEqualToString:@"exception"])
        {
            
            PL_ALERT_SHOWNOT_OKAND_YES(@"服务器异常");
            
            
        }
        else if([string isEqualToString:@"CATCH"])
        {
            
            PL_ALERT_SHOWNOT_OKAND_YES(@"此账号不存在");
            
            
        }

        else
        {
            
            PL_ALERT_SHOWNOT_OKAND_YES(@"登录失败,该账号不存在");
            
            
        }
        
    }];
    

}

- (void)showDateLable
{
    NSDate * nowTime = [NSDate date];
    NSCalendar * calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents * dd = [calendar components:unitFlags fromDate:nowTime];
    NSUInteger year = [dd year];
    NSUInteger month = [dd month];
    NSUInteger day = [dd day];
//    NSUInteger hour = [dd hour];
//    NSUInteger min = [dd minute];
//    NSUInteger sec = [dd second];
    self.dateLable.text = [NSString stringWithFormat:@"%2ld-%ld-%2ld",(unsigned long)year,(unsigned long)month,(unsigned long)day];
    //设置定位精确度
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyBest];
    //指定最小距离
    [BMKLocationService setLocationDistanceFilter:kCLDistanceFilterNone];
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    [BMKLocationService getCurrentLocationDesiredAccuracy];
    CLLocationDistance distant = [BMKLocationService getCurrentLocationDistanceFilter];
    NSLog(@"+++%fdddd",distant);
    
    
    
}

//用户位置更新后
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    NSLog(@"%@",userLocation.location);
    
    baiduX = userLocation.location.coordinate.latitude;
    baiduY = userLocation.location.coordinate.longitude;
    NSLog(@"%f  -- %f",baiduX,baiduY);
    //计算打开距离
    BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(baiduX, baiduY));
    BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(31.230892, 121.517972));
    
    
     distance = BMKMetersBetweenMapPoints(point1, point2);
    CLLocationDistance dis = BMKMetersPerMapPointAtLatitude(baiduX);
    distanceFlag  = [NSString stringWithFormat:@"%.4f",distance];
    
    NSLog(@"distance = %@ m  -%.2f",distanceFlag,dis);
//系统
    
}
//用户方向更新后
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    baiduX = userLocation.location.coordinate.latitude;
    baiduY = userLocation.location.coordinate.longitude;
   // NSLog(@"header = %@",userLocation.heading);
    //计算打开距离
    BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(baiduX, baiduY));
    BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(31.230892, 121.517972));
    
    
    distance = BMKMetersBetweenMapPoints(point1, point2);
    CLLocationDistance dis = BMKMetersPerMapPointAtLatitude(baiduX);
    distanceFlag  = [NSString stringWithFormat:@"%f",distance ];
    
    NSLog(@"distance = %@ m  -%f",distanceFlag,dis);
}

#pragma mark -- 注销账户

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==2015)
    {
        if (buttonIndex==0)
        {
            
        }
        else
        {
            NSLog(@"取消");
            if (buttonIndex ==0)
            {
                
            }
            else
            {
                NSString * text1 =  [alertView textFieldAtIndex:0].text;
                [self didselectRow:0 cellTile:text1 tableShowDeriction:tableAnimationRight];
                
                NSLog(@"%@",text1);
            }

        }
    }
    else
    {
        if (buttonIndex==0)
        {
        }
        else
        {
            //        [PL_USER_STORAGE removeObjectForKey:PL_USER_NAME];
            [PL_USER_STORAGE removeObjectForKey:PL_USER_TOKEN];
            [PL_USER_STORAGE removeObjectForKey:PL_USER_COOKIES];
            [PL_USER_STORAGE removeObjectForKey:PL_USER_PASSWORD];
            [PL_USER_STORAGE synchronize];
            //推送删除标签
            NSString *string = [PL_USER_STORAGE objectForKey:PL_USER_code];
            [UMessage removeTag:string
                       response:^(id responseObject, NSInteger remain, NSError *error) {
                       }];
            [PL_USER_STORAGE removeObjectForKey:@"UserName"];
            [PL_USER_STORAGE synchronize];
            KeychainItemWrapper * keychin = [[KeychainItemWrapper alloc]initWithIdentifier:@"Gesture" accessGroup:nil];
            [keychin resetKeychainItem];
            
            // [keychin objectForKey:(__bridge id)kSecValueData];
            //  NSArray * vc = self.navigationController.viewControllers;
            ViewController * view = [[ViewController alloc]init];
            
            [self.navigationController pushViewController:view animated:YES];
            
            //[self.navigationController popToViewController:view animated:YES];
            //[self presentViewController:view animated:YES completion:nil];
        }
    }
}
//删除15像素线
-(void)tableViewLine
{
    if ([_historyTable respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_historyTable setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_historyTable respondsToSelector:@selector(setLayoutMargins:)])
    {
        [_historyTable setLayoutMargins:UIEdgeInsetsZero];
    }
    
}
-(void)homeBack
{
   NSArray * arrr   = self.navigationController.viewControllers ;
    MainViewController * vc = arrr[arrr.count-2];
    
    [self.navigationController popToViewController:vc animated:YES];
    
}
#pragma mark --tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (_isEqueToOne == YES) {
        return _signArray.count;
    }
    else
    {
        return _modelArray.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifer = @"cell";
    static NSString * identifer1 = @"cell1";
    if (_isEqueToOne == YES) {
       cell1= (HIstoryCell *)[tableView dequeueReusableCellWithIdentifier:identifer];
        if (!cell1)
        {
            cell1 = [[[NSBundle mainBundle]loadNibNamed:@"HIstoryCell" owner:nil options:nil] firstObject];
        }
        NSDictionary * dict = _signArray[indexPath.row];
        SignTimeData * dataSign = [SignTimeData loadReloadDataFromDict:dict];
        NSLog(@"%@",dataSign.signDAY);
        cell1.dateLable.text = dataSign.signSignTime;
        cell1.dateLable.adjustsFontSizeToFitWidth = YES;
        cell1.xingqi.text = dataSign.signDAY;
        cell1.timerOn.text = dataSign.signDutySignTime;
        cell1.XiabanTimerLable.text = dataSign.signOffDutySignTime;
        cell1.stratCheck.text=dataSign.startCheck;
        cell1.endCheck.text=dataSign.endCheck;
        NSLog(@"heaven====%ld",(long)_isEqueToOne);
        return cell1;
    }
    else
    {
        cell2= (NewCell *)[tableView dequeueReusableCellWithIdentifier:identifer1];
        if (!cell2)
        {
            cell2 = [[[NSBundle mainBundle]loadNibNamed:@"NewCell" owner:nil options:nil] lastObject];
        }
       if(_modelArray.count>0)
       {
//           RHSignTimeData *data = _modelArray[indexPath.row];
           [cell2 cellModelData:_modelArray[indexPath.row]];
       }
        NSLog(@"heaven====%ld",(long)_isEqueToOne);
        return cell2;
    }
}
//tableView15像素删除
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell1 respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell1 setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell1 respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell1 setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell2 respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell2 setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell2 respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell2 setLayoutMargins:UIEdgeInsetsZero];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark --签到
- (IBAction)qiandaoBnt:(UIButton *)sender {
  
    NSLog(@"签到");
    NSLog(@"x:%@  y:%@",[NSString stringWithFormat:@"%f",baiduY],[NSString stringWithFormat:@"%f",baiduX]);
    [_locService stopUserLocationService];
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    
    [_locService startUserLocationService];
    
//    if ([distanceFlag integerValue] <=10  )
//    {
//        PL_ALERT_SHOW(@"您好可以打卡");
    NSLog(@"x:%@  y:%@",[NSString stringWithFormat:@"%f",baiduY],[NSString stringWithFormat:@"%f",baiduX]);
    if (baiduX==0) {
        PL_ALERT_SHOW(@"定位未开启!\n请前往应用设置,开启定位服务");
        
    }else
    {
         PL_PROGRESS_SHOW;
        [[MyRequest defaultsRequest]getSignTimer:nil gprsX:[NSString stringWithFormat:@"%f",baiduY] gprs:[NSString stringWithFormat:@"%f",baiduX] userName:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] callBack:^(NSString *string) {
            PL_PROGRESS_DISMISS;
            
            if ([string isEqualToString:@"exception"])
            {
                PL_ALERT_SHOW(@"考勤超时，请重新打卡");
                
            }
            else if ([string isEqualToString:@"OK"])
            {
                PL_ALERT_SHOW(@"打卡成功");
                [self SginTimeNotfation];
                
            }
            else if ([string isEqualToString:@"NoBusiness"])
            {
                PL_ALERT_SHOW(@"非营业员工没有App考勤打卡");
            }
            else if ([string isEqualToString:@"NoBusiness2"])
            {
                PL_ALERT_SHOW(@"您暂时无法使用app考勤打卡,请到门店打卡");
            }
            else if ([string isEqualToString:@"NoXYGPS"])
            {
                PL_ALERT_SHOW(@"员工所在部门坐标不存在");
            }
            else if ([string isEqualToString:@"DISTANCE"])
            {
                PL_ALERT_SHOW(@"超过500米经理审核");
            }
            else
            {
                PL_ALERT_SHOW(string);
            }
            [PL_MYREQUEST_DEFAULT afGetResaultUser:PL_USER_COREDATA_NAME userCookie:PL_USER_COREDATA_TOKEN call:^(id obj) {
                if (obj && [obj isKindOfClass:[NSArray class]])
                {
                    
                    _signArray = obj;
                    [self.historyTable reloadData];
                }
            }];
            
        }];

        
    }
        }
//打卡成功了执行此方法。用于获取当前时间发送通知
-(void)SginTimeNotfation
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"SginNotification" object:nil];
    
    NSDateFormatter*datef=[[NSDateFormatter alloc]init];
    datef.dateFormat=@"yyyy-MM-dd HH:mm";
    NSString*SiginTimDuty=[datef stringFromDate:[NSDate date]];
    [[NSUserDefaults standardUserDefaults]setObject:SiginTimDuty forKey:@"DutySignTime2"];
}
- (IBAction)historyBnt:(UIButton *)sender {
    NSLog(@"history");
    _isEqueToOne = YES;
    [_modelArray removeAllObjects];
    [_signArray removeAllObjects];
    [self.kaoqingBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.ronghanBut setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _signArray = [NSMutableArray array];
    
    [PL_MYREQUEST_DEFAULT afGetResaultUser:PL_USER_COREDATA_NAME userCookie:PL_USER_COREDATA_TOKEN call:^(id obj) {
        if ([obj isKindOfClass:[NSArray class]])
        {
            _signArray = obj;
            [self.historyTable reloadData];
        }
        
    }];
    [_historyTable reloadData];
    
}

- (IBAction)shareWeixinBnt {
    //微信分享
    
    NSLog(@"微信分像");
    NSLog(@"%@",[NSString stringWithFormat:@"http://61.129.51.211:9090/AppDetailPages/NameCard.aspx?UserCode=%@",self.strcode]);
    NSLog(@"%@",[NSString stringWithFormat:@"http://61.129.51.211:9090/AppDetailPages/NameCard.aspx?UserCode=%@",self.strcode]);

    if ([WXApi isWXAppInstalled])
    {
        NSString *shareText = [NSString stringWithFormat:@"部门:%@\n职位:%@\n电话:%@",self.bumenLable.text,self.zhiweiLable.text,self.phoneNum.text];
        //分享内嵌文字
        UIImage *shareImage = [UIImage imageNamed:@"byLogo.png"];          //分享内嵌图片
        
        //调用快速分享接口
//        54b730dcfd98c5d5ed000a3b
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"55a5c4f667e58e903b007641"
                                          shareText:shareText
                                         shareImage:shareImage
                                    shareToSnsNames:@[UMShareToWechatTimeline,UMShareToWechatSession,UMShareToWechatFavorite,]
                                           delegate:self];
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"http://61.129.51.211:9090/AppDetailPages/NameCard.aspx?UserCode=%@",self.strcode];
        [UMSocialData defaultData].extConfig.wechatTimelineData.title =[NSString stringWithFormat:@"%@,您身边的置业顾问",self.nameLable.text];
        [UMSocialData defaultData].extConfig.wechatSessionData.title =[NSString stringWithFormat:@"%@,您身边的置业顾问",self.nameLable.text];
        [UMSocialData defaultData].extConfig.wechatSessionData.url= [NSString stringWithFormat:@"http://61.129.51.211:9090/AppDetailPages/NameCard.aspx?UserCode=%@",self.strcode];
    }
    else
    {
        PL_ALERT_SHOWNOT_OKAND_YES(@"您未安装该应用，请前去下载，谢谢");
        
        
    }
//
    
    
}
#pragma mark --UMdelegate
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if (response.responseCode ==UMSResponseCodeSuccess)
    {
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
        PL_ALERT_SHOW(@"分享成功");
        
    }
}

- (IBAction)ronghan:(UIButton *)sender {
    [_signArray removeAllObjects];
    [_modelArray removeAllObjects];
    [self.kaoqingBut setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.ronghanBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
      _isEqueToOne = NO;
    NSLog(@"ronghan");
    NSString *  name = [PL_USER_STORAGE objectForKey:PL_USER_NAME];
    NSString * token = [PL_USER_STORAGE objectForKey:PL_USER_TOKEN];
    
    [self requestObj:name token:token];
    [_historyTable reloadData];
}
@end