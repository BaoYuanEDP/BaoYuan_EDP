//
//  FollowUpListViewController.m
//  BYFCApp
//
//  Created by zzs on 15/5/21.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "FollowUpListViewController.h"
#import "PL_Header.h"
@interface FollowUpListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    //跟进列表
    UITableView *FollowUpListTableView;
    //页面上方检索条件三个小列表
   // UITableView *FollowUphallTableView;
    __weak IBOutlet UIButton *firstDateTimeButton;
    __weak IBOutlet UIButton *lastDateTimeButton;
    __weak IBOutlet UIButton *genjinleixingButton;
    __weak IBOutlet UIButton *genjinfangshiButton;
    
    __weak IBOutlet UIButton *jiaoyileixingButton;
    
    int a;
    NSArray *styleArray;
    NSMutableArray *_followListArray;
    //页数记录器
    NSInteger pageCount;
    //定义字符串判断领导与客户经理
    NSString * flagSubs;
    
}

@property(nonatomic,strong)UITableView *FollowUphallTableView;

@property(nonatomic,strong)NSString *followListdutyCode;
@end

@implementation FollowUpListViewController

-(UITableView *)FollowUphallTableView{

    if (!_FollowUphallTableView) {
        _FollowUphallTableView = [[UITableView alloc]init];
        _FollowUphallTableView.delegate = self;
        _FollowUphallTableView.dataSource = self;
    }

    return _FollowUphallTableView;
}

-(NSString *)followListdutyCode{

    NSLog(@"%@",[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE]);
    _followListdutyCode = [[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE]substringWithRange:NSMakeRange([[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE] length] - 1, 1)];

   return _followListdutyCode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"跟进查询";
    //初始化followi列表
    [self formatFollowUpList];
    //判断领导客户经理
    [self isBoss];
    NSLog(@"_dutycode:%@",_dutyCode);
    pageCount = 1;
    genjinfangshiArray =[NSArray arrayWithObjects:@"电话",@"手机",@"微信",@"QQ", @"其他",nil];
    jiaoyileixingArray = [NSArray arrayWithObjects:@"求购",@"求租", nil];

    //自定义返回按钮
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    [self setupRefresh];
    
}
#pragma mark -----自定义返回按钮方法
-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ---选第一个跟进日期
- (IBAction)FirstDateTime:(UIButton *)sender {
    DatePickerView *datePickerView = [[DatePickerView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [datePickerView addSelfInAView:self.view comPleteBlock:^(NSString *str) {
        
        firstdateTimeStr = str;
        NSLog(@"%@",firstdateTimeStr);
        [firstDateTimeButton setTitle:str forState:UIControlStateNormal];
        
    }];
    
}
#pragma mark ---选第2个跟进日期
- (IBAction)LastDateTime:(UIButton *)sender {
    
    DatePickerView *datePickerView = [[DatePickerView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [datePickerView addSelfInAView:self.view comPleteBlock:^(NSString *str) {
        
        lastdateTimeStr = str;
        NSLog(@"%@",lastdateTimeStr);
        [lastDateTimeButton setTitle:str forState:UIControlStateNormal];
        
    }];
    
    
}

#pragma mark ---判断领导与客户经理
-(void)isBoss{
   
    if ([_followListdutyCode isEqualToString:@"E"]) {
        flagSubs =@"0";
        _dutyCode  = _followListdutyCode;
    }else
    {
        flagSubs = @"1";
    }


}

#pragma mark ---点击搜索按钮
- (IBAction)SearchButton:(UIButton *)sender {

    pageCount = 1;
    
    if (jiaoyileixingStr ==nil) {
        jiaoyileixingStr =@"";
    }
    if (genjinfangshiStr == nil) {
        genjinfangshiStr= @"";
    }
    if (genjinleixingStr == nil) {
        genjinleixingStr = @"";
    }
    if (firstdateTimeStr == nil) {
        firstdateTimeStr = @"";
    }
    if (lastdateTimeStr == nil) {
        lastdateTimeStr = @"";
    }if (_dutyCode == nil) {
        _dutyCode = @"";
    }

    NSLog(@"-交易类型：%@",jiaoyileixingStr);
    NSLog(@"-跟进类型：%@",genjinleixingStr);
    NSLog(@"-跟进方式：%@",genjinfangshiStr);
    NSLog(@"-跟进时间1：%@",firstdateTimeStr);
    NSLog(@"-跟进时间2：%@",lastdateTimeStr);
    NSLog(@"-dutycode:%@",_dutyCode);
//    [_followListArray removeAllObjects];
    PL_PROGRESS_SHOW;
[[MyRequest defaultsRequest]afGetFollowListTrade:jiaoyileixingStr FollowType:genjinleixingStr FollowWay:genjinfangshiStr FollowDateFrom:firstdateTimeStr FollowDateTo:lastdateTimeStr FlagSubs:flagSubs SubUserCode:_dutyCode StartIndex:[NSString stringWithFormat:@"%ld",(long)pageCount] completeBack:^(NSString *str) {
    //NSLog(@"\n\n%@",str);
    if ([str isEqualToString:@"NOLOGIN"]) {
        ViewController *login=[[ViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }
    if ([str isEqualToString:@"[]"]) {
        
        UILabel * label = [[UILabel alloc]init];
        label.text = @"暂无数据";
        label.textAlignment = NSTextAlignmentCenter;
        PL_ALERT_SHOW(@"暂无数据");
        [_followListArray removeAllObjects];
    }
    else  if ([str isEqualToString:@"exception"]) {
        PL_ALERT_SHOW(@"服务器异常");
        [_followListArray removeAllObjects];
    }
    else
    {
        SBJSON *json=[[SBJSON alloc]init];
        _followListArray=[json objectWithString:str error:nil];
        
        NSLog(@"%lu",(unsigned long)_followListArray.count);
        //NSLog(@"---------------------------->>>>>>>%@",_array);
        
    }
    [FollowUpListTableView reloadData];
    
    
    PL_PROGRESS_DISMISS;

    
}];
    
    
    
}
#pragma mark ---点击跟进类型按钮
- (IBAction)GenjinTypeButton:(UIButton *)sender {
    
    genjinfangshiButton.selected = NO;
    jiaoyileixingButton.selected = NO;
    
    a = 1;
    [self post];
    if (!sender.selected)
    {
        self.FollowUphallTableView.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y+sender.frame.size.height+65, 100, 130) ;
        
        [self.view addSubview:self.FollowUphallTableView];
        
        self.FollowUphallTableView.backgroundColor = [UIColor grayColor];
        self.FollowUphallTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        self.FollowUphallTableView.layer.masksToBounds=YES;
        self.FollowUphallTableView.layer.cornerRadius=10;
        

        sender.selected = YES;
//        [self.FollowUphallTableView reloadData];
    }
    else
    {
        
        [self.FollowUphallTableView removeFromSuperview];
        sender.selected = NO;
    }

    
}

#pragma mark ---点击跟进方式按钮
- (IBAction)GenjinfangshiButton:(UIButton *)sender {

    a=2;
    genjinleixingButton.selected = NO;
    jiaoyileixingButton.selected = NO;
    
    if (!sender.selected)
    {
        self.FollowUphallTableView.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y+sender.frame.size.height+65, 100, 120) ;
        
        [self.view addSubview:self.FollowUphallTableView];
        
        self.FollowUphallTableView.backgroundColor = [UIColor grayColor];
        self.FollowUphallTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        self.FollowUphallTableView.layer.masksToBounds=YES;
        self.FollowUphallTableView.layer.cornerRadius=10;
        sender.selected = YES;
        [self.FollowUphallTableView reloadData];
    }
    else
    {
        
        [self.FollowUphallTableView removeFromSuperview];
        sender.selected = NO;
    }

}
#pragma mark ---点击交易类型按钮
- (IBAction)JiaoyiType:(UIButton *)sender {

    a=3;
    genjinfangshiButton.selected = NO;
    genjinleixingButton.selected = NO;
    if (!sender.selected)
    {
        self.FollowUphallTableView.frame = CGRectMake(sender.frame.origin.x-20, sender.frame.origin.y+sender.frame.size.height+65, 100, 120) ;
        
        [self.view addSubview:self.FollowUphallTableView];
        
        self.FollowUphallTableView.backgroundColor = [UIColor grayColor];
        self.FollowUphallTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        self.FollowUphallTableView.layer.masksToBounds=YES;
        self.FollowUphallTableView.layer.cornerRadius=10;

        sender.selected = YES;
        [self.FollowUphallTableView reloadData];
    }
    else
    {
        
        [self.FollowUphallTableView removeFromSuperview];
        sender.selected = NO;
    }

}

//请求数据
-(void)post{
    
    if (a==1) {
        NSLog(@"******");
        styleArray = [NSArray array];
        

                      [[MyRequest defaultsRequest]GetFollowTypeList:^(NSMutableString *string) {
                NSLog(@"O&&&&&&&&&&&&&&%@",string);
                if ([string isEqualToString:@"NOLOGIN"]) {
                    ViewController *login=[[ViewController alloc]init];
                    [self.navigationController popToViewController:login animated:YES];
                }
                if ([string isEqualToString:@"[]"]) {
                    PL_ALERT_SHOW(@"暂无数据");
                }
                SBJSON *json=[[SBJSON alloc]init];
                styleArray=[json objectWithString:string error:nil];
                NSLog(@"%@",styleArray);
                [self.FollowUphallTableView reloadData];
                
                //   [smallView addSubview:sousuoViewstyle];
                
            }userid:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME] token:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN]];
        
    }
    
}




#pragma mark -----初始化跟进列表
-(void)formatFollowUpList{

    FollowUpListTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44+74+20, ([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)-44-74-20) style:UITableViewStylePlain];
    FollowUpListTableView.delegate=self;
    FollowUpListTableView.dataSource=self;
    FollowUpListTableView.tableFooterView=[UIView new];
    FollowUpListTableView.rowHeight = 120;
//    [FollowUpListTableView registerNib:[UINib nibWithNibName:@"FollowUpListTableViewCell" bundle:nil] forCellReuseIdentifier:@"flagcell"];
    //FollowUpListTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    //subVisterTableView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:FollowUpListTableView];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    if (tableView == self.FollowUphallTableView ) {
        if (a==1)
        {
            return styleArray.count;
        }
        else if (a==2)
        {
            return 4;
        }
        else if(a==3)
        {
            return 2;
        }

    }
        else
        {
        return _followListArray.count;
    }
    return  0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"%s",__FUNCTION__);
    static NSString *flag = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flag  ];
    //cell.backgroundColor = [UIColor clearColor];
    
    
    if (tableView == self.FollowUphallTableView) {
      
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
        }
        if (a==1) {
            if (styleArray.count==0) {
                NSArray*substitutionArray=@[@"录入约看",@"录入带看",@"意向金",@"议价谈判",@"过户",@"客户需求",@"信息补充",@"推荐反馈",@"经理分析",@"物业校验"];
                cell.textLabel.text=substitutionArray[indexPath.row];
                
            }else
            {
                  NSDictionary *dict = [styleArray objectAtIndex:indexPath.row];
                cell.textLabel.text = [dict objectForKey:@"FollowType"];

            }
        }
        if (a==2) {
            cell.textLabel.text = genjinfangshiArray[indexPath.row];
            
        }
        if (a==3) {
            cell.textLabel.text = jiaoyileixingArray[indexPath.row];
        }
        
    }
    
    if (tableView == FollowUpListTableView) {

        NSDictionary *followDict = [_followListArray objectAtIndex:indexPath.row];
        FollowUpListTableViewCell *followUpListCell = [tableView dequeueReusableCellWithIdentifier:@"flagcell"];
        if(followUpListCell == nil)
        {
            followUpListCell = [[[NSBundle mainBundle] loadNibNamed:@"FollowUpListTableViewCell" owner:self options:nil] lastObject];
        }
        followUpListCell.CustName.text = [followDict objectForKey:@"CustName"];
        followUpListCell.FollowType.text = [followDict objectForKey:@"FollowType"];
        followUpListCell.EmpName.text = [followDict objectForKey:@"EmpName"];
        followUpListCell.FollowWay.text = [followDict objectForKey:@"FollowWay"];
        
        followUpListCell.Trade.text = [[@"(" stringByAppendingString:[followDict objectForKey:@"Trade"]] stringByAppendingString:@")"];
        followUpListCell.Content.text = [followDict objectForKey:@"Content"];
        
        followUpListCell.FollowDate.text = [followDict objectForKey:@"FollowDate"];
        return followUpListCell;
    }
    cell.backgroundColor=[UIColor clearColor];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *dict = [styleArray objectAtIndex:indexPath.row];
    if (a==1) {
        genjinleixingStr = [dict objectForKey:@"FollowType"];
        [genjinleixingButton setTitle:genjinleixingStr forState:UIControlStateNormal];
        [self.FollowUphallTableView removeFromSuperview];
    }else if(a==2){
    
        genjinfangshiStr =genjinfangshiArray[indexPath.row];
        [genjinfangshiButton setTitle:genjinfangshiStr forState:UIControlStateNormal];
        NSLog(@"%@",genjinfangshiStr);
        [self.FollowUphallTableView removeFromSuperview];
    }else if(a==3){
    
        jiaoyileixingStr = jiaoyileixingArray[indexPath.row];
        [jiaoyileixingButton setTitle:jiaoyileixingStr forState:UIControlStateNormal];
        NSLog(@"%@",jiaoyileixingStr);
        [self.FollowUphallTableView removeFromSuperview];
    }
    

}


#pragma mark --上啦下拉刷新
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    // [table addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    [FollowUpListTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    //    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [FollowUpListTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    FollowUpListTableView.headerPullToRefreshText = @"下拉刷新";
    FollowUpListTableView.headerReleaseToRefreshText = @"松开刷新";
    FollowUpListTableView.headerRefreshingText = @"正在刷新中";
    
    FollowUpListTableView.footerPullToRefreshText = @"上拉加载更多数据";
    FollowUpListTableView.footerReleaseToRefreshText = @"松开加载更多数据";
    FollowUpListTableView.footerRefreshingText = @"正在加载中";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    NSLog(@"-交易类型：%@",jiaoyileixingStr);
    NSLog(@"-跟进类型：%@",genjinleixingStr);
    NSLog(@"-跟进方式：%@",genjinfangshiStr);
    NSLog(@"-跟进时间1：%@",firstdateTimeStr);
    NSLog(@"-跟进时间2：%@",lastdateTimeStr);
    NSLog(@"-dutycode:%@",_dutyCode);
    
    if (jiaoyileixingStr ==nil) {
        jiaoyileixingStr =@"";
    }
    if (genjinfangshiStr == nil) {
        genjinfangshiStr= @"";
    }
    if (genjinleixingStr == nil) {
        genjinleixingStr = @"";
    }
    if (firstdateTimeStr == nil) {
        firstdateTimeStr = @"";
    }
    if (lastdateTimeStr == nil) {
        lastdateTimeStr = @"";
    }


    
  //  pageCount ++;
    [[MyRequest defaultsRequest]afGetFollowListTrade:jiaoyileixingStr FollowType:genjinleixingStr FollowWay:genjinfangshiStr FollowDateFrom:firstdateTimeStr FollowDateTo:lastdateTimeStr FlagSubs:flagSubs  SubUserCode:_dutyCode  StartIndex:[NSString stringWithFormat:@"%ld",(long)pageCount] completeBack:^(NSString *str) {
        
        NSLog(@"\n\n%@",str);
        
        if ([str isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        if ([str isEqualToString:@"[]"]) {
            
            UILabel * label = [[UILabel alloc]init];
            label.text = @"暂无数据";
            label.textAlignment = NSTextAlignmentCenter;
            PL_ALERT_SHOW(@"暂无更多数据");
            //[_followListArray removeAllObjects];
        }
        else  if ([str isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
            //[_followListArray removeAllObjects];
        }
        else
        {
            SBJSON *json=[[SBJSON alloc]init];
            _followListArray=[json objectWithString:str error:nil];
            
            NSLog(@"%lu",(unsigned long)_followListArray.count);
            //NSLog(@"---------------------------->>>>>>>%@",_array);
            
        }

       [FollowUpListTableView reloadData];
        
        [FollowUpListTableView headerEndRefreshing];
        
        PL_PROGRESS_DISMISS;
        
        
    }];
}
- (void)footerRereshing
{
    pageCount ++;
    [[MyRequest defaultsRequest]afGetFollowListTrade:jiaoyileixingStr FollowType:genjinleixingStr FollowWay:genjinfangshiStr FollowDateFrom:firstdateTimeStr FollowDateTo:lastdateTimeStr FlagSubs:flagSubs   SubUserCode:_dutyCode StartIndex:[NSString stringWithFormat:@"%ld",(long)pageCount] completeBack:^(NSString *str) {
        
        NSLog(@"\n\n%@",str);
        
        if ([str isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        if ([str isEqualToString:@"[]"]) {
            
            UILabel * label = [[UILabel alloc]init];
            label.text = @"暂无数据";
            label.textAlignment = NSTextAlignmentCenter;
            PL_ALERT_SHOW(@"暂无更多数据");
            //[_followListArray removeAllObjects];
        }
        else  if ([str isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
            //[_followListArray removeAllObjects];
        }
        else
        {
        
          
            SBJSON *json=[[SBJSON alloc]init];
            
         
            [_followListArray addObjectsFromArray:[json objectWithString:str error:nil]];
         
//            _followListArray=[json objectWithString:str error:nil];
            
            NSLog(@"%lu",(unsigned long)_followListArray.count);
            //NSLog(@"---------------------------->>>>>>>%@",_array);
            
        }

        [FollowUpListTableView reloadData];
        
        [FollowUpListTableView footerEndRefreshing];
        PL_PROGRESS_DISMISS;
        
        
    }];}


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

@end
