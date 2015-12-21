//
//  RoomSourceVC.m
//  BYFCApp
//
//  Created by PengLee on 14/12/3.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import "RoomSourceVC.h"
#import "CustomCell.h"
#import "SouSuoVC.h"
#import "AppDelegate.h"
#import "PL_Header.h"
#import "MyPhoneViewController.h"
#import "SubPhoneViewController.h"
@protocol PianQuDelegate;
const char*RoomDtailsQueue_GCD;
#define BUTTONSIZE 80
@interface RoomSourceVC ()<UITableViewDataSource,UITableViewDelegate,PersonDelegate,UIPopoverControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextViewDelegate,UMSocialUIDelegate,SWTableViewCellDelegate,UIScrollViewDelegate,PopOverDelegate,AWActionSheetDelegate,MoreMenuVCDelegate,StyleDelegate>
{
    float       cellHeitht;
    BOOL        _isOpenView;
    
    UIView * sousuoView;
    UILabel * labelTitle;
    UIView * navView;
    UITableView * _tableView;
      BOOL isClick;
    UIImage * bgimage;
    NSMutableArray * iamgeSATORY;
    //接受服务器判断
    NSString * isShowImage;
    //照片选择路径
    
    NSString * filePathImage;
    UIView * bgView;
    UITextView  * textView;
    UILabel * count;
    UITextField * textField;
    UIButton * tableButton;
    TSPopoverController *   _popoverController1;
    
    GestureMenuViewController *gestureVC;
    
    UIButton *phonebutton;
    //字典
    
    //通话记录视图是否弹出
    BOOL phoneViewIsOut;
    //房源缺失登记按钮
    UIButton *btn;
    UIView *view1;
    NSInteger a;
    NSInteger indextag1;
}
@property(nonatomic,strong)UITableView * tableView;
@property(strong,nonatomic)UIView      * jilianView;
@property(strong,nonatomic)NSMutableArray * resultArray;
@property(strong,nonatomic)NSArray * quyuShuzu;
@property(strong,nonatomic)NSMutableArray * priceArray;
@property (strong,nonatomic)NSMutableArray * spellArray;
@property(nonatomic,strong)NSMutableOrderedSet * properIDSet;
@property(nonatomic,strong) NSMutableDictionary *filterDic;
@property(nonatomic,strong) NSArray * titles;
@property(nonatomic,strong)NSString *quyu;
@property(nonatomic,strong)NSString *jiage;
@property(nonatomic,strong)NSString *gengduo;

//片区数组
@property(strong,nonatomic)NSMutableArray * pianquArray;
@property(assign,nonatomic)id<PianQuDelegate>delegate;
@property (nonatomic, strong) AutocompletionTableView *autoCompleter;

// 显示没有数据时的Label
@property(nonatomic , strong)UILabel * label;
@end
@protocol PianQuDelegate <NSObject>

@optional
-(void)returnKeyArray:(NSArray *)array;

@end
@implementation RoomSourceVC
@synthesize jilianView;
@synthesize resultArray;
@synthesize chcheImageRoom;
@synthesize spellArray;
-(NSMutableDictionary *)filterDic
{
    if (!_filterDic) {
        _filterDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"学区房":@"",@"经理推荐":@"",@"急售":@"",@"满二年":@"",@"独家":@"",@"钥匙":@""}];
    }
    return _filterDic;
}

-(NSMutableOrderedSet *)properIDSet
{
    if (_properIDSet == nil) {
        _properIDSet = [[NSMutableOrderedSet alloc]init];
    }
    return _properIDSet;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBarHidden = YES;
    
    iamgeSATORY = [NSMutableArray array];
    self.chcheImageRoom = [NSMutableDictionary dictionary];
   // [self loadTableData:nil];
    [bgView removeFromSuperview];
    [bgHuiView removeFromSuperview];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"ROOMFOLLOWID"];
}

-(AppDelegate *)AppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(action:) name:@"sunH" object:nil];
    phoneViewIsOut = NO;
    [self createNav];
    //初始化房源信息
    [self roomInfo];
    a=1;
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel * bgLable = [[UILabel alloc]initWithFrame:CGRectMake(0, PL_SYSTEM_VERSION_ISIOS7?64.0:44.0, PL_WIDTH, 1)];
    bgLable.backgroundColor = [UIColor blackColor];
    
    
    [self.view addSubview:bgLable];
    currentTag =250;
  
    _downArrayImage = [NSMutableArray array];
    spellArray = [NSMutableArray array];
#pragma mark --房源下拉二级列表
  
    NSArray * imageBtn = [NSArray arrayWithObjects:@"第一个.png",@"第二个.png",@"第二个.png", nil];
    _titles = [NSArray arrayWithObjects:@" 区域     ",@" 价格    ",@" 更多     ", nil];
    
    //下拉列表
    for (int i=0; i<3; i++)
    {
        
        tableButton=[[UIButton alloc]init];
       
        tableButton.frame = CGRectMake(PL_WIDTH/3.0*i, PL_SYSTEM_VERSION_ISIOS7?65.0:45.0, PL_WIDTH/3.0, 50);
         [tableButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageBtn[i]]] forState:UIControlStateNormal];
        
      
      
        if (i==0 || i==1)
        {
            tableButton.tag = i+1;
            [tableButton addTarget:self action:@selector(openTable:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            tableButton.tag = 360;
            [tableButton addTarget:self action:@selector(openTable1:) forControlEvents:UIControlEventTouchUpInside];
        }
        
       
        [tableButton setTitle:_titles[i] forState:UIControlStateNormal];

        [tableButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tableButton setButtonNormalTile:_titles[i]];
        
        tableButton.titleLabel.font=[UIFont systemFontOfSize:12];
      
        tableButton.titleLabel.textAlignment=NSTextAlignmentLeft;
        
        
       
        UIImageView * selImage = [[UIImageView alloc]initWithFrame:CGRectMake(PL_WIDTH/3.0*i+PL_WIDTH/3.0-25,PL_SYSTEM_VERSION_ISIOS7?85.0:65.0, 15, 8)];
        selImage.image =    [UIImage imageNamed:@"dropdown.png"];
        selImage.tag =i+125;
        [_downArrayImage addObject:selImage];
        [self.view addSubview:tableButton];
        [tableButton sendSubviewToBack:self.view];
        
        [self.view addSubview:selImage];
        
    }
    //搜索框
  [textField addTarget:self.autoCompleter action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    dropBgView=[[UIView alloc]initWithFrame:CGRectMake(0, 100+15, PL_WIDTH, PL_HEIGHT)];
    dropBgView.backgroundColor = [UIColor whiteColor];
   
//    dropBgView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
    
    dropBgView.hidden=YES;
    UITapGestureRecognizer * tapView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clearViewFrame:)];
    tapView.numberOfTapsRequired = 1;
    
    [dropBgView addGestureRecognizer:tapView];
    
    [self.view addSubview:dropBgView];
//    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
//    but.frame = CGRectMake(100, 100, 50, 50);
//    but.backgroundColor = [UIColor redColor];
//    [but addTarget:self action:@selector(buta) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:but];
//    
   
    _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tableButton.frame), PL_WIDTH, PL_HEIGHT/2) style:UITableViewStylePlain];
    _tableView1.dataSource = self;
    _tableView1.delegate = self;
    _tableView1.rowHeight = 44;
    
    _tableView1.hidden =YES;
    _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView1.tag = 1001;
    [self.view addSubview:_tableView1];
    _tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(PL_WIDTH/3, CGRectGetMaxY(tableButton.frame), PL_WIDTH*2/3, PL_HEIGHT/2) style:UITableViewStylePlain];
    _tableView2.dataSource = self;
    _tableView2.delegate =self;
    _tableView2.hidden = YES;
    _tableView2.tag = 1002;
    _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView2];
    self.sousuoArray = [NSMutableArray array];
    self.cacheArray  = [NSMutableArray array];
    

//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cancleShoucang:) name:@"cancleShoucang" object:nil];
//    
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
    
    moreArr=[NSArray arrayWithObjects:@"不限",@"多层",@"高层",@"别墅",@"多类层",@"小高层", nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuString:) name:@"menuinfo" object:nil];
    imageArr = [NSArray arrayWithObjects:@"全部",@"无图",@"有图", nil];
    jiaoYiArray = [NSArray arrayWithObjects:@"有效",@"无效",@"已租",@"已售", nil];
    tradeArr = [NSArray arrayWithObjects:@"出租",@"出售",@"租售", nil];
    propertyOccupyArr = [NSArray arrayWithObjects:@"业主住",@"空置",@"租客住", nil];
    propertyOwn1Arr = [NSArray arrayWithObjects:@"私人物业",@"公司物业",@"共有物业",@"使用权", nil];
    propertyDirectionArr = [NSArray arrayWithObjects:@"东",@"西",@"南",@"北",@"东南",@"西南",@"正南", nil];
    propertyTrustArr = [NSArray arrayWithObjects:@"独家",@"签赔", nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuString:) name:@"menuinfo" object:nil];
    
    
    //页面底部视图
    topView=[[UIView alloc]initWithFrame:CGRectMake(0, PL_HEIGHT-50, PL_WIDTH, 50+10)];
    topView.backgroundColor=[UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1];
    [self.view addSubview:topView];
   
    
    
    view1=[[UIView alloc]initWithFrame:CGRectMake(PL_WIDTH-120, 0, 120, 50+10)];
    view1.tag = 1;
    [topView addSubview:view1];
    
    UIImageView *bgImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 120, 50)];
    bgImg.image=[UIImage imageNamed:@"属性背景.png"];
    [view1 addSubview:bgImg];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"房源缺失登记" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    btn.frame = CGRectMake(0,0, 120, 50);
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:btn];
    //房源缺失登记按钮
    
    //通话记录按钮
    [self addPhoneButton:topView];
    
    
    
    // 创建显示没有搜索到数据的Label
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, PL_WIDTH, 100)];
    self.label.text = @"没有您想要搜索的数据";
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.hidden = YES;
    [self.tableView addSubview:self.label];
}

-(void)addClick
{
    RoomLostViewController *vc = [[RoomLostViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark 根据权限判断是否添加下属电话和下属客源
-(void)addPhoneButton:(UIView *)view1
{
    //    view.frame = CGRectMake(0, PL_HEIGHT - 50, PL_WIDTH, 50);
    
    //    phonebutton.frame = CGRectMake(0, 0, PL_WIDTH - 121 , 50);
    //    [phonebutton setImage:[UIImage imageByScaleAndCropingForSize:CGSizeMake(30, 30) oldImage:[UIImage imageNamed:@"sanheng.png"]] forState:UIControlStateNormal];
    phonebutton=[[UIButton alloc]initWithFrame:CGRectMake(0,0, PL_WIDTH-121, 50)];
    phonebutton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"属性背景"]];
    [phonebutton setImage:[UIImage imageByScaleAndCropingForSize:CGSizeMake(30, 20) oldImage:[UIImage imageNamed:@"shangjiantou.png"]] forState:UIControlStateNormal];
    
    //    [phonebutton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [phonebutton addTarget:self action:@selector(phoneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:phonebutton];
    
    
    
}



#pragma  mark ---弹出通话记录
-(void)phoneButtonClick:(UIButton *)sender
{
    NSLog(@"%s",__FUNCTION__);
   
//    UIView *aview = [view viewWithTag:1];
    if (phoneViewIsOut == NO) {
//        aview.hidden = YES;
         view1.hidden = YES;
        [UIView animateWithDuration:0.1 animations:^{
            [self.view.window addSubview:topView];
            
            topView.backgroundColor = [UIColor clearColor];
            
            topView.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
            
            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, PL_HEIGHT - BUTTONSIZE - 160, PL_WIDTH, 250)];
            backView.backgroundColor = [UIColor whiteColor];
            [topView addSubview:backView];
            //            [self.view bringSubviewToFront:view];
            //            view.backgroundColor = [UIColor grayColor];
            phonebutton.frame = CGRectMake(0, PL_HEIGHT - BUTTONSIZE - 160, PL_WIDTH, 30);
            [phonebutton setImage:[UIImage imageByScaleAndCropingForSize:CGSizeMake(30, 20) oldImage:[UIImage imageNamed:@"xiala"]] forState:UIControlStateNormal];
            [topView bringSubviewToFront:phonebutton];
            
            
            //            view.frame = CGRectMake(0, PL_HEIGHT - 120, 320, 120);
            
        }
                         completion:^(BOOL finished)
         {
             UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBackView:)];
             gesture.numberOfTapsRequired = 1;
             gesture.numberOfTouchesRequired = 1;
             [topView addGestureRecognizer:gesture];
             
             if (![[[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE]substringWithRange:NSMakeRange([[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE] length] - 1, 1)] isEqualToString:@"E"])
             {
                 
                 
                 UIButton *subordinatePb = [[UIButton alloc]initWithFrame:CGRectMake((PL_WIDTH-BUTTONSIZE*3)/4, PL_HEIGHT- 95, BUTTONSIZE, BUTTONSIZE)];
                 [topView addSubview:subordinatePb];
                 [subordinatePb setBackgroundImage:[UIImage imageNamed:@"下属通话"]forState:UIControlStateNormal];
                 [subordinatePb addTarget:self action:@selector(tosubphone:) forControlEvents:UIControlEventTouchUpInside];
                 
//                 UIButton *subordinateB = [[UIButton alloc]initWithFrame:CGRectMake((PL_WIDTH - BUTTONSIZE * 3) / 4 *3 + BUTTONSIZE * 2, PL_HEIGHT - 105, BUTTONSIZE, BUTTONSIZE)];
//                 [topView addSubview:subordinateB];
//                 [subordinateB setBackgroundImage:[UIImage imageNamed:@"下属客源"]forState:UIControlStateNormal];
//                 [subordinateB addTarget:self action:@selector(tosub:) forControlEvents:UIControlEventTouchUpInside];
                 
             }
             UIButton *myPhoneButton = [[UIButton alloc]initWithFrame:CGRectMake((PL_WIDTH - BUTTONSIZE * 3) / 4, PL_HEIGHT - 185, BUTTONSIZE, BUTTONSIZE)];
             [topView addSubview:myPhoneButton];
             [myPhoneButton setBackgroundImage:[UIImage imageNamed:@"自己通话"]forState:UIControlStateNormal];
             [myPhoneButton addTarget:self action:@selector(tomyphone:) forControlEvents:UIControlEventTouchUpInside];
             
             UIButton *lookAtButton = [[UIButton alloc]initWithFrame:CGRectMake((PL_WIDTH - BUTTONSIZE * 3) / 4 * 3+2* BUTTONSIZE, PL_HEIGHT - 185, BUTTONSIZE, BUTTONSIZE)];
             [topView addSubview:lookAtButton];
             [lookAtButton setBackgroundImage:[UIImage imageNamed:@"带看查询"]forState:UIControlStateNormal];
             [lookAtButton addTarget:self action:@selector(toLookAtViewControler:) forControlEvents:UIControlEventTouchUpInside];
             
             UIButton *followUpButton = [[UIButton alloc]initWithFrame:CGRectMake ((PL_WIDTH - BUTTONSIZE * 3) / 4 * 2+BUTTONSIZE , PL_HEIGHT - 185, BUTTONSIZE, BUTTONSIZE)];
             [topView addSubview:followUpButton];
             [followUpButton setBackgroundImage:[UIImage imageNamed:@"查看跟进"] forState:UIControlStateNormal];
             [followUpButton addTarget:self action:@selector(toFollowUpViewControler:) forControlEvents:UIControlEventTouchUpInside];
         }];
        phoneViewIsOut = YES;
    }
    else
    {
        //通话记录和下属客源信息视图收回
        [self phoneFramchang];
    }
}
#pragma mark ----跳转到跟进
-(void)toFollowUpViewControler:(UIButton*)sender{

    //判断职级来跳转界面
    if ([[[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE]substringWithRange:NSMakeRange([[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE] length] - 1, 1)] isEqualToString:@"E"])
    {
        RoomFollowUpListViewController *roomFollowVc = [[RoomFollowUpListViewController alloc]init];
        [self.navigationController pushViewController:roomFollowVc animated:YES];
        [self phoneFramchang];

    }
    else
    {
        FollowUpViewController *followUpVc = [[FollowUpViewController alloc]init];
        followUpVc.titleStr = @"跟进查询";
        [self.navigationController pushViewController:followUpVc animated:YES];
        followUpVc.fromString = @"房源";
        
        [self phoneFramchang];
    }

    
    
    
}

#pragma mark -- 跳转到约看
-(void)toLookAtViewControler:(UIButton *)sender
{
    if ([[[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE]substringWithRange:NSMakeRange([[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE] length] - 1, 1)] isEqualToString:@"E"])
    {
        LookAboutViewController *laVC = [[LookAboutViewController alloc]init];
        laVC.fromType = ViewFrom_Room;
        [self.navigationController pushViewController:laVC animated:YES];
        [self phoneFramchang];
        
    }
    else
    {
        FollowUpViewController *followUpVc = [[FollowUpViewController alloc]init];
        followUpVc.titleStr = @"带看查询";
        [self.navigationController pushViewController:followUpVc animated:YES];
        followUpVc.fromString = @"房源";
        followUpVc.toString   = @"带看";
        
        [self phoneFramchang];
    }

    
  
}

#pragma mark --- 跳转到自己通话记录
-(void)tomyphone:(UIButton *)sender
{
    //    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该功能尚未开放" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    //    [alert show];
     MyPhoneViewController *roomMyphoneVC = [[MyPhoneViewController alloc]initWithNibName:@"MyPhoneViewController" bundle:nil];
    roomMyphoneVC.type = Type_Room;
    [self.navigationController pushViewController:roomMyphoneVC animated:YES];
    
//    dfdfViewController *dfdVc = [[dfdfViewController alloc]init];
//    [self.navigationController pushViewController:dfdVc animated:YES];
    
    [self phoneFramchang];
    
}
#pragma mark --- 跳转到下属通话记录
-(void)tosubphone:(UIButton *)sender
{
    SubPhoneViewController *subphoneVC = [[SubPhoneViewController alloc]initWithNibName:@"SubPhoneViewController" bundle:nil];

    subphoneVC.typeSub = TypeSub_Room;
    
    [self.navigationController pushViewController:subphoneVC animated:YES];

    [self phoneFramchang];
    
}

#pragma mark --- 背景视图下移手势
-(void)clickBackView:(UIGestureRecognizer *)gesture
{
    [self phoneFramchang];
}
#pragma mark ---- 通话记录视图复原
-(void)phoneFramchang
{
    //    for (UIView *item in self.view.window.subviews) {
    //        [item removeFromSuperview];
    //    }
//    UIView *aview = [view viewWithTag:1];
    view1.hidden = NO;
    [topView removeFromSuperview];
     topView.frame = CGRectMake(0, PL_HEIGHT - 50, PL_WIDTH, 50);
    [self.view addSubview:topView];
    phonebutton.frame = CGRectMake(0, 0, PL_WIDTH-121 , 50);
    [phonebutton setImage:[UIImage imageByScaleAndCropingForSize:CGSizeMake(30, 20) oldImage:[UIImage imageNamed:@"shangjiantou.png"]] forState:UIControlStateNormal];
//    [UIView animateWithDuration:0.1 animations:^{
//       
//    } completion:^(BOOL finished) {
//        aview.hidden = NO;
        phoneViewIsOut = NO;
        
//    }];
    
    
}


-(void)deleteClick
{
    [bgHuiView removeFromSuperview];
}
- (void)clearViewFrame:(UIGestureRecognizer *)tap
{
    [self changeImage];
    
  

}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}
-(void)clearMainWindow:(UITapGestureRecognizer *)tap
{
    [bgHuiView removeFromSuperview];
    
    
}

-(void)openTable1:(UIButton *)button
{
    
    NSLog(@"更多");
//    _tableView1.hidden = YES;
//    _tableView2.hidden = YES;
    MoreMenuVC * menu = [[MoreMenuVC alloc]initWithRootViewController:self];
    menu.moreDlegate = self;
    RoomStyleViewController * roo = [RoomStyleViewController new];
    roo.roomdelegate = self;
    gestureVC = [[GestureMenuViewController alloc]init];
    [gestureVC getAStringByBlock:^(NSMutableDictionary *dic) {
        self.filterDic = dic;
//        [self requestListPropertyData];
        NSLog(@"》》》》》》》》》%@",dic);
    }];
    [menu showTelWindow:self.view.window andViewController:gestureVC];
   
    

}
- (void)menuString:(NSNotification *)note
{
    NSDictionary * dict =note.userInfo;
    NSLog(@"-----------------》%@",dict);
    NSArray * arr = dict[@"string1"];
    if(arr.count == 19)
    {
        _roomBuildingNum = arr[0];
        _roomRoomNum = arr[1];
        propertyTypeAccept = arr[2];
        imageTypeAccept = arr[3];
        jiaoYiTypeAccept = arr[4];
        tradeStr = arr[5];
        propertyOccupyStr = arr[6];
        propertyDirectionStr = arr[7];
        propertyOwn1Str = arr[8];
        propertyTrustStr = arr[9];
        roomCountFStr = arr[10];
        roomCountTStr = arr[11];
        roomSquareFromStr = arr[12];
        roomSquareToStr = arr[13];
        custTelStr = arr[14];
        userCodeStr = arr[15];
        statusLimitStr = arr[16];
        effectiveDateFromStr = arr[17];
        effectiveDateToStr = arr[18];
    }
    else
    {
        _roomBuildingNum = @"";
        _roomRoomNum = @"";
        propertyTypeAccept = @"";
        imageTypeAccept = @"";
        jiaoYiTypeAccept = @"";
        tradeStr = @"";
        propertyOccupyStr = @"";
        propertyDirectionStr = @"";
        propertyOwn1Str = @"";
        propertyTrustStr = @"";
        roomCountFStr = @"";
        roomCountTStr = @"";
        roomSquareFromStr = @"";
        roomSquareToStr =@"";
        custTelStr = @"";
        userCodeStr = @"";
        statusLimitStr = @"";
        effectiveDateFromStr = @"";
        effectiveDateToStr = @"";

    }
    [self loadTableData:nil];
}
- (void)sendSelfText1:(NSString *)text1 selfText2:(NSString *)text2 styleString:(NSString *)string
{
     NSLog(@"++%@ ++%@  ++%@ ",text1,text2,string);
    
}
- (void)sendViewToSuperView:(UIView *)viewself
{
  // NSLog(@"%@",viewself);
   
   
   
        
}
-(void)openTable:(UIButton *)button
{
   // NSLog(@"button = %ld",button.tag);
    if (button.tag==_currentBtn.tag)
    {
        dropBgView.hidden=YES;
        _tableView1.hidden = YES;
        _tableView2.hidden = YES;
        if (_currentBtn.tag==3)
        {
             button.selected = NO;
        }else
        {button.selected = YES;
           
        }
        if (_currentBtn.tag==3)
        {
            _tableView1.hidden = YES;
            
        }
       
         _currentBtn = nil;
        [self turnImage];
       return;
    }
    _currentBtn.selected = NO;
    button.selected =YES;
    _currentBtn = button;
    dropBgView.hidden=YES;
    _tableView2.hidden = YES;
    
   
   
    _tableView1.hidden = NO;
    if (_currentBtn.tag==3)
    {
        _tableView1.hidden = YES;
        
    }

    
    [_tableView1 reloadData];
    [self turnImage];
    if (button.tag==1)
    {
        NSLog(@"--1");
        dropBgView.hidden=NO;
        _tableView2.hidden = YES;
        PL_PROGRESS_SHOW;
            NSBlockOperation * quyuBlock = [NSBlockOperation blockOperationWithBlock:^{
                //片区接口
                [[MyRequest defaultsRequest]requestAreaInfoMessage:@"1" roomDistrictId:@"" roomDisName:@"" mode:@"0" userName:[PL_USER_STORAGE objectForKey:PL_USER_NAME] userTokne:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] backInfoMessage:^(NSMutableArray *array) {
                     PL_PROGRESS_DISMISS;
                    for (roomAreaPlace * are in array)
                    {
                        NSLog(@"%@",are.areaDistrictName) ;
                        
                    }
               
                    if (array.count>0)
                    {
                        self.quyuShuzu = [NSArray arrayWithArray:array];
                        _tableView1.frame = CGRectMake(0, CGRectGetMaxY(tableButton.frame), PL_WIDTH, self.quyuShuzu.count>=7?(PL_HEIGHT/2):_tableView1.rowHeight*(self.quyuShuzu.count +1));
                        
                        
                        [_tableView1 reloadData];
                       
                    }
                    else
                    {
                        _tableView1.frame = CGRectMake(0, CGRectGetMaxY(tableButton.frame), PL_WIDTH, _tableView1.rowHeight*(self.quyuShuzu.count+1));
                        
                        [_tableView1 reloadData];
                    }
                    
                    
                }];
                
                
            }];
            [quyuBlock start];
              }
    else if (button.tag==2)
    {
         NSLog(@"--2");
     dropBgView.hidden=NO;
        _tableView1.frame = CGRectMake(0, CGRectGetMaxY(tableButton.frame), PL_WIDTH, _tableView1.rowHeight*3);
        
        [_tableView1 reloadData];
      
    }
   
    
}
- (void)MoreViewSureClick
{
    NSLog(@"ok");
}
//切换图片
- (void)turnImage
{
    for (int i=0; i<_downArrayImage.count; i++)
    {
        UIImageView * imageView = _downArrayImage[i];
        if (imageView.tag-124==_currentBtn.tag)
        {
            if (imageView.tag-124 ==3) {
                imageView.image = [UIImage imageNamed:@"dropdown.png"];
            }
            else
            {
                imageView.image = [UIImage imageNamed:@"属性选择_2.png"];
            }
           
            
        }
        else
        {
            imageView.image = [UIImage imageNamed:@"dropdown.png"];
        }
        
    }

}
- (void)changeImage
{
    for (int i=0; i<_downArrayImage.count; i++)
    {
        UIImageView * imageView = _downArrayImage[i];

            imageView.image = [UIImage imageNamed:@"dropdown.png"];
       
        
    }

    
}
- (AutocompletionTableView *)autoCompleter
{
    NSLog(@"%s",__FUNCTION__);
    if (!_autoCompleter)
    {
        NSMutableDictionary *options = [NSMutableDictionary dictionaryWithCapacity:2];
        [options setValue:[NSNumber numberWithBool:YES] forKey:ACOCaseSensitive];
        [options setValue:nil forKey:ACOUseSourceFont];
        
        
        _autoCompleter = [[AutocompletionTableView alloc] initWithTextField:textField inViewController:self withOptions:options];
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
                           
                            [spellArray addObject:easterName];
                           
                            
                            
                        }
                        _autoCompleter.suggestionsDictionary = spellArray;
                        
                        
                        
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
- (void)textFieldValueChanged:(UITextField *)text
{

}
//创建自定义导航
#pragma mark --房源导航
-(void)createNav
{
    navView = [[UIView alloc]initWithFrame:CGRectMake(0, PL_SYSTEM_VERSION_ISIOS7?20:0.0, PL_WIDTH, 44)];
    navView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:navView];
    
    //
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(0, 5, 50, 30);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回按钮.png"] forState:UIControlStateNormal];
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回按钮.png"] forState:UIControlStateHighlighted];
    [backItemBnt addTarget:self action:@selector(backHome:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backItemBnt];
    
 
    UIView * navTitleView = [[UIView alloc]initWithFrame:CGRectMake((PL_WIDTH-220)/2, 0, 220, 35)];
    navTitleView.backgroundColor = [UIColor clearColor];

     textField = [[UITextField alloc]initWithFrame:CGRectMake((PL_WIDTH-220)/2, 0, 220,35)];
    textField.layer.borderWidth = 1.5;
    textField.layer.cornerRadius = 5;
    textField.placeholder = @"请输入小区名、地址、片区：";
    textField.font = [UIFont systemFontOfSize:12];
    textField.delegate = self;
    
    textField.layer.borderColor = [UIColor grayColor].CGColor;
    [navView addSubview:textField];
    UIView * leftViewTF = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 35)];
    leftViewTF.backgroundColor = [UIColor clearColor];
 
    
   
    
    labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(5,7.5, 55, 20)];
    labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.text = @"全部";
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.contentMode = UIViewContentModeCenter;
    labelTitle.font = [UIFont systemFontOfSize:14];
    labelTitle.userInteractionEnabled=YES;
      [leftViewTF addSubview:labelTitle];
    
    textField.clearButtonMode = UITextFieldViewModeAlways;
    UIButton * buttonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLeft.frame = CGRectMake(CGRectGetMaxX(labelTitle.frame)+6,10,10, 15);
//    [buttonLeft addTarget:self action:@selector(showPopover:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    [buttonLeft setImage:[UIImage imageNamed:@"下拉列表.png"] forState:UIControlStateNormal];
    [leftViewTF addSubview:buttonLeft];
    UIButton*labelBut=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, leftViewTF.frame.size.width, leftViewTF.frame.size.height)];
    labelBut.backgroundColor=[UIColor clearColor];
    [labelBut addTarget:self action:@selector(showPopover:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    [leftViewTF addSubview:labelBut];

    textField.leftView = leftViewTF;
    textField.returnKeyType = UIReturnKeySearch;

    textField.leftViewMode = UITextFieldViewModeAlways;
    self.navigationItem.titleView = navTitleView;
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button .frame = CGRectMake(CGRectGetMaxX(navView.frame)-40, 0, 40, 40);
    [button addTarget:self action:@selector(serchBnt:) forControlEvents:UIControlEventTouchUpInside];

    [button setBackgroundImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    [navView addSubview:button];
    

    if (PL_HEIGHT<=500)
    {
        sousuoView = [[UIView alloc]initWithFrame:CGRectMake(PL_WIDTH/4.0, CGRectGetMaxY(buttonLeft.frame)+15, 80, 140)];
    }
    else if (PL_HEIGHT ==568)
    {
        sousuoView = [[UIView alloc]initWithFrame:CGRectMake(PL_WIDTH/3.9, CGRectGetMaxY(buttonLeft.frame)+15, 80, 140)];
    }
    else
    {
        sousuoView = [[UIView alloc]initWithFrame:CGRectMake(PL_WIDTH/3.5, CGRectGetMaxY(buttonLeft.frame)+15, 80, 140)];
    }
    UIImageView * viewBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"black.png"]];
    viewBg.frame = CGRectMake(0, 0, CGRectGetWidth(sousuoView.frame), CGRectGetHeight(sousuoView.frame));
    [sousuoView addSubview:viewBg];
    for (int i=0; i<4; i++)
    {
        UIImageView * sousuoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,i*25+36, 80, 1)];
       sousuoImage.image = [UIImage imageNamed:@"black_in_hengxian.png"];
        sousuoImage.backgroundColor = [UIColor clearColor];
        [sousuoView addSubview:sousuoImage];
    }
    arrTitle = [NSMutableArray arrayWithObjects:@"全部",@"出售房",@"出租房",@"待看房",@"收藏房", nil];
    
    for (int j=0; j<arrTitle.count; j++)
    {
        UIButton * buttonLable = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonLable.frame = CGRectMake(0, j*25+13, 80, 20);
        buttonLable.backgroundColor = [UIColor clearColor];
        [buttonLable setTitle:[arrTitle objectAtIndex:j] forState:UIControlStateNormal];
        [buttonLable setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        buttonLable.tag =250+j;
//        [buttonLable addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [sousuoView addSubview:buttonLable];
    }
    
    sousuoView.backgroundColor = [UIColor clearColor];
    
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField1
{
    NSLog(@"+++++++++++%@",textField1.text);
    
    self.cacheDistrictString = textField1.text;
    [textField1 resignFirstResponder];
    
    [self serchBnt:nil];
    
    
    
    return YES;
    
}
-(void)removesousuoView
{
    [sousuoView removeFromSuperview];
    
}
#pragma mark --
-(void)showPopover:(id)sender forEvent:(UIEvent*)event
{
   
    NSLog(@"%s",__FUNCTION__);
    
    NSLog(@"搜索");
    [self.view endEditing:YES];
    
    NSArray  * titleArray = @[@"全部",@"出售房",@"出租房",@"待看房",@"收藏房"];
    RoomTableViewController *tableViewController = [[RoomTableViewController alloc] initWithStyle:UITableViewStylePlain];
    tableViewController.delegate = self;
    
       
    [tableViewController loadWithData:titleArray];
    
    tableViewController.view.frame = CGRectMake(0,0, 80, 190);
    _popoverController1 = [[TSPopoverController alloc] initWithContentViewController:tableViewController];
    
    
    _popoverController1.cornerRadius = 0;
    
    // popoverController.titleText = @"change order";
    _popoverController1.popoverBaseColor = PL_CUSTOM_COLOR(48, 48, 48, 1);
    _popoverController1.popoverGradient= NO;
    //    popoverController.arrowPosition = TSPopoverArrowPositionHorizontal;
    [_popoverController1 showPopoverWithTouch:event];
   
    
    
    
}
#pragma mark --收藏列表
- (void)didSelectPopOverRowIndex:(NSIndexPath *)indexpath cellTitleText:(NSString *)title
{
    resultArray = [NSMutableArray array];
    if (indexpath.row==3)
    {
        PL_ALERT_SHOWNOT_OKAND_YES(@"暂无待看房数据,请选择其他房源信息!!!");
        [_popoverController1 dismissPopoverAnimatd:YES];
        
        return;
        
    }
    if (indexpath.row==0)
    {
        self.cacheAreaName = @"";
        self.cacheDistrictString = @"";
        self.cacheEstateName = @"";
        self.xingzhengqu = @"";
        self.govAreaString = @"";
        propertyTypeAccept = @"";
        textField.text = @"";
        self.tradeString = @"";
        rentPriceFrom = @"";
        rentPriceTo = @"";
        priceFrom = @"";
        priceTo = @"";
        _roomBuildingNum = @"";
        _roomRoomNum = @"";
        
        self.cacheStorage = @"";
    }
    NSString * titleAlert= [NSString stringWithFormat:@"您当前选择的是:%@",title];
    PL_ALERT_SHOWNOT_OKAND_YES(titleAlert);
  
    labelTitle.text = [title substringToIndex:2];
//    if (indexpath.row==0||indexpath.row==4)
//    {
//        self.tradeString = @"";
//    }
//    else
//    {
//        self.tradeString = labelTitle.text;
//        //self.cacheStorage = @"";
//        
//    }
        if (indexpath.row==0 || indexpath.row == 4)
        {
            self.tradeString = @"";
             self.cacheStorage = @"2";
        }
        else
        {
            self.tradeString = labelTitle.text;
            self.cacheStorage = @"2";
            
        }
    if (indexpath.row==4)
    {
        self.cacheStorage = @"3";
    }
    
    
    PL_PROGRESS_SHOW;
    NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
        [[MyRequest defaultsRequest] getRoomInfoEasterList:[self allDataTableSelect_refresh:1] backInfoMessage:^(NSMutableArray *array) {
            PL_PROGRESS_DISMISS;
            
            
           // NSLog(@"--------------------------------------------------------------\n%@",array);
//            if ([[array firstObject] isEqualToString:@"[]"])
//            {
//                [resultArray removeAllObjects];
//                _tableView.backgroundView = alertLable;
//                [_tableView reloadData];
//                
//                [_tableView footerEndRefreshing];
//                return ;
//                
//            }

            if (array.count==0) {
                resultArray = [NSMutableArray arrayWithArray:array];
                self.tableView.backgroundView = alertLable;
                [self.tableView reloadData];
                return ;
            }
            if (array && [[array firstObject] isKindOfClass:NSClassFromString(@"NSString")])
            {
                
                if ( [[array firstObject ]isEqualToString:@"NOLOGIN"]) {
                    ViewController * login = [[ViewController alloc]init];
                    [self.navigationController pushViewController:login animated:YES];
                    
                }
                else if ([[array firstObject] isEqualToString:@"[]"])
                {
                    [resultArray removeAllObjects];
                    
                    _tableView.backgroundView = alertLable;
                    
                    [_tableView reloadData];
                    PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                    return ;
                }
                else
                {
                    _tableView.backgroundView = alertLable;
                    [_tableView reloadData];
                    PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                    
                    return;
                }
            }
            else if(array.count>0)
            {
                NSLog(@"有数据");
                resultArray = [NSMutableArray arrayWithArray:array];
                self.cacheArray = [NSMutableArray arrayWithArray:resultArray];
                
                
                [self.tableView reloadData];  
                _tableView.backgroundView = nil;
                
            }
            else
            {
                _tableView.backgroundView = alertLable;
                [_tableView reloadData];
                PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                return;
            }
        }];
    }];
    [operation start];
    [_popoverController1 dismissPopoverAnimatd:YES];
      
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    [self callBackTitle];
}
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    return YES;
    
}
- (void)loadTableData:(id)sender
{
    NSLog(@"加载");
    [self callBackTitle];
    PL_PROGRESS_SHOW;
    RoomData *roominfo =[self allDataTableSelect_refresh:1];
    NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
        [[MyRequest defaultsRequest] getRoomInfoEasterList:roominfo backInfoMessage:^(NSMutableArray *array) {
            PL_PROGRESS_DISMISS;
            if (array.count==0) {
                resultArray = [NSMutableArray arrayWithArray:array];
                self.tableView.backgroundView = alertLable;
                [self.tableView reloadData];
                return ;
            }
            if (array && [[array firstObject] isKindOfClass:NSClassFromString(@"NSString")])
            {
                
                if ( [[array firstObject ]isEqualToString:@"NotLogin"]) {
                    ViewController * login = [[ViewController alloc]init];
                    [self.navigationController pushViewController:login animated:YES];
                    
                }
                else if ([[array firstObject] isEqualToString:@"[]"])
                {
                     [resultArray removeAllObjects];
                    _tableView.backgroundView = alertLable;
                    
                    [_tableView reloadData];
                    PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                    return ;
                }
                else
                {
                    _tableView.backgroundView = alertLable;
                    [_tableView reloadData];
                    PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                    
                    return;
                }
            }
            else if(array.count>0)
            {
                NSLog(@"有数据");
                resultArray = [NSMutableArray arrayWithArray:array];
                self.cacheArray = [NSMutableArray arrayWithArray:resultArray];
                
                for (RoomData *item  in resultArray) {
                    NSLog(@"=======================%@",item.roomPropertyId);
                    [self.properIDSet insertObject:@"suntt3" atIndex:self.properIDSet.count];
                
                }
               _tableView.backgroundView = nil;
                [self.tableView reloadData];
                return;
            }
            else
            {
                resultArray = [NSMutableArray arrayWithArray:array];
                
                _tableView.backgroundView = alertLable;
                [_tableView reloadData];
                PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                
                return;
            }

            
            
            
        }];
        
        
    }];
    [operation start];

    
}
#pragma mark --房源列表注册
-(void)roomInfo
{
//    alertLable = [[UIButton  alloc]initWithFrame:CGRectMake(PL_WIDTH/2-160, PL_HEIGHT/4,160, 60)];
//    [alertLable setTitle:@"暂无数据,请点击加载数据" forState:UIControlStateNormal];
//    [alertLable setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//     alertLable.contentMode = UIViewContentModeCenter;
//    [alertLable addTarget:self action:@selector(loadTableData:) forControlEvents:UIControlEventTouchUpInside];
//    alertLable.backgroundColor = [UIColor clearColor];
//    alertLable.titleLabel.textColor = [UIColor blackColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(navView.frame)+50,PL_WIDTH, PL_HEIGHT-(CGRectGetMaxY(navView.frame)+50+50)) style:UITableViewStylePlain];
       [self.tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tag = 500;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    resultArray = [NSMutableArray array];
    [self loadTableData:nil];
 }
#pragma mark -- 返回键
-(void)backHome:(UIButton *)button
{
   
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --搜索
-(void)serchBnt:(UIButton *)btn
{
    NSLog(@"%s",__FUNCTION__);
    
    NSLog(@">>>>>>>>>%@",textField.text);
    NSLog(@"+++++%@",self.filterDic);
//    [self.filterDic setObject:@"" forKey:@"学区房"];
//    [self.filterDic setObject:@"" forKey:@"急售"];
//    [self.filterDic setObject:@"" forKey:@"经理推荐"];
//    [self.filterDic setObject:@"" forKey:@"满二年"];
//    [self.filterDic setObject:@"" forKey:@"独家"];
//    [self.filterDic setObject:@"" forKey:@"钥匙"];
    [self.view endEditing:YES];
    //全部
    if (currentTag==250)
    {
//        self.cacheAreaName = @"";
//        self.cacheDistrictString = @"";
//        self.cacheEstateName = @"";
//            self.govAreaString = @"";
//            self.xingzhengqu = @"";
        if ([self.cacheStorage isEqualToString:@"1"])
        {
            PL_ALERT_SHOWNOT_OKAND_YES(@"您当前正在查看收藏房源，请返回选择全部查看其他房源");
            
            return;
            
        }
        
        PL_PROGRESS_SHOW;
        NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
            [[MyRequest defaultsRequest] getRoomInfoEasterList:[self allDataTableSelect_refresh:1] backInfoMessage:^(NSMutableArray *array) {
                PL_PROGRESS_DISMISS;
                
//                for (RoomData *item in  array) {
//                    NSLog(@"%@,%@",   textField.text,item.roomAddress);
//                }
                
                if ([[array firstObject] isKindOfClass:[NSString class]])
                {
                    if ([[array firstObject] isEqualToString:@"NOLOGIN"])
                    {
                        ViewController * login = [[ViewController alloc]init];
                        [self.navigationController pushViewController:login animated:YES];
                    }else{
                        NSLog(@"没有数据，dnadjakdjkk");
                        [resultArray removeAllObjects];
                        self.label.hidden = NO;
                        [self.tableView reloadData];
                    }
                }
                else
                {
                    self.label.hidden = YES;
                    resultArray = [NSMutableArray arrayWithArray:array];
                    self.cacheArray = [NSMutableArray arrayWithArray:array];
                    
                    
                    [self.tableView reloadData];
                    
                }

                
                
            }];
            
            
        }];
        [operation start];

    }
    else if (currentTag==251)
    {
        NSString * str = [labelTitle.text substringToIndex:2];
        self.tradeString = str;
        
       
        PL_PROGRESS_SHOW;
        NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
            [[MyRequest defaultsRequest] getRoomInfoEasterList:[self allDataTableSelect_refresh:1] backInfoMessage:^(NSMutableArray *array) {
                PL_PROGRESS_DISMISS;
                if ([[array firstObject] isEqualToString:@"NOLOGIN"])
                {
                    
                    ViewController * login = [[ViewController alloc]init];
                    [self.navigationController pushViewController:login animated:YES];
                    
                }
                else
                {
                    resultArray = [NSMutableArray arrayWithArray:array];
                    self.cacheArray = [NSMutableArray arrayWithArray:resultArray];
                    
                    
                    [self.tableView reloadData];
                    [[ShowActivityLoad shareDefault] dismissProgress];
                }

                
                
            }];
            
            
        }];
        [operation start];

    }
    else if (currentTag==252)
    {
        NSString * str = [labelTitle.text substringToIndex:2];
       // NSLog(@"----%@",str);
        self.tradeString = str;
       
        PL_PROGRESS_SHOW;
        NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
            [[MyRequest defaultsRequest] getRoomInfoEasterList:[self allDataTableSelect_refresh:1] backInfoMessage:^(NSMutableArray *array) {
                PL_PROGRESS_DISMISS;
                
                if ([[array firstObject] isKindOfClass:[NSString class]])
                {
                    if ([[array firstObject] isEqualToString:@"NOLOGIN"])
                    {
                        ViewController * login = [[ViewController alloc]init];
                        [self.navigationController pushViewController:login animated:YES];
                    }
                    
                    
                }
                else
                {
                    resultArray = [NSMutableArray arrayWithArray:array];
                    self.cacheArray = [NSMutableArray arrayWithArray:resultArray];
                    
                    
                    [self.tableView reloadData];
                    [[ShowActivityLoad shareDefault] dismissProgress];
                }

                
                
            }];
            
            
        }];
        [operation start];

    }
    else
    {
        return;
        
    }
//    textField.text = nil;
    textField.placeholder = @"请输入小区名、地址、片区：";
    
    [_autoCompleter hideOptionsView];
    

}
#pragma mark --tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView==_tableView1)
    {
        if (_currentBtn.tag==1)
        {
            
             return self.quyuShuzu.count+1;
        }
        else if (_currentBtn.tag==2)
        {
            return 3;
        }
        
        else
        {
            return moreArr.count;
            
        }
       
    }
    else if (tableView==_tableView2)
    {
        if (_currentBtn.tag==1)
        {
            return 0;
        }
        else if (_currentBtn.tag==2)
        {
             return self.priceArray.count;
        }
        else
        {
            return 0;
            
        }
       
        
    }else if (tableView==tableVeiwList)
    {
        return styleArray.count;
    }
    else   if(tableView==self.tableView)
    {
        if (resultArray.count>0)
        {
             return   resultArray.count;
        }
       else
       {
           return 0;
           
       }
        
    }
    else if (tableView ==telTableView)
    {
        if (telNumArray)
        {
            return telNumArray.count;
            
        }
        return 0;
        
    }
    else
    {
        return 0;
        
    }

    
   
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tableView1||tableView==_tableView2)
    {
        return 44;
    }
    else if (tableView==tableVeiwList)
    {
        return 30;
        
    }
    else if (tableView==self.tableView)
    {
        
             return 113;
        
        
       
        
    }
    else if (tableView==telTableView)
    {
        return 44;
        
    }
    else
    {
        return 0;
        
    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tableView1)
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifer" ];
        if (!cell)
        {
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifer"];
            
        }
        UILabel * bglable =[[UILabel alloc]initWithFrame:CGRectMake(0, cell.frame.size.height-1, PL_WIDTH, 1)];
        bglable.backgroundColor =[UIColor lightGrayColor];
        
        [cell addSubview:bglable];
        
        //cell.backgroundColor = [UIColor colorWithRed:76/255.0 green:73/255.0 blue:72/255.0 alpha:0.6];
        cell.backgroundColor = PL_CUSTOM_COLOR(255, 255, 255, 1);
        
        
        [cell.imageView removeFromSuperview];
        
        if (_currentBtn.tag==1)
        {
           // cell.textLabel.text = @"";
            //cell.imageView.image = nil;
            if (indexPath.row==0)
            {
                cell.textLabel.text = @"所有片区";
                
            }
            else{
                if (self.quyuShuzu.count>0)
                {
                    roomAreaPlace * area = self.quyuShuzu[indexPath.row-1];
                    
                    
                    cell.textLabel.text = [NSString stringWithFormat:@"%@",area.areaDistrictName];
                    
                }
            }
            if (indexPath.row!=0)
            {
                
            }
        }
        if (_currentBtn.tag==2)
        {
            cell.imageView.image = nil;
            
            cell.textLabel.text = @"";
            
            if (indexPath.row==0)
            {
                cell.textLabel.text = @"不限";
            }
            else if (indexPath.row==1)
            {
                cell.textLabel.text = @"售价";
                
            }
            else if (indexPath.row==2)
            {
                cell.textLabel.text = @"租价";
               // cell.userInteractionEnabled = NO;
                
            }
            else
            {
                cell.textLabel.text =@"";
                
            }
        }
        if (_currentBtn.tag==3)
        {
            cell.textLabel.text = @"";
            cell.imageView.image = nil;
            cell.textLabel.text=moreArr[indexPath.row];
            
            
        }
        
        return cell;
        
    }
    else if(tableView ==_tableView2)
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifercell"];
        
        if (!cell)
        {
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifercell"];
            
        }
        if (_currentBtn.tag==1)
        {
            if (indexPath.row==0)
            {
                cell.textLabel.text = @"所有片区";
                
            }
            else
            {
                cell.textLabel.text = self.pianquArray[indexPath.row-1];
                
            }
            
            
        }
        if (_currentBtn.tag==2)
        {
            cell.textLabel.text = @"";
          
            NSDictionary *dict=[self.priceArray objectAtIndex:indexPath.row];
          
            NSString *priceStr=[NSString stringWithFormat:@"%@-%@ %@",[dict objectForKey:@"PRICEUP"],[dict objectForKey:@"PRICEDOWN"],[dict objectForKey:@"UNIT"]];
            cell.textLabel.text = priceStr;
            cell.textLabel.font = [UIFont systemFontOfSize:14];

            
        }
       
        return cell;
        
    }else if (tableView==tableVeiwList)
    {
        static  NSString * identifer = @"cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        
        if (!cell)
        {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        NSDictionary *dic=[styleArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [dic objectForKey:@"FollowType"];
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.textLabel.textColor=[UIColor whiteColor];
        cell.backgroundColor=[UIColor clearColor];
        return cell;
        

    }
    else if (tableView ==telTableView)
    {
        static  NSString * identifer = @"cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        
        if (!cell)
        {
           
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        if (telNumArray.count>0)
        {
             NSString * telStr  = telNumArray[indexPath.row];
            NSArray * arrTel = [telStr componentsSeparatedByString:@"|"];
            //cell.textLabel.text = arrTel[0];
            
            NSLog(@"%@",arrTel[0]);
            NSString *currentStr=arrTel[0];
            if (currentStr.length==11) {
                cell.textLabel.text =[NSString stringWithFormat:@"         %@",arrTel[0]];
                UIImage *image=[UIImage imageNamed:@"call_mobile.png"];
                CGSize itemSize = CGSizeMake(30, 30);
                UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
                CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
                [image drawInRect:imageRect];
                
                cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
            }
            else
            {
                cell.textLabel.text =[NSString stringWithFormat:@"           %@",arrTel[0]];
                UIImage *image=[UIImage imageNamed:@"call_phone.png"];
                CGSize itemSize = CGSizeMake(30, 30);
                UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
                CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
                [image drawInRect:imageRect];
                
                cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
            }
                  }
       
        
        
        
        return cell;
        

    }
    else
    {
//        [_currentBtn setTitle:self.govAreaString forState:UIControlStateNormal];
//        [_currentBtn setButtonNormalTile:self.govAreaString];
//        _currentBtn.titleLabel.text =self.govAreaString;
        NSLog(@"%@",_currentBtn.titleLabel.text);
        static  NSString * identifer = @"cell";
        CustomCell * cell =(CustomCell *) [self.tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
        [cell setLeftUtilityButtons:[self leftButtons] WithButtonWidth:100.0f];
        [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:100.0f];
      
        
        
        cell.delegate = self;
    
        
    
        if (resultArray.count>0)
        {
            RoomData * room =resultArray[indexPath.row];
            cell.districtNameLable.text =[NSString stringWithFormat:@"%@",room.roomEasterName];
            cell.cellTag = room.roomPropertyId;
            [cell.districtButton addTarget:self action:@selector(estateClick:) forControlEvents:UIControlEventTouchUpInside];
            
            
            cell.districtNameLable.font = [UIFont systemFontOfSize:15];
            
            cell.districtNameLable.contentMode = UIViewContentModeLeft|UIViewContentModeScaleAspectFit;
            cell.estateNameLable.text = room.roomDistrictName;
            
            [cell.btn1Click addTarget:self action:@selector(districtBtnClick1:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btn2Click addTarget:self action:@selector(districtBtnClick2:) forControlEvents:UIControlEventTouchUpInside];
            cell.btn1Click.tag = indexPath.row;
            cell.btn2Click.tag = indexPath.row;
            cell.districtButton.tag=indexPath.row;
            NSString *str1 = [room.roomROOMSTYLE substringWithRange:NSMakeRange(2, 1)];
            cell.countFLable.text = [NSString stringWithFormat:@"%@房 %@厅",room.roomCountF,str1];
            //cell.countFLable.font = [UIFont systemFontOfSize:8];
            
            cell.roomNumLable.text = [NSString stringWithFormat:@"%@号%@室",room.roomBuildingName,room.roomROOMNO];
           
            cell.roomNumLable.adjustsFontSizeToFitWidth = YES;
           
            cell.areaLable.text = [NSString stringWithFormat:@"%@",room.roomAreaName];
            
            cell.squareLable.text =[NSString stringWithFormat:@"%@ 平米",room.roomSquare];
//            cell.priceLable.text = [NSString stringWithFormat:@"%@万",room.roomPRICE];
            if ([[NSString stringWithFormat:@"%@",room.roomTrade]  isEqualToString:@"出租"]) {
                cell.priceLable.text = [NSString stringWithFormat:@"%@元/月",room.roomRentPrice];
            }
            else
            {
                cell.priceLable.text = [NSString stringWithFormat:@"%@万",room.roomPRICE];

            }
            
            NSLog(@"%@",room.roomTrade);
            if (![room.roomTrade isKindOfClass:[NSNull class]]) {
                if ([[NSString stringWithFormat:@"%@",room.roomTrade]  isEqualToString:@"出租"])
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                       
                        cell.zuLable.image = [UIImage imageNamed:@"出租.jpg"];
                        cell.shaleLable.image = [UIImage imageNamed:@"出售-灰.jpg"];

                        
                    });
                    cell.priceLable.adjustsFontSizeToFitWidth = YES;
                    
                }
                else  if([room.roomTrade isEqualToString:@"租售"])
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                                              cell.zuLable.image = [UIImage imageNamed:@"出租.jpg"];
                        cell.shaleLable.image = [UIImage imageNamed:@"出售.jpg"];

                    });
                cell.priceLable.adjustsFontSizeToFitWidth = YES;
                    
                }
                else if ([[NSString stringWithFormat:@"%@",room.roomTrade] isEqualToString:@"出售"])
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                                               cell.zuLable.image = [UIImage imageNamed:@"出租-灰2.jpg"];
                        cell.shaleLable.image = [UIImage imageNamed:@"出售.jpg"];

                    });
                    cell.priceLable.adjustsFontSizeToFitWidth = YES;
                    
                }
            }
            else if([room.roomTrade isKindOfClass:[NSNull class]])
            {
                
               
                cell.zuLable.image = [UIImage imageNamed:@"出租-灰2.jpg"];
                cell.shaleLable.image = [UIImage imageNamed:@"出售-灰.jpg"];
//                cell.priceLable.text =@"222";
                cell.priceLable.adjustsFontSizeToFitWidth = YES;
                
            }
            if ([room.roomStatus isEqualToString:@"有效"]) {
                cell.roomStars.image=[UIImage imageNamed:@"有效.jpg"];
            }
            else if([room.roomStatus isEqualToString:@"无效"])
            {
                cell.roomStars.image=[UIImage imageNamed:@"无效(1).jpg"];
            }
            else if([room.roomStatus isEqualToString:@"已租"])
            {
                cell.roomStars.image=[UIImage imageNamed:@"已租.jpg"];
            }

            else if([room.roomStatus isEqualToString:@"已售"])
            {
                cell.roomStars.image=[UIImage imageNamed:@"已售.jpg"];
            }

           if ([room.TwoYears isEqualToString:@"1"])
            {
                cell.TwoYears.image=[UIImage imageNamed:@"满二年.jpg"];
                
            }
            if ([room.propertyTrust isEqualToString:@"独家"])
            {
                cell.dujia.image=[UIImage imageNamed:@"独家.jpg"];
                
            }else if ([room.propertyTrust isEqualToString:@"签赔"])
            {
                cell.dujia.image=[UIImage imageNamed:@"签赔房源状态标签.jpg"];
            }
            else if ([room.propertyTrust isEqualToString:@""])
            {
                cell.dujia.image=[UIImage imageNamed:@"独家-灰.jpg"];

            }
            if ([room.KeyHome isEqualToString:@"0"])
            {
                cell.KeyHome.image=[UIImage imageNamed:@"钥匙-灰.jpg"];
            }
            else
            {
                cell.KeyHome.image=[UIImage imageNamed:@"钥匙.jpg"];
            }

            if (room.roomImageContent==nil)
                
            {
                cell.roomImageInfo.image =[UIImage imageNamed:@"ShowBinaryImg.jpg"];
                
            }
            else
            {
                cell.roomImageInfo.image = room.roomImageContent;
                
                
                
            }
            
            
            
            cell.roomImageInfo.userInteractionEnabled = NO;
            
            //});
            cell.roomImageInfo.contentMode = UIViewContentModeScaleAspectFit;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            
            if ([room.roomHouseMarks isEqualToString:@"000"])
            {
               
                cell.jingliTuiJianLable.image =[UIImage imageNamed:@"经理推荐-灰.jpg"];
                cell.jishouLable.image =[UIImage imageNamed:@"急售-灰.jpg"];
                cell.xuequfangLable.image =[UIImage imageNamed:@"学区房-灰.jpg"];

            }
            else  if([room.roomHouseMarks isEqualToString:@"001"])
            {
                
                cell.jingliTuiJianLable.image =[UIImage imageNamed:@"经理推荐-灰.jpg"];
                cell.jishouLable.image =[UIImage imageNamed:@"急售-灰.jpg"];
                cell.xuequfangLable.image =[UIImage imageNamed:@"学区房.jpg"];

                
            }
            else if([room.roomHouseMarks isEqualToString:@"010"])
            {
                
                cell.jingliTuiJianLable.image =[UIImage imageNamed:@"经理推荐-灰.jpg"];
                cell.jishouLable.image =[UIImage imageNamed:@"急售.jpg"];
                cell.xuequfangLable.image =[UIImage imageNamed:@"学区房-灰.jpg"];

                
            }
            else if ([room.roomHouseMarks isEqualToString:@"011"])
            {
                
                cell.jingliTuiJianLable.image =[UIImage imageNamed:@"经理推荐-灰.jpg"];
                cell.jishouLable.image =[UIImage imageNamed:@"急售.jpg"];
                cell.xuequfangLable.image =[UIImage imageNamed:@"学区房.jpg"];
            }
            else if ([room.roomHouseMarks isEqualToString:@"100"])
            {
               
                cell.jingliTuiJianLable.image =[UIImage imageNamed:@"经理推荐.jpg"];
                cell.jishouLable.image =[UIImage imageNamed:@"急售-灰.jpg"];
                cell.xuequfangLable.image =[UIImage imageNamed:@"学区房-灰.jpg"];

            }
            else if ([room.roomHouseMarks isEqualToString:@"101"])
            {
               
                cell.jingliTuiJianLable.image =[UIImage imageNamed:@"经理推荐.jpg"];
                cell.jishouLable.image =[UIImage imageNamed:@"急售-灰.jpg"];
                cell.xuequfangLable.image =[UIImage imageNamed:@"学区房.jpg"];
            }
            else if ([room.roomHouseMarks isEqualToString:@"110"])
            {
                
                cell.jingliTuiJianLable.image =[UIImage imageNamed:@"经理推荐.jpg"];
                cell.jishouLable.image =[UIImage imageNamed:@"急售.jpg"];
                cell.xuequfangLable.image =[UIImage imageNamed:@"学区房-灰.jpg"];

            }
            else if ([room.roomHouseMarks isEqualToString:@"111"])
            {
              
                cell.jingliTuiJianLable.image =[UIImage imageNamed:@"经理推荐.jpg"];
                cell.jishouLable.image =[UIImage imageNamed:@"急售.jpg"];
                cell.xuequfangLable.image =[UIImage imageNamed:@"学区房.jpg"];

            }
            [cell.telBnt addTarget:self action:@selector(turnNextPage:) forControlEvents:UIControlEventTouchUpInside];
            cell.telBnt.tag = indexPath.row;
            [cell.changeBtn addTarget:self action:@selector(callPhoneNumber:) forControlEvents:UIControlEventTouchUpInside];
            cell.changeBtn.tag=indexPath.row;
            
            
            return cell;

       
        }
        
        
    
    }
    return nil;
    

    
}

#pragma mark -行政区，片区搜索
- (void)districtBtnClick1:(UIButton *)sender
{
    NSInteger row = sender.tag;
  
    [self callBackTitle];
    NSIndexPath * index = [NSIndexPath indexPathForRow:row inSection:0];
    CustomCell * cell = (CustomCell *)[self.tableView cellForRowAtIndexPath:index];
       
   
self.cacheEstateName = cell.estateNameLable.text;
   

    PL_PROGRESS_SHOW;
    
    
    [[MyRequest defaultsRequest] getRoomInfoEasterList:[self allDataTableSelect_refresh:1] backInfoMessage:^(NSMutableArray *array) {
        PL_PROGRESS_DISMISS;
        if (array && [[array firstObject] isKindOfClass:NSClassFromString(@"NSString")])
        {
            
            if ( [[array firstObject ]isEqualToString:@"NOLOGIN"]) {
                ViewController * login = [[ViewController alloc]init];
                [self.navigationController pushViewController:login animated:YES];
                
            }
            else if ([[array firstObject] isEqualToString:@"[]"])
            {
//                _tableView.backgroundView = alertLable;
//
//                [_tableView reloadData];
                PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                return ;
            }
            else if ([[array firstObject] isEqualToString:@"exception"]) {
                _tableView.backgroundView = alertLable;
                [_tableView reloadData];
                PL_ALERT_SHOWNOT_OKAND_YES(@"服务器异常");
                return ;
            }
            else
            {
                PL_ALERT_SHOW(@"请求超时");
                return;
                
            }
        }
        else if(array.count>0)
        {
            NSLog(@"有数据");
            resultArray = [NSMutableArray arrayWithArray:array];
            self.cacheArray = [NSMutableArray arrayWithArray:resultArray];
            
            
            [self.tableView reloadData];
            _tableView.backgroundView = nil;
            
        }
        else if ([[array firstObject] isEqualToString:@"exception"]) {
            resultArray = [NSMutableArray arrayWithArray:array];
            _tableView.backgroundView = alertLable;
            [_tableView reloadData];
            PL_ALERT_SHOWNOT_OKAND_YES(@"服务器异常");
            return;
        }
        else
        {
            PL_ALERT_SHOW(@"请求超时");
            return;
        }
    }];

   
    
   
    
}
- (void)districtBtnClick2:(UIButton *)sender
{
    NSInteger row = sender.tag;
    
    [self callBackTitle];
    NSIndexPath * index = [NSIndexPath indexPathForRow:row inSection:0];
    CustomCell * cell = (CustomCell *)[self.tableView cellForRowAtIndexPath:index];
    
 
    self.cacheAreaName = cell.areaLable.text;

    PL_PROGRESS_SHOW;
    
   
    [[MyRequest defaultsRequest] getRoomInfoEasterList:[self allDataTableSelect_refresh:1] backInfoMessage:^(NSMutableArray *array) {
        PL_PROGRESS_DISMISS;
        if (array && [[array firstObject] isKindOfClass:NSClassFromString(@"NSString")])
        {
            
            if ( [[array firstObject ]isEqualToString:@"NOLOGIN"]) {
                ViewController * login = [[ViewController alloc]init];
                [self.navigationController pushViewController:login animated:YES];
                
            }
            else if ([[array firstObject] isEqualToString:@"[]"])
            {
//                _tableView.backgroundView = alertLable;
//                
//                [_tableView reloadData];
                PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                return ;
            }
            else
            {
                _tableView.backgroundView = alertLable;
                [_tableView reloadData];
                PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                
                return;
            }
        }
        else if(array.count>0)
        {
            NSLog(@"有数据");
            resultArray = [NSMutableArray arrayWithArray:array];
            self.cacheArray = [NSMutableArray arrayWithArray:resultArray];
            
            
            [self.tableView reloadData];
            _tableView.backgroundView = nil;
        }
        
        else if ([[array firstObject] isEqualToString:@"exception"]) {
                resultArray = [NSMutableArray arrayWithArray:array];
                _tableView.backgroundView = alertLable;
                [_tableView reloadData];
                PL_ALERT_SHOWNOT_OKAND_YES(@"服务器异常");
                return;
        }
        else
        {
            PL_ALERT_SHOW(@"请求超时");
            return;
        }

    }];

    NSLog(@"%ld %@",(long)sender.tag,cell.areaLable.text);
    
    
}

#pragma mark --微信分享
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            
       
            
            PL_ALERT_SHOW(@"此功能暂未开放,敬请期待");
//            NSIndexPath * cellIndexPath = [self.tableView indexPathForCell:cell];
//            NSLog(@"++%ld",cellIndexPath.row);
//            CustomCell * cusCell =(CustomCell *) [self.tableView cellForRowAtIndexPath:cellIndexPath];
//            NSLog(@" %@",cusCell.cellTag);
//            
//            
//            if ([WXApi isWXAppInstalled])
//            {
//                NSString *shareText = [NSString stringWithFormat:@"%@",cusCell.districtNameLable.text];
//                //分享内嵌文字
//                UIImage *shareImage = [UIImage imageNamed:@"byLogo.png"];          //分享内嵌图片
//                
//                //调用快速分享接口
//                [UMSocialSnsService presentSnsIconSheetView:self
//                                                     appKey:@"54b730dcfd98c5d5ed000a3b"
//                                                  shareText:shareText
//                                                 shareImage:shareImage
//                                            shareToSnsNames:@[UMShareToWechatTimeline,UMShareToWechatSession,UMShareToWechatFavorite,]
//                                                   delegate:self];
//                //http://61.129.51.211:9090/AppDetailPages/PropertyDetail.aspx?PropertyID=1&UserCode=aa14682
//                [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"%@PropertyID=%@&UserCode=%@",BY_SHARE_URL,cusCell.cellTag,[PL_USER_STORAGE objectForKey:PL_USER_code]];
//                NSLog(@"%@  == %@",cusCell.cellTag,[PL_USER_STORAGE objectForKey:PL_USER_code]);
//                
//                [UMSocialData defaultData].extConfig.wechatTimelineData.title =[NSString stringWithFormat:@"今日推荐房源--%@",cusCell.districtNameLable.text];
//                [UMSocialData defaultData].extConfig.wechatSessionData.title =[NSString stringWithFormat:@"今日推荐房源--%@",cusCell.districtNameLable.text];
//                [UMSocialData defaultData].extConfig.wechatSessionData.url= [NSString stringWithFormat:@"%@PropertyID=%@&UserCode=%@",BY_SHARE_URL,cusCell.cellTag,[PL_USER_STORAGE objectForKey:PL_USER_code]];
//                
//            }
//            else
//            {
//                PL_ALERT_SHOWNOT_OKAND_YES(@"您未安装微信应用，请前去下载，谢谢");
//               
//                
//            }
//
//            
//            
//            [cell hideUtilityButtonsAnimated:YES];
    }
            break;

        default:
            break;
    }
}
- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    switch (state) {
        case 1:
            // set to NO to disable all left utility buttons appearing
            return YES;
            break;
        case 2:
            // set to NO to disable all right utility buttons appearing
            return YES;
            break;
        default:
            break;
    }
    
    return YES;
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
           // NSLog(@"delegate click");
            NSIndexPath * cellIndexPath = [self.tableView indexPathForCell:cell];
            NSLog(@"++%ld",(long)cellIndexPath.row);
            _currentNum = cellIndexPath.row;
            
            CustomCell * cusCell =(CustomCell *) [self.tableView cellForRowAtIndexPath:cellIndexPath];
            
            
             self.cellProperID = cusCell.cellTag;
            
            
        
            [self uploadImage:nil];
            
            
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 1:
        {
           
            break;
        }
        default:
            break;
    }
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
   
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:1.0f blue:1.0 alpha:1.0f]
                                                icon:[UIImage imageNamed:take_photo_image]];
    
    return rightUtilityButtons;
}

- (NSArray *)leftButtons
{
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.07 green:1.0f blue:1.0f alpha:1.0]
                                                icon:[UIImage imageNamed:develop_image_place]];
   
    
    return leftUtilityButtons;
}
- (void)callBackTitle
{
//    if (_currentBtn.tag==1)
//    {
//        [_currentBtn setButtonNormalTile:@"区域"];
//        
//    }
//    else if(_currentBtn.tag==2)
//    {
//        [_currentBtn setButtonNormalTile:@"价格"];
//    }
//    else if (_currentBtn.tag==3)
//    {
//        [_currentBtn setButtonNormalTile:@"更多"];
//    }
}
#pragma mark --小区点击

-(void)estateClick:(UIButton *)sender
{
    NSLog(@"小区");
    
    [self callBackTitle];
    NSIndexPath * index = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    
    CustomCell * cell  = (CustomCell *)[self.tableView cellForRowAtIndexPath:index];
    
    NSLog(@"%@",cell.districtNameLable.text);
   
    self.cacheDistrictString = cell.districtNameLable.text;
    
    PL_PROGRESS_SHOW;
    
   
    [[MyRequest defaultsRequest] getRoomInfoEasterList:[self allDataTableSelect_refresh:1] backInfoMessage:^(NSMutableArray *array) {
        PL_PROGRESS_DISMISS;
        [self.tableView headerEndRefreshing];
        if (array.count==0)
        {
            
            self.tableView.backgroundView =alertLable;
            [self.tableView reloadData];
            return ;
        }
        if ([[array firstObject] isKindOfClass:[NSString class]])
        {
            if ([[array firstObject] isEqualToString:@"NOLOGIN"])
            {
                ViewController * login = [[ViewController alloc]init];
                [self.navigationController pushViewController:login animated:YES];
            }
            
            
        }
        else
        {
            resultArray = [NSMutableArray arrayWithArray:array];
            self.cacheArray = [NSMutableArray arrayWithArray:resultArray];
            
            
            [self.tableView reloadData];
            self.tableView.backgroundView =nil;
           
            
            
        }
        
        
    }];

   
   
   
    

}

#pragma mark --所有筛选条件
- (RoomData *)allDataTableSelect_refresh:(NSInteger )count_num

{
    RoomData * roomdata = [[RoomData alloc]init];
      if (self.cacheEstateName.length)
        {
            roomdata.roomDistrictName =self.cacheEstateName;
        }
        else
        {
            roomdata.roomDistrictName =@"";
        }

    
    if (self.govAreaString.length) {
        roomdata.roomAreaName =self.govAreaString;
    }
    else
    {
        if (self.cacheAreaName.length)
        {
            roomdata.roomAreaName =self.cacheAreaName;
        }
        else
        {
            roomdata.roomAreaName =@"";
        }
        
    }

    if ([textField.text isEqualToString:@""]) {
        
        if (self.cacheDistrictString.length)
        {
            roomdata.roomEasterName = self.cacheDistrictString;
            
        }
        else
        {
            roomdata.roomEasterName = @"";
        }
 
    }
    else
    {
        
        roomdata.roomEasterName =textField.text;
          NSLog(@">>>>>>>>>++++%@",textField.text);
    }

//    roomdata.roomEasterName= self.cacheDistrictString;
//    NSLog(@"+++++++++++++++++%@",roomdata.roomEasterName);
    if (self.tradeString.length)
    {
        roomdata.roomTrade = self.tradeString;
        if (priceFrom.length) {
            roomdata.roomPriceFrom=priceFrom;
        }
        else
        {
            roomdata.roomPriceFrom=@"";
        }
        if (priceTo.length) {
            if ([priceTo isEqualToString:@"以上"]) {
                 roomdata.roomPriceTo =   @"";
            }else
            {
                roomdata.roomPriceTo=priceTo;
            }
        }
        else
        {
            roomdata.roomPriceTo =   @"";
        }
        if (rentPriceFrom.length) {
            roomdata.roomRentPriceFrom = rentPriceFrom;
        }
        else
        {
            roomdata.roomRentPriceFrom = @"";
        }
        if (rentPriceTo.length) {
            if ([rentPriceTo isEqualToString:@"以上"]) {
                rentPriceTo = @"";
            }
            roomdata.roomRentPriceTo= rentPriceTo;
        }
        else
        {
            roomdata.roomRentPriceTo= @"";
        }
        
    }
    else
    {
        roomdata.roomTrade = @"";
        roomdata.roomPriceFrom = @"";
        roomdata.roomPriceTo = @"";
        roomdata.roomRentPriceFrom = @"";
        roomdata.roomRentPriceTo = @"";
    }

    
    roomdata.roomCountF= @"";
    roomdata.roomSquareFrom = @"";
    roomdata.roomSquareTo = @"";
    roomdata.roomPropertyId = @"";
    roomdata.roomUserID = [PL_USER_STORAGE objectForKey:PL_USER_NAME];
    roomdata.roomToken = [PL_USER_STORAGE objectForKey:PL_USER_TOKEN];
  //  roomdata.roomStartIndex = @"1";
//    if (self.cacheStorage.length)
//    {
//        roomdata.roomStartIndex = [NSString stringWithFormat:@"%@",@"1" ];
//    }
//    else
//    {
        roomdata.roomStartIndex = [NSString stringWithFormat:@"%ld",(long)count_num ];
        
       
        
        
//    }
    roomdata.roomPageSize = @"10";
    roomdata.roomMode = @"2";
   
    if (self.cacheStorage.length)
    {
         roomdata.roomMode = self.cacheStorage;
    }
    else
    {
        roomdata.roomIpMode =@"";
        
    }
    roomdata.roomFiveYearsOnlyOne = @"";
    roomdata.roomHouseKey = @"";
    roomdata.roomHouseMarks = @"";
    //房屋类型，高层。。。
    if (propertyTypeAccept.length)
    {
        roomdata.roomPropertyType =propertyTypeAccept;
    }
    else
    {
        roomdata.roomPropertyType = @"";
    }
    //房屋朝向
    if(propertyDirectionStr.length)
    {
        roomdata.propertyDirection = propertyDirectionStr;
    }
    else
    {
        roomdata.propertyDirection = @"";
    }
    //房屋现状
    if(propertyOccupyStr.length)
    {
        roomdata.propertyOccupy = propertyOccupyStr;
    }
    else
    {
        roomdata.propertyOccupy = @"";
    }
    //签赔
    if(propertyTrustStr.length)
    {
        roomdata.propertyTrust = propertyTrustStr;
    }
    else
    {
        roomdata.propertyTrust = @"";
    }
    //业主联系电话
    if(custTelStr.length)
    {
        roomdata.custTel = custTelStr;
    }
    else
    {
        roomdata.custTel = @"";
    }
    //室
    if(roomCountFStr.length)
    {
        roomdata.roomCountF = roomCountFStr;
    }
    else
    {
        roomdata.roomCountF = @"";
    }
    //厅
    if(roomCountTStr.length)
    {
        roomdata.roomCountT = roomCountTStr;
    }
    else
    {
        roomdata.roomCountT = @"";
    }
    //物业归属
    if(propertyOwn1Str.length)
    {
        roomdata.propertyOwn1 = propertyOwn1Str;
    }
    else
    {
        roomdata.propertyOwn1 = @"";
    }
    //建筑面积F
    if(roomSquareFromStr.length)
    {
        roomdata.roomSquareFrom = roomSquareFromStr;
    }
    else
    {
        roomdata.roomSquareFrom = @"";
    }
    //建筑面积T
    if(roomSquareToStr.length)
    {
        roomdata.roomSquareTo = roomSquareToStr;
    }
    else
    {
        roomdata.roomSquareTo = @"";
    }
    //建筑面积T
    if(roomSquareToStr.length)
    {
        roomdata.roomSquareTo = roomSquareToStr;
    }
    else
    {
        roomdata.roomSquareTo = @"";
    }
    //房源类型
    if(tradeStr.length)
    {
        roomdata.trade = tradeStr;
    }
    else
    {
        roomdata.trade = @"";
    }
//    //房源类型
//    if(userCodeStr.length)
//    {
//        roomdata.userCode = userCodeStr;
//    }
//    else
//    {
//        roomdata.userCode = @"";
//    }
   
       //委托状态
    if (jiaoYiTypeAccept.length)
    {
        if ([jiaoYiTypeAccept isEqualToString:@"有效"]) {
            roomdata.roomJiaoYiType =@"";
            roomdata.userCode = userCodeStr;
            roomdata.status1 = jiaoYiTypeAccept;
            //筛选委托状态为有效时-时间
            if(statusLimitStr.length)
            {
                if ([statusLimitStr isEqualToString:@"自定义"]) {
                    roomdata.statusLimit = @"";
                    //筛选委托状态为有效时-自定义时间F
                    if(effectiveDateFromStr.length)
                    {
                        roomdata.effectiveDateFrom = effectiveDateFromStr;
                    }
                    else
                    {
                        roomdata.effectiveDateFrom = @"";
                    }
                    //筛选委托状态为有效时-自定义时间T
                    if(effectiveDateToStr.length)
                    {
                        roomdata.effectiveDateTo = effectiveDateToStr;
                    }
                    else
                    {
                        roomdata.effectiveDateTo = @"";
                    }
                }
                else
                {
                    if([statusLimitStr isEqualToString:@"全部"]||[statusLimitStr isEqualToString:@"请选择"])
                    {
                         roomdata.statusLimit = @"";
                    }
                    else
                    {
                        if ([statusLimitStr isEqualToString:@"当天"]) {
                            statusLimitStr = @"0";
                        }
                        else if([statusLimitStr isEqualToString:@"3天"])
                        {
                            statusLimitStr = @"3";

                        }
                        else if([statusLimitStr isEqualToString:@"7天"])
                        {
                            statusLimitStr = @"7";
                        }
                        else if([statusLimitStr isEqualToString:@"10天"])
                        {
                            statusLimitStr = @"10";
                        }
                        roomdata.statusLimit = statusLimitStr;

                    }
                    roomdata.effectiveDateFrom = @"";
                    roomdata.effectiveDateTo = @"";


                }
            }
            else
            {
                roomdata.statusLimit = @"";
                roomdata.effectiveDateFrom = @"";
                roomdata.effectiveDateTo = @"";
            }

        }
        else
        {
            roomdata.roomJiaoYiType = jiaoYiTypeAccept;
            roomdata.status1 =@"";
            roomdata.statusLimit = @"";
            roomdata.effectiveDateFrom = @"";
            roomdata.effectiveDateTo = @"";
            roomdata.userCode = @"";
        }
    }
    else
    {
        roomdata.roomJiaoYiType = @"";
        roomdata.status1 = @"";
        roomdata.statusLimit = @"";
        roomdata.effectiveDateFrom = @"";
        roomdata.effectiveDateTo = @"";
        roomdata.userCode = @"";

    }
    
    //有图无图
    if (imageTypeAccept.length)
    {
        if([imageTypeAccept isEqualToString:@"无图"])
        {
         roomdata.roomImageType = @"0";
        }
        else if([imageTypeAccept isEqualToString:@"有图"])
        {
        roomdata.roomImageType = @"1";
        }
       
    }
    else
    {
        roomdata.roomImageType = @"";
    }
    
    if (_roomBuildingNum.length>0)
    {
        roomdata.roomBuildingName=_roomBuildingNum;
       
    }
    else
    {
        roomdata.roomBuildingName=@"";
       
    }
    if (_roomRoomNum.length>0)
    {
        
        roomdata.roomROOMNO=_roomRoomNum;
    }
    else
    {
       
        roomdata.roomROOMNO=@"";
        
    }
    roomdata.address = @"";
    
//    roomdata.recommend = @"";
//    roomdata.fastsell = @"";
//    roomdata.school = @"";
    roomdata.recommend = self.filterDic[@"经理推荐"];
    roomdata.fastsell = self.filterDic[@"急售"];
    roomdata.school   = self.filterDic[@"学区房"];
    roomdata.TwoYears=self.filterDic[@"满二年"];
    roomdata.Exclusive=self.filterDic[@"独家"];
    roomdata.roomHouseKey=self.filterDic[@"钥匙"];

    NSLog(@"%@",self.filterDic);
    NSLog(@"---------%@----------",self.filterDic[@"经理推荐"]);
    //新加的地址字段
    if (self.cacheAddress.length)
    {
        roomdata.roomAddress   =self.cacheAddress;
    }
    else
    {
        roomdata.roomAddress =@"";
    }

    NSLog(@"<<<<<<%@",roomdata);
    
       return roomdata;
    

}


-(void)photoClick:(UIButton *)button
{
    imageCurrentID = button.tag;
    NSLog(@"%ld",imageCurrentID);
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"使用手机相册",@"打开相机拍照" ,nil];
    [actionSheet showInView:self.view];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
}
- (void)action:(NSNotification *)not
{
    NSLog(@"写跟进");
    //背景
    bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT)];
    bgView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
    
    [self.view addSubview:bgView];
    //小背景
    smallView=[[UIView alloc]initWithFrame:CGRectMake(20, PL_HEIGHT/3, PL_WIDTH-40, 200)];
    smallView.alpha=1;
    smallView.backgroundColor=[UIColor whiteColor];
    [bgView addSubview:smallView];
    
    
    //标题
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(PL_WIDTH/2-80, 5, 200, 30)];
    title.text=@"录入跟进信息";
    [smallView  addSubview:title];
    //跟进方式、按钮
    UIButton *FSBtn=[[UIButton alloc]initWithFrame:CGRectMake(20+20, 30, 80, 30)];
    FSBtn.highlighted = YES;
    [FSBtn addTarget:self action:@selector(fangshiClick:) forControlEvents:UIControlEventTouchUpInside];
    //FSBtn.backgroundColor=[UIColor redColor];
    [smallView addSubview:FSBtn];
    
    fangshi=[[UILabel alloc]initWithFrame:CGRectMake(20+20, 35, 50, 20)];
    fangshi.text=@"跟进方式";
    fangshi.font=[UIFont systemFontOfSize:12];
    [smallView addSubview:fangshi];
    fangshiBtn=[[UIButton alloc]initWithFrame:CGRectMake(71+20, 40, 10, 10)];
    [fangshiBtn addTarget:self action:@selector(fangshiClick:) forControlEvents:UIControlEventTouchUpInside];
    [fangshiBtn setImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    [fangshiBtn setImage:[UIImage imageNamed:@"dropup.png"] forState:UIControlStateSelected];
    [smallView addSubview:fangshiBtn];
    //跟进类型、按钮
    UIButton *STBtn=[[UIButton alloc]initWithFrame:CGRectMake(120+40, 30, 80, 30)];
    STBtn.highlighted = YES;
    [STBtn addTarget:self action:@selector(styleClickList:) forControlEvents:UIControlEventTouchUpInside];
    //STBtn.backgroundColor=[UIColor redColor];
    [smallView addSubview:STBtn];
    style=[[UILabel alloc]initWithFrame:CGRectMake(120+40, 35, 50, 20)];
    style.text=@"跟进类型";
    style.font=[UIFont systemFontOfSize:12];
    [smallView addSubview:style];
    styleBtn=[[UIButton alloc]initWithFrame:CGRectMake(171+40, 40, 10, 10)];
    [styleBtn setImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    [styleBtn setImage:[UIImage imageNamed:@"dropup.png"] forState:UIControlStateSelected];
    [styleBtn addTarget:self action:@selector(styleClickList:) forControlEvents:UIControlEventTouchUpInside];
    
    [smallView addSubview:styleBtn];
    //跟进方式
    NSMutableArray * arrTitleRoom = [NSMutableArray arrayWithObjects:@"电话",@"手机",@"微信",@"QQ",@"其他", nil];
    colView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMidX(fangshi.frame)-8, CGRectGetMaxY(fangshiBtn.frame)+5, 80, 30*arrTitleRoom.count)];
    UIImageView * viewBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"black.png"]];
    viewBg.frame = CGRectMake(0, 0, CGRectGetWidth(colView.frame), CGRectGetHeight(colView.frame));
    [colView addSubview:viewBg];
    for (int i=0; i<arrTitleRoom.count; i++)
    {
        UIImageView * sousuoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,i*28+36, 80, 0.5)];
        sousuoImage.image = [UIImage imageNamed:@"black_in_hengxian.png"];
        sousuoImage.backgroundColor = [UIColor clearColor];
        [colView addSubview:sousuoImage];
    }
    
    for (int j=0; j<arrTitleRoom.count; j++)
    {
        UIButton * buttonLable = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonLable.frame = CGRectMake(0, j*28+15, 80, 20);
        //buttonLable.backgroundColor = [UIColor clearColor];
        buttonLable.titleLabel.font=[UIFont systemFontOfSize:13];
        [buttonLable setTitle:[arrTitleRoom objectAtIndex:j] forState:UIControlStateNormal];
        [buttonLable setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        buttonLable.tag =2500+j;
        [buttonLable addTarget:self action:@selector(buttonClicklie:) forControlEvents:UIControlEventTouchUpInside];
        [colView addSubview:buttonLable];
    }
    sousuoViewstyle = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMidX(style.frame)-8, CGRectGetMaxY(styleBtn.frame)+5, 90, 80+40)];
    UIImageView * leixingIMge = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"black.png"]];
    leixingIMge.frame = CGRectMake(0, 0, CGRectGetWidth(sousuoViewstyle.frame), CGRectGetHeight(sousuoViewstyle.frame));
    [sousuoViewstyle addSubview:leixingIMge];
    tableVeiwList=[[UITableView alloc]initWithFrame:CGRectMake(0, 7, CGRectGetWidth(sousuoViewstyle.frame), 80+40-7) style:UITableViewStylePlain];
    tableVeiwList.delegate=self;
    tableVeiwList.dataSource=self;
    tableVeiwList.tag = 1991;
    tableVeiwList.rowHeight = 30;
    tableVeiwList.separatorColor = [UIColor grayColor];
    tableVeiwList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    tableVeiwList.separatorInset = UIEdgeInsetsZero;
    tableVeiwList.backgroundColor=[UIColor clearColor];
    
    [sousuoViewstyle addSubview:tableVeiwList];
    if ([tableVeiwList respondsToSelector:@selector(setSeparatorInset:)])
    {
        tableVeiwList.separatorInset = UIEdgeInsetsZero;
        
    }
    if ([tableVeiwList respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableVeiwList setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    //输入框
    textView=[[UITextView alloc]initWithFrame:CGRectMake(20, 55, PL_WIDTH-40-40, 100)];
    textView.layer.borderWidth=1.5;
    textView.layer.borderColor = [UIColor grayColor].CGColor;
    textView.delegate=self;
    [smallView addSubview:textView];
    
    placeholder=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH-40, 30)];
    placeholder.text=@"请输入跟进内容";
    placeholder.textColor=[UIColor grayColor];
    placeholder.font=[UIFont systemFontOfSize:13];
    //placeholder.hidden=YES;
    [textView addSubview:placeholder];
    
    //统计
    count=[[UILabel alloc]initWithFrame:CGRectMake(25, 157, 100, 20)];
    count.text=[NSString stringWithFormat:@"0/100"];
    [smallView addSubview:count];
    //确认按钮
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH-135, 150+10, 77, 30)];
    //button.backgroundColor=[UIColor redColor];
    [button setImage:[UIImage imageNamed:@"提交按钮.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [smallView addSubview:button];
}

-(void)turnNextPage:(UIButton *)button
{
    indextag1 = button.tag;
    NSString *indexStr = [NSString stringWithFormat:@"%ld",button.tag];
    [[NSUserDefaults standardUserDefaults] setObject:indexStr forKey:@"indextag1"];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"sunH" object:nil];
}
//genjinfangshi
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
   
}
-(void)buttonClicklie:(UIButton *)sender
{
    fangshiBtn.selected=NO;
    switch (sender.tag) {
        case 2500:
        {
            fangshi.text=@"电话";
            [colView removeFromSuperview];
        }
            break;
        case 2501:
        {
            fangshi.text=@"手机";
            [colView removeFromSuperview];
        }
            break;
        case 2502:
        {
            fangshi.text=@"微信";
            [colView removeFromSuperview];
        }
            break;
        case 2503:
        {
            fangshi.text=@"QQ";
            [colView removeFromSuperview];
        }
            break;
        case 2504:
        {
            fangshi.text=@"其他";
            [colView removeFromSuperview];
        }
            break;
        default:
            break;
    }
}

#pragma mark---UITextView  Delegate
- (void)textViewDidChange:(UITextView *)textView1
{
    
  
    if (textView1.text.length >BOOKMARK_WORD_LIMIT)
    {
        textView.text = [textView1.text substringToIndex:BOOKMARK_WORD_LIMIT];
        
    }
    else
    {
        count.text=[NSString stringWithFormat:@"%ld/100",(unsigned long)textView.text.length];
    }
}
-(BOOL)textView:(UITextView *)textView1 shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text1
{
    if (![[NSString stringWithFormat:@"%@",text1] isEqualToString:@""])
        
    {
        
        placeholder.hidden = YES;
        
    }
    
    if ([text1 isEqualToString:@""] && range.location == 0 && range.length == 1)
        
    {
        
        placeholder.hidden = NO;
        
    }
    NSString * str = [NSString stringWithFormat:@"%@%@",textView1.text,text1];
    if (str.length >BOOKMARK_WORD_LIMIT)
    {
        textView.text = [textView.text substringToIndex:BOOKMARK_WORD_LIMIT];
        return NO;
    }
    else
    {
        count.text=[NSString stringWithFormat:@"%ld/100",(unsigned long)str.length];
    }
    
    
      return YES;
    
}




#pragma mark - 判断跟进信息是否是电话号码
- (BOOL)validateNumber:(NSString *) textString
{
    NSString * number = @"(\\d+){8,}(\\w+|\\D+|\\w+\\D+|\\D+\\w|)";
    NSString * number2 = @"(\\w+|\\D|\\w+\\D|\\D+\\w+|\\w+\\D+\\w|\\D+\\w+\\D+)(\\d+){8,}";
    NSString * number3 = @"(\\w+|\\D|\\w+\\D+|\\D+\\w)(\\d+){8,}(\\w+|\\D+|\\D+\\w+|\\w+\\D+)";
    NSLog(@"%@",number);
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    NSPredicate *numberPre2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number2];
    
    NSPredicate *numberPre3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number3];
    
    return [numberPre evaluateWithObject:textString] || [numberPre2 evaluateWithObject:textString] || [numberPre3 evaluateWithObject:textString];

}

#pragma mark ---确认按钮
-(void)sureClick
{
    [textView resignFirstResponder];
    NSLog(@"-------");
    if ([fangshi.text isEqualToString:@"跟进方式"]&&[style.text isEqualToString:@"跟进类型"]&&[textView.text isEqualToString:@""]) {
        PL_ALERT_SHOW(@"跟进方式、跟进类型、跟进内容不能为空");
    }else if([style.text isEqualToString:@"跟进类型"]&&[textView.text isEqualToString:@""]){
        PL_ALERT_SHOW(@"跟进类型、跟进内容不能为空");
    }
    else if([fangshi.text isEqualToString:@"跟进方式"]&&[textView.text isEqualToString:@""]){
        PL_ALERT_SHOW(@"跟进方式、跟进内容不能为空");
    }else if([fangshi.text isEqualToString:@"跟进方式"]&&[style.text isEqualToString:@"跟进类型"]){
        PL_ALERT_SHOW(@"跟进方式、跟进类型不能为空");
    }else if([fangshi.text isEqualToString:@"跟进方式"]){
        PL_ALERT_SHOW(@"跟进方式不能为空");
    }else if([style.text isEqualToString:@"跟进类型"]){
        PL_ALERT_SHOW(@"跟进类型不能为空");
    }else if([textView.text isEqualToString:@""]){
        PL_ALERT_SHOW(@"跟进内容不能为空");
    }else if ([self validateNumber:textView.text]){
        PL_ALERT_SHOW(@"输入的内容不能含有电话号码");

    }
    else{
        [textView resignFirstResponder];
        ADDPropertyContactData *follow = [[ADDPropertyContactData alloc] init];
        NSString *strIndex = [[NSUserDefaults standardUserDefaults]objectForKey:@"indextag1"];
        RoomData *room = [resultArray objectAtIndex:strIndex.integerValue];
        follow.PropertyId = room.roomPropertyId;
//        follow.PropertyId = [[NSUserDefaults standardUserDefaults]objectForKey:@"PropertyId"];
        follow.FollowType = style.text;
        follow.Content = textView.text;
        follow.FollowWay = fangshi.text;
        follow.followID = [[NSUserDefaults standardUserDefaults]objectForKey:@"ROOMFOLLOWID"];
        follow.userid = [[NSUserDefaults standardUserDefaults] objectForKey:PL_USER_NAME];
        follow.token = [[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
         NSLog(@"%@  %@  %@  %@  %@  %@",follow.PropertyId,follow.FollowType,follow.Content,follow.FollowWay,follow.userid,follow.token);
            [[MyRequest defaultsRequest] addPropertyContact:follow backInfoMessage:^(NSMutableString *string) {
                if ([string isEqualToString:@"NOLOGIN"]) {
                    ViewController *login = [[ViewController alloc] init];
                    [self.navigationController popToViewController:login animated:YES];
                }
                else if ([string isEqualToString:@"OK"])
                {
                    PL_ALERT_SHOWNOT_OKAND_YES(@"提交成功");
                    [bgView removeFromSuperview];

                }
                else if ([string isEqualToString:@"ERR"])
                {
                    PL_ALERT_SHOW(@"提交失败");
                }else
                {
                    PL_ALERT_SHOW(@"提交内容有敏感词汇!");
                }
            }];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"ROOMFOLLOWID"];
            }
        
}
//    if ([fangshi.text isEqualToString:@"跟进方式"]||[style.text isEqualToString:@"跟进类型"]||[text.text isEqualToString:@""]) {
//        PL_ALERT_SHOW(@"跟进内容或跟进内容或跟进类型不能为空");
//    }else
//    {
//        ADDPropertyContactData *follow=[[ADDPropertyContactData alloc]init];
//        follow.PropertyId=[[NSUserDefaults standardUserDefaults]objectForKey:@"PropertyId"];
//        
//        if ([style.text isEqualToString:@"跟进类型"])
 //       {
//            follow.FollowType=@"";
//            //PL_ALERT_SHOW(@"跟进类型不能为空");
//            
//        }else
//        {
//            follow.FollowType=style.text;
//        }
//        
//        follow.Content=text.text;
//        
//        
//        if ([fangshi.text isEqualToString:@"跟进方式"]) {
//            follow.FollowWay=@"";
//            // PL_ALERT_SHOW(@"跟进方式不能为空");
//        }else{
//            follow.FollowWay=fangshi.text;
//        }
//        
//        
//        follow.userid=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
//        follow.token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
//        NSLog(@"%@  %@  %@  %@  %@  %@",follow.PropertyId,follow.FollowType,follow.Content,follow.FollowWay,follow.userid,follow.token);
//        
//        [[MyRequest defaultsRequest]addPropertyContact:follow backInfoMessage:^(NSMutableString *string) {
//            if ([string isEqualToString:@"NOLOGIN"]) {
//                ViewController *login=[[ViewController alloc]init];
//                [self.navigationController popToViewController:login animated:YES];
//            }
//            NSLog(@"string==%@",string);
//            PL_ALERT_SHOWNOT_OKAND_YES(string);
//            
//                   }];
//        [bgView removeFromSuperview];
//    }
//   
//    


#pragma mark----跟进fs
-(void)fangshiClick:(UIButton *)sender
{
    sender.selected=!sender.selected;
    if (sender.selected) {
        fangshiBtn.selected=YES;
        [smallView addSubview:colView];
        
    }
    else
    {
        fangshiBtn.selected=NO;
        [colView removeFromSuperview];
        
    }
    
         
}
#pragma mark---跟进类型---
-(void)styleClickList:(UIButton *)sender
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
            [tableVeiwList reloadData];
            [smallView addSubview:sousuoViewstyle];
        } userid:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME] token:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN]];
        
    }else{
        styleBtn.selected=NO;
        [sousuoViewstyle removeFromSuperview];
    }
}

-(void)callPhoneNumber:(UIButton *)button
{
        RoomData * rroom=[resultArray objectAtIndex:button.tag];
        NSString *indexStr = [NSString stringWithFormat:@"%ld",button.tag];
        [[NSUserDefaults standardUserDefaults] setObject:indexStr forKey:@"indextag1"];
        telNumArray = [rroom.roomOwnerTel componentsSeparatedByString:@","];
        TelViewAlert * alert = [[TelViewAlert alloc]initWithconnectWithArray:telNumArray Calltype:callType_Room custId:rroom.roomPropertyId];
        alert.stringTitle = [NSString stringWithFormat:@"%@",rroom.roomonerName];
            [alert showTelWindow:self.view];

    
}
-(int)numberOfItemsInActionSheet
{
    return 7;
}

-(AWActionSheetCell *)cellForActionAtIndex:(NSInteger)index
{
//    NSArray * imageArr = @[[UIImage imageNamed:@"卧室.png"],[UIImage imageNamed:@"客厅.png"],[UIImage imageNamed:@"厨房.png"],[UIImage imageNamed:@"卫生间.png"],[UIImage imageNamed:@"阳台.png"],[UIImage imageNamed:@"户型图.png"],[UIImage imageNamed:@"其他.png"]];
    NSArray * imageArray= @[@"卧室.png",@"客厅.png",@"厨房.png",@"卫生间.png",@"阳台.png",@"户型图.png",@"其他.png"];
    AWActionSheetCell* cell = [[AWActionSheetCell alloc] init];
    cell.iconView.image = [UIImage imageNamed:imageArray[index]];
    cell.index = (int)index;
    return cell;
}
-  (void)DidTapOnItemAtIndex:(NSInteger)index title:(NSString *)name
{
    NSLog(@"tap on %d--- titl%@",(int)index,name);
    NSArray * titleArr = @[@"卧室",@"客厅",@"厨房",@"卫生间",@"阳台",@"户型图",@"其他"];
    _photoCacheType = titleArr[index];
    
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"使用手机相册",@"打开相机拍照" ,nil];
    [actionSheet showInView:self.view];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
}

-(void)uploadImage:(UITapGestureRecognizer * )tap
{
    NSLog(@"上传图片  %ld",(long)tap.view.tag);
   
    AWActionSheet *sheet = [[AWActionSheet alloc] initWithIconSheetDelegate:self ItemCount:[self numberOfItemsInActionSheet]];
    [sheet show];
  }
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0 :
            NSLog(@"打开系统相册");
            [self openPhoto];
            
            break;
        case 1 :
            NSLog(@"打开照相机");
            [self openCarama];
            break;
            
        default:
            break;
    }
}
//打开系统相册
-(void)openPhoto
{
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
       picker.delegate = self;
   
    
     [self presentViewController:picker animated:YES completion:^{
    
   }];
    [self.view addSubview:picker.view];
}
//打开照相机
-(void)openCarama
{
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
   
    picker.delegate = self;
   picker.allowsEditing = YES;
    
     [self presentViewController:picker animated:YES completion:^{
    
    }];
     [self.view addSubview:picker.view];
}
#pragma mark --上传图片
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
        NSString * type = [info objectForKey:UIImagePickerControllerMediaType];
    //当前选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转换成data
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSData * data=nil;
        
        if (UIImagePNGRepresentation(image)==nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }else
        {
            data = UIImagePNGRepresentation(image);
            
        }
        //图片保存路径
        NSString * DocumentsImage = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        //文件管理器
        NSFileManager * filemanager = [NSFileManager defaultManager];
        //保存刚刚存储的图片信息
        [filemanager createDirectoryAtPath:DocumentsImage withIntermediateDirectories:YES attributes:nil error:nil];
        [filemanager createFileAtPath:[DocumentsImage stringByAppendingString:@"/image.png"] contents:data attributes:nil];
      filePathImage = [[NSString alloc]initWithFormat:@"%@%@",DocumentsImage,@"/image.png"];
     UIImage * baseImage = [UIImage imageWithContentsOfFile:filePathImage];
    UIImage * imagess = [self imageWithImage:baseImage scaledToSize:CGSizeMake(600,450)];
        
        NSLog(@"%@",NSStringFromCGSize(baseImage.size));
        UIImage * cellImage =(UIImage *) [self.view viewWithTag:imageCurrentID];
        cellImage = imagess;
        
        NSData * daImage = UIImagePNGRepresentation(imagess);
        NSData * iamgeData = [daImage base64EncodedDataWithOptions:0];
        NSString * lipeng = [[NSString alloc]initWithData:iamgeData encoding:NSUTF8StringEncoding];
            RoomData * roomContent = resultArray[_currentNum];
        dispatch_async(dispatch_get_main_queue(), ^{
            
       
            
            if ([_photoCacheType isEqualToString:@"卧室"])
            {
                if (roomContent.roomImageContent)
                {
                    PL_PROGRESS_IMAGE;
                    [[MyRequest defaultsRequest]getImageInfo:[NSString stringWithFormat:@"%@",self.cellProperID] proMode:@"1" userID:[PL_USER_STORAGE objectForKey:PL_USER_NAME] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] callBack:nil string:^(NSString *str) {
                        PL_PROGRESS_DISMISS;

                        NSLog(@"current = %ld",imageCurrentID);
                        if ([str isEqualToString:@"OK"])
                        {
                            
                            [[MyRequest defaultsRequest]uploadImage:[NSString stringWithFormat:@"%@",self.cellProperID] type:_photoCacheType phovalue:@"房源" photoValue:@"1" imagebytes:lipeng userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] string:^(NSString *str) {
                                [self  loadTableData:nil];
                                NSLog(@"%@",str);
                                if ([str isEqualToString:@"OK"])
                                {
                                    PL_ALERT_SHOW(@"图片网上业务发展部审核中.....");
                                }
                                else if ([str isEqualToString:@"ERRSIZE"])
                                {
                                    PL_ALERT_SHOW(@"上传失败,图片大小不正确");
                                }
                                else
                                {
                                    PL_ALERT_SHOW(@"上传失败");
                                    
                                }
                            }];
                            
                        }
                    }];
                    
                }
                else
                {
                    NSLog(@"%@",lipeng);
                    PL_PROGRESS_IMAGE;
                    [[MyRequest defaultsRequest]uploadImage:[NSString stringWithFormat:@"%@",self.cellProperID] type:_photoCacheType phovalue:@"房源" photoValue:@"1" imagebytes:lipeng userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] string:^(NSString *str) {
                        [self loadTableData:nil];
                        NSLog(@"%@",str);
                        PL_PROGRESS_DISMISS;
                        if ([str isEqualToString:@"OK"])
                        {
                            PL_ALERT_SHOW(@"图片网上业务发展部审核中.....");
                        }
                        else if ([str isEqualToString:@"ERRSIZE"])
                        {
                            PL_ALERT_SHOW(@"上传失败,图片大小不正确");
                        }
                        else
                        {
                            PL_ALERT_SHOW(@"上传失败");
                            
                        }
                    }];
                    
                }

            }
            else
            {
                if (roomContent.roomImageContent)
                {
                    PL_PROGRESS_IMAGE;
                    [[MyRequest defaultsRequest]getImageInfo:[NSString stringWithFormat:@"%@",self.cellProperID] proMode:@"1" userID:[PL_USER_STORAGE objectForKey:PL_USER_NAME] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] callBack:nil string:^(NSString *str) {
                        NSLog(@"current = %ld",imageCurrentID);
                        PL_PROGRESS_DISMISS;
                        if ([str isEqualToString:@"OK"])
                        {
                            [[MyRequest defaultsRequest]uploadImage:[NSString stringWithFormat:@"%@",self.cellProperID] type:_photoCacheType phovalue:@"房源" photoValue:@"1" imagebytes:lipeng userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] string:^(NSString *str) {
                                 [self  loadTableData:nil];
                                NSLog(@"%@",str);
                                if ([str isEqualToString:@"OK"])
                                {
                                    PL_ALERT_SHOW(@"图片网上业务发展部审核中.....");
                                }
                                else if ([str isEqualToString:@"ERRSIZE"])
                                {
                                    PL_ALERT_SHOW(@"上传失败,图片大小不正确");
                                }
                                else
                                {
                                    PL_ALERT_SHOW(@"上传失败");
                                    
                                }
                            }];
                            
                        }
                    }];
                    
                }
                else
                {
                    NSLog(@"%@",lipeng);
                    PL_PROGRESS_IMAGE;
                    [[MyRequest defaultsRequest]uploadImage:[NSString stringWithFormat:@"%@",self.cellProperID] type:_photoCacheType phovalue:@"房源" photoValue:@"1" imagebytes:lipeng userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] string:^(NSString *str) {
                         [self  loadTableData:nil];
                        NSLog(@"%@",str);
                        PL_PROGRESS_DISMISS;
                        if ([str isEqualToString:@"OK"])
                        {
                            PL_ALERT_SHOW(@"图片网上业务发展部审核中.....");
                        }
                        else if ([str isEqualToString:@"ERRSIZE"])
                        {
                            PL_ALERT_SHOW(@"上传失败,图片大小不正确");
                        }
                        else
                        {
                            PL_ALERT_SHOW(@"上传失败");
                            
                        }
                    }];
                }
            }
 
        });
   
         [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark --请求列表数据封装
- (void)requestListPropertyData
{
    PL_PROGRESS_SHOW;
    
    NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
        [[MyRequest defaultsRequest] getRoomInfoEasterList:[self allDataTableSelect_refresh:1] backInfoMessage:^(NSMutableArray *array) {
            PL_PROGRESS_DISMISS;
            if ([[array firstObject] isKindOfClass:[NSString class]])
            {
                if ([[array firstObject] isEqualToString:@"NOLOGIN"])
                {
                    ViewController * login = [[ViewController alloc]init];
                    [self.navigationController pushViewController:login animated:YES];
                }else{
                    [resultArray removeAllObjects];
                    
                    self.label.hidden = NO;
                    [self.tableView reloadData];
                }
                
                
            }
            else
            {
                resultArray = [NSMutableArray arrayWithArray:array];
                self.cacheArray = [NSMutableArray arrayWithArray:resultArray];
                self.label.hidden = YES;
                
                [self.tableView reloadData];
                
                
                
            }
            
            
        }];
        
        
    }];
    [operation start];
    [_tableView2 reloadData];
    
}
#pragma mark --tableViewDelegate


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.label.hidden = YES;
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    [self.filterDic setObject:@"" forKey:@"学区房"];
//    [self.filterDic setObject:@"" forKey:@"急售"];
//    [self.filterDic setObject:@"" forKey:@"经理推荐"];

    
       if (tableView==_tableView1)
    {
        if (_currentBtn.tag==1)
        {
            _tableView2.hidden = YES;
            
            
            if (indexPath.row==0)
            {
                
                NSLog(@"buxian");
                dropBgView.hidden=YES;
                _tableView1.hidden = YES;
                _tableView2.hidden = YES;
                
                [tableButton setTitle:@"所有片区" forState:UIControlStateNormal];
                [_currentBtn setButtonNormalTile:@"所有片区"];
                _currentBtn.titleLabel.text = @"所有片区";
                
                //self.xingzhengqu = @"";
                //self.cacheEstateName = @"";
                self.govAreaString = @"";
                
                
                UIImageView * xiala = (UIImageView *)[self.view viewWithTag:124+_currentBtn.tag];
                xiala.image = [UIImage imageNamed:@"dropdown.png"];
                [self requestListPropertyData];
              
            }
            else
            {
                UITableViewCell * cell =[tableView cellForRowAtIndexPath:indexPath];
                [_currentBtn setTitle:cell.textLabel.text forState:UIControlStateNormal];
                [_currentBtn setButtonNormalTile:cell.textLabel.text];
                _currentBtn.titleLabel.text =cell.textLabel.text;
                UIImageView * xiala = (UIImageView *)[self.view viewWithTag:124+_currentBtn.tag];
                xiala.image = [UIImage imageNamed:@"dropdown.png"];
                dropBgView.hidden=YES;
                _tableView1.hidden = YES;
                roomAreaPlace * area = self.quyuShuzu[indexPath.row-1];
                self.govAreaString = area.areaDistrictName;
               // _tableView2.hidden = YES;
                PL_PROGRESS_SHOW;
                NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
                    [[MyRequest defaultsRequest] getRoomInfoEasterList:[self allDataTableSelect_refresh:1] backInfoMessage:^(NSMutableArray *array) {
                        PL_PROGRESS_DISMISS;
                        if (array && [[array firstObject] isKindOfClass:NSClassFromString(@"NSString")])
                        {
                            
                            if ( [[array firstObject ]isEqualToString:@"NOLOGIN"]) {
                                ViewController * login = [[ViewController alloc]init];
                                [self.navigationController pushViewController:login animated:YES];
                                
                            }
                            else if ([[array firstObject] isEqualToString:@"[]"])
                            {

                                [resultArray removeAllObjects];
                                self.label.hidden = NO;
                                [_tableView reloadData];
//                                PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                                return ;
                            }
                            else if ([[array firstObject] isEqualToString:@"<null>"])
                            {
                                _tableView.backgroundView = alertLable;
                                
                                [_tableView reloadData];
                                PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                                return ;
                            }
                            else
                            {
                                _tableView.backgroundView = alertLable;
                                [_tableView reloadData];
                                PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                                
                                return;
                            }
                        }
                        else if(array.count>0)
                        {
                            NSLog(@"有数据");
                            resultArray = [NSMutableArray arrayWithArray:array];
                            self.cacheArray = [NSMutableArray arrayWithArray:resultArray];
                            
                            
                            [self.tableView reloadData];
                            _tableView.backgroundView = nil;
                            
                        }
                        else
                        {
                            resultArray = [NSMutableArray arrayWithArray:array];
                            _tableView.backgroundView = alertLable;
                            [_tableView reloadData];
                            PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                            
                            return;
                        }
                        
                        
                    }];
                    
                    
                }];
                [operation start];
            }
            
    }
        if (_currentBtn.tag==2)
        {
            NSLog(@"我是2");
           
            
            
            if (indexPath.row==0)
            {
                _tableView1.hidden = YES;
                _tableView2.hidden = YES;
                dropBgView.hidden=YES;
                
                [_currentBtn setButtonNormalTile:@"不  限"];
                _currentBtn.titleLabel.text = @"不  限";
                
               rentPriceFrom = @"";
                rentPriceTo = @"";
                priceFrom = @"";
                priceTo = @"";
                self.tradeString = @"";
               
                
               
                [self loadTableData:nil];
                UIImageView * xiala = (UIImageView *)[self.view viewWithTag:124+_currentBtn.tag];
                xiala.image = [UIImage imageNamed:@"dropdown.png"];
                

                return;
                
            }
            if (indexPath.row==1)
            {
                PriceRangeData * price = [[PriceRangeData alloc]init];
                price.PriceType = @"售价";
               
                self.tradeString = @"出售";
                NSLog(@"%@",self.tradeString);
                
                tradeStringCache =[NSString stringWithFormat:@"%@",price.PriceType];
                
                price.userid = [PL_USER_STORAGE objectForKey:PL_USER_NAME];
                price.token = [PL_USER_STORAGE objectForKey:PL_USER_TOKEN];
               // PL_PROGRESS_SHOW;
                [[MyRequest defaultsRequest]getPriceRange:price backInfoMessage:^(NSMutableString *string) {
                    if (string.length && ![string isEqualToString:@"[]"] && ![string isEqualToString:@"exception"])
                    {
                        SBJSON *json=[[SBJSON alloc]init];
                        self.priceArray=[json objectWithString:string error:nil];
                        [_tableView2 reloadData];
                        
                    }
                    else
                    {
                        PL_ALERT_SHOWNOT_OKAND_YES(string);
                    }
                    
                  //  PL_PROGRESS_DISMISS;
                    
                }];



                
            }
            else  if(indexPath.row==2)
            {
                PriceRangeData * price = [[PriceRangeData alloc]init];
                price.PriceType = @"租价";
                self.tradeString = [NSString stringWithFormat:@"%@",@"出租"];
                //PL_PROGRESS_SHOW;
                price.userid = [PL_USER_STORAGE objectForKey:PL_USER_NAME];
                price.token = [PL_USER_STORAGE objectForKey:PL_USER_TOKEN];
                [[MyRequest defaultsRequest]getPriceRange:price backInfoMessage:^(NSMutableString *string) {
                    if (string.length && ![string isEqualToString:@"[]"] && ![string isEqualToString:@"exception"])
                    
                    {
                        SBJSON *json=[[SBJSON alloc]init];
                        self.priceArray=[json objectWithString:string error:nil];
                        [_tableView2 reloadData];
                    }
                    else
                    {
                        PL_ALERT_SHOWNOT_OKAND_YES(string);
                        
                    }
                   
                   // PL_PROGRESS_DISMISS;
                }];

                
                
                
            }
            else
            {
                
                return;
            }
            
            
        }
       
        if (_currentBtn.tag != 3 ) {
            if (_currentBtn.tag==1)
            {
                 _tableView2.hidden = YES;
            }
            else
            {
                _tableView2.hidden = NO;
                
            }
            [_tableView2 reloadData];
        }
        else
        {
            NSLog(@"我是推荐");
           
            UIImageView * xiala = (UIImageView *)[self.view viewWithTag:124+_currentBtn.tag];
            xiala.image = [UIImage imageNamed:@"dropdown.png"];
            
            [_currentBtn setButtonNormalTile:moreArr[indexPath.row]];
            
            [_currentBtn setTitle:moreArr[indexPath.row] forState:UIControlStateNormal];
            _currentBtn.titleLabel.text =moreArr[indexPath.row];
            
            #pragma mark  更多筛选
            if (indexPath.row==0)
            {
                propertyTypeAccept = @"";
            }
            else
            {
                propertyTypeAccept = moreArr[indexPath.row];
            }
            
       
            
            PL_PROGRESS_SHOW;
            
            [[MyRequest defaultsRequest] getRoomInfoEasterList:[self allDataTableSelect_refresh:1] backInfoMessage:^(NSMutableArray *array) {
                NSLog(@"%ld-----",(unsigned long)array.count);
                
                 PL_PROGRESS_DISMISS;
                if (array && [[array firstObject] isKindOfClass:NSClassFromString(@"NSString")])
                {
                    
                    if ( [[array firstObject ]isEqualToString:@"NOLOGIN"]) {
                        ViewController * login = [[ViewController alloc]init];
                        [self.navigationController pushViewController:login animated:YES];
                        
                    }
                    else if ([[array firstObject] isEqualToString:@"[]"])
                    {
//                        _tableView.backgroundView = alertLable;
//                        
//                        [_tableView reloadData];
                        PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                        return ;
                    }
                    else
                    {
                        _tableView.backgroundView = alertLable;
                        
                        [_tableView reloadData];
                        PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                        
                        return;
                    }
                }
                else if(array.count>0)
                {
                    NSLog(@"有数据");
                    resultArray = [NSMutableArray arrayWithArray:array];
                    self.cacheArray = [NSMutableArray arrayWithArray:resultArray];
                    
                    
                    [self.tableView reloadData];
                    _tableView.backgroundView = nil;
                    return;
                }
                else
                {
                    resultArray = [NSMutableArray arrayWithArray:array];
                    _tableView.backgroundView = alertLable;
                    [_tableView reloadData];
                    PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                    
                    return;
                }
                
               
                
            }];
            
            dropBgView.hidden=YES;
            _tableView1.hidden = YES;
            
            
            
        }
        if (_currentBtn.tag==1)
        {
            if (indexPath.row==0)
            {
                dropBgView.hidden=YES;
                _tableView2.hidden = YES;
                [_tableView2 reloadData];
                
            }
        }
        else if (_currentBtn.tag==2)
        {
            if (indexPath.row==0)
            {
                dropBgView.hidden=YES;
                _tableView2.hidden = YES;
                [_tableView2 reloadData];
                
            }
        }
       
    }
    else if(tableView ==_tableView2)
    {
        
        
        if (_currentBtn.tag==1)
        {
            
            if (indexPath.row==0)
            {
                UIImageView * xiala = (UIImageView *)[self.view viewWithTag:124+_currentBtn.tag];
                xiala.image = [UIImage imageNamed:@"dropdown.png"];
               
                [_currentBtn setTitle:@"所有片区" forState:UIControlStateNormal];
                [_currentBtn setButtonNormalTile:@"所有片区"];
                _currentBtn.titleLabel.text = @"所有片区";
                
               
                self.cacheAreaName = @"";
                
                PL_PROGRESS_SHOW;
                
                NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
                    [[MyRequest defaultsRequest] getRoomInfoEasterList:[self allDataTableSelect_refresh:1] backInfoMessage:^(NSMutableArray *array) {
                         PL_PROGRESS_DISMISS;
                        if (array && [[array firstObject] isKindOfClass:NSClassFromString(@"NSString")])
                        {
                            
                            if ( [[array firstObject ]isEqualToString:@"NOLOGIN"]) {
                                ViewController * login = [[ViewController alloc]init];
                                [self.navigationController pushViewController:login animated:YES];
                                
                            }
                            else if ([[array firstObject] isEqualToString:@"[]"])
                            {
//                                _tableView.backgroundView = alertLable;
                                
//                                [_tableView reloadData];
                                PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                                return ;
                            }
                            else
                            {
                                _tableView.backgroundView = alertLable;
                                [_tableView reloadData];
                                PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                                
                                return;
                            }
                        }
                        else if(array.count>0)
                        {
                            NSLog(@"有数据");
                            resultArray = [NSMutableArray arrayWithArray:array];
                            self.cacheArray = [NSMutableArray arrayWithArray:resultArray];
                            
                            
                            [self.tableView reloadData];
                            
                        }
                        else if ([[array firstObject] isEqualToString:@"exception"]) {
                            resultArray = [NSMutableArray arrayWithArray:array];
                            _tableView.backgroundView = alertLable;
                            [_tableView reloadData];
                            PL_ALERT_SHOWNOT_OKAND_YES(@"服务器异常");
                            return;
                        }
                        else
                        {
                            PL_ALERT_SHOW(@"请求超时");
                            return;
                        }

                    }];
                    
                    
                }];
                [operation start];
                [_tableView2 reloadData];
            }
            else
            {
            //NSLog(@"tag==1  --%d-",indexPath.row);
            
             UITableViewCell * cell1 = [tableView cellForRowAtIndexPath:indexPath];
            
                [_currentBtn setTitle:cell1.textLabel.text forState:UIControlStateNormal];
                [_currentBtn setButtonNormalTile:cell1.textLabel.text];
                self.govAreaString = cell1.textLabel.text;
                
                UIImageView * xiala = (UIImageView *)[self.view viewWithTag:124+_currentBtn.tag];
                xiala.image = [UIImage imageNamed:@"dropdown.png"];

          
                PL_PROGRESS_SHOW;
             
          
            NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
                [[MyRequest defaultsRequest] getRoomInfoEasterList:[self allDataTableSelect_refresh:1] backInfoMessage:^(NSMutableArray *array) {
                    PL_PROGRESS_DISMISS;
                    
                    if (array && [[array firstObject] isKindOfClass:NSClassFromString(@"NSString")])
                    {
                        
                        if ( [[array firstObject ]isEqualToString:@"NOLOGIN"]) {
                            ViewController * login = [[ViewController alloc]init];
                            [self.navigationController pushViewController:login animated:YES];
                            
                        }
                        else if ([[array firstObject] isEqualToString:@"[]"])
                        {
//                            _tableView.backgroundView = alertLable;
                            
//                            [_tableView reloadData];
                            PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                            return ;
                        }
                        else
                        {
                            _tableView.backgroundView = alertLable;
                            [_tableView reloadData];
                            PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                            
                            return;
                        }
                    }
                    else if(array.count>0)
                    {
                        NSLog(@"有数据");
                        resultArray = [NSMutableArray arrayWithArray:array];
                        self.cacheArray = [NSMutableArray arrayWithArray:resultArray];
                        
                        
                        [self.tableView reloadData];
                        
                    }
                    else if ([[array firstObject] isEqualToString:@"exception"]) {
                        resultArray = [NSMutableArray arrayWithArray:array];
                        //                        _tableView.backgroundView = alertLable;
                        //                        [_tableView reloadData];
                        PL_ALERT_SHOWNOT_OKAND_YES(@"服务器异常");
                        
                        return;

                    }
                    else
                    {
                        PL_ALERT_SHOW(@"请求超时");
                        return;
                    }
                }];
                
                
            }];
            [operation start];

          
            
            [_tableView2 reloadData];
            
            }
            
        }
        else if(_currentBtn.tag==2)
        {
            NSLog(@"+++%ld,%ld",(long)_currentBtn.tag,(long)indexPath.row);
            // NSLog(@"tag==2  --%ld",indexPath.row);
            NSDictionary *dict=[self.priceArray objectAtIndex:indexPath.row];
            NSLog(@"%@",dict);
            
            UITableViewCell * cell =[tableView cellForRowAtIndexPath:indexPath];
           
            [_currentBtn setTitle:cell.textLabel.text forState:UIControlStateNormal];
           [_currentBtn setButtonNormalTile:cell.textLabel.text];
            _currentBtn.titleLabel.text =cell.textLabel.text;
            
            UIImageView * xiala = (UIImageView *)[self.view viewWithTag:124+_currentBtn.tag];
            xiala.image = [UIImage imageNamed:@"dropdown.png"];
//            _currentBtn.selected = NO;
            PL_PROGRESS_SHOW;
            if ([self.tradeString isEqualToString:@"出租"])
            {
                
                
                
                rentPriceFrom =[dict objectForKey:@"PRICEUP"];
                rentPriceTo = [dict objectForKey:@"PRICEDOWN"];
                priceFrom = @"";
                priceTo = @"";
                NSLog(@">>>>>>>>>%@,%@",rentPriceFrom,rentPriceTo);
                
            }
            else if ([self.tradeString isEqualToString:@"出售"])
            {
                
                priceFrom =[dict objectForKey:@"PRICEUP"];
                priceTo =[dict objectForKey:@"PRICEDOWN"];
                rentPriceFrom = @"";
                rentPriceTo = @"";
            }

            
            
            NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
                [[MyRequest defaultsRequest] getRoomInfoEasterList:[self allDataTableSelect_refresh:1] backInfoMessage:^(NSMutableArray *array) {
                    NSLog(@"+++++++++++%@",array.firstObject);
                     PL_PROGRESS_DISMISS;
                    if (array && [[array firstObject] isKindOfClass:NSClassFromString(@"NSString")])
                    {
                        NSLog(@"进入");
                        
                        if ( [[array firstObject ]isEqualToString:@"NOLOGIN"]) {
                            ViewController * login = [[ViewController alloc]init];
                            [self.navigationController pushViewController:login animated:YES];
                            
                        }
                        else if ([[array firstObject] isEqualToString:@"[]"])
                        {
                            
                            resultArray = [NSMutableArray arrayWithArray:array];
                            [resultArray removeLastObject];
                            _tableView.backgroundView = alertLable;
//                            self.label.hidden = NO;
                            [_tableView reloadData];
                            PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                            return ;
                        }
                        else
                        {
                            resultArray = [NSMutableArray arrayWithArray:array];
                            _tableView.backgroundView = alertLable;
                            [_tableView reloadData];
                            PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                            
                            return;
                        }
                    }
                    else if(array.count>0)
                    {
                        NSLog(@"有数据");
                        resultArray = [NSMutableArray arrayWithArray:array];
                        self.cacheArray = [NSMutableArray arrayWithArray:resultArray];
                        
                        
                        [self.tableView reloadData];
                        _tableView.backgroundView = nil;
                        
                    }
                    else if ([[array firstObject] isEqualToString:@"exception"]) {
                        resultArray = [NSMutableArray arrayWithArray:array];
                        _tableView.backgroundView = alertLable;
                        [_tableView reloadData];
                        PL_ALERT_SHOWNOT_OKAND_YES(@"服务器异常");
                        
                        return;
                        
                    }
                    else
                    {
                        PL_ALERT_SHOW(@"请求超时");
                        return;
                    }
                }];
                
                
            }];
            [operation start];
            

            
        }
        else if(_currentBtn.tag==3)
        {
            // NSLog(@"tag==3  --%ld",indexPath.row);
            return;
            
        }
        
        dropBgView.hidden=YES;
        _tableView2.hidden = YES;
        _tableView1.hidden = YES;
    } else  if (tableView==tableVeiwList)
    {
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        style.text = cell.textLabel.text;
        //[tableVeiwList removeFromSuperview];
        styleBtn.selected=NO;
        [sousuoViewstyle removeFromSuperview];
        
    }
   
    else if(tableView==self.tableView)
    {
       RoomData * room=[resultArray objectAtIndex:indexPath.row];
        NSLog(@"%@",room);
        detailVC = [[RoomDetailVC alloc]init];
        detailVC.aRoomData = room;
        [PL_USER_STORAGE setValue:room.roomPropertyId forKey:@"PropertyId"];
        PL_PROGRESS_SHOW;
        dispatch_queue_t RoomDetailsQueue=dispatch_queue_create(RoomDtailsQueue_GCD, DISPATCH_QUEUE_SERIAL);
        dispatch_sync(RoomDetailsQueue, ^{
        [[MyRequest defaultsRequest]GetPropertyDetail:^(NSMutableString *string) {
            // NSLog(@"%@",string);
            if (string.length && ![string isEqualToString:@"[]"] && ![string isEqualToString:@"exception"])
            {
                SBJSON *json=[[SBJSON alloc]init];
                detailVC.detailArray=[json objectWithString:string error:nil];
                NSDictionary *detailDic=[detailVC.detailArray objectAtIndex:0];
                
                [[NSUserDefaults standardUserDefaults]setObject:[detailDic objectForKey:@"ESTATEID"] forKey:@"ESTATEID"];
                
                //**************
                
               
                [[VisitersRequest defaultsRequest]GetEstateDetail:^(NSMutableString *string) {
                    if (string.length && ![string isEqualToString:@"[]"] && ![string isEqualToString:@"exception"])
                    {
                        SBJSON *json=[[SBJSON alloc]init];
                        detailVC.loupanArray=[json objectWithString:string error:nil];
                        detailVC.RoomDetailCustID = _RoonSourceCustID;
                        
                        dispatch_sync(RoomDetailsQueue, ^{
                            [self.navigationController pushViewController:detailVC animated:YES];
                            
                        });
                        
                        
                        //*******************
                        //                        [[CountRequest defaultsRequest]GetLegelProperties:^(NSMutableString *string) {
                        //                            NSLog(@"%@",string);
                        //                            SBJSON *json=[[SBJSON alloc]init];
                        //                            detailVC.countArray=[json objectWithString:string error:nil];
                        //
                        //                            NSLog(@"+++++ %@",string);
                        //                            //*************
                        //                            PL_PROGRESS_DISMISS;
                        //                            detailVC.RoomDetailCustID = _RoonSourceCustID;
                        //                            [self.navigationController pushViewController:detailVC animated:YES];
                        //                            //                            dfdfViewController *av = [[dfdfViewController alloc]init];
                        //                            //                            [self.navigationController pushViewController:av animated:YES];
                        //
                        //
                        //                        } EstateID:[[NSUserDefaults standardUserDefaults]objectForKey:@"ESTATEID"] userid:[[NSUserDefaults standardUserDefaults]objectForKey:@"userName" ] token:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN]];
                        
                    }
                    else
                    {
                        return ;
                    }
                    
                    PL_PROGRESS_DISMISS;
                }
         EstateID:[[NSUserDefaults standardUserDefaults]objectForKey:@"PropertyId"] userid:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME] token:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN]]
                ;
                    
              
                
            }
            else
            {
                PL_ALERT_SHOWNOT_OKAND_YES(@"请检查网络，暂无数据");
                
            }
            
            
        } PropertyId:room.roomPropertyId userid:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME] token:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN]];
            
            });
        
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [textView resignFirstResponder];
    UITouch *touch=[touches anyObject];
    [self.view endEditing:YES];
    
    
    if (_currentBtn.tag==1)
    {
        [_currentBtn setButtonNormalTile:@"区域"];
        
    }
    else if(_currentBtn.tag==2)
    {
        [_currentBtn setButtonNormalTile:@"价格"];
    }
    else if (_currentBtn.tag==3)
    {
        [_currentBtn setButtonNormalTile:@"更多"];
    }
    CGPoint point=[touch locationInView:bgView];
    if (CGRectContainsPoint(smallView.frame, point)) {
        [smallView endEditing:YES];
        CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, 0);
        //使视图使用这个变换
        bgView.transform = pTransform;
        
    }
    else
    {
        [bgView removeFromSuperview];
        [bgHuiView removeFromSuperview];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"ROOMFOLLOWID"];
    }
  
    _tableView1.hidden=YES;
    _tableView2.hidden=YES;
    dropBgView.hidden=YES;
    [sousuoView removeFromSuperview];
}
- (void)change2:(id)sender
{
    
    CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, 0);
    //使视图使用这个变换
    smallView.transform = pTransform;
    
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
    smallView.transform = pTransform;
    if ([textView.text isEqualToString:@""]) {
        placeholder.text=@"请输入跟进内容";
    }
}

#pragma mark --注册房源上拉下拉加载
- (void)setupRefresh
{
       [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerReleaseToRefreshText = @"松开刷新";
    self.tableView.headerRefreshingText = @"房源正在刷新中";
    
    self.tableView.footerPullToRefreshText = @"上拉加载更多数据";
    self.tableView.footerReleaseToRefreshText = @"松开加载更多数据";
    self.tableView.footerRefreshingText = @"房源正在加载中";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    NSLog(@"下拉");
    NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
        [[MyRequest defaultsRequest] getRoomInfoEasterList:[self allDataTableSelect_refresh:1] backInfoMessage:^(NSMutableArray *array) {
            PL_PROGRESS_DISMISS;
            if (array.count==0) {
                resultArray = [NSMutableArray arrayWithArray:array];
                self.tableView.backgroundView = alertLable;
                [self.tableView reloadData];
                return ;
            }
            if (array && [[array firstObject] isKindOfClass:NSClassFromString(@"NSString")])
            {
                
                if ( [[array firstObject ]isEqualToString:@"NOLOGIN"]) {
                    ViewController * login = [[ViewController alloc]init];
                    [self.navigationController pushViewController:login animated:YES];
                    
                }
                else if ([[array firstObject] isEqualToString:@"[]"])
                {
                    [resultArray removeAllObjects];
                    _tableView.backgroundView = alertLable;
                    //                    self.label.hidden = NO;
                    [_tableView reloadData];
                    PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                    return ;
                }
                else
                {
                    _tableView.backgroundView = alertLable;
                    [_tableView reloadData];
                    PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                    
                    return;
                }
            }
            else if(array.count>0)
            {
                NSLog(@"有数据");
                self.label.hidden = YES;
                
                resultArray = [NSMutableArray arrayWithArray:array];
                self.cacheArray = [NSMutableArray arrayWithArray:resultArray];
                
                for (RoomData *item  in resultArray) {
                    NSLog(@"=======================%@",item.roomPropertyId);
                    [self.properIDSet insertObject:@"suntt3" atIndex:self.properIDSet.count];
                    
                    
                }
                
                [self.tableView reloadData];
                _tableView.backgroundView = nil;
                
                
            }
            else
            {
                resultArray = [NSMutableArray arrayWithArray:array];
                _tableView.backgroundView = alertLable;
                [_tableView reloadData];
                PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                
                return;
            }
            
            
            
            
        }];
        
        //        [[MyRequest defaultsRequest] getRoomInfoEasterList:[self allDataTableSelect_refresh:a] backInfoMessage:^(NSMutableArray *array) {
        //            PL_PROGRESS_DISMISS;
        //            if (array.count==0) {
        //                resultArray = [NSMutableArray arrayWithArray:array];
        //                self.tableView.backgroundView = alertLable;
        //                [self.tableView reloadData];
        //                return ;
        //            }
        //            if (array && [[array firstObject] isKindOfClass:NSClassFromString(@"NSString")])
        //            {
        //
        //                if ( [[array firstObject ]isEqualToString:@"NOLOGIN"]) {
        //                    ViewController * login = [[ViewController alloc]init];
        //                    [self.navigationController pushViewController:login animated:YES];
        //
        //                }
        //                else if ([[array firstObject] isEqualToString:@"[]"])
        //                {
        //                    _tableView.backgroundView = alertLable;
        //
        //                    [_tableView reloadData];
        //                    PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
        //                    return ;
        //                }
        //                else
        //                {
        //                    _tableView.backgroundView = alertLable;
        //                    [_tableView reloadData];
        //                    PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
        //
        //                    return;
        //                }
        //            }
        //            else if(array.count>0)
        //            {
        //                NSLog(@"有数据");
        //               [resultArray addObjectsFromArray:array];
        //            NSMutableArray *eArray = [[NSMutableArray alloc]init];
        //
        //                for (RoomData *item  in resultArray) {
        //                    NSLog(@"++++++++++%@",item.roomPropertyId);
        //                    [self.properIDSet insertObject:item.roomPropertyId atIndex:self.properIDSet.count];
        //
        //                }
        //
        //                for (NSString *item in self.properIDSet) {
        //                    NSLog(@"<<<<<<<<<<<<<<<<%@",item);
        //                    int index=0;
        //                    for (RoomData *rom in resultArray) {
        //                        if ([rom.roomPropertyId isEqualToString:item] && index == 0) {
        //                            [eArray addObject:rom];
        //                            index ++;
        //                        }
        //                    }
        //                }
        //                [resultArray removeAllObjects];
        //
        //                [resultArray addObjectsFromArray:eArray];
        //
        //
        //
        //                self.cacheArray = [NSMutableArray arrayWithArray:resultArray];
        //
        ////                [self.cacheArray addObjectsFromArray:eArray];
        //
        //                [self.tableView reloadData];
        //                _tableView.backgroundView = nil;
        //
        //
        //            }
        //            else
        //            {
        //                _tableView.backgroundView = alertLable;
        //                [_tableView reloadData];
        //                PL_ALERT_SHOWNOT_OKAND_YES(@"服务器异常");
        //                
        //                return;
        //            }
        //
        //            
        //            
        //        }];
    }];
    [operation start];
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
    
    
    
}


- (void)footerRereshing
{
    NSLog(@"上拉");
    a++;
    self.label.hidden = YES;
    PL_SAFE_BLOCK(safeself);
    NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
        [[MyRequest defaultsRequest] getRoomInfoEasterList:[self allDataTableSelect_refresh:a] backInfoMessage:^(NSMutableArray *array) {
             PL_PROGRESS_DISMISS;
            
            if ([self.cacheStorage isEqualToString:@"1"])
            {
               
                resultArray = [NSMutableArray arrayWithArray:array];
                [safeself.tableView reloadData];
                
//                [safeself.tableView footerEndRefreshing];
                
                return ;
                
            }

            if (array.count==0) {
                 [resultArray addObjectsFromArray:array];
               // resultArray = [NSMutableArray arrayWithArray:array];
                self.tableView.backgroundView = nil;
                [self.tableView reloadData];
                return ;
            }
            if (array && [[array firstObject] isKindOfClass:NSClassFromString(@"NSString")])
            {
                
                if ( [[array firstObject ]isEqualToString:@"NOLOGIN"]) {
                    ViewController * login = [[ViewController alloc]init];
                    [self.navigationController pushViewController:login animated:YES];
                    
                }
                else if ([[array firstObject] isEqualToString:@"[]"])
                {
//                    [resultArray removeAllObjects];
//                    self.label.hidden = NO;
//                    _tableView.backgroundView = alertLable;
                    [_tableView reloadData];
                     a--;
                    PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                    return ;
                }
                else
                {
                    _tableView.backgroundView = alertLable;
                    [_tableView reloadData];
//                    [self.tableView footerEndRefreshing];
                    PL_ALERT_SHOWNOT_OKAND_YES(@"暂无数据");
                    a--;
                    return;
                }
            }
            else if(array.count>0)
            {
                NSLog(@"有数据");
                _tableView.backgroundView = nil;
                [resultArray addObjectsFromArray:array];
//                NSMutableArray *eArray = [[NSMutableArray alloc]init];
//                
//                for (RoomData *item  in resultArray) {
////                    NSLog(@"++++++++++%@",item.roomPropertyId);
//                    
//                    [self.properIDSet insertObject:item.roomPropertyId atIndex:self.properIDSet.count];
//                }
//                for (NSString *item in self.properIDSet) {
////                    NSLog(@"<<<<<<<<<<<<<<<<%@",item);
//                    int index=0;
//                    for (RoomData *rom in resultArray) {
//                        if ([rom.roomPropertyId isEqualToString:item] && index == 0) {
//                            [eArray addObject:rom];
//                            index ++;
//                        }
//                    }
//                }
//                [resultArray removeAllObjects];
//                NSLog(@"%lu",(unsigned long)resultArray.count);
//                NSLog(@"eeeeeee %lu",(unsigned long)eArray.count);
//                [resultArray addObjectsFromArray:eArray];
//                NSLog(@">>>>>>>>>>>>>>>>>>%lu",(unsigned long)resultArray.count);
                
                safeself.cacheArray = [NSMutableArray arrayWithArray:resultArray];
                
                
                [safeself.tableView reloadData];
//                [self.tableView footerEndRefreshing];

            }
            else if ([[array firstObject] isEqualToString:@"exception"]) {
                _tableView.backgroundView = alertLable;
                [_tableView reloadData];
                PL_ALERT_SHOWNOT_OKAND_YES(@"服务器异常");
                
                return;
            }
            else
            {
                PL_ALERT_SHOW(@"请求超时");
                return;
            }
        }];
    }];
    [operation start];

//     2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        //[self.tableView reloadData];
        
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
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
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[MyRequest defaultsRequest]disConnect];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}
@end
