//
//  LookAboutViewController.m
//  BYFCApp
//
//  Created by PengLee on 15/5/21.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "LookAboutViewController.h"
#import "PL_Header.h"

@interface LookAboutViewController ()<UITableViewDataSource,UITabBarDelegate,CustomDelegate,UITableViewDelegate>
{
    LookAboutTableViewCell *lookAboutTableViewCell;
    NSString * _string1;
    NSString * _string2;
    NSInteger  pagecount;
    BOOL isSende;
}

@property (weak, nonatomic) IBOutlet UIButton *zoneButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *fromDateButton;
@property (weak, nonatomic) IBOutlet UIButton *todateButton;
@property (weak, nonatomic) IBOutlet UITableView *sourcesTableView;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *quyuLabel;
@property (nonatomic,strong) NSMutableArray *dataSourceArray;
@property (weak, nonatomic) IBOutlet UILabel *lableH;

@end

@implementation LookAboutViewController

-(NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        _dataSourceArray = [[NSMutableArray alloc]init];
    }
    return _dataSourceArray;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    switch (self.fromType) {
        case 0:
            self.navigationController.navigationBarHidden = NO;
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    pagecount = 0;
    [self setBackButton];
    [self setupRefresh];
    
}



-(void)setBackButton
{
    //标题
    self.title = @"带看查询";
    //自定义返回按钮
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    //注册cell
    UINib *nib = [UINib nibWithNibName:@"LookAboutTableViewCell" bundle:nil];
    [self.sourcesTableView registerNib:nib forCellReuseIdentifier:@"lookcellReuseID"];
    
    self.zoneButton.layer.borderWidth = 1;
    self.zoneButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.fromDateButton.layer.borderWidth = 1;
    self.fromDateButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.todateButton.layer.borderWidth = 1;
    self.todateButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.topView.layer.borderWidth = 1;
    self.topView.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    
}

- (IBAction)clickSearchButton:(UIButton *)sender
{
    
    pagecount = 1;
    [self.dataSourceArray removeAllObjects];
    [self postRequest];
    
}
#pragma mark 请求数据
-(void)postRequest
{
    NSLog(@"%s",__FUNCTION__);
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]afGetGoSeeListWithDistrictName:_string1.length == 0 ? @"":_string1 AreaName:_string2.length == 0 ? @"":_string2 EstateName:@"" DateFrom:self.fromDateButton.currentTitle.length == 0 ? @"":self.fromDateButton.currentTitle DateTo:self.todateButton.currentTitle.length == 0 ? @"":self.todateButton.currentTitle FlagSubs:self.subUserCode.length == 0 ? @"0":@"1" SubUserCode:self.subUserCode.length == 0 ? @"":self.subUserCode StartIndex:@(pagecount).description completeBack:^(NSString *str)
    {
        PL_PROGRESS_DISMISS;
        NSLog(@"%@",str);
        if ([str isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        if ([str isEqualToString:@"[]"]) {
            
//            UILabel * label = [[UILabel alloc]init];
//            label.text = @"暂无数据";
//            label.textAlignment = NSTextAlignmentCenter;
            PL_ALERT_SHOW(@"暂无数据");
//            [self.dataSourceArray removeAllObjects];
            [self.sourcesTableView reloadData];

        }
        else  if ([str isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
            [self.dataSourceArray removeAllObjects];
            [self.sourcesTableView reloadData];

        }
        else
        {
            
            SBJSON *json=[[SBJSON alloc]init];
            NSArray *array = [json objectWithString:str error:nil];
            [self.dataSourceArray addObjectsFromArray:array];
            
            [self.sourcesTableView reloadData];
//            
//            NSUserDefaults*user3=[NSUserDefaults standardUserDefaults];
//            
//            [user3 setObject:self.dataSourceArray forKey:@"MainData"];
            
            
        }
            
        }
     
     
    ];

}

#pragma mark --区域选择
- (IBAction)clickZoneButton:(UIButton *)sender
{
    [[VisitersRequest defaultsRequest]requestAreaInfoMessage:@"2" roomDistrictId:@"" roomDisName:@"" userName:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userTokne:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] backInfoMessage:^(NSMutableArray *array) {
        
        if (array.count>0)
        {
            //            NSLog(@"=========%s",__FUNCTION__);
           NSMutableArray * tempArray = [NSMutableArray array];
            
            for (NSDictionary * dict in array)
            {
            roomAreaPlace * roomArea = [[roomAreaPlace alloc]init];
                
           
                roomArea.areaDistrictId = dict[@"DistrictId"];
                roomArea.areaDistrictName =dict[@"DistrictName"];
                NSLog(@"++++++%@,%@",roomArea.areaDistrictId,roomArea.areaDistrictName);
                [tempArray addObject:roomArea];
            }
            roomAreaPlace * virtuRoom = [[roomAreaPlace alloc]init];
            virtuRoom.areaDistrictName = @"不限";
            virtuRoom.areaDistrictId   = @"";
            [tempArray insertObject:virtuRoom atIndex:0];
            CustomAddView * addView = [[CustomAddView alloc]initWithArray:tempArray];
            addView.delegate = nil;
            addView.delegate = self;
            [addView showInView:self.view animation:YES];
        }
        else
        {
            PL_ALERT_SHOWNOT_OKAND_YES(@"暂无区域数据");
            
        }
        
    } string:^(NSString *string) {
        
    }];
}

#pragma mark --开始日期
- (IBAction)clickFromDateButton:(UIButton *)sender
{
    DatePickerView *dpView = [[DatePickerView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [dpView addSelfInAView:self.view comPleteBlock:^(NSString *str) {
        [sender setTitle:str forState:UIControlStateNormal];
    }];
}
#pragma mark -- 结束日期
- (IBAction)clickToDateButton:(UIButton *)sender
{
    
    DatePickerView *dpView = [[DatePickerView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [dpView addSelfInAView:self.view comPleteBlock:^(NSString *str) {
//        [sender setTitle:str forState:UIControlStateNormal];
        self.lableH.text = str;
    }];
}
#pragma mark 代理
-(void)didSelectRowIndexPath:(NSIndexPath *)indexPath administrativeArea:(NSString *)adminnistat
{
   
    
    if ([adminnistat isEqualToString:@"不限"]) {
        _string1 = @"";
        _string1 = @"";
    }
    else
    {
        _string1 = adminnistat;
        _string2 = @"";
    }
    self.cityLabel.text = _string1;
    self.quyuLabel.text = _string2;
}
-(void)didSelectRowIndexPath:(NSIndexPath *)indexPath sadministativeArea:(NSString *)adminnistat
{
    
    if ([adminnistat isEqualToString:@"全部片区"])
    {
        _string2 = @"";
    }
    else
    {
       
        _string2 = adminnistat;
    }
     self.quyuLabel.text = _string2;
}

-(void)clickEditButton:(UIButton *)sender Event:(UIEvent *)event
{
    isSende=YES;
    CGPoint point = [[[event allTouches]anyObject]locationInView:self.sourcesTableView];
    NSIndexPath *indexPath = [self.sourcesTableView indexPathForRowAtPoint:point];
        NSDictionary *dic = self.dataSourceArray[indexPath.row];
    GosenResultView *goseeView = [[GosenResultView alloc]initWithFrame:[UIScreen mainScreen].bounds isBool:isSende];
    goseeView.cellHeightLayout.constant = 0.0;
    goseeView.lableHeightLayout.constant = 0.0;
    goseeView.lableJL.text = @"";
    [goseeView addSelfInAView:self.view andGoseeID:dic[@"GoSeeID"]];
    goseeView.dataSourcesTableView.hidden = YES;
    goseeView.lableJL.hidden = YES;
}



#pragma mark tableviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    lookAboutTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"lookcellReuseID"];
     [lookAboutTableViewCell.editButton addTarget:self action:@selector(clickEditButton:Event:) forControlEvents:UIControlEventTouchUpInside];
    if (self.dataSourceArray.count > 0) {
        id dic = self.dataSourceArray[indexPath.row];
        if ([dic isKindOfClass:[NSDictionary class]]) {
            lookAboutTableViewCell.custNameLabel.text = dic[@"CustName"];
            lookAboutTableViewCell.addressLabel.text  = [dic[@"BuildingName"] stringByAppendingFormat:@"栋%@室",dic[@"RoomNo"]];
            lookAboutTableViewCell.employeeNameLabel.text = dic[@"EmpName"];
            lookAboutTableViewCell.buildNameLabel.text = dic[@"EstateName"];
            lookAboutTableViewCell.areaNameLabel.text  = [dic[@"DistrictName"]stringByAppendingFormat:@"--%@",dic[@"AreaName"]];
            lookAboutTableViewCell.recordTimeLabel.text =[ dic[@"CreatTime"] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            
        }
    }
    return lookAboutTableViewCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataSourceArray[indexPath.row];
    GosenResultView *goseeView = [[GosenResultView alloc]initWithFrame:[UIScreen mainScreen].bounds isBool:NO];;
//    goseeView.viewTopLayout.constant = [UIScreen mainScreen].bounds.size.height;
    goseeView.viewS.hidden = YES;
    goseeView.lableHeightLayout.constant = 20.5;
    
    [goseeView addSelfInAView:self.view andGoseeID:dic[@"GoSeeID"]];
}
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    // [table addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    
    [self.sourcesTableView addHeaderWithTarget:self action:@selector(headerRereshingL)];
    
    //#warning 自动刷新(一进入程序就下拉刷新)
    //    [self.tableView headerBeginRefreshing];
    [self.sourcesTableView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.sourcesTableView addFooterWithTarget:self action:@selector(footerRereshingL)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.sourcesTableView.headerPullToRefreshText = @"下拉刷新";
    self.sourcesTableView.headerReleaseToRefreshText = @"松开刷新";
    self.sourcesTableView.headerRefreshingText = @"客源正在刷新中";
    
    self.sourcesTableView.footerPullToRefreshText = @"上拉加载更多数据";
    self.sourcesTableView.footerReleaseToRefreshText = @"松开加载更多数据";
    self.sourcesTableView.footerRefreshingText = @"客源正在加载中";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshingL
{
    pagecount ++;
    [self postRequest];
    [self.sourcesTableView headerEndRefreshing];
}

- (void)footerRereshingL
{
    pagecount ++ ;
    [self postRequest];
    [self.sourcesTableView footerEndRefreshing];
    
}



-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
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
