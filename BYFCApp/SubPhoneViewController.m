//
//  SubPhoneViewController.m
//  BYFCApp
//
//  Created by zzs on 15/4/20.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "SubPhoneViewController.h"
#import "PL_Header.h"

@interface SubPhoneViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,TimeFilterViewDelegate>
{
    UILabel *sikeLable;
    UIButton *rightBtn;
    //筛选一级菜单
    UITableView *filterView;
    //筛选二级菜单
    UITableView *secondFilterTableView;
    //下属通话记录列表
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
    NSMutableArray *_array;
    NSString * privateCount;
    NSDictionary *dictionary;
    //判断电话呼出呼入
    NSString *IO;
    BOOL  isIO;
//    BYPersonInfo *person;
    
    MyVisiterCustomCell *customcell;
    
    //全部or个人
    BOOL allAllSelf;
    //页数记录器
    NSInteger pageCount;
    
    //自定义cellnib
    UINib *nib;
   
    TimeFilterView *timeFileterView;
    
    NSString *timeString;
    UIImage *image;
    UIImage *image2;
    UIButton *btn;
    UIButton *btn2;
    //
    NSString *status;
    //
    NSString *oldfilterLabelStr;
    NSString *oldStatusStr;
    NSString *showLevelStr;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

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
@property (weak, nonatomic) IBOutlet UIView *TimeSelesctView;

@property (weak, nonatomic) IBOutlet UIButton *but1;
@property (weak, nonatomic) IBOutlet UIButton *but2;
@property (weak, nonatomic) IBOutlet UIButton *but3;
@property (weak, nonatomic) IBOutlet UIButton *but4;



@property (nonatomic,strong) phoneTableViewCell *phoneTableViewCell;


//@property (weak, nonatomic) IBOutlet UITableView *recordTableview;
//@property(nonatomic,strong) RecordTableViewCell *recordViewCell;
@end

@implementation SubPhoneViewController

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
        _filterArray = @[@"职位状态",@"大区",@"片区",@"区域/摊",@"分行经理",@"客户经理"];
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    
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



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通话记录";
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@",self.title);
    status = @"0";
    oldStatusStr = @"0";
    showLevelStr = @"";
    //初始化页面计数器
    pageCount = 0;
    //请求上级领导
    [self requestSup];
    //本机机主的等级
    [self findlevenumber];
    NSLog(@"%@",[PL_USER_STORAGE objectForKey:PL_USER_code]);
    
    self.navigationController.navigationBarHidden = NO;
    
    self.filterLabel.text = @"";
    timeString = @"1";
    _but1.selected = YES;
    //通话时间筛选按钮
    
    isIO = YES;
    IO = @"1";
    // 初始化下属通话记录
    [self formatSubVisterTableView];
    
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, PL_HEIGHT-50, PL_WIDTH, 50)];
    
//    bottomView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:bottomView];
//
//    
    //左边电话按钮
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, 0, (PL_WIDTH - 1)/2, 50);
    [bottomView addSubview:btn];
    image = [UIImage imageCompressForSizeImage:[UIImage imageNamed:@"phone_huchu"] targetSize:CGSizeMake(40, 40)];
    [btn setTintColor:[UIColor colorWithPatternImage:image ]];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing"]]];
    [btn addTarget:self action:@selector(phone) forControlEvents:UIControlEventTouchUpInside];
    
    NSLog(@"%f",btn.frame.size.width);
    NSLog(@"%f",PL_WIDTH);

    //右边电话按钮
    btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.frame = CGRectMake(btn.frame.size.width + 1, 0, (PL_WIDTH - 1)/2, 50);
    [bottomView addSubview:btn2];
    image2 = [UIImage imageCompressForSizeImage:[UIImage imageNamed:@"phone_huru_hui"] targetSize:CGSizeMake(40, 40)];
    [btn2 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing"]]];
    [btn2 setTintColor:[UIColor colorWithPatternImage:image2 ]];
    [btn2 setImage:image2  forState:UIControlStateNormal];
     [btn2 addTarget:self action:@selector(phone1) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //背景线
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, 1)];
    label.backgroundColor = [UIColor grayColor];
    [bottomView addSubview:label];
    
    
    
    
    //设置一级下拉菜单
    filterView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, 100,0 ) style:UITableViewStylePlain];
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
    
    
    //自定义返回按钮
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    // Do any additional setup after loading the view from its nib.
    
    [self setupRefresh];
    
   [self initFramTimeSelecstView];
    
    
    
     
   
}
#pragma mark -----筛选时间初始化
-(void)initFramTimeSelecstView
{
    _TimeSelesctView.layer.borderColor=[[UIColor grayColor]CGColor];
    _TimeSelesctView.layer.borderWidth=0.5;
    _TimeSelesctView.layer.masksToBounds=YES;
    
}
#pragma mark ------底部呼入按钮方法
-(void)phone{

    IO = @"1";
    image = [UIImage imageCompressForSizeImage:[UIImage imageNamed:@"phone_huchu"] targetSize:CGSizeMake(40, 40)];
    [btn setTintColor:[UIColor colorWithPatternImage:image ]];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing"]]];
    
    image2 = [UIImage imageCompressForSizeImage:[UIImage imageNamed:@"phone_huru_hui"] targetSize:CGSizeMake(40, 40)];
    [btn2 setTintColor:[UIColor colorWithPatternImage:image2]];
    [btn2 setImage:image2 forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing"]]];
    [self postRequest];
}

#pragma mark ------底部呼进电话按钮方法
-(void)phone1{
    IO = @"0";
    image = [UIImage imageCompressForSizeImage:[UIImage imageNamed:@"phone_huchu_hui"] targetSize:CGSizeMake(40, 40)];
    [btn setTintColor:[UIColor colorWithPatternImage:image ]];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing"]]];
    
    image2 = [UIImage imageCompressForSizeImage:[UIImage imageNamed:@"phone_huru"] targetSize:CGSizeMake(40, 40)];
    [btn2 setTintColor:[UIColor colorWithPatternImage:image2 ]];
    [btn2 setImage:image2 forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing"]]];
    [self postRequest];
}

#pragma mark -- 初始化下属通话记录列表
-(void)formatSubVisterTableView
{
    subVisterTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 146, ([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)-114-100) style:UITableViewStylePlain];
    subVisterTableView.delegate=self;
    subVisterTableView.dataSource=self;
    subVisterTableView.tableFooterView=[UIView new];
    subVisterTableView.rowHeight = 71;
    //subVisterTableView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:subVisterTableView];
}



#pragma mark -- 设置检索条件
-(BYPersonInfo *)frashSearchFilterCondition
{
//    NSString * name         =[PL_USER_STORAGE objectForKey:PL_USER_NAME];
//    NSString * token        = [PL_USER_STORAGE objectForKey:PL_USER_TOKEN];
    BYPersonInfo *person    = self.supArray.lastObject;
    //    NSString * subCode      = person.userCode;

    NSInteger index = self.supArray.count - 1;
    
    if ([[PL_USER_STORAGE objectForKey:PL_USER_code] isEqualToString:@"AA0006"])
    {
        BYPersonInfo *Bperson = [[BYPersonInfo alloc]init];
        if (self.supArray.count == 0)
        {
            Bperson.flagSubs = @"0";
            Bperson.userCode = [PL_USER_STORAGE objectForKey:PL_USER_code];
            Bperson.mobile = [PL_USER_STORAGE objectForKey:PL_USER_PHONEnUM];
            Bperson.dutyName =  [[PL_USER_STORAGE objectForKey: PL_USER_DUTYCODE] substringFromIndex:[[PL_USER_STORAGE objectForKey: PL_USER_DUTYCODE] length] -1];
        }
        else
        {
            if (self.supArray.count == 1 && [((BYPersonInfo *)self.supArray[0]).userName isEqualToString:@"全部"])
            {
                Bperson.flagSubs = @"1";
                Bperson.userCode = [PL_USER_STORAGE objectForKey:PL_USER_code];
                Bperson.mobile = [PL_USER_STORAGE objectForKey:PL_USER_PHONEnUM];
                Bperson.dutyName =  [[PL_USER_STORAGE objectForKey: PL_USER_DUTYCODE] substringFromIndex:[[PL_USER_STORAGE objectForKey: PL_USER_DUTYCODE] length] -1];
            }
            else
                if ([((BYPersonInfo *)self.supArray.lastObject).userName isEqualToString:@"全部"])
            {
                Bperson = self.supArray[self.supArray.count - 2];
                
                Bperson.flagSubs = @"1";
                  Bperson.dutyName =  [Bperson.dutyName substringFromIndex:[Bperson.dutyName length] -1];
                
            }
            else
            {
                Bperson = self.supArray.lastObject;
                
                Bperson.flagSubs = @"0";
                Bperson.dutyName =  [Bperson.dutyName substringFromIndex:[Bperson.dutyName length] -1];
            }
          
            
        }

        return Bperson;
    }
    
    else
    {
        if ([person.userName isEqualToString:@"全部"])
    {
        NSLog(@">>>>>>>> %@",person.userName);
//        person.flagSubs = @"1";
        if (index >= 0) {
            
            BYPersonInfo *lastperson = self.supArray[index - 1];
            
            if ([lastperson.userName isEqualToString:[PL_USER_STORAGE objectForKey:PL_USER_TRUE_NAME]]) {
                
                lastperson.userCode = [PL_USER_STORAGE objectForKey:PL_USER_code];
                lastperson.mobile = [PL_USER_STORAGE objectForKey:PL_USER_PHONEnUM];
                lastperson.dutyName =  [[PL_USER_STORAGE objectForKey: PL_USER_DUTYCODE] substringFromIndex:[[PL_USER_STORAGE objectForKey: PL_USER_DUTYCODE] length] -1];
                lastperson.flagSubs = @"1";
                
            }
            
            NSLog(@"++%@",lastperson.userName);
            NSLog(@"++%@",lastperson.mobile);
            NSLog(@"++%@",lastperson.dutyName);
            return lastperson;
            
        }

    }
    else
    {
        person.flagSubs = @"0";
        
        if ([person.userName isEqualToString:[PL_USER_STORAGE objectForKey:PL_USER_TRUE_NAME]]) {
            
            NSLog(@"%@",[PL_USER_STORAGE objectForKey:PL_USER_PHONEnUM]);
            person.userCode = [PL_USER_STORAGE objectForKey:PL_USER_code];
            person.mobile = [PL_USER_STORAGE objectForKey:PL_USER_PHONEnUM];
            person.dutyName =  [[PL_USER_STORAGE objectForKey: PL_USER_DUTYCODE] substringFromIndex:[[PL_USER_STORAGE objectForKey: PL_USER_DUTYCODE] length] -1];
        }
        else
        {
            person.dutyName = [(NSString *)person.dutyName substringFromIndex:person.dutyName.length - 1];
        }

        NSLog(@"%@",person.userName);
        NSLog(@"%@",person.mobile);
        NSLog(@"%@",person.dutyName);

    }
    
    //NSLog(@"=================%@",custom.StartIndex);
    return person;
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
        [self filterString];
        oldfilterLabelStr = self.filterLabel.text;
        PL_PROGRESS_DISMISS;
    }];
    
    

//    PL_PROGRESS_SHOW ;
//    [[MyRequest defaultsRequest]afGetSupFromSnapshot:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSString *str) {
//        
//        //        NSLog(@"1111111111111111111%@",str);
//        //
//        //        NSLog(@"22222222222222222.%@,%@",[PL_USER_STORAGE objectForKey: PL_USER_TOKEN],[PL_USER_STORAGE objectForKey:PL_USER_USERID]);
//        
//        SBJSON *json = [[SBJSON alloc]init];
//        NSArray *array = [json objectWithString:str error:nil];
//        for (NSDictionary *dic in array)
//        {
//            BYPersonInfo *person = [[BYPersonInfo alloc]init];
//            
//            person.sort = dic[@"Sort"];
//            person.userId = dic[@"UserID"];
//            person.userCode = dic[@"UserCode"];
//            person.userName = dic[@"UserName"];
//            person.department = dic[@"Department"];
//
//            NSLog(@"aaaaaa  %@",person.userName);
//            [self.supArray addObject:person];
//            [self.supArray sortUsingComparator:^NSComparisonResult(BYPersonInfo  *person, BYPersonInfo *anothorperson) {
//                return  [person.sort compare:anothorperson.sort];
//            }];
//        }
//        for (BYPersonInfo *item in self.supArray) {
//            NSLog(@"%@",item);
//        }
//        [self filterString];
//        
//        PL_PROGRESS_DISMISS;
//    }];
//    
    
    
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
             person.mobile = dic[@"Mobile"];
             person.dutyName = dic[@"DutyName"];
             person.department = dic[@"Department"];
             person.FLG = dic[@"FLG"];
             //NSLog(@"%@",person.mobile);
             
             [self.subArray addObject:person];
             
             
             //             NSLog(@"%@ %@ %@ ",person.userCode,person.userName,person.sort);
         }
         //                    NSLog(@"%@",str);
         
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
-(void)filterString
{
//    self.filterLabel.text = @"";
//    for (int index = 0; index < self.supArray.count; index ++) {
//        BYPersonInfo *person = self.supArray[index];
//        if (index == 0) {
//            self.filterLabel.text = [self.filterLabel.text stringByAppendingString:person.userName];
//        }
//        else if(index == 1||index ==2)
//        {
//            self.filterLabel.text = [self.filterLabel.text stringByAppendingFormat:@"-%@",person.department];
//        }
//        else
//        {
//        self.filterLabel.text = [self.filterLabel.text stringByAppendingFormat:@"-%@",person.userName];
//        }
//    }
    self.filterLabel.text = @"";
    NSLog(@"---------------%ld",(long)filterClickrow);
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

//推出二级页面
-(void)popSecondFilterView
{
    [UIView animateWithDuration:0.1 animations:^{
        secondFilterTableView.frame = CGRectMake(filterView.bounds.size.width, 114, 100, 180);
    } completion:^(BOOL finished) {
        [secondFilterTableView reloadData];
    }];
}


- (IBAction)clickFilterButton:(UIButton *)sender
{
    NSLog(@"aaaa");
    if (fistfilrerisout == NO ) {
        [UIView animateWithDuration:0.1 animations:^{
            
            filterView.frame = CGRectMake(0, 114, 120, 180);
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
- (IBAction)clickSearchButton:(UIButton *)sender
{
   
    [UIView animateWithDuration:0.1 animations:^{
        [self faleOut];
        filterView.frame = CGRectMake(0, 104, 120,0 );
        //            filterView.rowHeight = 30;
        
    } completion:^(BOOL finished) {
        //            [filterView reloadData];
        fistfilrerisout = NO;
    }];
    
    //请求客源列表
    pageCount = 1;
    
     [self postRequest];
    
}
#pragma mark -----请求通话记录数据
-(void)postRequest{

    [_array removeAllObjects];
      pageCount = 1;
    _person = self.supArray.lastObject;
    
    NSLog(@"flagsubs %@",[self frashSearchFilterCondition].flagSubs);
    NSLog(@"userCode %@",[self  frashSearchFilterCondition].userCode);
   NSLog(@"mobile %@",[self  frashSearchFilterCondition].mobile);
      NSLog(@"dutyName %@",[self  frashSearchFilterCondition].dutyName);
    //NSLog(@"%@",person.mobile);

    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest] afGetPhoneHistory:IO Time:timeString Type:[NSString stringWithFormat:@"%ld",(long)self.typeSub] FlagSubs:[self frashSearchFilterCondition].flagSubs SubUserCode:[self  frashSearchFilterCondition].userCode SubPhone:[self frashSearchFilterCondition].mobile SubDutyCode:[self frashSearchFilterCondition].dutyName StarIndex:[NSString stringWithFormat:@"%ld",(long)pageCount] userid:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSMutableString *str) {
        
        NSLog(@"%@",[NSString stringWithFormat:@"%ld",(long)self.typeSub]);
        _resultString=str;
        
        NSLog(@"%@",str);
        
        //NSLog(@"str===%@",str);
        
        
        if ([str isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        if ([str isEqualToString:@"[]"]) {
            
            UILabel * label = [[UILabel alloc]init];
            label.text = @"暂无数据";
            label.textAlignment = NSTextAlignmentCenter;
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





#pragma mark -- 自定义返回按钮
-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 表格方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == subVisterTableView) {
        return _array.count;
    }
    return tableView == filterView ?  self.filterArray.count:self.subArray.count;
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
        if (indexPath.row == 0) {
            
        }
        else if (indexPath.row <= self.levenumber+1 && ![[PL_USER_STORAGE objectForKey:PL_USER_code] isEqualToString:@"AA0006"])
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
            if (filterClickrow == 1) {
                cell.textLabel.text = sperson.department;
                cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
            }
            if (filterClickrow == 2) {
                cell.textLabel.text = sperson.department;
                cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
            }
            if (filterClickrow == 3) {
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
    
   else if (tableView == subVisterTableView) {
        
        dictionary=[_array objectAtIndex:indexPath.row];

        if (!nib) {
              nib = [UINib nibWithNibName:@"phoneTableViewCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:reusedID];
        }
          phoneTableViewCell *phoneCell = [tableView dequeueReusableCellWithIdentifier:reusedID];
        phoneCell.selectionStyle =UITableViewCellSelectionStyleNone;
       phoneCell.selected   = NO;
       phoneCell.userInteractionEnabled = NO;
          if (_array.count>0) {
 
            phoneCell.customLabel.text = [dictionary objectForKey:@"Name"];
            phoneCell.phoneLabel.text =  [[dictionary objectForKey:@"CustTel"]componentsSeparatedByString:@"|"].firstObject;
            phoneCell.nowTimeLabel.text = [dictionary objectForKey:@"TalkDuration"];
            phoneCell.phoneTimeLabel.text = [[dictionary objectForKey:@"InboundCallTime"]substringWithRange:NSMakeRange(5, ((NSString*)[dictionary objectForKey:@"InboundCallTime"]).length - 8)];
            phoneCell.yewuTypeLabel.text = [dictionary objectForKey:@"UserName"];
        }
        
        NSLog(@"----------------111111%@",phoneCell.customLabel.text);
        NSLog(@"----------------222222%@",phoneCell.phoneLabel.text);
        NSLog(@"----------------333333%@",phoneCell.nowTimeLabel.text);
        NSLog(@"----------------444444%@",phoneCell.phoneLabel.text);
        NSLog(@"----------------555555%@",phoneCell.yewuTypeLabel.text);
        
        return phoneCell;

    }
    
    
    return cell;
}

#pragma mark -- 点击筛选一级菜单
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
            if (indexPath.row == 1) {
                [self requestSub:[PL_USER_STORAGE objectForKey:PL_USER_code] flg:@"0" department:showLevelStr];
                filterClickrow = indexPath.row;
                [self popSecondFilterView];
            }
            else
            {
                //                BYPersonInfo *firstPerson = [[BYPersonInfo alloc]init];
                //                firstPerson = self.supArray[indexPath.row - 1];
                if ( (int)indexPath.row -1- (int)self.supArray.count <= 0  )
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
                
                if (self.supArray.count != 0 && (int)indexPath.row -1- (int)self.supArray.count <= 0) {
                    
                    BYPersonInfo *person = self.supArray[indexPath.row - 2];
                    if (![person.userName isEqualToString:@"全部"]) {
                        status = oldStatusStr;
                        if (person.FLG == nil) {
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
    else  if(tableView == secondFilterTableView)
    {
        NSLog(@"点击了second");
        
        BYPersonInfo *person = self.subArray[indexPath.row];
        
        //        if (filterClickrow == 0 && self.supArray.count != 0) {
        //            [self.supArray replaceObjectAtIndex:filterClickrow withObject:person];
        //        }
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
            //            [self.supArray replaceObjectAtIndex:filterClickrow withObject:person];
            
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
            for (int index = (int)filterClickrow; index < arraycount; index ++)
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

#pragma mark --上啦下拉刷新
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    // [table addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    [subVisterTableView addHeaderWithTarget:self action:@selector(headerRereshingVC)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    //    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [subVisterTableView addFooterWithTarget:self action:@selector(footerRereshingVC)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    subVisterTableView.headerPullToRefreshText = @"下拉刷新";
    subVisterTableView.headerReleaseToRefreshText = @"松开刷新";
    subVisterTableView.headerRefreshingText = @"通话记录正在刷新中";
    
    subVisterTableView.footerPullToRefreshText = @"上拉加载更多数据";
    subVisterTableView.footerReleaseToRefreshText = @"松开加载更多数据";
    subVisterTableView.footerRefreshingText = @"通话记录正在加载中";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshingVC
{
    pageCount ++;
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest] afGetPhoneHistory:IO Time:timeString Type:@"0" FlagSubs:[self frashSearchFilterCondition].flagSubs SubUserCode:[self  frashSearchFilterCondition].userCode SubPhone:[self frashSearchFilterCondition].mobile SubDutyCode:[self frashSearchFilterCondition].dutyName StarIndex:[NSString stringWithFormat:@"%ld",(long)pageCount] userid:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSMutableString *str) {
        
        _resultString=str;
        
        
        //NSLog(@"str===%@",str);
        
        
        if ([str isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        if ([str isEqualToString:@"[]"]) {
            
            UILabel * label = [[UILabel alloc]init];
            label.text = @"暂无数据";
            label.textAlignment = NSTextAlignmentCenter;
            PL_ALERT_SHOW(@"暂无更多通话记录");
//            [_array removeAllObjects];
//            [subVisterTableView reloadData];
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

- (void)footerRereshingVC
{
    pageCount++;
    
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest] afGetPhoneHistory:IO Time:timeString Type:@"0" FlagSubs:[self frashSearchFilterCondition].flagSubs SubUserCode:[self  frashSearchFilterCondition].userCode SubPhone:[self frashSearchFilterCondition].mobile SubDutyCode:[self frashSearchFilterCondition].dutyName StarIndex:[NSString stringWithFormat:@"%ld",(long)pageCount] userid:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSMutableString *str) {
        
        _resultString=str;
        
        
        //NSLog(@"str===%@",str);
        
        
        if ([str isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        if ([str isEqualToString:@"[]"]) {
            
            UILabel * label = [[UILabel alloc]init];
            label.text = @"暂无数据";
            label.textAlignment = NSTextAlignmentCenter;
            PL_ALERT_SHOW(@"暂无更多通话记录");
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
- (IBAction)SelestChenBox:(UIButton *)sender {
    if (sender.tag==331) {
        NSLog(@"当天");
        
        if (_but1.selected==NO) {
            timeString = @"1";
            _but2.selected=NO;
            _but3.selected=NO;
            _but4.selected=NO;
        }
        
        
sender.selected=!sender.selected;
    }else if (sender.tag==332)
    {
        NSLog(@"7天以内");
        if (_but2.selected==NO) {
            timeString = @"7";
            _but1.selected=NO;
            _but3.selected=NO;
            _but4.selected=NO;
        }


        sender.selected=!sender.selected;

    }else if (sender.tag==333)
    {
        NSLog(@"7天到30");
        if (_but3.selected==NO) {
            timeString = @"30";
            _but2.selected=NO;
            _but1.selected=NO;
            _but4.selected=NO;
        }

        sender.selected=!sender.selected;

    }else if (sender.tag==334)
    {
        NSLog(@"30到90");
        if (_but4.selected==NO) {
            timeString = @"90";
            _but2.selected=NO;
            _but3.selected=NO;
            _but1.selected=NO;
        }
        sender.selected=!sender.selected;

    }

    
}


@end
