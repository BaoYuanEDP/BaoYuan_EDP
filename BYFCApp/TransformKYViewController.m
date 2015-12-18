//
//  TransformKYViewController.m
//  BYFCApp
//
//  Created by PengLee on 15/5/19.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "TransformKYViewController.h"
#import "PL_Header.h"

@interface TransformKYViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,CWStarRateViewDelegate,UIGestureRecognizerDelegate>
{
    //资源ID
    NSString *strIDc;
    
    UILabel *sikeLable;
    UIButton *rightBtn;
    //筛选一级菜单
    UITableView *filterView;
    //筛选二级菜单
    UITableView *secondFilterTableView;
    //下属客源列表
    UITableView *subVisterTableView;
    //记录一级下拉菜单点击的行
    NSInteger filterClickrow;
    
    //二级菜单是否弹出
    BOOL   secondFilterisout;
    //一级菜单是否淡出
    BOOL fistfilrerisout;
    
    NSString *topStr1;
    NSString *topStr2;
    NSString *topStr3;
    NSString *XQStr;
    NSString *PQStr;
    NSString *currentStr;
    NSString *currentTradeStr;
    NSString *currentPriceMin;
    NSString *currentPriceMax;
    BOOL rightIsClick;
    NSMutableString *_resultString;
    NSString * privateCount;
    NSDictionary *dictionary;
    
    //    __block VisterInfo *vister;
    
    ChageTableViewCell *customcell;
    
    //记录是否点击转私
    BOOL transformPrivteIsClick;
    //记录是否点击转公
    BOOL transFromPublicIsClick;
    //全部or个人
    BOOL allAllSelf;
    //页数记录器
    NSInteger pageCount;
    
    //记录跟进，电话按钮tag值
    NSInteger indexTag;
    //跟进弹出视图的背景图
    UIView *bgView;
    //跟进视图主视图
    UIView *genjinView;
    //意向登记
    NSInteger starCount;
    //跟进方式label
    UILabel *fangshi;
    UIButton *fangshiBtn;
    UIView *sousuoView;
    UILabel *style;
    UIButton *styleBtn;
    UITextView *textView1;
    UILabel *placeholder;
    UILabel *count;
    //跟进方式
    
    
    //CUSTID
    NSString *CustID;
    
    //上级编号
    NSString *supCode;
    //转公或者转私
    ToFlag toFlag;
    //客源来源公或私
    FromFlag fromFlag;
    //公客类型
    PubType pubType;
    BOOL whicDropTableViewWillShow;
    NSInteger spaceLevel;

    NSString *status;
    NSString *oldfilterLabelStr;
    NSString *oldStatusStr;
    NSString *showLevelStr;
}
@property (weak, nonatomic) IBOutlet UIButton *filterButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *visterSearch;
@property (weak, nonatomic) IBOutlet UILabel *filterLabel;
//filterView数据源
@property(nonatomic,strong) NSArray *filterArray;
//二级菜单数据源
@property(nonatomic,strong) NSMutableArray *secondFilterMutableArray;
//用户等级
@property(nonatomic,copy) NSString *dutycode;

@property(nonatomic,strong)BYPersonInfo *person;
//上级领导和自己
@property(nonatomic,strong) NSMutableArray *supArray;
@property(nonatomic,strong) NSMutableArray *subArray;

//等级标识
@property(nonatomic,assign)NSInteger levenumber;

@property(nonatomic,strong)NSString *pianquString;
//数组用于存储将转移的客源
@property(nonatomic,strong) NSMutableArray *transformMArray;
@property(nonatomic,strong) __block NSMutableArray *visterArray;
@property(nonatomic,strong) NSMutableArray * zoneArray;
@property(nonatomic,strong) NSArray     * pubTypeArray;

@end

@implementation TransformKYViewController
-(NSArray *)pubTypeArray
{
    return @[@"大区公客",@"总监公客",@"组别公客",@"区经公客",@"公司公客"];
}

-(NSMutableArray *)zoneArray
{
    if (!_zoneArray) {
        _zoneArray = [[NSMutableArray alloc]init];
    }
    return _zoneArray;
}
-(NSMutableArray *)visterArray
{
    if (_visterArray == nil) {
        _visterArray = [[NSMutableArray alloc]init];
    }
    return _visterArray;
}

-(NSMutableArray *)transformMArray
{
    if (_transformMArray == nil) {
        _transformMArray = [[NSMutableArray alloc]init];
    }
    return _transformMArray;
}
-(NSMutableArray *)subArray
{
    if (_subArray == nil) {
        _subArray = [[NSMutableArray alloc]init];
        
    }
    return _subArray;
}
-(NSString *)dutycode
{
    
    if (_dutycode == nil) {
        NSLog(@"%@",[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE]);
        _dutycode = [[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE]substringWithRange:NSMakeRange([[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE] length] - 1, 1)];
    }
    return _dutycode;
}
-(NSMutableArray *)supArray
{
    
    if (_supArray == nil) {
        _supArray = [[NSMutableArray alloc]init];
    }
    return _supArray;
}

-(NSArray *)filterArray
{
    if (_filterArray == nil) {
//        _filterArray = @[@"大区副总",@"董事",@"总监",@"分行经理",@"客户经理"];
        _filterArray = @[@"职位状态",@"大  区",@"片  区",@"区域/摊",@"分行经理",@"客户经理"];

    }
    return _filterArray;
}
-(NSMutableArray *)secondFilterMutableArray
{
    if (_secondFilterMutableArray == nil) {
        _secondFilterMutableArray = [NSMutableArray array];
        for (int index = 0; index < 10; index++) {
            [_secondFilterMutableArray addObject:[NSString stringWithFormat:@"%d",index]];
        }
    }
    return _secondFilterMutableArray;
}
-(NSInteger)levenumber
{
    NSLog(@"%@",self.dutycode);
    if ([self.dutycode isEqualToString:@"A"]) {
        _levenumber = 0;
        
    };
    if ([self.dutycode isEqualToString:@"B"]) {
        _levenumber = 1;
        
        
    };
    if ([self.dutycode isEqualToString:@"C"]) {
        _levenumber = 2;
        
        
    };
    if ([self.dutycode isEqualToString:@"D"]) {
        _levenumber = 3;
        
        
    };
    if ([self.dutycode isEqualToString:@"E"]) {
        _levenumber = 4;
        
        
    };
    return _levenumber;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SunHai:) name:@"sunHai" object:nil];
    //请求上级领导
    [self requestSup];
    status = @"0";
    oldStatusStr =@"0";
    showLevelStr = @"";
    strIDc = [NSString string];
    //初始化页面计数器
    pageCount = 1;
    //初始化是否转移
    transformPrivteIsClick = NO;
    //初始化转公
    transFromPublicIsClick = NO;
    
    //本机机主的等级
    [self levenumber];
    NSLog(@"%@",[PL_USER_STORAGE objectForKey:PL_USER_code]);
    
    //    userCode = [PL_USER_STORAGE objectForKey:PL_USER_code];
    
    
    //初始化下属客源列表
    [self formatSubVisterTableView];
    
    self.filterLabel.text = @"";
    //初始化数据源
    //    lastClickRow = self.levenumber == 0 ? 0 : self.levenumber;
    
    //设置一级下拉菜单
    filterView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, 200,0 ) style:UITableViewStylePlain];
    filterView.delegate = self;
    filterView.dataSource = self;
    [self.view addSubview:filterView];
    fistfilrerisout = NO;
    //设置二级下拉菜单
    
    secondFilterTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, 0, 0) style:UITableViewStylePlain];
    secondFilterTableView.delegate = self;
    secondFilterTableView.dataSource = self;
    [self.view addSubview:secondFilterTableView];
    
    //滚动视图daili
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(240, self.scrollView.bounds.size.height);
    self.scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"属性背景"]];
    
    
    //搜索按钮图片
    
    UIImage *searchImage = [UIImage imageByScaleAndCropingForSize:CGSizeMake(25, 25) oldImage:[UIImage imageNamed:@"search"]];
    
    [self.visterSearch setTintColor:[UIColor colorWithPatternImage:searchImage]];
    [self.visterSearch setImage:searchImage forState:UIControlStateNormal];
    //    [self.visterSearch setImage:[UIImage imageCompressForSizeImage:[UIImage imageNamed:@"search"] targetSize:CGSizeMake(30, 30)] forState:UIControlStateNormal];
    //标题
    self.title = @"下属客源";
    //自定义返回按钮
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    //自定义导航右键
    UIView * rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 110, 30)];
    rightView.backgroundColor = [UIColor clearColor];
    sikeLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 75, 25)];
    sikeLable.adjustsFontSizeToFitWidth=YES;
    sikeLable.textAlignment=NSTextAlignmentRight;
    sikeLable.font = [UIFont systemFontOfSize:10];
    [rightView addSubview:sikeLable];
    
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(CGRectGetMaxX(sikeLable.frame), 0, 30, 30);
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:17];
    [rightBtn setImage:[UIImage imageNamed:@"私客图标.png"] forState:UIControlStateNormal];
    pubType = 1;
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightClick1:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:rightBtn];
    
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = right;
    
    [self setupRefresh];
    
}
- (void)SunHai:(NSNotification *) obj
{
    [self formatSubVisterTableView];
    [self frashSearchFilterCondition];
}
#pragma mark -- 初始化下属客源列表
-(void)formatSubVisterTableView
{
    subVisterTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 114, ([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)-114-50) style:UITableViewStylePlain];
    subVisterTableView.delegate=self;
    subVisterTableView.dataSource=self;
    subVisterTableView.tableFooterView=[UIView new];
    subVisterTableView.rowHeight = 88;
    [subVisterTableView registerNib:[UINib nibWithNibName:@"ChageTableViewCell" bundle:nil] forCellReuseIdentifier:@"reusedID"];
    
    [self.view addSubview:subVisterTableView];
}
#pragma mark -- 设置检索条件
-(VisiterData *)frashSearchFilterCondition
{
    NSString * name         =[PL_USER_STORAGE objectForKey:PL_USER_NAME];
    NSString * token        = [PL_USER_STORAGE objectForKey:PL_USER_TOKEN];
    NSInteger indexNum;
    if(_supArray.count == 1)
    {
        indexNum = _supArray.count-1;
    }
    else
    {
        indexNum = _supArray.count-2;
    }
    BYPersonInfo *person    = self.supArray[indexNum];
    //    NSString * subCode      = person.userCode;
    VisiterData *custom     =[[VisiterData alloc]init];
    custom.getAllString = oldStatusStr;
    if ([rightBtn.currentImage isEqual:[UIImage imageNamed:@"私客图标.png"]])
    {
        BYPersonInfo *lastPerson = [[BYPersonInfo alloc]init];
        lastPerson = self.supArray.lastObject;
        if ([lastPerson.userName isEqualToString:@"直属"]) {
            custom.directFlgString = @"1";
        }
        else
        {
            custom.directFlgString = @"0";
        }
        if ([lastPerson.userName isEqualToString:@"全部"])
        {
            if([person.userName isEqualToString:name])
            {
                custom.flagSubs = @"1";
                custom.subUserCode = @"";
            }
            else
            {
                custom.flagSubs = @"1";
                custom.subUserCode = person.userCode;
            }

        }
        else
        {
            custom.flagSubs = @"0";
            custom.subUserCode = lastPerson.userCode;
            
        }
        custom.FlagPrivate      = @"1";
        custom.pubTypeString    = @"";

    }
    else
    {
        custom.directFlgString = @"0";
        custom.flagSubs = @"";
        custom.subUserCode = @"";
        custom.FlagPrivate = @"0";
        custom.pubTypeString = [NSString stringWithFormat:@"%ld",(long)pubType];
    }
    
    custom.userid           = name;
    custom.CustLevel        = @"";
    custom.DistrictName     = @"";
    custom.AreaId           = @"";
    custom.Trade            = @"";
    custom.PriceMax         = @"";
    custom.PriceMin         = @"";
    
    custom.FlagRecommand    = @"";
    custom.FlagNeed         = @"";
    custom.FlagSchool       = @"";
    custom.StartIndex       = [NSString stringWithFormat:@"%ld",(long)pageCount];
    custom.token            = token;
    
    NSLog(@"=================%@",custom.StartIndex);
    custom.telephoneNumberString = @"";
    custom.pubTypeString = @"";
    custom.jiaoYiString = @"";
    return custom;
}
#pragma mark 转私
- (IBAction)clickTransformPrivte:(UIButton *)sender
{
    toFlag = ToFlag_Public;
    if (self.transformMArray.count == 0) {
        PL_ALERT_SHOW(@"至少要选一个转移的客源");
    }
    else
    {
        
        [self.visterSearch setTitle:@"提交" forState:UIControlStateNormal];
        [self.visterSearch setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.visterSearch setImage:nil forState:UIControlStateNormal];
        transformPrivteIsClick = YES;
        transFromPublicIsClick = NO;
        [self clickFilterButton:nil];
    }
    
    
}
#pragma mark 转公
- (IBAction)clickTransformPublicButton:(UIButton *)sender
{
    NSLog(@"%s",__FUNCTION__);
    PL_ALERT_SHOW(@"该功能正在开发中!");
//    toFlag = ToFlag_Private;
//    if (self.transformMArray.count == 0) {
//        PL_ALERT_SHOW(@"至少要选一个转移的客源");
//        
//    }
//    else
//    {
//        
//        [self.visterSearch setTitle:@"提交" forState:UIControlStateNormal];
//        [self.visterSearch setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self.visterSearch setImage:nil forState:UIControlStateNormal];
//        transFromPublicIsClick = YES;
//        transformPrivteIsClick = NO;
//        spaceLevel = 0;
////                NSLog(@"%@",[PL_USER_STORAGE objectForKey:PL_USER_SUPCODE]);
////        [self clickFilterButton:nil];
//
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(doPostDepetInfo) name:@"TRobserverResult" object:nil];
//        [self postDeptInfo];
    
//    }
}
-(void)doPostDepetInfo
{
    spaceLevel++;
    [self postDeptInfo];
}

-(void)postDeptInfo
{
    [[MyRequest defaultsRequest]afGetDeptFromSnapshotWithUnitCode:[PL_USER_STORAGE objectForKey:PL_USER_UNITFULLCODE] SpaceLevel:[NSString stringWithFormat:@"%ld",(long)spaceLevel] DutyCode:[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE] completeBack:^(NSString *str)
     {
//         if ([str isEqualToString:@"1"]) {
//             PL_ALERT_SHOW(@"没有下级部门可选了");
//             return ;
//         }
          if ([str isEqualToString:@"[]"]) {
             NSLog(@">>>>>>%@",str);
             [[NSNotificationCenter defaultCenter]postNotificationName:@"TRobserverResult" object:nil];
             [[NSNotificationCenter defaultCenter]removeObserver:self name:@"TRobserverResult" object:nil];
             
         }
         else
         {
             SBJSON *json = [[SBJSON alloc]init];
             NSArray *resultArray = [json objectWithString:str error:nil];
//             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"查找要转公的部门" message:@"浦东" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//             [alert show];
//
             SelectPersonAndZoneView *selectView = [[SelectPersonAndZoneView alloc]initWithFrame:[UIScreen mainScreen].bounds andData:resultArray];
             [selectView addSelfInAView:self.view];
         }
         
     }];
    
}



#pragma mark--请求客源列表
-(void)postRequest
{
    [self.visterArray removeAllObjects];
    PL_PROGRESS_SHOW;
    NSLog(@"----------%@",[self frashSearchFilterCondition]);
    [[MyRequest defaultsRequest]afXYGetCustomListWithVist:[self frashSearchFilterCondition] ComPleteBack:^(NSMutableString *str) {
        _resultString=str;
        NSLog(@">>>>>>>%@",str);
        if ([str isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        if ([str isEqualToString:@"[]"]) {
            
            UILabel * label = [[UILabel alloc]init];
            label.text = @"暂无数据";
            label.textAlignment = NSTextAlignmentCenter;
            PL_ALERT_SHOW(@"暂无私客数据");
            [self.visterArray removeAllObjects];
        }
        else  if ([str isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
            [self.visterArray removeAllObjects];
        }
        else
        {
            
            SBJSON *json=[[SBJSON alloc]init];
            NSArray *array = [json objectWithString:_resultString error:nil];
            if (pubType == PubType_GS) {
                NSDictionary *dic = array.firstObject;
                sikeLable.text = [NSString stringWithFormat:@"共%@条公客",[dic[@"CountNum"]length] == 0 ? @"0":dic[@"CountNum"]];
            }else
            {
                NSDictionary *dic = array.firstObject;
                sikeLable.text = [NSString stringWithFormat:@"共%@条私客",[dic[@"CountNum"]length] == 0 ? @"0":dic[@"CountNum"]];
            }
            for (NSDictionary *dic in array) {
                VisterInfo *vister = [VisterInfo loadVisterInfoFromDictionary:dic];
                [self.visterArray addObject:vister];
                NSLog(@"》》》》》%lu",(unsigned long)self.visterArray.count);
                
            }
            
        }
        
        [subVisterTableView reloadData];
        
        
        PL_PROGRESS_DISMISS;
        

    }];
    
//    [[MyRequest defaultsRequest]getSubCustomList:[self frashSearchFilterCondition] backInfoMessage:^(NSMutableString *string) {
//        _resultString=string;
//        
//        
//        
//        NSLog(@">>>>>>>%@",string);
//        if ([string isEqualToString:@"NOLOGIN"]) {
//            ViewController *login=[[ViewController alloc]init];
//            [self.navigationController pushViewController:login animated:YES];
//        }
//        if ([string isEqualToString:@"[]"]) {
//            
//            UILabel * label = [[UILabel alloc]init];
//            label.text = @"暂无数据";
//            label.textAlignment = NSTextAlignmentCenter;
//            PL_ALERT_SHOW(@"暂无私客数据");
//            [self.visterArray removeAllObjects];
//        }
//        else  if ([string isEqualToString:@"exception"]) {
//            PL_ALERT_SHOW(@"服务器异常");
//            [self.visterArray removeAllObjects];
//        }
//        else
//        {
//            
//            SBJSON *json=[[SBJSON alloc]init];
//            NSArray *array = [json objectWithString:_resultString error:nil];
//            for (NSDictionary *dic in array) {
//                VisterInfo *vister = [VisterInfo loadVisterInfoFromDictionary:dic];
//                    [self.visterArray addObject:vister];
//                NSLog(@"》》》》》%lu",(unsigned long)self.visterArray.count);
//                
//            }
//            
//        }
//        [subVisterTableView reloadData];
//        
//        
//        PL_PROGRESS_DISMISS;
//        
//    }];
}


#pragma mark -- 请求上级领导
-(void)requestSup
{
    
    NSLog(@"%s",__FUNCTION__);
    PL_PROGRESS_SHOW ;
    NSLog(@"++++++++++++++++++ %@ %@",[PL_USER_STORAGE objectForKey:PL_USER_TOKEN],[PL_USER_STORAGE objectForKey:PL_USER_code]);
    [[MyRequest defaultsRequest]afGetSupFromSnapshot:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSString *str) {
        
        SBJSON *json = [[SBJSON alloc]init];
        NSArray *array = [json objectWithString:str error:nil];
        for (NSDictionary *dic in array)
        {
            BYPersonInfo *person = [[BYPersonInfo alloc]init];
            
            person.sort = dic[@"Sort"];
            person.userId = dic[@"UserID"];
            person.userCode = dic[@"UserCode"];
            person.userName = dic[@"UserName"];
            person.department = dic[@"Department"];
            NSLog(@"aaaaaa  %@",person.userName);
            [self.supArray addObject:person];
            [self.supArray sortUsingComparator:^NSComparisonResult(BYPersonInfo  *person, BYPersonInfo *anothorperson) {
                return  [person.sort compare:anothorperson.sort];
            }];
        }
        int supCount = (int)self.supArray.count;
        //领导断层加入虚拟人
        if (![[PL_USER_STORAGE objectForKey:PL_USER_code] isEqualToString:@"AA0006"]) {
           
            for (int index = 0; index <= _levenumber - supCount; index++) {
                BYPersonInfo *virtulPerson = [[BYPersonInfo alloc]init];
                virtulPerson.sort = @"";
                virtulPerson.userId = @"";
                virtulPerson.userCode = @"";
                virtulPerson.userName = @"";
                virtulPerson.department = @"";
                [self.supArray insertObject:virtulPerson atIndex:index];
            }
            
        }
        
        
        for (BYPersonInfo *item in self.supArray) {
            NSLog(@"%@",item);
        }
        [self filterString];
        oldfilterLabelStr = self.filterLabel.text;
        PL_PROGRESS_DISMISS;
    }];
    
    
    
}

#pragma mark --- 导航右键点击事件
-(void)rightClick1:(UIButton *)sender
{
    [self.transformMArray removeAllObjects];
    transFromPublicIsClick = NO;
    transformPrivteIsClick = NO;

    if ([rightBtn.currentImage isEqual:[UIImage imageNamed:@"私客图标.png"]])
    {
        
        [rightBtn setImage:[UIImage imageNamed:@"公客图标.png"] forState:UIControlStateNormal];
        pubType = PubType_GS;
        [self postRequest];
        [self filterString];

    }
    else
    {
        [rightBtn setImage:[UIImage imageNamed:@"私客图标.png"] forState:UIControlStateNormal];
        pubType  = 1;
        [self postRequest];
        [self filterString];
    }
    
}
#pragma mark 表；
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == subVisterTableView)
    {
        return self.visterArray.count;
    }
    else
    {
        if ([self whichDropTableViewWillShow]) {
             return tableView == filterView ?  self.filterArray.count:self.subArray.count;
        }
        else
        {
            return tableView == filterView ?  self.pubTypeArray.count:0;
        }
        
//        if ([rightBtn.currentImage isEqual:[UIImage FimageNamed:@"私客图标.png"]]) {
//             return tableView == filterView ?  self.filterArray.count:self.subArray.count;
//        }
//        else
//        {
//            if (transformPrivteIsClick == NO) {
//                return tableView == filterView ?  self.pubTypeArray.count:0;
//            }
//            else
//            {
//              return tableView == filterView ?  self.filterArray.count:self.subArray.count;
//            }
//            
//        }
       
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reusedID = @"cellReusedID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedID];
        
    }
    if (tableView == filterView)
    {
        if ([self whichDropTableViewWillShow]) {
            cell.textLabel.text = self.filterArray[indexPath.row];
        }
        else
        {
            cell.textLabel.text = self.pubTypeArray[indexPath.row];
        }
        if (indexPath.row == 0) {
            
        }
        else if (indexPath.row <= self.levenumber +1 && ![[PL_USER_STORAGE objectForKey:PL_USER_code] isEqualToString:@"AA0006"])
        {
            NSLog(@"你无权限点击此项");
            cell.userInteractionEnabled = NO;
            //           cell = [filterView cellForRowAtIndexPath:indexPath];
            cell.backgroundColor = [UIColor grayColor];
            [self faleOut];
            
        }
        
    }
    else
        if (tableView == secondFilterTableView)
    {
        BYPersonInfo *sperson = self.subArray[indexPath.row];
        if (filterClickrow == 0) {
            cell.textLabel.text = self.subArray[indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
        }
        else if (filterClickrow == 1) {
            cell.textLabel.text = sperson.department;
            cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
        } else if (filterClickrow == 2) {
            cell.textLabel.text = sperson.department;
            cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
        }
        else if (filterClickrow == 3) {
            cell.textLabel.text = sperson.department;
            cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
        }
        else if(filterClickrow == 4)
        {
            cell.textLabel.text = sperson.userName;
            cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
            
        }
        else if(filterClickrow == 5)
        {
            cell.textLabel.text = sperson.userName;
            cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
            
        }
        
    }
    
    
    
    
    else if(tableView == subVisterTableView)
    {
        
        
        
        
        customcell = [tableView dequeueReusableCellWithIdentifier:@"reusedID"];
        
             customcell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        customcell.tag=[indexPath row];
        
        if (self.visterArray.count>0)
        {
            VisterInfo *info = [self.visterArray objectAtIndex:indexPath.row];
            if (info && [info isKindOfClass:[VisterInfo class]])
            {
                _pianquString= info.areaIDString ;
                if ([info.ageString isEqualToString:@""]) {
                    if ((NSNull *)info.sexString ==[NSNull null])
                    {
//                        customcell.name.text=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"CustName"]];
                        customcell.name.text=[NSString stringWithFormat:@"%@", info.custNameString];
                    }
                    else
                    {
                        customcell.name.text=[NSString stringWithFormat:@"%@ %@", info.custNameString ,info.sexString];
                    }
                    
                }else{
                    if ((NSNull *)info.sexString ==[NSNull null])
                    {
                        customcell.name.text=[NSString stringWithFormat:@"%@ %@",info.custNameString ,info.ageString];
                    }
                    else
                    {
                        customcell.name.text=[NSString stringWithFormat:@"%@ %@ %@",info.custNameString ,info.sexString,info.ageString];
                    }
                    
                    
                }
                if ((NSNull *)info.districtNameString ==[NSNull null])
                {
                    [customcell.xiaoqu setTitle:@"" forState:UIControlStateNormal];
                }
                else
                {
                    [customcell.xiaoqu setTitle:[NSString stringWithFormat:@"%@",info.districtNameString] forState:UIControlStateNormal];
                }
                
//                [customcell.xiaoqu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//                customcell.xiaoqu.titleLabel.text =[NSString stringWithFormat:@"%@",info.districtNameString];
//                   customcell.xiaoqu.titleLabel.textColor = [UIColor blackColor];
                if ((NSNull *)info.areaNameString ==[NSNull null])
                {
                    [customcell.pianqu setTitle:@"" forState:UIControlStateNormal];
                }
                else
                {
                    [customcell.pianqu setTitle:[NSString stringWithFormat:@"%@",info.areaNameString] forState:UIControlStateNormal];
                    [customcell.pianqu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    customcell.pianqu.tag=indexPath.row;
                }
                                //            [customcell.pianqu addTarget:self action:@selector(pianquClick:) forControlEvents:UIControlEventTouchUpInside];
                if ([info.countFString isEqualToString:@"房"]) {
                    customcell.roomInfo.text=[NSString stringWithFormat:@"%@%@",info.countTString ,info.squareString ];
                }else{
                    customcell.roomInfo.text=[NSString stringWithFormat:@"%@%@%@",info.countFString ,info.countTString ,info.squareString];
                }
                if ([info.tradeString isEqualToString:@"求购"]) {
                    customcell.gou.image=[UIImage imageNamed:@"gou_hong"];
                    customcell.yixiangPrice.text=[NSString stringWithFormat:@"意向总价:%@万",info.priceString];
                    NSMutableAttributedString * attri = [[NSMutableAttributedString alloc]initWithString:customcell.yixiangPrice.text];
                    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, attri.length-4)];
                    customcell.yixiangPrice.attributedText=attri;
                }else
                {
                    customcell.gou.image=[UIImage imageNamed:@"gou_hui.png"];
                }
                if ([info.tradeString isEqualToString:@"求租"]) {
                    customcell.zu.image=[UIImage imageNamed:@"zu_lv.png"];
                    customcell.yixiangPrice.text=[NSString stringWithFormat:@"意向总价:%@万",info.priceString];
//                    NSMutableAttributedString * attri = [[NSMutableAttributedString alloc]initWithString:customcell.yixiangPrice.text.length == 0 ? @"意向总价:":customcell.yixiangPrice.text];
//                    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, attri.length-4)];
//                    customcell.yixiangPrice.attributedText=attri;
                }
                else
                {
                    customcell.zu.image=[UIImage imageNamed:@"zu_hui.png"];
                }
                if ([info.tradeString isEqualToString:@""]) {
                    customcell.zu.image=[UIImage imageNamed:@"zu_lv.png"];
                    customcell.gou.image=[UIImage imageNamed:@"gou_hong"];
                }
                if ((NSNull *)info.tradeString ==[NSNull null]) {
                    customcell.zu.image=[UIImage imageNamed:@"zu_lv.png"];
                    customcell.gou.image=[UIImage imageNamed:@"gou_hong"];
                }
                if ([info.flagRecommandString isEqualToString:@"1"]) {
                    customcell.jinglituijian.image=[UIImage imageNamed:@"jinglituijian_lan"];
                }
                
                if ([info.flagNeedString isEqualToString:@"1"]) {
                    customcell.jixu.image=[UIImage imageNamed:@"急需.png"];
                }
                
                if ([info.flagSchoolString isEqualToString:@"1"]) {
                    customcell.xuequfang.image=[UIImage imageNamed:@"xuequfang_fen.png"];
                }
                
                NSString *custlevelString = [NSString stringWithFormat:@"%@", info.custLevelString];
                //            if ([[dictionary objectForKey:@"CustLevel"]  isEqual: @(1)]) {
                //                cell.XX1.image=[UIImage imageNamed:@"小黄星星.png"];
                //            }
                
                if ([custlevelString isEqualToString:@"1"]) {
                    
                    customcell.XX1.image=[UIImage imageNamed:@"小黄星星.png"];
                }
                else if ([custlevelString isEqualToString:@"2"]){
                    customcell.XX1.image=[UIImage imageNamed:@"小黄星星.png"];
                    customcell.XX2.image=[UIImage imageNamed:@"小黄星星.png"];
                }
                else if ([custlevelString isEqualToString:@"3"]){
                    customcell.XX1.image=[UIImage imageNamed:@"小黄星星.png"];
                    customcell.XX2.image=[UIImage imageNamed:@"小黄星星.png"];
                    customcell.XX3.image=[UIImage imageNamed:@"小黄星星.png"];
                }else if ([custlevelString isEqualToString:@"4"]){
                    customcell.XX1.image=[UIImage imageNamed:@"小黄星星.png"];
                    customcell.XX2.image=[UIImage imageNamed:@"小黄星星.png"];
                    customcell.XX3.image=[UIImage imageNamed:@"小黄星星.png"];
                    customcell.XX4.image=[UIImage imageNamed:@"小黄星星.png"];
                }else if ([custlevelString isEqualToString:@"5"]){
                    customcell.XX1.image=[UIImage imageNamed:@"小黄星星.png"];
                    customcell.XX2.image=[UIImage imageNamed:@"小黄星星.png"];
                    customcell.XX3.image=[UIImage imageNamed:@"小黄星星.png"];
                    customcell.XX4.image=[UIImage imageNamed:@"小黄星星.png"];
                    customcell.XX5.image=[UIImage imageNamed:@"小黄星星.png"];
                }
                else {
                    customcell.XX1.image=[UIImage imageNamed:@"小灰星星.png"];
                    customcell.XX2.image=[UIImage imageNamed:@"小灰星星.png"];
                    customcell.XX3.image=[UIImage imageNamed:@"小灰星星.png"];
                    customcell.XX4.image=[UIImage imageNamed:@"小灰星星.png"];
                    customcell.XX5.image=[UIImage imageNamed:@"小灰星星.png"];
                }
                
                if ( [info.isClick isEqualToString:@"NO"]) {
                    [customcell.phoneBtn setImage:[UIImage imageNamed:@"no_checked"] forState:UIControlStateNormal];
                }
                else
                {
                    [customcell.phoneBtn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
                }
                
//                
                [customcell.phoneBtn addTarget:self action:@selector(clickselectButton:Event:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        return customcell;
    }
    
    
    return cell;
}

#pragma mark 获取上级编号
-(void)getSupCode
{
    [[MyRequest defaultsRequest]afGetSupFromUserCode:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSString *str) {
        supCode = str;
    }];
}
#pragma mark 选择按钮点击事件
-(void)clickselectButton:(UIButton *)sender Event:(UIEvent *)event
{
    strIDc = @"";
    CGPoint point = [[[event allTouches]anyObject]locationInView:subVisterTableView];
    NSIndexPath *indexPath = [subVisterTableView indexPathForRowAtPoint:point];
    VisterInfo *info = [self.visterArray objectAtIndex:indexPath.row];
    if ([sender.currentImage isEqual:[UIImage imageNamed:@"checked"]]) {
        [sender setImage:[UIImage imageNamed:@"no_checked"] forState:UIControlStateNormal];
        info.isClick = @"NO";
        [self.transformMArray removeObject:info.custIDString];
        for (int i = 0; i< self.transformMArray.count; i ++) {
            strIDc = [strIDc stringByAppendingFormat:@"%@,",[self.transformMArray objectAtIndex:i]];
        }
        if (strIDc.length == 0) {
            strIDc = @"";
        }else
        {
            strIDc = [strIDc substringToIndex:strIDc.length-1];
        }
    }
    else
    {
        strIDc = @"";
        [sender setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
        info.isClick = @"YES";
        [self.transformMArray addObject:info.custIDString];
        for (int i = 0; i< self.transformMArray.count; i++) {
            strIDc = [strIDc stringByAppendingFormat:@"%@,",[self.transformMArray objectAtIndex:i]];
        }
        strIDc = [strIDc substringToIndex:strIDc.length-1];
        sender.tag = self.transformMArray.count - 1;
    }
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
//        UITouch *touch=[touches anyObject];
//    CGPoint point=[touch locationInView:self.view];
    
    
  }



#pragma mark 防止手势拦截
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    NSLog(@"%s",__FUNCTION__);
    
    if ([NSStringFromClass([touch.view class])isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    else
    {
        return YES;
    }
}

-(void)tapbgView
{
    NSLog(@"==================== %s",__FUNCTION__);
    //    for (UIView *item in view.subviews) {
    //        [item removeFromSuperview];
    //    }
  
   [genjinView removeFromSuperview];
   [bgView removeFromSuperview];
  }
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""])
    {
        placeholder.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        placeholder.hidden = NO;
    }
    NSString * str = [NSString stringWithFormat:@"%@%@",textView.text,text];
    if (str.length >BOOKMARK_WORD_LIMIT)
    {
        textView.text =[textView.text substringToIndex:BOOKMARK_WORD_LIMIT];
        return NO;
    }
    else
    {
        count.text=[NSString stringWithFormat:@"%lu/100",(unsigned long)str.length];
    }
    
    if ([text isEqualToString:@"\n"]) {
        [textView1 resignFirstResponder];
    }
    return YES;
}


#pragma mark -- 点击筛选一级菜单
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //弹出二级菜单
    if ([self whichDropTableViewWillShow])
    {
        if (tableView == filterView) {
            if(indexPath.row == 0)
            {
                
            }
            else if(indexPath.row == 1)
            {
                showLevelStr = @"YA";
            }
            else if(indexPath.row == 2)
            {
                showLevelStr = @"YB";
            }
            else if(indexPath.row == 3)
            {
                showLevelStr = @"YC";
            }
            else if(indexPath.row == 4)
            {
                showLevelStr = @"YD";
                
            }
            else if(indexPath.row == 5)
            {
                showLevelStr = @"YE";
            }
            //董事长权限判断
            if ([[PL_USER_STORAGE objectForKey:PL_USER_code] isEqualToString:@"AA0006"])
            {
                filterClickrow = indexPath.row;
                NSLog(@"code %@",[PL_USER_STORAGE objectForKey:PL_USER_code]);
                if(indexPath.row == 0)
                {
                    filterClickrow = indexPath.row;
                    self.subArray = [NSMutableArray arrayWithObjects:@"全部",@"在职",@"离职", nil];
                    NSLog(@"%@",_subArray);
                    self.filterLabel.text = oldfilterLabelStr;
                    [self popSecondFilterView];
                    
                }
                if (indexPath.row == 1) {
                    [self requestSub:[PL_USER_STORAGE objectForKey:PL_USER_code] flg:@"0" department:showLevelStr];
                    filterClickrow = indexPath.row;
                    [self popSecondFilterView];
                }
                else
                {
                    //                BYPersonInfo *firstPerson = [[BYPersonInfo alloc]init];
                    //                firstPerson = self.supArray[indexPath.row - 1];
                    if ( (int)indexPath.row -1 - (int)self.supArray.count <= 0  )
                    {
                        BYPersonInfo *person = self.supArray[indexPath.row - 2];
                        if(![person.userName isEqualToString:@"全部"]){
                            
                            status = oldStatusStr;
                            if(person.FLG == nil)
                            {
                                person.FLG = @"0";
                            }
                            [self requestSub:person.userCode flg:person.FLG department:showLevelStr];
                            [self popSecondFilterView];
                            //                    if (indexPath.row > self.subArray.count - 1) {
                            //                    }
                        }}
                    else
                    {
                        NSLog(@"请选择上级领导");
                        [self.subArray removeAllObjects];
                        [secondFilterTableView reloadData];
                        
                    }
                }
                
            }
            else
            {
                //判断处董事长以外的成员是否有权限点击
                if (indexPath.row == 0) {
                    filterClickrow = indexPath.row;
                    self.subArray = [NSMutableArray arrayWithObjects:@"全部",@"在职",@"离职", nil];
                    NSLog(@"%@",_subArray);
                    self.filterLabel.text = oldfilterLabelStr;
                    [self popSecondFilterView];
                    
                }
                else if (indexPath.row <= self.levenumber +1 && ![[PL_USER_STORAGE objectForKey:PL_USER_code] isEqualToString:@"AA0006"])
                {
                    NSLog(@"你无权限点击此项");
                    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                    cell.userInteractionEnabled = NO;
                    cell.backgroundColor = [UIColor grayColor];
                    [cell setSelected:NO animated:NO];
                    [cell setHighlighted:NO animated:NO];
                    [self faleOut];
                    
                }
                else
                {
                    
                    filterClickrow = indexPath.row;
                    
                    if (self.supArray.count != 0 && (int)indexPath.row-1 - (int)self.supArray.count <=0) {
                        
                        BYPersonInfo *person = self.supArray[indexPath.row - 2];
                        if (![person.userName isEqualToString:@"全部"]) {
                            
                            status = oldStatusStr;
                            if(person.FLG == nil)
                            {
                                person.FLG = @"0";
                            }
                            [self requestSub:person.userCode flg:person.FLG department:showLevelStr];
                            [self popSecondFilterView];
                        }
                        
                        
                    }
                    else
                    {
                        NSLog(@"请选择上级领导");
                        [self.subArray removeAllObjects];
                        [secondFilterTableView reloadData];
                        
                    }
                    
                    
                }
                
            }}
        else
            if(tableView == secondFilterTableView)
            {
                NSLog(@"点击了second");
                
                BYPersonInfo *person = self.subArray[indexPath.row];
                if (filterClickrow ==0) {
                    if (indexPath.row == 0) {
                        status = @"0";
                        oldStatusStr = status;
                    }
                    else if (indexPath.row == 1) {
                        status = @"1";
                        oldStatusStr = status;
                    }
                    else{
                        status = @"2";
                        oldStatusStr = status;

                    }
                }
                else if (filterClickrow-1  >= self.supArray.count)
                {
                    
                    [self.supArray addObject:person];
                    [self.supArray sortUsingComparator:^NSComparisonResult(BYPersonInfo  *person, BYPersonInfo *anothorperson) {
                        return  [person.sort compare:anothorperson.sort];
                    }];
                    NSLog(@"xfilterrow %ld",(long)filterClickrow);
                    NSLog(@"xcount %lu",(unsigned long)self.supArray.count);
                    [self filterString];

                }
                
                else
                {
                    NSLog(@"d1filterrow %ld",(long)filterClickrow);
                    NSLog(@"d1count %lu",(unsigned long)self.supArray.count);
                    
                    [self.supArray replaceObjectAtIndex:filterClickrow -1 withObject:person];
                    NSInteger arraycount = self.supArray.count;
                    for (int index = (int)filterClickrow ; index < arraycount; index ++)
                    {
                        NSLog(@"%d",index);
                        
                        [self.supArray removeLastObject];
                    }
                    
                    
                    
                    [self.supArray sortUsingComparator:^NSComparisonResult(BYPersonInfo  *person, BYPersonInfo *anothorperson) {
                        return  [person.sort compare:anothorperson.sort];
                    }];
                    
                    NSLog(@"dfilterrow %ld",(long)filterClickrow);
                    NSLog(@"dcount %lu",(unsigned long)self.supArray.count);
                    
                    [self filterString];

                }
                
                [self faleOut];
                
            }
    }
    else
    {
        if (tableView == filterView )
        {
            filterClickrow = indexPath.row;
            if (indexPath.row < self.levenumber+1) {
                NSLog(@"不能点击");
            }
            else
            {
                switch (indexPath.row)
                {
                    case 0:
                        pubType = PubType_DQ;
                        break;
                    case 1:
                        pubType = PubType_ZJ;
                        break;
                    case 2:
                        pubType = PubType_QJ;
                        break;
                    case 3:
                        pubType = PubType_ZB;
                        break;
                    default:
                        pubType = PubType_GS;
                        break;
                }
                [self filterString];
                if (transFromPublicIsClick == NO) {
                    [self postRequest];
                }
            [self faleOut];
            }
        }

        
    }
    
    
    
//    if (tableView == subVisterTableView) {
//        AVisiterDetailViewController *customer=[[AVisiterDetailViewController alloc]init];
//        VisterInfo *vister = [self.visterArray objectAtIndex:indexPath.row];
//        customer.dict = [vister transSelfToAdictionary:vister];
        
//        customer.dict= @{@"Age":vister.ageString,@"AreaID":vister.areaIDString,@"AreaName":vister.areaNameString,@"CountF":vister.countFString,@"CountNum":vister.countFString,@"CountT":vister.countTString,@"CustID":vister.custIDString,@"CustLevel":vister.custLevelString,@"CustName":vister.custNameString,@"CustTel":vister.custTelString,@"DistrictName":vister.districtNameString,@"EmpCode":vister.empCodeString,@"EmpName":vister.empNameString,@"FlagNeed":vister.flagNeedString,@"FlagPrivate":vister.flagprivateString,@"FlagRecommand":vister.flagRecommandString,@"FlagSchool":vister.flagSchoolString,@"LastDateDisplay":vister.lastDateDisPlayString,@"Price":vister.priceString,@"PropertyType":vister.propertyTypeString,@"ROWNUM":vister.rowNumString,@"RegDate":vister.regDateString,@"Sex":vister.sexString,@"Square":vister.squareString,@"Status":vister.statusString,@"Trade":vister.tradeString,@"UnitName":vister.unitNameString,@"isClick":vister.isClick};
        //客源详情请求
//        AppointVisiterData *customDetail=[[AppointVisiterData alloc]init];
//        
//        customDetail.CustID=[customer.dict objectForKey:@"CustID"];
//        customer.custId=customDetail.CustID;
//        [[NSUserDefaults standardUserDefaults]setObject:customDetail.CustID forKey:@"CustID"];
//        customDetail.userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
//        customDetail.token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
//        [[NSUserDefaults standardUserDefaults]setObject:customDetail.CustID forKey:@"custID"];
//        PL_PROGRESS_SHOW;
//        [[MyRequest defaultsRequest]getCustomDetailInfoEasterList:customDetail backInfoMessage:^(NSMutableString *string) {
//            if ([string isEqualToString:@"NOLOGIN"]) {
//                ViewController *login=[[ViewController alloc]init];
//                [self.navigationController pushViewController:login animated:YES];
//            }
//            else if ([string isEqualToString:@"exception"]) {
//                PL_ALERT_SHOW(@"服务器异常");
//            }
//            else if ([string isEqualToString:@"[]"])
//            {
//                PL_ALERT_SHOW(@"暂无数据");
//            }
//            else
//            {
//                SBJSON *json=[[SBJSON alloc]init];
//                NSArray *array=[json objectWithString:string error:nil];
//                NSDictionary * dicti=[array objectAtIndex:0];
//                NSLog(@"%@",[dicti objectForKey:@"CustLevel"]);
//            }
//            PL_PROGRESS_DISMISS;
//            customer.detailString=string;
//            
//            if (rightIsClick==NO) {
//                customer.isHiden=NO;
//            }
//            else
//            {
//                customer.isHiden=YES;
//            }
//            [self.navigationController pushViewController:customer animated:YES];
//        }];
        
//    }
    
}
#pragma mark 获取响应等级的usercode
-(void)fidthleveusercode:(NSInteger)index
{
    
    
}
#pragma mark 请求下级数据
-(void)requestSub:(NSString *)str flg:(NSString *)flg department:(NSString *)department
{
    if (self.subArray) {
        [self.subArray removeAllObjects];
    }
    [[MyRequest defaultsRequest]afGetSubFromSnapshot:str FLG:flg  Status:status  ShowLevel:department completeBack:^(NSString *str)
     {
         SBJSON *json = [[SBJSON alloc]init];
         NSArray *array = [json objectWithString:str error:nil];
         //首次进入现实全部
         if (transformPrivteIsClick == NO)
         {
             BYPersonInfo *allPerson = [[BYPersonInfo alloc]init];
             allPerson.userName = @"全部";
             allPerson.department = @"全部";
             allPerson.sort     = @"F";
             [self.subArray insertObject:allPerson atIndex:0];
         }
         
         for (NSDictionary *dic in array) {
             BYPersonInfo *person = [[BYPersonInfo alloc]init];
             person.userName = dic[@"UserName"];
             person.userCode = dic[@"UserCode"];
             person.sort     = dic[@"Sort"];
             person.department = dic[@"Department"];
             person.FLG = dic[@"FLG"];
             [self.subArray addObject:person];
             
             
             NSLog(@"%@ %@ %@ ",person.userCode,person.userName,person.sort);
         }
         //  NSLog(@"%@",str);
         
         [secondFilterTableView reloadData];
     }];
}

#pragma mark 筛选视图淡出
-(void)faleOut
{
    [UIView animateWithDuration:0.1 animations:^{
        secondFilterTableView.frame = CGRectMake(0, 104, 0, 0);
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark -- 筛选标题
-(void)filterString
{
    self.filterLabel.text = @"";
    NSLog(@"++++++++++++++++++%d",[self whichDropTableViewWillShow]);
    NSLog(@"---------------%ld",(long)filterClickrow);
    if ([self whichDropTableViewWillShow])
    {
        for (int index = 0; index < self.supArray.count; index ++) {
            BYPersonInfo *person = self.supArray[index];
            if (index == 0) {
                
                self.filterLabel.text = [self.filterLabel.text stringByAppendingString:person.department];
            }
            else if (index ==1||index==2)
            {
                self.filterLabel.text = [self.filterLabel.text stringByAppendingFormat:@"-%@",person.department];
            }
            else
            {
                self.filterLabel.text = [self.filterLabel.text stringByAppendingFormat:@"-%@",person.userName];
            }
        }
        if (self.filterLabel.text.length == 0) {
            
            //        if ([[self.filterLabel.text substringWithRange:NSMakeRange(0, self.supArray.count)]isEqualToString:@"-"] ) {
            //            self.filterLabel.text = [self.filterLabel.text substringWithRange:NSMakeRange(self.supArray.count, self.filterLabel.text.length - self.supArray.count)];
            //        }
            
        }
        else
        {
            if ([[self.filterLabel.text substringWithRange:NSMakeRange(0, self.supArray.count)]isEqualToString:@"-"] ) {
                self.filterLabel.text = [self.filterLabel.text substringWithRange:NSMakeRange(self.supArray.count, self.filterLabel.text.length - self.supArray.count)];
            }
        }

    }
    else
    {
        if (filterClickrow < _levenumber) {
            self.filterLabel.text = @"公司公客";
        }
        else
        {
            self.filterLabel.text = self.pubTypeArray[filterClickrow];
        }
        
    }
    
}

-(void)popSecondFilterView
{
    [UIView animateWithDuration:0.1 animations:^{
        secondFilterTableView.frame = CGRectMake(filterView.bounds.size.width, 114, 100, 180);
    } completion:^(BOOL finished) {
        [secondFilterTableView reloadData];
    }];
}


#pragma mark -- 自定义返回按钮
-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- 点击筛选按钮
- (IBAction)clickFilterButton:(UIButton *)sender
{
    NSLog(@"aaaa");
    if (fistfilrerisout == NO ) {
        [UIView animateWithDuration:0.1 animations:^{
            
            filterView.frame = CGRectMake(0, 105, 120, 180);
            filterView.rowHeight = 30;
            
        } completion:^(BOOL finished) {
            [filterView reloadData];
            fistfilrerisout = YES;
        }];
        
        
    }
    else
    {
        [UIView animateWithDuration:0.1 animations:^{
            [self faleOut];
            filterView.frame = CGRectMake(0, 104, 120,0 );
            //            filterView.rowHeight = 30;
            
        } completion:^(BOOL finished) {
            //            [filterView reloadData];
            fistfilrerisout = NO;
        }];
        
    }
    
}

#pragma mark 点击搜索按钮或提交按钮
- (IBAction)clickSearchButton:(UIButton *)sender
{
    if ([sender.currentTitle isEqualToString:@"提交"]) {
        transformPrivteIsClick = NO;
        transFromPublicIsClick = NO;
        [self.transformMArray removeAllObjects];
        UIImage *searchImage = [UIImage imageByScaleAndCropingForSize:CGSizeMake(25, 25) oldImage:[UIImage imageNamed:@"search"]];
             [self.visterSearch setTintColor:[UIColor colorWithPatternImage:searchImage]];
        [self.visterSearch setTitle:nil forState:UIControlStateNormal];
        [self.visterSearch setImage:searchImage forState:UIControlStateNormal];
//        NSString *custid = [[NSString alloc]init];
//        for (VisterInfo *vister in self.transformMArray)
//        {
//        custid = [custid stringByAppendingFormat:@"%@,",vister.custIDString];
//        }
//        if (custid.length) {
//            custid = [custid stringByReplacingCharactersInRange:NSMakeRange(custid.length - 1, 1) withString:@""];
//        }
//        else
//        {
//            custid = @"";
//        }
        BYPersonInfo *person = self.supArray.lastObject;
        
        if ([rightBtn.currentImage isEqual:[UIImage imageNamed:@"私客图标.png"]]) {
            fromFlag = FromFlag_Public;
        }
        else
        {
            fromFlag = FromFlag_Private;
        }
        PL_PROGRESS_SHOW;
        [[MyRequest defaultsRequest]afSetCustMoveWithCustID:strIDc ToEmpCode:person.userCode ToUnitCode:@"" FrFlagPrivate:[NSString stringWithFormat:@"%ld",(long)fromFlag] ToFlagPrivate:[NSString stringWithFormat:@"%ld",(long)toFlag] CompleteBack:^(NSString *str) {
            NSLog(@"%@",str);
            if ([str isEqualToString:@"OK"]) {
                PL_ALERT_SHOW(@"转移成功");
                [self.navigationController popViewControllerAnimated:YES];
            }
            else if([str isEqualToString:@"ERR"])
            {
                PL_ALERT_SHOW(@"转移失败");
            }
            

        }];
        
        
    }
    else
    {
        
        //请求客源列表
        pageCount = 1;
        [self postRequest];
        [subVisterTableView reloadData];
    }
    [UIView animateWithDuration:0.1 animations:^{
        [self faleOut];
        filterView.frame = CGRectMake(0, 104, 0,0 );
        //            filterView.rowHeight = 30;
        
    } completion:^(BOOL finished) {
        //            [filterView reloadData];
        fistfilrerisout = NO;
    }];

    PL_PROGRESS_DISMISS;
}
#pragma mark -- 下拉列表显示条件
-(BOOL)whichDropTableViewWillShow
{
    
 
    NSLog(@"<><>><>><>><>><>>%d",[rightBtn.currentImage isEqual:[UIImage imageNamed:@"公客图标.png"]]);
    NSLog(@">>>>>>>>>>>>>>>>>%d",[rightBtn.currentImage isEqual:[UIImage imageNamed:@"私客图标.png"]]);
    if ([rightBtn.currentImage isEqual:[UIImage imageNamed:@"私客图标.png"]])
    {
        whicDropTableViewWillShow = YES;
        if (transFromPublicIsClick) {
            whicDropTableViewWillShow = NO;
        }
    }
   else
    {
        NSLog(@"++++++++>>>>>>>%d",transformPrivteIsClick);
        whicDropTableViewWillShow = NO;
        if (transformPrivteIsClick) {
            whicDropTableViewWillShow = YES;
        }
        
        
    }
    return whicDropTableViewWillShow;
}

#pragma mark --上啦下拉刷新
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    // [table addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    [subVisterTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    //    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [subVisterTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    subVisterTableView.headerPullToRefreshText = @"下拉刷新";
    subVisterTableView.headerReleaseToRefreshText = @"松开刷新";
    subVisterTableView.headerRefreshingText = @"客源正在刷新中";
    
    subVisterTableView.footerPullToRefreshText = @"上拉加载更多数据";
    subVisterTableView.footerReleaseToRefreshText = @"松开加载更多数据";
    subVisterTableView.footerRefreshingText = @"客源正在加载中";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [self.visterArray removeAllObjects];
    PL_PROGRESS_SHOW;
    NSLog(@"----------%@",[self frashSearchFilterCondition]);
    [[MyRequest defaultsRequest]afXYGetCustomListWithVist:[self frashSearchFilterCondition] ComPleteBack:^(NSMutableString *str) {
        _resultString=str;
        NSLog(@">>>>>>>%@",str);
        if ([str isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        if ([str isEqualToString:@"[]"]) {
            
            UILabel * label = [[UILabel alloc]init];
            label.text = @"暂无数据";
            label.textAlignment = NSTextAlignmentCenter;
            PL_ALERT_SHOW(@"暂无私客数据");
        }
        else  if ([str isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
        }
        else
        {
            SBJSON *json=[[SBJSON alloc]init];
            NSArray *array = [json objectWithString:_resultString error:nil];
            if (pubType == PubType_GS) {
                NSDictionary *dic = array.firstObject;
                sikeLable.text = [NSString stringWithFormat:@"共%@条公客",[dic[@"CountNum"]length] == 0 ? @"0":dic[@"CountNum"]];
            }else
            {
                NSDictionary *dic = array.firstObject;
                sikeLable.text = [NSString stringWithFormat:@"共%@条私客",[dic[@"CountNum"]length] == 0 ? @"0":dic[@"CountNum"]];
            }
            for (NSDictionary *dic in array) {
                VisterInfo *vister = [VisterInfo loadVisterInfoFromDictionary:dic];
                [self.visterArray addObject:vister];
                NSLog(@"》》》》》%lu",(unsigned long)self.visterArray.count);
                
            }
            
        }
        
        [subVisterTableView reloadData];
        [subVisterTableView headerEndRefreshing];
        
        PL_PROGRESS_DISMISS;
        
        
    }];
}

- (void)footerRereshing
{
    pageCount++;
    NSString * name         =[PL_USER_STORAGE objectForKey:PL_USER_NAME];
    NSString * token        = [PL_USER_STORAGE objectForKey:PL_USER_TOKEN];
    NSInteger indexNum;
    if(_supArray.count == 1)
    {
        indexNum = _supArray.count-1;
    }
    else
    {
        indexNum = _supArray.count-2;
    }
    BYPersonInfo *person    = self.supArray[indexNum];    //    NSString * subCode      = person.userCode;
    VisiterData *custom     =[[VisiterData alloc]init];
    custom.getAllString = oldStatusStr;
    if ([rightBtn.currentImage isEqual:[UIImage imageNamed:@"私客图标.png"]])
    {
        BYPersonInfo *lastPerson = [[BYPersonInfo alloc]init];
        lastPerson = self.supArray.lastObject;
        if ([lastPerson.userName isEqualToString:@"直属"]) {
            custom.directFlgString = @"1";
        }
        else
        {
            custom.directFlgString = @"0";
        }
        if ([lastPerson.userName isEqualToString:@"全部"])
        {
            if([person.userName isEqualToString:name])
            {
                custom.flagSubs = @"1";
                custom.subUserCode = @"";
            }
            else
            {
                custom.flagSubs = @"1";
                custom.subUserCode = person.userCode;
            }

        }
        else
        {
            custom.flagSubs = @"0";
            custom.subUserCode = lastPerson.userCode;
            
        }
        custom.FlagPrivate      = @"1";
        custom.pubTypeString    = @"";
        
    }
    else
    {
        custom.flagSubs = @"";
        custom.subUserCode = @"";
        custom.FlagPrivate = @"0";
        custom.pubTypeString = [NSString stringWithFormat:@"%ld",(long)pubType];
    }
    
    custom.userid           = name;
    custom.CustLevel        = @"";
    custom.DistrictName     = @"";
    custom.AreaId           = @"";
    custom.Trade            = @"";
    custom.PriceMax         = @"";
    custom.PriceMin         = @"";
    
    custom.FlagRecommand    = @"";
    custom.FlagNeed         = @"";
    custom.FlagSchool       = @"";
    custom.StartIndex       = [NSString stringWithFormat:@"%ld",(long)pageCount+1];
    custom.token            = token;
    
    NSLog(@"=================%@",custom.StartIndex);
    custom.telephoneNumberString = @"";
    
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]afXYGetCustomListWithVist:custom ComPleteBack:^(NSMutableString *str) {
        _resultString=str;
        if ([str isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        else if ([str isEqualToString:@"[]"]) {
            
            UILabel * label = [[UILabel alloc]init];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"暂无私客数据";
            // table.backgroundView = label;
            
            PL_ALERT_SHOW(@"暂无数据");
            //            [_array removeAllObjects];
            
            // [table removeFromSuperview];
        }
        else  if ([str isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
            [self.visterArray removeAllObjects];
        }
        else
        {
            SBJSON *json=[[SBJSON alloc]init];
            NSMutableArray *array = [[NSMutableArray alloc]init];
            for (NSMutableDictionary *dic in [json objectWithString:_resultString error:nil])
            {
                VisterInfo *vister = [VisterInfo loadVisterInfoFromDictionary:dic];
                [self.visterArray addObject:vister];
                
            }
            
            
            
            
            if (array.count==0) {
                UILabel * label = [[UILabel alloc]init];
                label.text = @"暂无私客数据";
                label.textAlignment = NSTextAlignmentCenter;
                //table.backgroundView = label;
                PL_ALERT_SHOW(@"没有更多数据了");
                pageCount--;
            }
            [self.visterArray addObjectsFromArray:array];
        }
        
        
        // sikeLable.text = [NSString stringWithFormat:@"共有%ld条私客",(long)_array.count];
        PL_PROGRESS_DISMISS;
        [subVisterTableView reloadData];
        [subVisterTableView footerEndRefreshing];
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"%s",__FUNCTION__);
    
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
