//
//  SubViewController.m
//  BYFCApp
//
//  Created by zzs on 15/4/20.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "SubViewController.h"
#import "PL_Header.h"
#import "CWStarRateView.h"

#define DUTYCODE 2

@interface SubViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,CWStarRateViewDelegate,UIGestureRecognizerDelegate>
{
    NSInteger score;
    UILabel *sikeLable;
    UIButton *rightBtn;
    //筛选一级菜单
    UITableView *filterView;
    //筛选二级菜单
    UITableView *secondFilterTableView;
    //下属客源列表
    UITableView *subVisterTableView;
    
    int freshcount;
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
    NSMutableArray *_array;
    NSString * privateCount;
    NSDictionary *dictionary;
    //是否是在职 1在职 2离职
    NSString *status;
    
    MyVisiterCustomCell *customcell;
    
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
    NSArray *styleArray;
    UIView *sousuoViewstyle;
    UITableView *styleTable;
    NSArray *phoneArr;
    //CUSTID
    NSString *CustID;
    //判断公私客
    BOOL isEqCode;
    //上级编号
    NSString *supCode;
    UIView *phoneBG;
    UITableView *phoneTable;
    NSArray *phoneArr2;
    NSString *flgString;
    NSString *departmentString;
    //存放一开始筛选条件
    NSString *oldfilterLabelStr;
    NSString *oldStatusStr;
    NSString *showLevelStr;
//    NSString *directFlgStr;
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

@end

@implementation SubViewController
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
-(void)findlevenumber
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
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self postRequest];
//    [self setupRefresh];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //请求上级领导
    [self requestSup];
    status = @"0";
    oldStatusStr = @"0";
    showLevelStr = @"";
    //初始化页面计数器
    pageCount = 0;
    
    //本机机主的等级
    [self findlevenumber];
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
    sikeLable = [[UILabel alloc]initWithFrame:CGRectMake(35, 5, 75, 25)];
    sikeLable.adjustsFontSizeToFitWidth=YES;
    sikeLable.textAlignment=NSTextAlignmentRight;
    
    sikeLable.font = [UIFont systemFontOfSize:10];
    [rightView addSubview:sikeLable];
    
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(CGRectGetMaxX(sikeLable.frame), 0, 30, 30);
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:17];
    [rightBtn setImage:[UIImage imageNamed:@"私客图标.png"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"公客图标.png"] forState:UIControlStateSelected];
    
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightClick1:) forControlEvents:UIControlEventTouchUpInside];
//    [rightView addSubview:rightBtn];
    
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = right;
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //键盘消失
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    [self setupRefresh];
    
}

#pragma mark -- 初始化下属客源列表
-(void)formatSubVisterTableView
{
    subVisterTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 114, ([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)-114) style:UITableViewStylePlain];
    subVisterTableView.delegate=self;
    subVisterTableView.dataSource=self;
    subVisterTableView.tableFooterView=[UIView new];
    subVisterTableView.rowHeight = 88;
    
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
    BYPersonInfo *lastPerson = [[BYPersonInfo alloc]init];
    lastPerson = self.supArray.lastObject;
    if([lastPerson.userName isEqualToString:@"直属"])
    {
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
    custom.userid           = name;
    custom.CustLevel        = @"";
    custom.DistrictName     = @"";
    custom.AreaId           = @"";
    custom.Trade            = @"";
    custom.PriceMax         = @"";
    custom.PriceMin         = @"";
    if (isEqCode == NO) {
        custom.FlagPrivate      = @"1";
    }else{
        custom.FlagPrivate      = @"0";
    }
    custom.FlagRecommand    = @"";
    custom.FlagNeed         = @"";
    custom.FlagSchool       = @"";
//    custom.StartIndex       = [NSString stringWithFormat:@"%ld",(long)pageCount];
    custom.StartIndex = @"1";
    custom.token            = token;
    
    NSLog(@"=================%@",custom.StartIndex);
    custom.telephoneNumberString = @"";
    custom.pubTypeString = @"";
    custom.jiaoYiString = @"";
    return custom;
}

#pragma mark--请求客源列表
-(void)postRequest
{
    if (isEqCode == NO) {
        [_array removeAllObjects];
        
        PL_PROGRESS_SHOW;
        NSLog(@"----------%@",[self frashSearchFilterCondition]);
        [[MyRequest defaultsRequest]getSubCustomList:[self frashSearchFilterCondition] backInfoMessage:^(NSMutableString *string) {
            _resultString=string;
            NSLog(@"%@",string);
            if ([string isEqualToString:@"NOLOGIN"]) {
                ViewController *login=[[ViewController alloc]init];
                [self.navigationController pushViewController:login animated:YES];
            }
            if ([string isEqualToString:@"[]"]) {
                
                UILabel * label = [[UILabel alloc]init];
                label.text = @"暂无数据";
                label.textAlignment = NSTextAlignmentCenter;
                PL_ALERT_SHOW(@"暂无私客数据");
                [_array removeAllObjects];
            }
            else  if ([string isEqualToString:@"exception"]) {
                PL_ALERT_SHOW(@"服务器异常");
                [_array removeAllObjects];
            }
            else
            {
                SBJSON *json=[[SBJSON alloc]init];
                _array=[json objectWithString:_resultString error:nil];
                NSLog(@"%lu",(unsigned long)_array.count);
                
            }
            [subVisterTableView reloadData];
            NSDictionary *dic = _array.firstObject;
            sikeLable.text = [NSString stringWithFormat:@"共%@条私客",[dic[@"CountNum"]length] == 0 ? @"0":dic[@"CountNum"]];
            PL_PROGRESS_DISMISS;
        }];
    }else{
        [_array removeAllObjects];
        
        PL_PROGRESS_SHOW;
        NSLog(@"----------%@",[self frashSearchFilterCondition]);
        [[MyRequest defaultsRequest]getSubCustomList:[self frashSearchFilterCondition] backInfoMessage:^(NSMutableString *string) {
            _resultString=string;
            NSLog(@"%@",string);
            if ([string isEqualToString:@"NOLOGIN"]) {
                ViewController *login=[[ViewController alloc]init];
                [self.navigationController pushViewController:login animated:YES];
            }
            if ([string isEqualToString:@"[]"]) {
                
                UILabel * label = [[UILabel alloc]init];
                label.text = @"暂无数据";
                label.textAlignment = NSTextAlignmentCenter;
                PL_ALERT_SHOW(@"暂无私客数据");
                [_array removeAllObjects];
            }
            else  if ([string isEqualToString:@"exception"]) {
                PL_ALERT_SHOW(@"服务器异常");
                [_array removeAllObjects];
            }
            else
            {
                SBJSON *json=[[SBJSON alloc]init];
                _array=[json objectWithString:_resultString error:nil];
                NSLog(@"%lu",(unsigned long)_array.count);
                
            }
            [subVisterTableView reloadData];
            NSDictionary *dic = _array.firstObject;
            sikeLable.text = [NSString stringWithFormat:@"共%@条公客",[dic[@"CountNum"]length] == 0 ? @"0":dic[@"CountNum"]];
            PL_PROGRESS_DISMISS;
        }];
    }
    
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
        [self filterStringf];
       oldfilterLabelStr = self.filterLabel.text;
        PL_PROGRESS_DISMISS;
    }];
    
    
    
}

#pragma mark --- 导航右键点击时间
-(void)rightClick1:(UIButton *)sender
{
    sender.selected=!sender.selected;
    if (!sender.selected) {
        isEqCode = NO;
        self.title=@"我的客源";
        rightIsClick=NO;
        [self postRequest];
        
    }
    else
    {
        isEqCode = YES;
        self.title=@"公司客源";
        rightIsClick=YES;
        sikeLable.hidden = NO;
        [self postRequest];
    }
    
}
//-(void)post2
//{
//    _strP = @"";
//    NSString * name =[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
//    NSString * token = [PL_USER_STORAGE objectForKey:PL_USER_TOKEN];
//    PL_PROGRESS_SHOW;
//    VisiterData *custom=[[VisiterData alloc]init];
//    custom.userid=name;
//    if (topStr1.length) {
//        custom.CustLevel=topStr1;
//    }
//    else
//    {
//        custom.CustLevel=@"";
//    }
//    if (XQStr.length) {
//        custom.DistrictName=XQStr;
//    }
//    else
//    {
//        custom.DistrictName=@"";
//    }
//    if (PQStr.length) {
//        custom.AreaId=PQStr;
//    }
//    else
//    {
//        custom.AreaId=@"";
//    }
//    if (currentTradeStr.length) {
//        custom.Trade=currentTradeStr;
//    }
//    else
//    {
//        custom.Trade=@"";
//    }
//    if (currentPriceMin.length) {
//        custom.PriceMin=currentPriceMin;
//    }
//    else
//    {
//        custom.PriceMin=@"";
//    }
//    if (currentPriceMax.length) {
//        custom.PriceMax=currentPriceMax;
//    }
//    else
//    {
//        custom.PriceMax=@"";
//    }
//    custom.FlagPrivate=@"0";
//    custom.StartIndex=@"";
//    if (!topStr3.length) {
//        custom.FlagRecommand=@"";
//        custom.FlagNeed=@"";
//        custom.FlagSchool=@"";
//    }
//    if ([topStr3 isEqualToString:@"经理推荐"]) {
//        custom.FlagRecommand=@"1";
//        custom.FlagNeed=@"";
//        custom.FlagSchool=@"";
//    }
//    else if ([topStr3 isEqualToString:@"急需"]) {
//        custom.FlagRecommand=@"";
//        custom.FlagNeed=@"1";
//        custom.FlagSchool=@"";
//    }
//    else if ([topStr3 isEqualToString:@"学区房"]) {
//        custom.FlagRecommand=@"";
//        custom.FlagNeed=@"";
//        custom.FlagSchool=@"1";
//    }
//    custom.token=token;
//    _strP = custom.FlagPrivate;
//    [[MyRequest defaultsRequest]getCustomList:custom backInfoMessage:^(NSMutableString *string) {
//        _resultString=string;
//        
//        if ([string isEqualToString:@"NOLOGIN"]) {
//            ViewController *login=[[ViewController alloc]init];
//            [self.navigationController pushViewController:login animated:YES];
//        }
//        else if ([string isEqualToString:@"[]"]) {
//            PL_ALERT_SHOW(@"暂无数据");
//            [_array removeAllObjects];
//        }
//        else  if ([string isEqualToString:@"exception"]) {
//            PL_ALERT_SHOW(@"服务器异常");
//            [_array removeAllObjects];
//        }
//        else
//        {
//            SBJSON *json=[[SBJSON alloc]init];
//            _array=[json objectWithString:_resultString error:nil];
//        }
//        [subVisterTableView reloadData];
//        
//        [[MyRequest defaultsRequest]afGetPublicCount:[PL_USER_STORAGE objectForKey:PL_USER_NAME] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(id obj) {
//            if ([obj isKindOfClass:[NSString class]])
//            {
//                NSString * str2 = obj;
//                if ([str2 isEqualToString:@"[]"]) {
//                    str2=@"0";
//                }else{
//                    sikeLable.text = [NSString stringWithFormat:@"共%@条公客",str2];
//                }
//                PL_PROGRESS_DISMISS;
//            }
//        }];
//    }];
//    
//}
//
#pragma mark 表；
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == subVisterTableView)
    {
        return _array.count;
    }
    if (tableView.tag==15000) {
        return styleArray.count;
    }
    else
    {
        return tableView == filterView ?  self.filterArray.count:self.subArray.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reusedID = @"cellReusedID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedID];
        
    }
    if (tableView == filterView) {
        
        
        
        cell.textLabel.text = self.filterArray[indexPath.row];
        if(indexPath.row == 0)
        {
            
        }
        else if (indexPath.row <= self.levenumber + 1 && ![[PL_USER_STORAGE objectForKey:PL_USER_code] isEqualToString:@"AA0006"])
        {
            NSLog(@"你无权限点击此项");
            cell.userInteractionEnabled = NO;
            //           cell = [filterView cellForRowAtIndexPath:indexPath];
            cell.backgroundColor = [UIColor grayColor];
            [self faleOut];
            
        }
        
    }
    else if (tableView == secondFilterTableView) {
        {
            BYPersonInfo *sperson = self.subArray[indexPath.row];
            if (filterClickrow == 0) {
                cell.textLabel.text = self.subArray[indexPath.row];
                cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
            }
            else if (filterClickrow == 1)
            {
                cell.textLabel.text = sperson.department;
                cell.textLabel.font = [UIFont systemFontOfSize:12.0f];

            }
            else if(filterClickrow == 2)
            {
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
    }
    else if(tableView == subVisterTableView)
    {
        static NSString *str=@"cell";
        customcell=[tableView dequeueReusableCellWithIdentifier:str];
        
        
        
        if (!customcell) {
            customcell=[[MyVisiterCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            customcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            //            customcell.selected = NO;
            //            customcell.Highlighted = NO;
        }
        customcell.tag=[indexPath row];
        
        if (_array.count>0)
        {
            dictionary=[_array objectAtIndex:indexPath.row];
            if (dictionary.count>0 && [dictionary isKindOfClass:[NSDictionary class]])
            {
                _pianquString=[dictionary objectForKey:@"AreaName"];
                if ([[dictionary objectForKey:@"Age"]isEqualToString:@""]) {
                    if ((NSNull *)[dictionary objectForKey:@"Sex"]==[NSNull null])
                    {
                        customcell.name.text=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"CustName"]];
                    }
                    else
                    {
                        customcell.name.text=[NSString stringWithFormat:@"%@ %@",[dictionary objectForKey:@"CustName"],[dictionary objectForKey:@"Sex"]];
                    }
                    
                }else{
                    if ((NSNull *)[dictionary objectForKey:@"Sex"]==[NSNull null])
                    {
                        customcell.name.text=[NSString stringWithFormat:@"%@ %@",[dictionary objectForKey:@"CustName"],[dictionary objectForKey:@"Age"]];
                    }
                    else
                    {
                        customcell.name.text=[NSString stringWithFormat:@"%@ %@ %@",[dictionary objectForKey:@"CustName"],[dictionary objectForKey:@"Sex"],[dictionary objectForKey:@"Age"]];
                    }
                    
                    
                }
                if ((NSNull *)[dictionary objectForKey:@"DistrictName"]==[NSNull null])
                {
                    [customcell.xiaoqu setTitle:@"" forState:UIControlStateNormal];
                }
                else
                {
                    [customcell.xiaoqu setTitle:[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"DistrictName"]] forState:UIControlStateNormal];
                }
                
                [customcell.xiaoqu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                customcell.xiaoqu.titleLabel.text =[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"DistrictName"]];
                
                //            [customcell.xiaoqu addTarget:self action:@selector(xiaoquClick:) forControlEvents:UIControlEventTouchUpInside];
                customcell.xiaoqu.titleLabel.textColor = [UIColor blackColor];
                if ((NSNull *)[dictionary objectForKey:@"AreaName"]==[NSNull null])
                {
                    [customcell.pianqu setTitle:@"" forState:UIControlStateNormal];
                }
                else
                {
                    [customcell.pianqu setTitle:[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"AreaName"]] forState:UIControlStateNormal];
                }
                
                
                [customcell.pianqu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                customcell.pianqu.tag=indexPath.row;
                //            [customcell.pianqu addTarget:self action:@selector(pianquClick:) forControlEvents:UIControlEventTouchUpInside];
                if ([[dictionary objectForKey:@"CountF"]isEqualToString:@"房"]) {
                    customcell.roomInfo.text=[NSString stringWithFormat:@"%@ %@",[dictionary objectForKey:@"CountT"],[dictionary objectForKey:@"Square"]];
                }else{
                    customcell.roomInfo.text=[NSString stringWithFormat:@"%@ %@ %@",[dictionary objectForKey:@"CountF"],[dictionary objectForKey:@"CountT"],[dictionary objectForKey:@"Square"]];
                }
                if ([[dictionary objectForKey:@"Trade"]isEqualToString:@"求购"]) {
                    customcell.gou.image=[UIImage imageNamed:@"gou_hong"];
                    customcell.yixiangPrice.text=[NSString stringWithFormat:@"意向总价:%@万",[dictionary objectForKey:@"Price"]];
                    NSMutableAttributedString * attri = [[NSMutableAttributedString alloc]initWithString:customcell.yixiangPrice.text];
                    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, attri.length-4)];
                    customcell.yixiangPrice.attributedText=attri;
                }else
                {
                    customcell.gou.image=[UIImage imageNamed:@"gou_hui.png"];
                }
                if ([[dictionary objectForKey:@"Trade"]isEqualToString:@"求租"]) {
                    customcell.zu.image=[UIImage imageNamed:@"zu_lv.png"];
                    customcell.yixiangPrice.text=[NSString stringWithFormat:@"意向总价:%@",[dictionary objectForKey:@"Price"]];
                    NSMutableAttributedString * attri = [[NSMutableAttributedString alloc]initWithString:customcell.yixiangPrice.text];
                    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, attri.length-4)];
                    customcell.yixiangPrice.attributedText=attri;
                }
                else
                {
                    customcell.zu.image=[UIImage imageNamed:@"zu_hui.png"];
                }
                if ([[dictionary objectForKey:@"Trade"]isEqualToString:@""]) {
                    customcell.zu.image=[UIImage imageNamed:@"zu_lv.png"];
                    customcell.gou.image=[UIImage imageNamed:@"gou_hong"];
                }
                if ((NSNull *)[dictionary objectForKey:@"Trade"]==[NSNull null]) {
                    customcell.zu.image=[UIImage imageNamed:@"zu_lv.png"];
                    customcell.gou.image=[UIImage imageNamed:@"gou_hong"];
                }
                if ([[dictionary objectForKey:@"FlagRecommand"]isEqualToString:@"1"]) {
                    customcell.jinglituijian.image=[UIImage imageNamed:@"jinglituijian_lan"];
                }
                
                if ([[dictionary objectForKey:@"FlagNeed"]isEqualToString:@"1"]) {
                    customcell.jixu.image=[UIImage imageNamed:@"急需.png"];
                }
                
                if ([[dictionary objectForKey:@"FlagSchool"]isEqualToString:@"1"]) {
                    customcell.xuequfang.image=[UIImage imageNamed:@"xuequfang_fen.png"];
                }
                
                NSString *custlevelString = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"CustLevel"] ];
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
                [customcell.genjin addTarget:self action:@selector(genClick:) forControlEvents:UIControlEventTouchUpInside];
                customcell.genjin.tag=indexPath.row;
                
                [customcell.phoneBtn addTarget:self action:@selector(phoneClick:) forControlEvents:UIControlEventTouchUpInside];
                customcell.phoneBtn.tag=indexPath.row;
            }
            
        }
        return customcell;
    }
    if (tableView.tag==15000) {
        static NSString *str=@"cellStr";
        UITableViewCell *cell2=[tableView dequeueReusableCellWithIdentifier:str];
        if (!cell2) {
            cell2=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        if (styleArray.count>0)
        {
            NSDictionary *dic=[styleArray objectAtIndex:indexPath.row];
            cell2.textLabel.text=[dic objectForKey:@"FollowType"];
            cell2.textLabel.font=[UIFont systemFontOfSize:14];
            cell2.backgroundColor=[UIColor clearColor];
            cell2.textLabel.textColor=[UIColor whiteColor];
            cell2.selectionStyle=UITableViewCellSelectionStyleNone;
            
            
        }
        return cell2;
    }
    return cell;
}

#pragma mark 点击打电话按钮
-(void)phoneClick:(UIButton *)sender
{
    
    //    [self getSupCode];
    NSDictionary *starDic=[_array objectAtIndex:sender.tag];
    starCount=[[starDic objectForKey:@"CustLevel"] intValue];
    CustID = _array[sender.tag][@"CustID"];
    NSLog(@"id  %@",CustID);
    NSDictionary *visterDic = _array[sender.tag];
    NSString *phoneStr=[visterDic objectForKey:@"CustTel"];
    phoneArr=[phoneStr componentsSeparatedByString:@","];
    TelViewAlert * alert = [[TelViewAlert alloc]initWithconnectWithArray:phoneArr Calltype:callType_Vister custId:visterDic[@"CustID"]];
    alert.stringTitle = [NSString stringWithFormat:@"%@",visterDic[@"CustName"]];
    [alert showTelWindow:self.view];
    
}

-(void)deleteClick
{
//   [phoneBG removeFromSuperview];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    
    [textView1 resignFirstResponder];
    
    
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:self.view];
    
    if (CGRectContainsPoint(genjinView.frame, point)) {
        [genjinView endEditing:YES];
        CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, 0);
        //使视图使用这个变换
        bgView.transform = pTransform;
    }
    else
    {
        [bgView removeFromSuperview];
        [genjinView removeFromSuperview];
    }

//    if (CGRectContainsPoint(phoneBG.frame, point)) {
//       [phoneBG removeFromSuperview];
//    }
}


#pragma  mark ---写跟进
-(void)genClick:(UIButton *)sender
{
    indexTag=sender.tag;
    //背景
    NSDictionary *starDic1=[_array objectAtIndex:sender.tag];
    starCount=[[starDic1 objectForKey:@"CustLevel"] intValue];
    bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT)];
    //bgView.backgroundColor=[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:0.9];
    bgView.backgroundColor=[[UIColor grayColor]colorWithAlphaComponent:0.5];
    [self.view addSubview:bgView];
    
   
    //小背景
    genjinView=[[UIView alloc]initWithFrame:CGRectMake(20, PL_HEIGHT/3-30, PL_WIDTH-40, 200+30)];
    genjinView.alpha=1;
    genjinView.backgroundColor=[UIColor whiteColor];
    [bgView addSubview:genjinView];
    
    UILabel *yi=[[UILabel alloc]initWithFrame:CGRectMake(40, 10, 60, 20)];
    yi.text=@"意向度:";
    [genjinView addSubview:yi];
    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(100, 5, 150, 30) numberOfStars:5];
    NSDictionary *starDic=[_array objectAtIndex:sender.tag];
    starCount=[[starDic objectForKey:@"CustLevel"] intValue];
    self.starRateView.scorePercent = starCount/5.0;
    self.starRateView.allowIncompleteStar = NO;
    self.starRateView.hasAnimation = YES;
    self.starRateView.delegate=self;
    [genjinView addSubview:self.starRateView];
    
    //标题
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(PL_WIDTH/2-80, 5+30, 200, 30)];
    title.text=@"录入跟进信息";
    [genjinView addSubview:title];
    //跟进方式、按钮
    UIButton *FSBtn=[[UIButton alloc]initWithFrame:CGRectMake(20+20, 30+30, 80, 30)];
    [FSBtn addTarget:self action:@selector(fangshiClick:) forControlEvents:UIControlEventTouchUpInside];
    [genjinView addSubview:FSBtn];
    
    fangshi=[[UILabel alloc]initWithFrame:CGRectMake(20+20, 35+30, 50, 20)];
    fangshi.text=@"跟进方式";
    fangshi.font=[UIFont systemFontOfSize:12];
    fangshi.textAlignment=NSTextAlignmentCenter;
    [genjinView addSubview:fangshi];
    fangshiBtn=[[UIButton alloc]initWithFrame:CGRectMake(71+20, 40+30, 10, 10)];
    [fangshiBtn setImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    [fangshiBtn setImage:[UIImage imageNamed:@"dropup.png"] forState:UIControlStateSelected];
    [fangshiBtn addTarget:self action:@selector(fangshiClick:) forControlEvents:UIControlEventTouchUpInside];
    [genjinView addSubview:fangshiBtn];
    NSMutableArray * arrTitle = [NSMutableArray arrayWithObjects:@"电话",@"手机",@"微信",@"QQ",@"其他", nil];
    sousuoView = [[UIView alloc]initWithFrame:CGRectMake(20+20, 55+30, 80, 30*arrTitle.count)];
    UIImageView * viewBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"black.png"]];
    viewBg.frame = CGRectMake(0, 0, CGRectGetWidth(sousuoView.frame), CGRectGetHeight(sousuoView.frame));
    [sousuoView addSubview:viewBg];
    
    for (int i=0; i<3; i++)
    {
        UIImageView * sousuoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,i*28+26+10+5, 80, 1)];
        sousuoImage.image = [UIImage imageNamed:@"black_in_hengxian.png"];
        sousuoImage.backgroundColor = [UIColor clearColor];
        [sousuoView addSubview:sousuoImage];
    }
    
    for (int j=0; j<arrTitle.count; j++)
    {
        UIButton * buttonLable = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonLable.frame = CGRectMake(0, j*28+18, 80, 20);
        buttonLable.backgroundColor = [UIColor clearColor];
        buttonLable.titleLabel.font=[UIFont systemFontOfSize:14];
        [buttonLable setTitle:[arrTitle objectAtIndex:j] forState:UIControlStateNormal];
        [buttonLable setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        buttonLable.tag =2500+j;
        [buttonLable addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [sousuoView addSubview:buttonLable];
    }
    
    sousuoView.backgroundColor = [UIColor clearColor];
    
    //跟进类型、按钮
    sousuoViewstyle = [[UIView alloc]initWithFrame:CGRectMake(120+40, 55+30, 80, 80+40)];
    UIImageView * leixingIMge = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"black.png"]];
    leixingIMge.frame = CGRectMake(0, 0, CGRectGetWidth(sousuoViewstyle.frame), CGRectGetHeight(sousuoViewstyle.frame));
    [sousuoViewstyle addSubview:leixingIMge];
    styleTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 7, 90, 80+40-7) style:UITableViewStylePlain];
    styleTable.delegate=self;
    styleTable.dataSource=self;
    styleTable.tag=15000;
    styleTable.separatorColor = [UIColor grayColor];
    styleTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    styleTable.separatorInset = UIEdgeInsetsZero;
    styleTable.backgroundColor=[UIColor clearColor];
    [sousuoViewstyle addSubview:styleTable];
    if ([styleTable respondsToSelector:@selector(setSeparatorInset:)])
    {
        [styleTable setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if([styleTable respondsToSelector:@selector(setLayoutMargins:)])
    {
        [styleTable setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    style=[[UILabel alloc]initWithFrame:CGRectMake(120+40, 35+30, 50, 20)];
    style.text=@"跟进类型";
    style.font=[UIFont systemFontOfSize:12];
    [genjinView addSubview:style];
    styleBtn=[[UIButton alloc]initWithFrame:CGRectMake(171+40, 40+30, 10, 10)];
    [styleBtn setImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    [styleBtn setImage:[UIImage imageNamed:@"dropup.png"] forState:UIControlStateSelected];
    [styleBtn addTarget:self action:@selector(styleClick:) forControlEvents:UIControlEventTouchUpInside];
    [genjinView addSubview:styleBtn];
    //跟进类型、按钮
//    UIButton *STBtn=[[UIButton alloc]initWithFrame:CGRectMake(120+40, 30+30, 80, 30)];
//    [STBtn addTarget:self action:@selector(styleClick:) forControlEvents:UIControlEventTouchUpInside];
//    [genjinView addSubview:STBtn];
    
    //输入框
    textView1=[[UITextView alloc]initWithFrame:CGRectMake(20, 55+30, PL_WIDTH-40-40, 100)];
    textView1.layer.borderWidth=1.5;
    textView1.layer.borderColor = [UIColor grayColor].CGColor;
    textView1.delegate=self;
    [genjinView addSubview:textView1];
    
    placeholder=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH-40, 30)];
    placeholder.text=@"请输入跟进内容";
    placeholder.textColor=[UIColor grayColor];
    placeholder.font=[UIFont systemFontOfSize:13];
    [textView1 addSubview:placeholder];
    
    //统计
    count=[[UILabel alloc]initWithFrame:CGRectMake(25, 157+30, 100, 20)];
    count.text=[NSString stringWithFormat:@"0/100"];
    [genjinView addSubview:count];
    //确认按钮
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH-135, 150+40, 77, 30)];
    [button setImage:[UIImage imageNamed:@"提交按钮.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [genjinView addSubview:button];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapbgView)];
    gesture.numberOfTapsRequired = 1;
    gesture.numberOfTouchesRequired = 1;
    gesture.delegate = self;
    [bgView addGestureRecognizer:gesture];
}
- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent
{
    score=newScorePercent*5;
    starCount=score;
}
#pragma mark---跟进类型---
-(void)styleClick:(UIButton *)sender
{
    NSLog(@"******");
    styleArray = [NSArray array];
    
    sender.selected=!sender.selected;
    if (sender.selected) {
        styleBtn.selected=YES;
        [[MyRequest defaultsRequest]GetFollowTypeList:^(NSMutableString *string) {
            NSLog(@"%@",string);
            if ([string isEqualToString:@"NOLOGIN"]) {
                ViewController *login=[[ViewController alloc]init];
                [self.navigationController popToViewController:login animated:YES];
            }
            if ([string isEqualToString:@"[]"]) {
                PL_ALERT_SHOW(@"暂无数据");
            }
            SBJSON *json=[[SBJSON alloc]init];
            styleArray=[json objectWithString:string error:nil];
            [styleTable reloadData];
            [genjinView addSubview:sousuoViewstyle];
        } userid:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME] token:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN]];
        
    }else{
        styleBtn.selected=NO;
        [sousuoViewstyle removeFromSuperview];
    }

    
//    sender.selected=!sender.selected;
//    if (sender.selected) {
//        styleBtn.selected=YES;
//        PL_PROGRESS_SHOW;
//        [[MyRequest defaultsRequest]GetFollowTypeList:^(NSMutableString *string) {
//            PL_PROGRESS_DISMISS;
//            if ([string isEqualToString:@"NOLOGIN"]) {
//                ViewController *login=[[ViewController alloc]init];
//                [self.navigationController pushViewController:login animated:YES];
//            }
//            else if ([string isEqualToString:@"[]"]) {
//                PL_ALERT_SHOW(@"暂无数据");
//            }
//            else  if ([string isEqualToString:@"exception"]) {
//                PL_ALERT_SHOW(@"服务器异常");
//            }
//            else
//            {
//                SBJSON *json=[[SBJSON alloc]init];
//                styleArray=[json objectWithString:string error:nil];
//            }
//            
//            
//            sousuoViewstyle = [[UIView alloc]initWithFrame:CGRectMake(120+40, 55+30, 80, 80+40)];
//            UIImageView * viewBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"black.png"]];
//            viewBg.frame = CGRectMake(0, 0, CGRectGetWidth(sousuoViewstyle.frame), CGRectGetHeight(sousuoViewstyle.frame));
//            [sousuoViewstyle addSubview:viewBg];
//            styleTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 7, 80+20, 80+40-7) style:UITableViewStylePlain];
//            styleTable.delegate=self;
//            styleTable.dataSource=self;
//            styleTable.tag=15000;
//            styleTable.backgroundColor=[UIColor redColor];
//            [sousuoViewstyle addSubview:styleTable];
//            [genjinView addSubview:sousuoViewstyle];
//            if ([styleTable respondsToSelector:@selector(setSeparatorInset:)])
//            {
//                [styleTable setSeparatorInset:UIEdgeInsetsZero];
//                
//            }
//            if([styleTable respondsToSelector:@selector(setLayoutMargins:)])
//            {
//                [styleTable setLayoutMargins:UIEdgeInsetsZero];
//                
//            }
//        } userid:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME] token:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN]];
//        
//    }else{
//        [sousuoViewstyle removeFromSuperview];
//        styleBtn.selected=NO;
//    }
}
#pragma mark----跟进方式
-(void)fangshiClick:(UIButton *)sender
{
    sender.selected=!sender.selected;
    if (sender.selected) {
        [genjinView addSubview:sousuoView];
        fangshiBtn.selected=YES;
    }else{
        [sousuoView removeFromSuperview];
        fangshiBtn.selected=NO;
    }
}
-(void)buttonClick:(UIButton *)sender
{
    fangshiBtn.selected=NO;
    switch (sender.tag) {
        case 2500:
        {
            fangshi.text=@"电话";
            [sousuoView removeFromSuperview];
        }
            break;
        case 2501:
        {
            fangshi.text=@"手机";
            [sousuoView removeFromSuperview];
        }
            break;
        case 2502:
        {
            fangshi.text=@"微信";
            [sousuoView removeFromSuperview];
        }
            break;
        case 2503:
        {
            fangshi.text=@"QQ";
            [sousuoView removeFromSuperview];
        }
            break;
        case 2504:
        {
            fangshi.text=@"其他";
            [sousuoView removeFromSuperview];
        }
            break;
        default:
            break;
    }
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
//    [genjinView removeFromSuperview];
//    [bgView removeFromSuperview];
}
#pragma mark---UITextView  Delegate
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length >BOOKMARK_WORD_LIMIT)
    {
        textView.text =[textView.text substringToIndex:BOOKMARK_WORD_LIMIT];
    }
    else
    {
        count.text=[NSString stringWithFormat:@"%lu/100",(unsigned long)textView.text.length];
    }
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
    
    if ([text  isEqualToString:@"\n"]) {
        [textView1 resignFirstResponder];
         }
    
    return YES;
}
#pragma mark ---确认按钮
-(void)sureClick
{
    if (starCount<4) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"意向度过低，是否修改意向度" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alert show];
    }
    else
    {
        [self commitRequest];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [self commitRequest];
    }
    else
    {
        //        [self commitRequest];
    }
}
-(void)commitRequest
{
    
    
    if ([fangshi.text isEqualToString:@"跟进方式"]||[style.text isEqualToString:@"跟进类型"]||[textView1.text isEqualToString:@""])
    {
        PL_ALERT_SHOW(@"跟进内容或跟进内容或跟进类型不能为空");
    }
    else
    {
        NSLog(@"+++++%s",__FUNCTION__);
        CustomersFollowData *follow=[[CustomersFollowData alloc]init];
        NSDictionary *d=[_array objectAtIndex:indexTag];
        follow.CustID=[d objectForKey:@"CustID"];
        if ([style.text isEqualToString:@"跟进类型"]) {
            follow.FollowType=@"";
        }else
        {
            follow.FollowType=style.text;
        }
        follow.Content=textView1.text;
        if ([fangshi.text isEqualToString:@"跟进方式"]) {
            follow.FollowWay=@"";
        }else{
            follow.FollowWay=fangshi.text;
        }
        follow.CustLevel=[NSString stringWithFormat:@"%ld",(long)starCount];
        follow.userid=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
        follow.token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSLog(@"%@  %@  %@  %@  %@  %@",follow.CustID,follow.FollowType,follow.Content,follow.FollowWay,follow.userid,follow.token);
        PL_PROGRESS_SHOW;
        [[MyRequest defaultsRequest]getAddCustomersFollow:follow backInfoMessage:^(NSMutableString *string) {
            if ([string isEqualToString:@"NOLOGIN"]) {
                ViewController *login=[[ViewController alloc]init];
                [self.navigationController pushViewController:login animated:YES];
            }
            else  if ([string isEqualToString:@"exception"]) {
                PL_ALERT_SHOW(@"服务器异常");
            }
            else if ([string isEqualToString:@"[]"])
            {
                PL_ALERT_SHOW(@"暂无数据");
            }
            if ([string isEqualToString:@"OK"]) {
                NSLog(@"%@",follow.CustLevel);
                PL_ALERT_SHOW(@"提交成功");
                //                rightBtn.selected=NO;
                //                rightIsClick=NO;
                //                [self postRequest];
                //                [self post2];
                
            }
            else if ([string isEqualToString:@"2"])
            {
                PL_ALERT_SHOW(@"您的私客已经满了，请先移除部分客源");
            }
            else if ([string isEqualToString:@"3"])
            {
                PL_ALERT_SHOW(@"该客户已变成其他客户经理的私客，无法更新");
            }
            else if ([string isEqualToString:@"ERR"])
            {
                PL_ALERT_SHOW(@"提交失败");
            }else
            {
                PL_ALERT_SHOW(@"提交内容有敏感词汇!");
            }
            PL_PROGRESS_DISMISS;
            // [table reloadData];
        }];
        [bgView removeFromSuperview];
        
    }
}


#pragma mark -- 点击筛选一级菜单
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==phoneTable) {
        if (phoneArr.count>0)
        {
            
            
            NSLog(@"%@",[PL_USER_STORAGE objectForKey:PL_USER_PHONEnUM]);
            NSString * telNum =[PL_USER_STORAGE objectForKey:PL_USER_PHONEnUM];
            NSLog(@"%@",telNum);
            NSLog(@"%@",CustID);
            NSLog(@"%@",supCode);
            NSLog(@"%@",[PL_USER_STORAGE objectForKey:PL_USER_USERID]);
            NSLog(@"%@",[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]);
            NSString *phoneString=[phoneArr objectAtIndex:indexPath.row];
            NSLog(@"%@-------->",phoneString);
            NSArray *phoneArr22=[phoneString componentsSeparatedByString:@"|"];
            NSString *phoneNum=[phoneArr22 objectAtIndex:1];
            if([telNum isEqualToString:@""]||[phoneNum isEqualToString:@""])
            {
                
            }
            else
            {
                PL_ALERT_SHOW(@"系统正在拨打，请稍后");
                [phoneBG removeFromSuperview];
                
                [[MyRequest defaultsRequest]afDialCustTelephone:telNum CustPhone:phoneNum ID:CustID Type:@"0" FromCode:supCode userid:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSMutableString *str)
                 {
                     
                     NSLog(@"%@",str);
                     
                 }];
                
                
                [self genClick:customcell.genjin];
            }

           
        }
        
    }
    
    //弹出二级菜单
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
            else if (indexPath.row == 1) {
//                NSLog(@"status =%@",status);
//                if ([status isEqualToString:@"1"]) {
//                    
//                }
//                else if([status isEqualToString:@"2"])
//                {
//                    status = @"0";
//                }
                [self requestSub:[PL_USER_STORAGE objectForKey:PL_USER_code] flg:@"0" department:showLevelStr];
                [self popSecondFilterView];
            }
            else
            {
                //                BYPersonInfo *firstPerson = [[BYPersonInfo alloc]init];
                //                firstPerson = self.supArray[indexPath.row - 1];
                if ( (int)indexPath.row-1- (int)self.supArray.count <= 0  )
                {
                    BYPersonInfo *person = self.supArray[indexPath.row - 2];
                    if(![person.userName isEqualToString:@"全部"]){
                        
//                        NSLog(@"status =%@",status);
//                        if (filterClickrow ==5) {
//                            NSLog(@"status = %@",status);
//                            status = oldStatusStr;
//                        }
//                        else
//                        {
//                            NSLog(@"status = %@",status);
//                            if ([status isEqualToString:@"1"]) {
//                                
//                            }
//                            else if([status isEqualToString:@"2"])
//                            {
//                                status = @"0";
//                            }
//                        }
                        status = oldStatusStr;
                        if (person.FLG == nil) {
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
               
                if (self.supArray.count != 0 && (NSInteger)indexPath.row-1- (NSInteger)self.supArray.count <= 0) {
                    
                    BYPersonInfo *person = self.supArray[indexPath.row-2];
                    if (![person.userName isEqualToString:@"全部"]) {
//                        if (filterClickrow ==5) {
//                            NSLog(@"status = %@",status);
//                            status = oldStatusStr;
//                        }
//                        else
//                        {
//                            NSLog(@"status = %@",status);
//                            if ([status isEqualToString:@"1"]) {
//                                
//                            }
//                            else if([status isEqualToString:@"2"])
//                            {
//                                status = @"0";
//                            }
//                        }
                        status = oldStatusStr;
                        if(person.FLG == nil)
                        {
                            person.FLG =@"0";
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
            
        }
    }
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
            else if (filterClickrow-1 >= self.supArray.count)
            {
                
                [self.supArray addObject:person];
                [self.supArray sortUsingComparator:^NSComparisonResult(BYPersonInfo  *person, BYPersonInfo *anothorperson) {
                    return  [person.sort compare:anothorperson.sort];
                }];
                NSLog(@"xfilterrow %ld",(long)filterClickrow);
                NSLog(@"xcount %lu",(unsigned long)self.supArray.count);
                [self filterStringf];
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
                
                [self filterStringf];
            }
            
            [self faleOut];
            
        }
    if (tableView == subVisterTableView) {
        AVisiterDetailViewController *customer=[[AVisiterDetailViewController alloc]init];
        customer.dict=[_array objectAtIndex:indexPath.row];
        //客源详情请求
        AppointVisiterData *customDetail=[[AppointVisiterData alloc]init];
        customDetail.CustID=[customer.dict objectForKey:@"CustID"];
        customer.custId=customDetail.CustID;
        [[NSUserDefaults standardUserDefaults]setObject:customDetail.CustID forKey:@"CustID"];
        customDetail.userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
        customDetail.token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        [[NSUserDefaults standardUserDefaults]setObject:customDetail.CustID forKey:@"custID"];
        PL_PROGRESS_SHOW;
        [[MyRequest defaultsRequest]getCustomDetailInfoEasterList:customDetail backInfoMessage:^(NSMutableString *string) {
            if ([string isEqualToString:@"NOLOGIN"]) {
                ViewController *login=[[ViewController alloc]init];
                [self.navigationController pushViewController:login animated:YES];
            }
            else if ([string isEqualToString:@"exception"]) {
                PL_ALERT_SHOW(@"服务器异常");
            }
            else if ([string isEqualToString:@"[]"])
            {
                PL_ALERT_SHOW(@"暂无数据");
            }
            else
            {
                SBJSON *json=[[SBJSON alloc]init];
                NSArray *array=[json objectWithString:string error:nil];
                NSDictionary * dicti=[array objectAtIndex:0];
                NSLog(@"%@",[dicti objectForKey:@"CustLevel"]);
            }
            PL_PROGRESS_DISMISS;
            customer.detailString=string;
            
            if (rightIsClick==NO) {
                customer.isHiden=NO;
            }
            else
            {
                customer.isHiden=YES;
            }
            customer.customDetail = customDetail;
            [self.navigationController pushViewController:customer animated:YES];
        }];
        
    }
    if (tableView.tag==15000) {
        
        NSLog(@"%ld",(long)tableView.tag);
        NSDictionary *dict=[styleArray objectAtIndex:indexPath.row];
        style.text=[dict objectForKey:@"FollowType"];
        [sousuoViewstyle removeFromSuperview];
        styleBtn.selected=NO;
    }
    
}
#pragma mark 获取响应等级的usercode
-(void)fidthleveusercode:(NSInteger)index
{
    
    
}
#pragma mark 请求下级数据
-(void)requestSub:(NSString *)str flg:(NSString *)flgStr department:(NSString *)showLevelString
{
    if (self.subArray) {
        [self.subArray removeAllObjects];
    }
    [[MyRequest defaultsRequest]afGetSubFromSnapshot:str FLG:flgStr  Status:status ShowLevel:showLevelString completeBack:^(NSString *string)
     {
         SBJSON *json = [[SBJSON alloc]init];
         NSArray *array = [json objectWithString:string error:nil];
         BYPersonInfo *allPerson = [[BYPersonInfo alloc]init];
         allPerson.userName = @"全部";
         allPerson.department = @"全部";
         allPerson.sort     = @"F";
         [self.subArray insertObject:allPerson atIndex:0];
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

-(void)faleOut
{
    [UIView animateWithDuration:0.1 animations:^{
        secondFilterTableView.frame = CGRectMake(0, 104, 0, 0);
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark -- 筛选标题
-(void)filterStringf
{
    self.filterLabel.text = @"";
    for (int index = 0; index < self.supArray.count; index ++) {
        BYPersonInfo *person = self.supArray[index];
        if (index == 0) {
            
            self.filterLabel.text = [self.filterLabel.text stringByAppendingFormat:@"%@",person.department];        }
        else if (index == 1|| index==2)
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
//搜索按钮事件
- (IBAction)clickSearchButton:(UIButton *)sender
{
    [UIView animateWithDuration:0.1 animations:^{
        [self faleOut];
        filterView.frame = CGRectMake(0, 104, 0,0 );
        //            filterView.rowHeight = 30;
        
    } completion:^(BOOL finished) {
        //            [filterView reloadData];
        fistfilrerisout = NO;
    }];
    
    //请求客源列表
    pageCount = 1;
    [self postRequest];
    
}
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //创建一个仿射变换，平移(0, -100)视图上移100像素
    CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, -120);
    //使视图使用这个变换
    bgView.transform = pTransform;
    
    placeholder.text=@"";
    
    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    //创建一个仿射变换，平移(0, -100)视图上移100像素
    CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, 0);
    //使视图使用这个变换
    genjinView.transform = pTransform;
    
    if ([textView1.text isEqualToString:@""]) {
        placeholder.text=@"请输入跟进内容";
    }
}
#pragma mark --上啦下拉刷新
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    // [table addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    [subVisterTableView addHeaderWithTarget:self action:@selector(headerRereshingSu)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    //    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [subVisterTableView addFooterWithTarget:self action:@selector(footerRereshingSu)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    subVisterTableView.headerPullToRefreshText = @"下拉刷新";
    subVisterTableView.headerReleaseToRefreshText = @"松开刷新";
    subVisterTableView.headerRefreshingText = @"客源正在刷新中";
    
    subVisterTableView.footerPullToRefreshText = @"上拉加载更多数据";
    subVisterTableView.footerReleaseToRefreshText = @"松开加载更多数据";
    subVisterTableView.footerRefreshingText = @"客源正在加载中";
}


#pragma mark 开始进入刷新状态
- (void)headerRereshingSu
{
    pageCount = 1;
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]getSubCustomList:[self frashSearchFilterCondition] backInfoMessage:^(NSMutableString *string) {
        _resultString=string;
        if ([string isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        else if ([string isEqualToString:@"[]"]) {
            
            UILabel * label = [[UILabel alloc]init];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"暂无私客数据";
            // table.backgroundView = label;
            
            PL_ALERT_SHOW(@"暂无数据");
            //            [_array removeAllObjects];
            
            // [table removeFromSuperview];
        }
        else  if ([string isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
            [_array removeAllObjects];
        }
        else
        {
            SBJSON *json=[[SBJSON alloc]init];
            _array=[json objectWithString:_resultString error:nil];
        }
        
        // sikeLable.text = [NSString stringWithFormat:@"共%ld条私客",(long)_array.count];
        PL_PROGRESS_DISMISS;
        [subVisterTableView reloadData];
        [subVisterTableView headerEndRefreshing];
    }];
}

- (void)footerRereshingSu
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
    BYPersonInfo *person    = self.supArray[indexNum];
    //    NSString * subCode      = person.userCode;
    VisiterData *custom     =[[VisiterData alloc]init];
    BYPersonInfo *lastPerson = [[BYPersonInfo alloc]init];
    custom.getAllString = oldStatusStr;
    lastPerson = self.supArray.lastObject;
    if([lastPerson.userName isEqualToString:@"直属"])
    {
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
    custom.userid           = name;
    custom.CustLevel        = @"";
    custom.DistrictName     = @"";
    custom.AreaId           = @"";
    custom.Trade            = @"";
    custom.PriceMax         = @"";
    custom.PriceMin         = @"";
    if (isEqCode == NO) {
        custom.FlagPrivate      = @"1";
    }else{
        custom.FlagPrivate      = @"0";
    }
    custom.FlagRecommand    = @"";
    custom.FlagNeed         = @"";
    custom.FlagSchool       = @"";
    custom.StartIndex       = [NSString stringWithFormat:@"%ld",(long)pageCount];
    custom.token            = token;
    
    NSLog(@"=================%@",custom.StartIndex);
    custom.telephoneNumberString = @"";
    custom.pubTypeString = @"";
    custom.jiaoYiString = @"";
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]getSubCustomList:custom backInfoMessage:^(NSMutableString *string) {
        
        _resultString=string;
        if ([string isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        
        else  if ([string isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
        }
        else
        {
            SBJSON *json=[[SBJSON alloc]init];
            NSArray*array=[json objectWithString:_resultString error:nil];
            if (array.count==0) {
                UILabel * label = [[UILabel alloc]init];
                label.text = @"暂无私客数据";
                label.textAlignment = NSTextAlignmentCenter;
                //table.backgroundView = label;
                PL_ALERT_SHOW(@"没有更多数据了");
                pageCount--;

            }
            [_array addObjectsFromArray:array];
        }
        
        [subVisterTableView reloadData];
        [subVisterTableView footerEndRefreshing];
        PL_PROGRESS_DISMISS;
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
