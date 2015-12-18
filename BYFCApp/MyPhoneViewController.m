//
//  MyPhoneViewController.m
//  BYFCApp
//
//  Created by zzs on 15/4/20.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "MyPhoneViewController.h"
#import "PL_Header.h"
#import "MyphoneTableViewCell.h"

@interface MyPhoneViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{

    //下属通话记录列表
    UITableView *subVisterTableView;
    NSMutableArray *_array;
    NSMutableString *_resultString;
    NSDictionary *dictionary;
    //判断电话呼出呼入
    NSString *IO;
    BOOL  isIO;
    
    //保存电话
    NSMutableArray *phoneArray;
    //页数记录器
    NSInteger pageCount;
    
    //custid
    NSString *clustID;
    //自定义cellnib
    UINib *nib;
    //通话时间筛选视图
//    TimeFilterView *timeFileterView;
    //通话记录时间
    NSString *timeString;
}
/*
 *Title:Action
 *DT:底部呼入呼出相关
 *2015.6.19 添加（SHC）
 *删除以前不完善功能
*/
//拨打电话主视图
@property (strong, nonatomic) IBOutlet UIView *mainView;
//呼出按钮
@property (weak, nonatomic) IBOutlet UIButton *btnDials;
//呼出事件
- (IBAction)btnDial:(UIButton *)sender;
//呼出image
@property (weak, nonatomic) IBOutlet UIImageView *imgDial;
//呼入按钮
@property (weak, nonatomic) IBOutlet UIButton *btnComings;
//呼入事件
- (IBAction)btnComing:(UIButton *)sender;
//呼入image
@property (weak, nonatomic) IBOutlet UIImageView *imgComing;
/*
 *Title:End
 */

@end


@implementation MyPhoneViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = NO;
    
   // [self getSupCode];
    NSLog(@"%s",__FUNCTION__);
    self.title = @"通话记录";
    self.view.backgroundColor = [UIColor whiteColor];

    // 初始化通话记录
    [self formatSubVisterTableView];
    timeString = @"7";
#pragma mark - 通话时间筛选按钮(2015年6月19日取消功能，如需添加解注)
    /*
    timeFileterView = [[TimeFilterView alloc]initWithFrame:CGRectMake(0, 64, PL_WIDTH, 50) andTitlleArray:@[@"7天以内",@"7—30天",@"30—90天",@"90—180天"]];
    timeFileterView.delegate = self;
    [self.view addSubview:timeFileterView];
     */
    isIO = YES;
    IO = @"1";
    //点进去加载呼出通话记录
     [self postRequest];
    //背景线
    _mainView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-44, [UIScreen mainScreen].bounds.size.width, 44);
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, 1)];
    label.backgroundColor = [UIColor grayColor];
    [_mainView addSubview:label];
    
    _imgDial.image = [UIImage imageNamed:@"phone_huchu"];
    _imgComing.image = [UIImage imageNamed:@"phone_huru_hui"];
    [self.view addSubview:_mainView];
    [_btnDials setBackgroundImage:[UIImage imageNamed:@"beijing"] forState:UIControlStateNormal];
    [_btnComings setBackgroundImage:[UIImage imageNamed:@"beijing"] forState:UIControlStateNormal];
    //自定义返回按钮
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    [self setupRefresh];
}
#pragma mark 顶部时间筛选按钮代理
-(void)whichButtonClick:(UIButton *)sender
{
    NSLog(@"%ld",(long)sender.tag);
    switch (sender.tag) {
        case 0:
            timeString = @"7";
            break;
        case 1:
            timeString = @"30";
            break;
        case 2:
            timeString = @"90";
            break;
        default:
            timeString = @"180";
            break;
    }
    [self postRequest];
}
#pragma mark -----请求通话记录数据
-(void)postRequest{
    NSLog(@"%s",__FUNCTION__);
    [_array removeAllObjects];
    pageCount = 1;
    PL_PROGRESS_SHOW;
    NSLog(@"%@",[PL_USER_STORAGE objectForKey:PL_USER_code]);
    ;
    [[MyRequest defaultsRequest] afGetPhoneHistory:IO Time:timeString Type:[NSString stringWithFormat:@"%ld",(long)self.type] FlagSubs:@"0" SubUserCode:[PL_USER_STORAGE objectForKey:PL_USER_code] SubPhone:@"" SubDutyCode:@"" StarIndex:[NSString stringWithFormat:@"%ld",(long)pageCount] userid:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSMutableString *str) {
        _resultString=str;
        NSLog(@"str===%@",str);
        if ([str isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        if ([str isEqualToString:@"[]"]) {
            
//            UILabel * label = [[UILabel alloc]init];
//            label.text = @"暂无数据";
//            label.textAlignment = NSTextAlignmentCenter;
            PL_ALERT_SHOW(@"暂无通话记录");
            [_array removeAllObjects];
        }
        else  if ([str isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
            [_array removeAllObjects];
        }
        else
        {
            SBJSON *json=[[SBJSON alloc]init];
            _array=[json objectWithString:_resultString error:nil];
            NSLog(@"%lu",(unsigned long)_array.count);
            NSLog(@"---------------------------->>>>>>>%@",_array);
        }
        [subVisterTableView reloadData];
        PL_PROGRESS_DISMISS;
    }];
}
#pragma mark -- 初始化通话记录列表
-(void)formatSubVisterTableView
{
    subVisterTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)-50-44) style:UITableViewStylePlain];
    subVisterTableView.delegate=self;
    subVisterTableView.dataSource=self;
    subVisterTableView.tableFooterView=[UIView new];
    subVisterTableView.rowHeight = 71;
    subVisterTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    //subVisterTableView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:subVisterTableView];
}
#pragma mark -- 自定义返回按钮
-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- 表格方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return _array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusedID = @"cellReusedID";
    dictionary=[_array objectAtIndex:indexPath.row];
    
    phoneArray = [NSMutableArray arrayWithObject:[[dictionary objectForKey:@"CustTel"]componentsSeparatedByString:@"|"].firstObject];
    
    if (!nib) {
        nib = [UINib nibWithNibName:@"MyphoneTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:reusedID];
    }
    MyphoneTableViewCell *phoneCell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    
    if (_array.count>0) {
        phoneCell.customLabel.text = [dictionary objectForKey:@"Name"];
        phoneCell.phoneLabel.text =  [[dictionary objectForKey:@"CustTel"]componentsSeparatedByString:@"|"].firstObject;
        phoneCell.nowTimeLabel.text = [dictionary objectForKey:@"TalkDuration"];
         phoneCell.phoneTimeLabel.text = [[dictionary objectForKey:@"InboundCallTime"]substringWithRange:NSMakeRange(5, ((NSString*)[dictionary objectForKey:@"InboundCallTime"]).length - 8)];
        phoneCell.yewuTypeLabel.text = [dictionary objectForKey:@"CustID"];
        if (isIO) {
            phoneCell.typeImagview.image = [UIImage imageNamed:@"huchu_lv"];
        }
        else
        {
            phoneCell.typeImagview.image = [UIImage imageNamed:@"huru_lv"];
        }
    }
    return phoneCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    dictionary=[_array objectAtIndex:indexPath.row];
    NSLog(@"主叫方电话：%@",[PL_USER_STORAGE objectForKey:PL_USER_PHONEnUM]);
    NSLog(@"客源ID：%@",[dictionary objectForKey:@"ID"]);
    NSLog(@"被叫方电话：%@",[[dictionary objectForKey:@"CustTel"]componentsSeparatedByString:@"|"].firstObject);
    NSLog(@"上级编号:%@",[PL_USER_STORAGE objectForKey:PL_USER_SUPCODE]);
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@:%@",[dictionary objectForKey:@"Name"],[[dictionary objectForKey:@"CustTel"]componentsSeparatedByString:@"|"].firstObject] delegate:self cancelButtonTitle:@"拨打" otherButtonTitles:@"取消", nil];
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"第%ld个",(long)buttonIndex);
    if (buttonIndex==0) {
        [self callBtn];
    }
    
}

-(void)callBtn{

    NSLog(@"打电话");
    [[MyRequest defaultsRequest]afDialCustTelephone:[PL_USER_STORAGE objectForKey:PL_USER_PHONEnUM] CustPhone:[[dictionary objectForKey:@"CustTel"]componentsSeparatedByString:@"|"].lastObject ID:[dictionary objectForKey:@"ID"] Type:@"0" FromCode:[PL_USER_STORAGE objectForKey:PL_USER_SUPCODE] userid:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSMutableString *str)
     {
         if ([str isEqualToString:@"True"]) {
         
             [UIAlertView showAlertWithTitle:@"提示" message:@"The system is dialing now,please wait" duration:0.1];
             
//             [NSTimer  scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(alertDistMiss) userInfo:nil repeats:NO];
         }
         
         NSLog(@"%@",[PL_USER_STORAGE objectForKey:PL_USER_PHONEnUM]);
                      NSLog(@"%@",[[dictionary objectForKey:@"CustTel"]componentsSeparatedByString:@"|"].firstObject);
         NSLog(@"%@",[dictionary objectForKey:@"ID"]);
            NSLog(@"%@",[PL_USER_STORAGE objectForKey:PL_USER_SUPCODE]);
         
         NSLog(@"%@",[PL_USER_STORAGE objectForKey:PL_USER_USERID]);
         NSLog(@"%@",[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]);
         NSLog(@"%@",str);
     }];
}
-(void)alertDistMiss
{
//    UIAlertView *aler = (UIAlertView *)[self.view viewWithTag:1000];
}
#pragma mark --上啦下拉刷新
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    // [table addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    [subVisterTableView addHeaderWithTarget:self action:@selector(headerRereshing1)];
    //#warning 自动刷新(一进入程序就下拉刷新)
     //   [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [subVisterTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    subVisterTableView.headerPullToRefreshText = @"下拉刷新";
    subVisterTableView.headerReleaseToRefreshText = @"松开刷新";
    subVisterTableView.headerRefreshingText = @"正在刷新中";
    subVisterTableView.footerPullToRefreshText = @"上拉加载更多数据";
    subVisterTableView.footerReleaseToRefreshText = @"松开加载更多数据";
    subVisterTableView.footerRefreshingText = @"正在加载中";
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing1
{
    pageCount ++;
    [[MyRequest defaultsRequest] afGetPhoneHistory:IO Time:timeString Type:@"0" FlagSubs:@"0" SubUserCode:@"" SubPhone:@"" SubDutyCode:@"" StarIndex:[NSString stringWithFormat:@"%ld",(long)pageCount] userid:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSMutableString *str) {
        _resultString=str;
        NSLog(@"str===%@",str);
        if ([str isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        if ([str isEqualToString:@"[]"]) {
            UILabel * label = [[UILabel alloc]init];
            label.text = @"暂无数据";
            label.textAlignment = NSTextAlignmentCenter;
            PL_ALERT_SHOW(@"暂无通话记录");
//            [_array removeAllObjects];
        }
        else  if ([str isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
            [_array removeAllObjects];
        }
        else
        {
            SBJSON *json=[[SBJSON alloc]init];
            NSMutableArray *resultArray = [[NSMutableArray alloc]init];
            resultArray =[json objectWithString:_resultString error:nil];
            [_array addObjectsFromArray:resultArray];
            NSLog(@"%lu",(unsigned long)_array.count);
            NSLog(@"---------------------------->>>>>>>%@",_array);
        }
        [subVisterTableView reloadData];
        [subVisterTableView headerEndRefreshing];
        PL_PROGRESS_DISMISS;
    }];
}
- (void)footerRereshing
{
    pageCount++;
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest] afGetPhoneHistory:IO Time:timeString Type:@"0" FlagSubs:@"0" SubUserCode:@"" SubPhone:@"" SubDutyCode:@"" StarIndex:[NSString stringWithFormat:@"%ld",(long)pageCount] userid:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSMutableString *str) {
        _resultString=str;
        NSLog(@"str===%@",str);
        if ([str isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        if ([str isEqualToString:@"[]"]) {
            UILabel * label = [[UILabel alloc]init];
            label.text = @"暂无数据";
            label.textAlignment = NSTextAlignmentCenter;
            PL_ALERT_SHOW(@"暂无通话记录");
//            [_array removeAllObjects];
        }
        else  if ([str isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
            [_array removeAllObjects];
        }
        else
        {
            SBJSON *json=[[SBJSON alloc]init];
            NSMutableArray *resultArray = [[NSMutableArray alloc]init];
            resultArray =[json objectWithString:_resultString error:nil];
            [_array addObjectsFromArray:resultArray];
            
            NSLog(@"%lu",(unsigned long)_array.count);
            NSLog(@"---------------------------->>>>>>>%@",_array);
        }
        [subVisterTableView reloadData];
        [subVisterTableView footerEndRefreshing];
        PL_PROGRESS_DISMISS;
    }];
}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *cellreuseID = @"cellReuse";
//    
//    UINib *nib = [UINib nibWithNibName:@"RecordTableViewCell" bundle:nil];
//    
//    [tableView registerNib:nib forCellReuseIdentifier:cellreuseID];
//
//    
//   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellreuseID  ];
//    
//    self.recordViewCell= [tableView dequeueReusableCellWithIdentifier:cellreuseID];
////    if (self.recordViewCell == nil) {
////              self.recordViewCell = [[RecordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellreuseID];
//    
//        self.recordViewCell.recordImage.image = [UIImage imageNamed:@"shijia"];
//        self.recordViewCell.nameLabel.text = @"zhangsan";
//       self.recordViewCell.phoneLabel.text = @"12344555661";
//        self.recordViewCell.phoneTimeLabel.text = @"15-04-13 13:13";
//        self.recordViewCell.nowLabel.text = @"45:56";
////    }
//
//    return self.recordViewCell;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark ------底部呼入按钮方法(SHC.2015.6.19修改)
- (IBAction)btnDial:(UIButton *)sender {
    _imgDial.image = [UIImage imageNamed:@"phone_huchu"];
    _imgComing.image = [UIImage imageNamed:@"phone_huru_hui"];
    isIO = YES;
    IO = @"1";
    [self postRequest];
}
#pragma mark ------底部呼进电话按钮方法(SHC.2015.6.19修改)
- (IBAction)btnComing:(UIButton *)sender {
    _imgComing.image = [UIImage imageNamed:@"phone_huru"];
    _imgDial.image = [UIImage imageNamed:@"phone_huchu_hui"];
    IO = @"0";
    isIO = NO;
    [self postRequest];
}
@end
