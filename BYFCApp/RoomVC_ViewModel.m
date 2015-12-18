//
//  RoomVC_ViewModel.m
//  BYFCApp
//
//  Created by Wangpu_IOS on 15/12/7.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import "RoomVC_ViewModel.h"
#import "PL_Header.h"
#define PropertyID [[NSUserDefaults standardUserDefaults]objectForKey:@"PropertyId"]
const char*ContactMessSubQue;
const char *LookKey;
@implementation RoomVC_ViewModel
{
    
    NSMutableArray*Model_ImageArr3;
//RoomDetailVC的实例变量
    RoomDetailVC* _SELF;
    UIAlertView*alertViewimage2;
//    滚动视图
    CycleScrollView*imageScrollView1;
    CycleScrollView*imageScrollView2;
    CycleScrollView*imageScrollView3;
    CycleScrollView*imageScrollView4;
    CycleScrollView*imageScrollView5;
    CycleScrollView*imageScrollView6;
    CycleScrollView*imageScrrollView7;
    CycleScrollView*imageScrrollView8;
    
    
    
    NSMutableArray*ModelimageArr1;
//    选择照片或相机
    UIAlertView*alertViewimage1;
    UIAlertView*alertViewimage3;
    UIAlertView*alertViewimage8;
    UIAlertView*alertViewImage9;
    UIAlertView*alertViewImage10;

    UIAlertView*alertViewImage11;

//    自选的上传附件弹窗
    UIAlertView*AlertViewUpImage;
    NSString*eqStr;
//    日历控件
    CalendarHomeViewController*CalendarVC;
    NSString*imageData;
    NSString *filePathImage;
    NSString*imageData1;
    NSString*imageData5;
    NSString*WhereKeyStr;
    NSString*PasswordKeyStr;
    NSString*ContactMess;
    NSString*CheckInUserId;
    NSString*QianPeiDate;
    NSString*QianPeiPicke;
    NSString*imageData8;
//  钥匙的数量
    NSString*HouseKey_Equeal;
    
    NSMutableArray*UserIDarray;
    NSString*UserIDstring;
    NSString*EquealString;
    
    
//    判断被点击的是哪个View是上面的按钮
    NSInteger SelectInt;

    UIButton*CellSelect;
}

/**
 *  实现这个单例的工厂方法；
 */
+(RoomVC_ViewModel *)DefalutRoomVC
{
    static RoomVC_ViewModel*RommVcModel=nil;

    static dispatch_once_t Once;
    
    dispatch_once(&Once, ^{
       
        RommVcModel=[[self alloc]init ];
    });
    return RommVcModel;
    
}
/**
 *  获取当前self_RoomDatailVC
 *
 *
 */

-(RoomDetailVC*)Acquire_RoomDatailVC:(RoomDetailVC*)roomVC
{
    _SELF=roomVC;
    QianPeiDate=@"";
     WhereKeyStr=@"宝原";
    PasswordKeyStr=@"0";
    ContactMess=@"";
    CheckInUserId=@"";
    
    
    return _SELF;
    
}
-(Custom_Popover *)Custom_Room_PopoverView
{
    if (!_Custom_Room_PopoverView) {
        _Custom_Room_PopoverView=[Custom_Popover initCustomView];
        _Custom_Room_PopoverView.frame=CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
        _Custom_Room_PopoverView.backgroundColor=PL_CUSTOM_COLOR(125, 125, 125, 0.6);
    }
    return _Custom_Room_PopoverView;
}
-(Custom_Popover2 *)Custom_Room_PopoverView2
{
    if (!_Custom_Room_PopoverView2) {
        _Custom_Room_PopoverView2=[Custom_Popover2 initiCustom_Popover2];
        _Custom_Room_PopoverView2.frame=CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
        _Custom_Room_PopoverView2.backgroundColor=PL_CUSTOM_COLOR(125, 125, 125, 0.6);
    }
    return _Custom_Room_PopoverView2;
}
-(Custom_Popover3 *)Custom_Room_PopoverView3
{
    if (!_Custom_Room_PopoverView3) {
        _Custom_Room_PopoverView3=[Custom_Popover3 initCustom_Popover3];
        _Custom_Room_PopoverView3.frame=CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
        _Custom_Room_PopoverView3.backgroundColor=PL_CUSTOM_COLOR(125, 125, 125, 0.6);
    }
    return _Custom_Room_PopoverView3;
}
-(Custom_Popover4 *)Custom_Room_PopoverView4
{
    if (!_Custom_Room_PopoverView4) {
        _Custom_Room_PopoverView4=[Custom_Popover4 initCustom_Popover4];
        _Custom_Room_PopoverView4.frame=CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
        _Custom_Room_PopoverView4.backgroundColor=PL_CUSTOM_COLOR(125, 125, 125, 0.6);
    }
    return _Custom_Room_PopoverView4;
}
-(Custom_Popover5*)Custom_Room_PopoverView5
{
    if (!_Custom_Room_PopoverView5) {
        _Custom_Room_PopoverView5=[Custom_Popover5 initWithLoadView5];
        _Custom_Room_PopoverView5.frame=CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
        _Custom_Room_PopoverView5.MainBackgroundView.backgroundColor=PL_CUSTOM_COLOR(125, 125, 125, 0.6);
    }
    return _Custom_Room_PopoverView5;
}
-(Custom_Popover6 *)Custom_Room_PopoverView6
{
    if (!_Custom_Room_PopoverView6) {
        _Custom_Room_PopoverView6=[Custom_Popover6 initWithCustomView6];
        _Custom_Room_PopoverView6.frame=CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
        _Custom_Room_PopoverView6.backgroundColor=PL_CUSTOM_COLOR(125, 125, 125,0.8);
        _Custom_Room_PopoverView6.BackgroundView.layer.cornerRadius=8;
        _Custom_Room_PopoverView6.BackgroundView.layer.masksToBounds=YES;
        _Custom_Room_PopoverView6.BackgroundView.layer.borderWidth=3;
        _Custom_Room_PopoverView6.BackgroundView.layer.borderColor=[UIColor grayColor].CGColor;
        }
    
    return _Custom_Room_PopoverView6;
    
}
-(Custom_Popover7 *)Custom_Room_PopoverView7
{
    if (!_Custom_Room_PopoverView7) {
        _Custom_Room_PopoverView7=[Custom_Popover7 InitWithCutom_Popover7];
        _Custom_Room_PopoverView7.backgroundColor=PL_CUSTOM_COLOR(125, 125, 125, 0.6);
        _Custom_Room_PopoverView7.Delegate=self;

        _Custom_Room_PopoverView7.frame=CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
            }
    return _Custom_Room_PopoverView7;
    
    
    
}
-(LookKeyManagerController *)LookKeyView
{
    if (!_LookKeyView) {
        _LookKeyView=[[LookKeyManagerController alloc]initWithNibName:@"LookKeyManagerController" bundle:nil];
    }
    return _LookKeyView;
}
-(NSMutableArray *)BranchArray{
    if (!_BranchArray) {
        _BranchArray=[NSMutableArray array];
    }
    return _BranchArray;
}
-(NSMutableArray *)SalesmanArray
{
    if (!_SalesmanArray) {
        _SalesmanArray=[NSMutableArray array];
    }
    return _SalesmanArray;
}
-(NSMutableArray*)DujiaImageArray
{
    if (!_DujiaImageArray) {
        _DujiaImageArray=[NSMutableArray array];
    }
    return _DujiaImageArray;
}
-(NSMutableArray*)QianPeiImageArray
{
    if (!_QianPeiImageArray) {
        _QianPeiImageArray=[NSMutableArray array];
    }
    return _QianPeiImageArray;
}
-(NSMutableArray *)KeyImageArray
{
    if (!_KeyImageArray) {
        _KeyImageArray=[NSMutableArray array];
    }
    return _KeyImageArray;
}
-(NSMutableArray*)LookKeyArray
{
    if (!_LookKeyArray) {
        _LookKeyArray=[NSMutableArray array];
    }
    return _LookKeyArray;
}
-(NSMutableArray *)DowdloadImageArray
{
    if (!_DowdloadImageArray) {
        _DowdloadImageArray=[NSMutableArray array];
    }
    return _DowdloadImageArray;
}
-(NSString *)Acquire_RoomHouseKey:(NSString *)houseKey
{
    HouseKey_Equeal=houseKey;
    
    return HouseKey_Equeal;
    
}
/**
 *  PickerView的隐藏或者显示的方法
 *
 *  @param hidden  <#hidden description#>
 *  @param hidden2 <#hidden2 description#>
 */
-(void)Custom_Room_PopoverView6_ListPickerViewHidden1:(BOOL)hidden Hidden2:(BOOL)hidden2
{
    self.Custom_Room_PopoverView6.ListPickerView.hidden=hidden;
    
    self.Custom_Room_PopoverView6.ListPickerView2.hidden=hidden2;

    
}
/**
 *  PickerView的代理协议
 *
 *  @param delegate   PickerViewDalegate
 *  @param DataSource ickerViewDataSoucre
 */
-(void)Custom_Room_PopoverView6_ListPickerView1Delegate:(id)delegate DataSource:(id)DataSource
{
    self.Custom_Room_PopoverView6.ListPickerView.delegate=delegate;
    self.Custom_Room_PopoverView6.ListPickerView.dataSource=DataSource;
    
    
    
}
/**
 *  PickerView2的代理协议
 *
 *  @param delegate   PickerViewDalegate
 *  @param DataSource ickerViewDataSoucre
 */
-(void)Custom_Room_PopoverView6_ListPickerView2Delegate:(id)delegate DataSource:(id)DataSource
{
    self.Custom_Room_PopoverView6.ListPickerView2.delegate=delegate;
    self.Custom_Room_PopoverView6.ListPickerView2.dataSource=DataSource;
    
    
    
}
#pragma mark - 点击独家按钮----------------------
-(void)ConfigurationPopoverView2AllButtonMethod
{
    self.Custom_Room_PopoverView2.tiShiView.layer.masksToBounds = YES;
   self.Custom_Room_PopoverView2.tiShiView.layer.cornerRadius = 5;
    
    [_SELF.view addSubview:self.Custom_Room_PopoverView2];
    /**
     加载在自定义的View
     */
    [self.Custom_Room_PopoverView2.cancelBtn addTarget:self action:@selector(clickCancelBtn2) forControlEvents:UIControlEventTouchUpInside];
    [self.Custom_Room_PopoverView2.qianPeiBtn addTarget:self action:@selector(clickQianPeiBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.Custom_Room_PopoverView2.dujiaBtn addTarget:self action:@selector(clickDujiaBtn) forControlEvents:UIControlEventTouchUpInside];
   

    
    
}
/**
 *也可以写在第一次获取到DateilVC的方法里写在这里只是为了测试这种方法可行
 *
 *  @param imageArr3 获取预先加载的scrollView的数组
 *
 *  @return <#return value description#>
 */
-(NSMutableArray*)Acquire_ImageArr3:(NSMutableArray*)imageArr3
{
    Model_ImageArr3 =[NSMutableArray arrayWithArray:imageArr3];
    
    return Model_ImageArr3;
}
-(NSMutableArray*)Acquire_ImageArr1:(NSMutableArray*)imageArr1
{
    ModelimageArr1 =[NSMutableArray arrayWithArray:imageArr1];
    
    return ModelimageArr1;
}
-(NSMutableArray*)Model_ImageArray2
{
    if (!_Model_ImageArray2) {
        _Model_ImageArray2=[NSMutableArray array];
    }
    
    return _Model_ImageArray2;
}
-(NSMutableArray*)Model_ImageArray4
{
    if (!_Model_ImageArray4) {
        _Model_ImageArray4=[NSMutableArray array];
        

    }
    return _Model_ImageArray4;
}
-(NSMutableArray*)Model_ImageArray5
{
    if (!_Model_ImageArray5) {
        _Model_ImageArray5=[NSMutableArray array];
        
        
    }
    return _Model_ImageArray5;}
-(NSMutableArray*)Model_ImageArray8
{
    if (!_Model_ImageArray8) {
        _Model_ImageArray8=[NSMutableArray array];
        
        
    }
    return _Model_ImageArray8;}

#pragma mark  取消点击独家弹出的第一个框
-(void)clickCancelBtn2
{
    
     [self.Custom_Room_PopoverView2 removeFromSuperview];

   

}

#pragma mark 选择了签赔之后的按钮
-(void)clickQianPeiBtn
{
    self.Custom_Room_PopoverView3.qianPeiView.layer.masksToBounds = YES;
    self.Custom_Room_PopoverView3.qianPeiView.layer.cornerRadius = 5;
    self.Custom_Room_PopoverView3.qianPeiDataTextField.userInteractionEnabled = NO;
    self.Custom_Room_PopoverView3.qianPeiData.backgroundColor = [UIColor clearColor];
    /**
     加载在自定义的View
     */
    [self.Custom_Room_PopoverView3.cancelButton addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.Custom_Room_PopoverView3.upXiuGaibtn2 addTarget:self action:@selector(clickUpXiuGaibtn2) forControlEvents:UIControlEventTouchUpInside];
    [self.Custom_Room_PopoverView3.qianPeiData addTarget:self action:@selector(clickQianPeiData) forControlEvents:UIControlEventTouchUpInside];
    [self.Custom_Room_PopoverView3.selectImages addTarget:self action:@selector(clickSelectImages) forControlEvents:UIControlEventTouchUpInside];
    
    
    //默认
    imageScrollView3 =
    [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.Custom_Room_PopoverView3.imageViews.frame.size.width, self.Custom_Room_PopoverView3.imageViews.frame.size.height)];
    
    imageScrollView3.layer.borderColor = [UIColor grayColor].CGColor;
    imageScrollView3.layer.borderWidth = 1;
    imageScrollView3.hidden = NO;
    [imageScrollView3 cycleDirection:CycleDirectionLandscape pictures:Model_ImageArr3];
    [self.Custom_Room_PopoverView3.imageViews addSubview:imageScrollView3];
    
    imageScrollView4 =
    [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0,self.Custom_Room_PopoverView3.imageViews.frame.size.width, self.Custom_Room_PopoverView3.imageViews.frame.size.height)];
    imageScrollView4.layer.borderColor = [UIColor grayColor].CGColor;
    imageScrollView4.layer.borderWidth = 1;
    imageScrollView4.hidden = YES;
    [self.Custom_Room_PopoverView3.imageViews addSubview:imageScrollView4];
    [_SELF.view addSubview:self.Custom_Room_PopoverView3];
    

}
#pragma mark--选择了弹窗出来的独家按钮
-(void)clickDujiaBtn
{
    self.Custom_Room_PopoverView.yellowView.layer.masksToBounds = YES;
    self.Custom_Room_PopoverView.yellowView.layer.cornerRadius = 5;
    /**
     加载在自定义的View
     */
    [self.Custom_Room_PopoverView.TestBut addTarget:self action:@selector(CustomBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.Custom_Room_PopoverView.selectImage addTarget:self action:@selector(clickSelectImage) forControlEvents:UIControlEventTouchUpInside];
    [self.Custom_Room_PopoverView.upImageBtn addTarget:self action:@selector(clickUpImageBtn) forControlEvents:UIControlEventTouchUpInside];
    
    //默认
    imageScrollView1 =
    [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0,self.Custom_Room_PopoverView.imageScrollView.frame.size.width, self.Custom_Room_PopoverView.imageScrollView.frame.size.height)];
//    独家的第一个滚动视图
    imageScrollView1.layer.borderColor = [UIColor grayColor].CGColor;
    imageScrollView1.layer.borderWidth = 1;
    imageScrollView1.hidden = NO;
    [imageScrollView1 cycleDirection:CycleDirectionLandscape pictures:ModelimageArr1];
    [self.Custom_Room_PopoverView.imageScrollView addSubview:imageScrollView1];
    
//    独家显示的滚动的视图
    imageScrollView2 =
    [[CycleScrollView alloc] initWithFrame:imageScrollView1.frame];
    imageScrollView2.layer.borderColor = [UIColor grayColor].CGColor;
    imageScrollView2.layer.borderWidth = 1;
    imageScrollView2.hidden = YES;
    [self.Custom_Room_PopoverView.imageScrollView addSubview:imageScrollView2];
    
    [_SELF.view addSubview:self.Custom_Room_PopoverView];
}


#pragma mark-点击密码钥匙
-(void)clickMiMakeyBtn:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {

        PasswordKeyStr=@"1";
    }
    else
    {

        PasswordKeyStr=@"0";
        
    }
}
//查看钥匙
#pragma mark --查看钥匙
-(void)ClicklookKeyBtn
{
   
    
//    dispatch_queue_t LookKeyQueue=dispatch_queue_create(LookKey, DISPATCH_QUEUE_SERIAL);
//    dispatch_sync(LookKeyQueue, ^{
    
        NSDictionary*Dic=[NSDictionary dictionary];
        Dic=@{@"PropertyID":PropertyID,
              @"userid":[PL_USER_STORAGE objectForKey:PL_USER_USERID],
              @"token":[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]
              };
        [self GetHouseKeyListModel:Dic];
//    });
   
    
    
}
#pragma mark 点击宝源
-(void)clickBaoyuanBtn:(UIButton*)sender
{
     sender.selected=!sender.selected;
    if (sender.selected==YES) {
         WhereKeyStr=@"宝原";
        self.Custom_Room_PopoverView4.hangjiaBtn.selected=NO;
        self.Custom_Room_PopoverView4.LinkmanView.hidden=YES;

    }else
    {
        self.Custom_Room_PopoverView4.baoyuanBtn.selected=YES;
    }
   
    
}
//行家
#pragma mark 点击行家
-(void)clickHangjiaBtn:(UIButton*)sender
{
    sender.selected=!sender.selected;
    if (sender.selected==YES) {
         WhereKeyStr=@"行家";
        self.Custom_Room_PopoverView4.numKeyTextField.text=@"";
        self.Custom_Room_PopoverView4.beizhuTextView.text=@"";
        self.Custom_Room_PopoverView4.baoyuanBtn.selected=NO;
        self.Custom_Room_PopoverView4.LinkmanView.hidden=NO;
    }else
    {
        self.Custom_Room_PopoverView4.hangjiaBtn.selected=YES;
    }

   
}
#pragma mark 选择分行
-(void)clickFenhangBtn
{
    
    
    [self.Custom_Room_PopoverView6.Sure addTarget:self action:@selector(ExitListBrack) forControlEvents:UIControlEventTouchUpInside];
    self.Custom_Room_PopoverView6.ListPickerView2.hidden=YES;
    self.Custom_Room_PopoverView6.ListPickerView.hidden=NO;
    [self.Custom_Room_PopoverView6.ListPickerView selectRow:0 inComponent:0 animated:YES];
    [self CalltouchesBegan];
    [_SELF.view addSubview:self.Custom_Room_PopoverView6];
    if (self.BranchArray.count>0) {
        [self.Custom_Room_PopoverView4.fenhangBtn setTitle:self.BranchArray[0] forState:0];
        ContactMess=self.BranchArray[0];

    }
    else
    {
    
    }
    
    
    
}
#pragma mark  PickerView的取消和去顶按钮
-(void)ExitListBrack
{
    [self.Custom_Room_PopoverView6 removeFromSuperview];
    
    
    
}
//业务员
#pragma mark----选择业务员
-(void)clickSalesmanBtn
{
    if ([ContactMess isEqualToString:@""]) {
        PL_ALERT_SHOW(@"请先选择分行");
    }else
    {
    self.Custom_Room_PopoverView6.ListPickerView.hidden=YES;
    
    self.Custom_Room_PopoverView6.ListPickerView2.hidden=NO;
    [self.Custom_Room_PopoverView6.ListPickerView2 selectRow:0 inComponent:0 animated:YES];

        [_SELF.view addSubview:self.Custom_Room_PopoverView6];
    
    NSDictionary*Dic=[NSDictionary dictionary];
    Dic=@{ @"WhereKey":ContactMess,
           @"userid":[PL_USER_STORAGE objectForKey:PL_USER_USERID],
           @"token":[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]
           };
    
    
    [self Get_BranchModel:Dic];
    
    }

}
#pragma mark 选择行家添加钥匙弹出上传图片的界面

-(void)HangjiaImageUpPopover7
{
       [self.Custom_Room_PopoverView7.XXButoon addTarget:self action:@selector(ExitpopoverView7) forControlEvents:UIControlEventTouchUpInside];
    
    [self CalltouchesBegan];
    [self.KeyImageArray removeAllObjects];
    [self.Model_ImageArray2 removeAllObjects];
    [self.Model_ImageArray4 removeAllObjects];
    [self.Model_ImageArray8 removeAllObjects];

         [_SELF.view addSubview:self.Custom_Room_PopoverView7];
    
    [self.Custom_Room_PopoverView7.VisitingCard.Visitingcard addTarget:self action:@selector(VisitingcardImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.Custom_Room_PopoverView7.ID_Card.ID_Card addTarget:self action:@selector(ID_CardImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.Custom_Room_PopoverView7.KeyBook.KeyStorageBook addTarget:self action:@selector(KeyStorageBookImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.Custom_Room_PopoverView7.UpCommit.CommitIUp addTarget:self action:@selector(CommitIUpIamge:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.Custom_Room_PopoverView7.MainTableView reloadData];
}
#pragma mark 选择名片
-(void)VisitingcardImage:(UIButton*)but
{
    
         alertViewImage9=[[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"相册", nil];
        [alertViewImage9 show];
   
    [self.Custom_Room_PopoverView7 RowHeight1:200];
    
    
}
#pragma mark 选择身份证
-(void)ID_CardImage:(UIButton*)but

{
    but.selected=YES;
        alertViewImage10=[[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"相册", nil];
        [alertViewImage10 show];
    SelectInt=2;

    [self.Custom_Room_PopoverView7 RowHeight2:200];


    
}
#pragma mark 选择h行家的钥匙保管书
-(void)KeyStorageBookImage:(UIButton*)but
{
    but.selected=YES;
    SelectInt=3;
         alertViewImage11=[[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"相册", nil];
        [alertViewImage11 show];

    [self.Custom_Room_PopoverView7 RowHeight3:200];

}
#pragma mark 行家的上传提交在上传图片的里面
-(void)CommitIUpIamge:(UIButton*)but
{
    if (![HouseKey_Equeal isEqualToString:@"0"]) {
         [self postRquestAddKey];
    }else
    {
        if (self.Model_ImageArray2.count==0||self.Model_ImageArray4.count==0||self.Model_ImageArray8.count==0) {
            
            PL_ALERT_SHOW(@"首次请上传全部附件");
            
        }else
        {
           [self postRquestAddKey];
        }
   
    }
    
    
   
    
}
#pragma mark XX按钮CustomView7

-(void)ExitpopoverView7
{
    [self.Custom_Room_PopoverView7 RowHeight:0.01];
    [self.Custom_Room_PopoverView7 RowHeight1:0.1];
    [self.Custom_Room_PopoverView7 RowHeight2:0.1];
    [self.Custom_Room_PopoverView7 RowHeight3:0.1];
    self.Custom_Room_PopoverView4.numKeyTextField.text=@"";
    [self.Custom_Room_PopoverView4.fenhangBtn setTitle:@"" forState:0];
    [self.Custom_Room_PopoverView4.salesmanBtn setTitle:@"" forState:0];
    self.Custom_Room_PopoverView4.PhoneNumber.text=@"";
    self.Custom_Room_PopoverView4.baoyuanBtn.selected=YES;
    self.Custom_Room_PopoverView4.hangjiaBtn.selected=NO;
    self.Custom_Room_PopoverView4.miMakeyBtn.selected=NO;
    self.Custom_Room_PopoverView4.beizhuTextView.text=@"";
    self.Custom_Room_PopoverView4.LinkmanView.hidden=YES;
    ContactMess=@"";
    CheckInUserId=@"";
    PasswordKeyStr=@"0";
    [self.KeyImageArray removeAllObjects];
    [self.Model_ImageArray2 removeAllObjects];
    [self.Model_ImageArray4 removeAllObjects];
    [self.Model_ImageArray8 removeAllObjects];
    [self.KeyImageArray removeAllObjects];
    [self.Model_ImageArray5 removeAllObjects];
    [self.Model_ImageArray8 removeAllObjects];
    [self.Custom_Room_PopoverView7 removeFromSuperview];
    [self.Custom_Room_PopoverView4 removeFromSuperview];
    imageScrollView5.hidden=YES;
    imageScrollView6.hidden=YES;
    imageScrrollView7.hidden=YES;
    imageScrrollView8.hidden=YES;
    
}
#pragma mark 选择宝源添加钥匙弹出上传图片的界面

-(void)addKeyImage
{
    
    [self CalltouchesBegan];
    self.Custom_Room_PopoverView5.layer.cornerRadius=5;
    self.Custom_Room_PopoverView5.layer.masksToBounds=YES;
    [self.Custom_Room_PopoverView5.SelectFile addTarget:self action:@selector(ClickImageUpLoad:) forControlEvents:UIControlEventTouchUpInside];
    [self.Custom_Room_PopoverView5.KeyBtnBooke addTarget:self action:@selector(ClickbookKeyImage:) forControlEvents:UIControlEventTouchUpInside];
    self.Custom_Room_PopoverView5.userInteractionEnabled=YES;
    self.Custom_Room_PopoverView5.ScrollView.scrollEnabled=YES;
        self.Custom_Room_PopoverView5.ScrollView.userInteractionEnabled=YES;
    self.Custom_Room_PopoverView5.MainBackgroundView.userInteractionEnabled=YES;
    [_SELF.view addSubview:self.Custom_Room_PopoverView5];
    [self.Custom_Room_PopoverView5.RmoveViewBut addTarget:self action:@selector(Exit) forControlEvents:UIControlEventTouchUpInside];
    
    [self.Custom_Room_PopoverView5.CommitImage addTarget:self action:@selector(sureCommit) forControlEvents:UIControlEventTouchUpInside];
    
    
    imageScrollView5= [[CycleScrollView alloc] initWithFrame:CGRectMake(0,self.Custom_Room_PopoverView5.Card.frame.size.height+self.Custom_Room_PopoverView5.Card.frame.origin.y,PL_WIDTH-55,200)];
    
    imageScrollView5.layer.borderColor = [UIColor grayColor].CGColor;
    imageScrollView5.layer.borderWidth = 1;
    imageScrollView5.hidden = YES;
    [imageScrollView5 cycleDirection:CycleDirectionLandscape pictures:ModelimageArr1];
    [self.Custom_Room_PopoverView5.ScrollView addSubview:imageScrollView5];
    
    
    imageScrollView6= [[CycleScrollView alloc] initWithFrame:imageScrollView5.frame];
    
    imageScrollView6.layer.borderColor = [UIColor grayColor].CGColor;
    imageScrollView6.layer.borderWidth = 1;
    imageScrollView6.hidden = YES;
    [self.Custom_Room_PopoverView5.ScrollView addSubview:imageScrollView6];
    
    
    imageScrrollView7= [[CycleScrollView alloc] initWithFrame:CGRectMake(0,self.Custom_Room_PopoverView5.KeyBook.frame.size.height+self.Custom_Room_PopoverView5.KeyBook.frame.origin.y,PL_WIDTH-56,200)];
    imageScrrollView7.layer.borderColor = [UIColor grayColor].CGColor;
    imageScrrollView7.layer.borderWidth = 1;
    imageScrrollView7.hidden = YES;
    [imageScrrollView7 cycleDirection:CycleDirectionLandscape pictures:Model_ImageArr3];
    [self.Custom_Room_PopoverView5.ScrollView addSubview:imageScrrollView7];
    
    
    imageScrrollView8= [[CycleScrollView alloc] initWithFrame:CGRectMake(0, self.Custom_Room_PopoverView5.KeyBook.frame.size.height+self.Custom_Room_PopoverView5.KeyBook.frame.origin.y, PL_WIDTH-55, 200)];
    
    imageScrrollView8.layer.borderColor = [UIColor grayColor].CGColor;
    imageScrrollView8.layer.borderWidth = 1;
    imageScrrollView8.hidden = YES;
    [self.Custom_Room_PopoverView5.ScrollView addSubview:imageScrrollView8];
        
   }
//上传修改
#pragma mark 钥匙的上传修改
-(void)clickUpXiuGaiBtn
{
   
    if (self.Custom_Room_PopoverView4.hangjiaBtn.selected==YES) {
        
        if ([self.Custom_Room_PopoverView4.numKeyTextField.text isEqualToString:@""])
        {
            PL_ALERT_SHOW(@"请输入钥匙数量");
            
        }else if ([self.Custom_Room_PopoverView4.PhoneNumber.text isEqualToString:@""])
        {
            PL_ALERT_SHOW(@"请输入电话");
        }else if ([self.Custom_Room_PopoverView4.beizhuTextView.text isEqualToString:@""])
        {
            PL_ALERT_SHOW(@"请输入备注");
        }else
        {
//            [self postRquestAddKey];
            [self HangjiaImageUpPopover7];
        }
        
    }else if(!self.Custom_Room_PopoverView4.hangjiaBtn.selected==YES)
    {
        if ([self.Custom_Room_PopoverView4.numKeyTextField.text isEqualToString:@""])
        {
            PL_ALERT_SHOW(@"请输入钥匙数量");
            
        }else if ([ContactMess isEqualToString:@""])
        {
            PL_ALERT_SHOW(@"请选择分行");
            
        }else if ([UserIDstring isEqualToString:@""])
        {
            PL_ALERT_SHOW(@"请选择业务员");
            
        }else if ([self.Custom_Room_PopoverView4.beizhuTextView.text isEqualToString:@""])
        {
            PL_ALERT_SHOW(@"请输入备注");
        }else
        {
//            [self postRquestAddKey];
            
            [self addKeyImage];

        }
    }
}
#pragma mark--钥匙XX按钮
-(void)clickCancelBtn4
{
    [self.Custom_Room_PopoverView4.fenhangBtn setTitle:@"" forState:0];
    [self.Custom_Room_PopoverView4.salesmanBtn setTitle:@"" forState:0];
    PasswordKeyStr=@"0";
    self.Custom_Room_PopoverView4.miMakeyBtn.selected=NO;
    self.Custom_Room_PopoverView4.numKeyTextField.text=@"";
    self.Custom_Room_PopoverView4.beizhuTextView.text=@"";
    self.Custom_Room_PopoverView4.PhoneNumber.text=@"";
    self.Custom_Room_PopoverView4.baoyuanBtn.selected=YES;
    self.Custom_Room_PopoverView4.hangjiaBtn.selected=NO;
    self.Custom_Room_PopoverView4.LinkmanView.hidden=YES;
    [self.KeyImageArray removeAllObjects];
    [self.Model_ImageArray5 removeAllObjects];
    [self.Model_ImageArray8 removeAllObjects];
    [self.Custom_Room_PopoverView4 removeFromSuperview];
    
}

#pragma mark 添加钥匙的请求
-(void)postRquestAddKey
{
    NSDictionary*dic=[NSDictionary dictionary];
    NSData*JsonData=[NSJSONSerialization dataWithJSONObject:self.KeyImageArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString*str=[[NSString alloc]initWithData:JsonData encoding:NSUTF8StringEncoding];
    if ([EquealString isEqualToString:@"YES"]) {
        
        str =@"[]";
    }
        if (self.Custom_Room_PopoverView4.hangjiaBtn.selected==YES) {
        
        ContactMess=self.Custom_Room_PopoverView4.PhoneNumber.text;
        UserIDstring=[PL_USER_STORAGE objectForKey:PL_USER_USERID];
    }
    dic=@{ @"PropertyID":PropertyID,
           @"HouseKey":self.Custom_Room_PopoverView4.numKeyTextField.text,
           @"WhereKey":WhereKeyStr,
           @"PasswordKey":PasswordKeyStr,
           @"ContactMess":ContactMess,
           @"CheckInUserId":UserIDstring,
           @"Remark":self.Custom_Room_PopoverView4.beizhuTextView.text,
           @"jsonData":str,
           @"userid":[PL_USER_STORAGE objectForKey:PL_USER_USERID],
           @"token":[PL_USER_STORAGE objectForKey:PL_USER_TOKEN ]
           };
    
    
    [self AddForKeyModel:dic];
    

    
}

#pragma mark 单独刷新胸卡和钥匙保管里面的滚动视图Frame
-(void)UpdateScrollViewFrame
{
    imageScrollView5.frame=CGRectMake(0, self.Custom_Room_PopoverView5.Card.frame.origin.y+self.Custom_Room_PopoverView5.Card.frame.size.height, PL_WIDTH-55, 200);
    imageScrollView6.frame=CGRectMake(0, self.Custom_Room_PopoverView5.Card.frame.origin.y+self.Custom_Room_PopoverView5.Card.frame.size.height, PL_WIDTH-55, 200);
    self.Custom_Room_PopoverView5.KeyBook.frame=CGRectMake(0, self.Custom_Room_PopoverView5.Card.frame.origin.y+self.Custom_Room_PopoverView5.Card.frame.size.height+200, PL_WIDTH-55, 90);
    imageScrrollView7.frame=CGRectMake(0, self.Custom_Room_PopoverView5.KeyBook.frame.size.height+self.Custom_Room_PopoverView5.KeyBook.frame.origin.y, PL_WIDTH-55, 200);
    imageScrrollView8.frame=CGRectMake(0, self.Custom_Room_PopoverView5.KeyBook.frame.size.height+self.Custom_Room_PopoverView5.KeyBook.frame.origin.y, PL_WIDTH-55, 200);
    
}
#pragma mark 钥匙上传的按钮，在上传图片里面的
-(void)sureCommit
{
    
    
    [self P_UpImageEqueal];
    
}
-(void)P_UpImageEqueal
{
    if ([HouseKey_Equeal isEqualToString:@"0"]) {
        if (self.Model_ImageArray5.count==0||self.Model_ImageArray8.count==0) {
            
            PL_ALERT_SHOW(@"首次请上传全部附件");
            
            
        }
           else
        {
            [self UpDateXiongkaFrame];
            
            
            [self postRquestAddKey];
            
        }

    }else
    {
        if (self.Model_ImageArray5.count==0&&self.Model_ImageArray8.count==0) {
        AlertViewUpImage=[[UIAlertView alloc]initWithTitle:@"提示" message:@"没有上传附件是否提交" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
        
        [AlertViewUpImage show];
   
        }else
        {
            [self UpDateXiongkaFrame];
            
            
            [self postRquestAddKey];
            
        }
    }
    
}
#pragma mark    xxCustom_Room_PopoverView5退出添加附件的界面
-(void)Exit
{
    
    [self.Custom_Room_PopoverView4 removeFromSuperview];
    [self.Custom_Room_PopoverView5 removeFromSuperview];
   
    [self UpDateXiongkaFrame];
    imageScrollView5.hidden=YES;
    imageScrollView6.hidden=YES;
    
    imageScrrollView7.hidden=YES;
    
    imageScrrollView8.hidden=YES;
    [self.Model_ImageArray5 removeAllObjects];
    [self.Model_ImageArray8 removeAllObjects];
}
-(void)UpDateXiongkaFrame
{
    self.Custom_Room_PopoverView5.SelectFile.selected=NO;
    self.Custom_Room_PopoverView5.KeyBtnBooke.selected=NO;
    self.Custom_Room_PopoverView5.ChestCardLayout.constant=0;
    self.Custom_Room_PopoverView5.KeyBookLayout.constant=0;
    
}
#pragma mark 点击胸卡上传图片
-(void)ClickImageUpLoad:(UIButton*)Sender
{
   
//    if (Sender.selected==NO)
//    {
//        self.Custom_Room_PopoverView5.KeyBook.frame=CGRectMake(0, self.Custom_Room_PopoverView5.Card.frame.origin.y+self.Custom_Room_PopoverView5.Card.frame.size.height,self.Custom_Room_PopoverView5.MainBackgroundView.frame.size.width, 91);
//        imageScrrollView7.frame=CGRectMake(0,self.Custom_Room_PopoverView5.KeyBook.frame.size.height+self.Custom_Room_PopoverView5.KeyBook.frame.origin.y,PL_WIDTH-50,PL_WIDTH-55);
//         imageScrrollView8.frame=CGRectMake(0,self.Custom_Room_PopoverView5.KeyBook.frame.size.height+self.Custom_Room_PopoverView5.KeyBook.frame.origin.y,PL_WIDTH-50,PL_WIDTH-55);
////        self.Custom_Room_PopoverView5.KeyBookLayout.constant=0;
//    }else
//    {
        if (self.Custom_Room_PopoverView5.KeyBtnBooke.selected==YES) {
            [self UpdateScrollViewFrame];
        }
//    }
//    if (Sender.selected) {
        alertViewimage3=[[UIAlertView alloc]initWithTitle:@"请上传附件证明" message:nil delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"拍照",@"本地相册" ,nil];
        [alertViewimage3 show];
        
        if (self.Model_ImageArray5.count==0) {
             imageScrollView5.hidden = NO;
            
        }else
        {
          imageScrollView6.hidden = NO;
        }
       

        
//    }else
//    {
//          imageScrollView5.hidden = YES;
//        imageScrollView6.hidden = YES;
//
//        
//    }
   
}
#pragma mark点击钥匙保管的按钮
-(void)ClickbookKeyImage:(UIButton*)sender
{
        if (self.Custom_Room_PopoverView5.ChestCardBtn.selected==YES) {
    
            [self UpdateScrollViewFrame];
    
        }else
        {
            imageScrrollView7.frame=CGRectMake(0,self.Custom_Room_PopoverView5.KeyBook.frame.size.height+self.Custom_Room_PopoverView5.KeyBook.frame.origin.y,PL_WIDTH-55,200);
            imageScrrollView8.frame=imageScrrollView7.frame;
        }

//    if (sender.selected) {
        alertViewimage8=[[UIAlertView alloc]initWithTitle:@"请上传附件证明" message:nil delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"拍照",@"本地相册" ,nil];
        [alertViewimage8 show];
        
        if (self.Model_ImageArray8.count==0) {
            imageScrrollView7.hidden = NO;
            
        }else
        {
            imageScrrollView8.hidden = NO;
            imageScrrollView8.frame=CGRectMake(0,self.Custom_Room_PopoverView5.KeyBook.frame.size.height+self.Custom_Room_PopoverView5.KeyBook.frame.origin.y,PL_WIDTH-55,200);
        }
        
        
        
//    }else
//    {
//        imageScrrollView7.hidden = YES;
//        imageScrrollView8.hidden = YES;
    
        
//    }
    
 
    
    
}
#pragma mark 签赔上传的XX按钮
-(void)clickCancelButton
{
    [self.Custom_Room_PopoverView3.qianPeiData setTitle:@"" forState:0];
    self.Custom_Room_PopoverView3.qianPeiPrice.text=@"";
    self.Custom_Room_PopoverView3.qianPeiDataTextField.placeholder=@"选择";
    [self.Model_ImageArray4 removeAllObjects];
    
    [self.Custom_Room_PopoverView3 removeFromSuperview];
    [self.Custom_Room_PopoverView2 removeFromSuperview];
}
#pragma mark 签赔的上传修改
-(void)clickUpXiuGaibtn2
{
    if ([self.Custom_Room_PopoverView3.qianPeiPrice.text isEqualToString:@""]) {
        
        PL_ALERT_SHOW(@"请输入金额");
    }else if ([QianPeiDate isEqualToString:@""])
    {
        PL_ALERT_SHOW(@"请选择日期");
    }else if (self.Model_ImageArray4.count==0)
    {
        
        PL_ALERT_SHOW(@"请上传图片");
    }else
    {
        NSDictionary*dic=[NSDictionary dictionary];
        
        NSData*jsondata=[NSJSONSerialization dataWithJSONObject:self.QianPeiImageArray options:NSJSONWritingPrettyPrinted error:nil];
        NSString*str=[[NSString alloc]initWithData:jsondata encoding:NSUTF8StringEncoding];
        dic=@{@"PropertyID":PropertyID,
              @"PropertyType":@"2",
              @"PropertyTrust":@"签赔",
              @"Price":self.Custom_Room_PopoverView3.qianPeiPrice.text,
              @"Date":QianPeiDate,
              @"jsonData":str,
              @"userid":[PL_USER_STORAGE objectForKey:PL_USER_USERID],
              @"token":[PL_USER_STORAGE objectForKey:PL_USER_TOKEN],
              };
        
        NSInteger intter=self.Custom_Room_PopoverView3.qianPeiPrice.text.integerValue;
        
        if (intter>=2000||intter<0 ) {
            
            PL_ALERT_SHOW(@"签赔金额不可以小于2000或者大于0");
            self.Custom_Room_PopoverView3.qianPeiPrice.text=@"";
            
            return;
        }

        
        [self SignatureDic:dic];
        imageScrollView3.hidden=NO;
        imageScrollView4.hidden=YES;
        [self.Model_ImageArray4 removeAllObjects];
       
        
        
    }
    
    
    
}
#pragma  mark 签赔选择日期
-(void)clickQianPeiData
{
    if (!CalendarVC) {
        CalendarVC=[[CalendarHomeViewController alloc]init];
        [CalendarVC setAirPlaneToDay:365 ToDateforString:nil];
    }
    
    [_SELF presentViewController:CalendarVC animated:YES completion:^{
              __block Custom_Popover3 *BlockSelf=self.Custom_Room_PopoverView3;
        CalendarVC.calendarblock=^(CalendarDayModel*model)
        {
            [BlockSelf.qianPeiData setTitle:[model toString] forState:0];
            
            QianPeiDate=[model toString];
            BlockSelf.qianPeiDataTextField.placeholder=@"";
            
        };
        
        
    }];
 
}
-(void)clickSelectImages
{
    alertViewimage2=[[UIAlertView alloc]initWithTitle:@"请上传附件证明" message:nil delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"拍照",@"本地相册" ,nil];
    [alertViewimage2 show];
}
-(void)clickSelectImage
{
    alertViewimage1=[[UIAlertView alloc]initWithTitle:@"请上传附件证明" message:nil delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"拍照",@"本地相册" ,nil];
    [alertViewimage1 show];
    
}
#pragma mark 独家上传修改
-(void)clickUpImageBtn
{
    if (self.Model_ImageArray2.count==0) {
        PL_ALERT_SHOW(@"请添加附件");
    }else
    {
        NSData*jsonData=[NSJSONSerialization dataWithJSONObject:self.DujiaImageArray options:NSJSONWritingPrettyPrinted error:nil];
        NSString*str=[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSDictionary*SingatureDic=[NSDictionary dictionary];
        SingatureDic=@{@"PropertyID":PropertyID,
                       @"PropertyType":@"1",
                       @"PropertyTrust":@"独家",
                       @"Price":@"",
                       @"Date":@"",
                       @"jsonData":str,
                       @"userid":[PL_USER_STORAGE objectForKey:PL_USER_USERID],
                       @"token":[PL_USER_STORAGE objectForKey:PL_USER_TOKEN],
                       };
        
        
        [self SignatureDic:SingatureDic];
            }

}
#pragma mark 取消独家上传照片的XX按钮
-(void)CustomBtn
{
    [self.Custom_Room_PopoverView removeFromSuperview];
    [self.Model_ImageArray2 removeAllObjects];
    imageScrollView2.hidden=YES;
    
}

#pragma mark--AlertView提示
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == alertViewimage1) {
        if (buttonIndex==0) {
            NSLog(@"取消");
        }else if (buttonIndex==1)
        {
            NSLog(@"拍照");
            [self openCarama1];
        }else
        {
            NSLog(@"相册");
            [self locaPhonto1];
        }
        
    }
    else if (alertView == alertViewimage2)
    {
        if (buttonIndex==0) {
            NSLog(@"取消");
        }else if (buttonIndex==1)
        {
            NSLog(@"拍照");
            [self openCarama2];
        }else
        {
            NSLog(@"相册");
            [self locaPhonto2];
        }
        
    }else if (alertView == alertViewimage3)
    {
        if (buttonIndex==0) {
            NSLog(@"取消");
        }else if (buttonIndex==1)
        {
            NSLog(@"拍照");
            [self openCarama3];
        }else
        {
            NSLog(@"相册");
            [self locaPhonto3];
        }
        
    }else if (alertView == alertViewimage8)
    {
        if (buttonIndex==0) {
            NSLog(@"取消");
        }else if (buttonIndex==1)
        {
            NSLog(@"拍照");
            [self openCarama8];
        }else
        {
            NSLog(@"相册");
            [self locaPhonto8];
        }
        
    }else if (alertView==AlertViewUpImage)
    {
        
        if (buttonIndex==0) {
            
            EquealString=@"YES";
            
            [self UpDateXiongkaFrame];
            
            
            [self postRquestAddKey];
            

            
        }
        
        
        
    }else if (alertView==alertViewImage9)
    {
        if (buttonIndex==0) {
            NSLog(@"取消");
        }else if (buttonIndex==1)
        {
            NSLog(@"拍照");
            [self openCarama9];
        }else
        {
            NSLog(@"相册");
            [self locaPhonto9];
        }

        
    }else if (alertView==alertViewImage10)
    {
        if (buttonIndex==0) {
            NSLog(@"取消");
        }else if (buttonIndex==1)
        {
            NSLog(@"拍照");
            [self openCarama10];
        }else
        {
            NSLog(@"相册");
            [self locaPhonto10];
        }
        
        
    }else if (alertView==alertViewImage11)
    {
        if (buttonIndex==0) {
            NSLog(@"取消");
        }else if (buttonIndex==1)
        {
            NSLog(@"拍照");
            [self openCarama11];
        }else
        {
            NSLog(@"相册");
            [self locaPhonto11];
        }
        
        
    }
    
}
//打开相机
-(void)openCarama1
{
    eqStr = @"0";
    UIImagePickerController*imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing=YES;
    imagePicker.delegate=self;
    [_SELF presentViewController:imagePicker animated:YES completion:nil];
    [_SELF.view addSubview:imagePicker.view];
    
    
    
}
//打开相册
-(void)locaPhonto1
{
    eqStr = @"0";
    UIImagePickerController*ImagePicker=[[UIImagePickerController alloc]init];
    ImagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    ImagePicker.delegate=self;
    ImagePicker.allowsEditing=YES;
    [_SELF presentViewController:ImagePicker animated:YES completion:nil];
    [_SELF.view addSubview:ImagePicker.view];
    
}
//打开相机
-(void)openCarama2
{
    eqStr = @"2";
    UIImagePickerController*imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing=YES;
    imagePicker.delegate=self;
    [_SELF presentViewController:imagePicker animated:YES completion:nil];
    [_SELF.view addSubview:imagePicker.view];
    
    
    
}
//打开相册
-(void)locaPhonto2
{
    eqStr = @"2";
    UIImagePickerController*ImagePicker=[[UIImagePickerController alloc]init];
    ImagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    ImagePicker.delegate=self;
    ImagePicker.allowsEditing=YES;
    [_SELF presentViewController:ImagePicker animated:YES completion:nil];
    [_SELF.view addSubview:ImagePicker.view];
    
}
//打开相机
-(void)openCarama3
{
    eqStr = @"2";
    UIImagePickerController*imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing=YES;
    imagePicker.delegate=self;
    [_SELF presentViewController:imagePicker animated:YES completion:nil];
    [_SELF.view addSubview:imagePicker.view];
    
    
    
}
//打开相册
-(void)locaPhonto3
{
    eqStr = @"2";
    UIImagePickerController*ImagePicker=[[UIImagePickerController alloc]init];
    ImagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    ImagePicker.delegate=self;
    ImagePicker.allowsEditing=YES;
    [_SELF presentViewController:ImagePicker animated:YES completion:nil];
    [_SELF.view addSubview:ImagePicker.view];
    
}


//打开相机
-(void)openCarama8
{
    eqStr = @"8";
    UIImagePickerController*imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing=YES;
    imagePicker.delegate=self;
    [_SELF presentViewController:imagePicker animated:YES completion:nil];
    [_SELF.view addSubview:imagePicker.view];
    
    
    
}
//打开相册
-(void)locaPhonto8
{
    eqStr = @"8";
    UIImagePickerController*ImagePicker=[[UIImagePickerController alloc]init];
    ImagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    ImagePicker.delegate=self;
    ImagePicker.allowsEditing=YES;
    [_SELF presentViewController:ImagePicker animated:YES completion:nil];
    [_SELF.view addSubview:ImagePicker.view];
    
}
//打开相机
-(void)openCarama9
{
    eqStr = @"9";
    UIImagePickerController*imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing=YES;
    imagePicker.delegate=self;
    [_SELF presentViewController:imagePicker animated:YES completion:nil];
    [_SELF.view addSubview:imagePicker.view];
    
    
    
}
//打开相册
-(void)locaPhonto9
{
    eqStr = @"9";
    UIImagePickerController*ImagePicker=[[UIImagePickerController alloc]init];
    ImagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    ImagePicker.delegate=self;
    ImagePicker.allowsEditing=YES;
    [_SELF presentViewController:ImagePicker animated:YES completion:nil];
    [_SELF.view addSubview:ImagePicker.view];
    
}
//打开相机
-(void)openCarama10
{
    eqStr = @"10";
    UIImagePickerController*imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing=YES;
    imagePicker.delegate=self;
    [_SELF presentViewController:imagePicker animated:YES completion:nil];
    [_SELF.view addSubview:imagePicker.view];
    
    
    
}
//打开相册
-(void)locaPhonto10
{
    eqStr = @"10";
    UIImagePickerController*ImagePicker=[[UIImagePickerController alloc]init];
    ImagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    ImagePicker.delegate=self;
    ImagePicker.allowsEditing=YES;
    [_SELF presentViewController:ImagePicker animated:YES completion:nil];
    [_SELF.view addSubview:ImagePicker.view];
    
}
//打开相机
-(void)openCarama11
{
    eqStr = @"11";
    UIImagePickerController*imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing=YES;
    imagePicker.delegate=self;
    [_SELF presentViewController:imagePicker animated:YES completion:nil];
    [_SELF.view addSubview:imagePicker.view];
    
    
    
}
//打开相册
-(void)locaPhonto11
{
    eqStr = @"11";
    UIImagePickerController*ImagePicker=[[UIImagePickerController alloc]init];
    ImagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    ImagePicker.delegate=self;
    ImagePicker.allowsEditing=YES;
    [_SELF presentViewController:ImagePicker animated:YES completion:nil];
    [_SELF.view addSubview:ImagePicker.view];
    
}


#pragma mark --图片处理的方法---------------------------------------------------------------
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    if ([eqStr isEqualToString:@"0"]) {
        NSString*type=[info objectForKey:UIImagePickerControllerMediaType];
        if ([type isEqualToString:@"public.image"]) {
            UIImage*image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
            NSData*data;
            if (UIImagePNGRepresentation(image)==nil) {
                data=UIImageJPEGRepresentation(image, 1.0);
            }else
            {
                data=UIImagePNGRepresentation(image);
                
            }NSString*DoucmestPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSFileManager*fileManger=[NSFileManager defaultManager];
            
            [fileManger createDirectoryAtPath:DoucmestPath withIntermediateDirectories:YES attributes:nil error:nil];
            [fileManger createFileAtPath:[DoucmestPath stringByAppendingString:@"/image.png"]  contents:data attributes:nil];
            NSString*filePath=[[NSString alloc ]initWithFormat:@"%@%@",DoucmestPath,@"/image.png"];
            [self.Model_ImageArray2  addObject:[UIImage imageWithContentsOfFile:filePath]];
            if (self.Model_ImageArray2.count>0) {
                imageScrollView2.hidden=NO;
                imageScrollView1.hidden=YES;
            }
            [picker dismissViewControllerAnimated:YES completion:nil];
            UIImage * baseImage = [UIImage imageWithContentsOfFile:filePath];
            UIImage * imagess = [self imageWithImage:baseImage scaledToSize:CGSizeMake(600,450)];
            NSData * daImage = UIImagePNGRepresentation(imagess);
            NSData * iamgeData2 = [daImage base64EncodedDataWithOptions:0];
            imageData = [[NSString alloc]initWithData:iamgeData2 encoding:NSUTF8StringEncoding];
            [self.DujiaImageArray addObject:imageData];
            [imageScrollView2 cycleDirection:CycleDirectionLandscape pictures:self.Model_ImageArray2];
        }
        
    }
    else if ([eqStr isEqualToString:@"2"]) {
        NSString*type=[info objectForKey:UIImagePickerControllerMediaType];
        if ([type isEqualToString:@"public.image"]) {
            UIImage*image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
            NSData*data;
            if (UIImagePNGRepresentation(image)==nil) {
                data=UIImageJPEGRepresentation(image, 1.0);
            }else
            {
                data=UIImagePNGRepresentation(image);
                
            }NSString*DoucmestPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSFileManager*fileManger=[NSFileManager defaultManager];
            
            [fileManger createDirectoryAtPath:DoucmestPath withIntermediateDirectories:YES attributes:nil error:nil];
            [fileManger createFileAtPath:[DoucmestPath stringByAppendingString:@"/image.png"]  contents:data attributes:nil];
            NSString*filePath=[[NSString alloc ]initWithFormat:@"%@%@",DoucmestPath,@"/image.png"];
            [self.Model_ImageArray4  addObject:[UIImage imageWithContentsOfFile:filePath]];
            if (self.Model_ImageArray4.count>0) {
                imageScrollView4.hidden=NO;
                imageScrollView3.hidden=YES;
            }
            [self.Model_ImageArray5  addObject:[UIImage imageWithContentsOfFile:filePath]];
            
            if (self.Model_ImageArray5.count>0) {
                imageScrollView5.hidden=YES;
                imageScrollView6.hidden=NO;
            }
            
            
            [picker dismissViewControllerAnimated:YES completion:nil];
            UIImage * baseImage = [UIImage imageWithContentsOfFile:filePath];
            UIImage * imagess = [self imageWithImage:baseImage scaledToSize:CGSizeMake(600,450)];
            NSData * daImage = UIImagePNGRepresentation(imagess);
            NSData * iamgeData2 = [daImage base64EncodedDataWithOptions:0];
            imageData1 = [[NSString alloc]initWithData:iamgeData2 encoding:NSUTF8StringEncoding];
            [self.QianPeiImageArray addObject:imageData1];
            [imageScrollView4 cycleDirection:CycleDirectionLandscape pictures:self.Model_ImageArray4];
            imageData5 = [[NSString alloc]initWithData:iamgeData2 encoding:NSUTF8StringEncoding];
            
            [self.KeyImageArray addObject:imageData5];
            [imageScrollView6 cycleDirection:CycleDirectionLandscape pictures:self.Model_ImageArray5];
           
            
        }
    } else if ([eqStr isEqualToString:@"8"]) {
        NSString*type=[info objectForKey:UIImagePickerControllerMediaType];
        if ([type isEqualToString:@"public.image"]) {
            UIImage*image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
            NSData*data;
            if (UIImagePNGRepresentation(image)==nil) {
                data=UIImageJPEGRepresentation(image, 1.0);
            }else
            {
                data=UIImagePNGRepresentation(image);
                
            }NSString*DoucmestPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSFileManager*fileManger=[NSFileManager defaultManager];
            
            [fileManger createDirectoryAtPath:DoucmestPath withIntermediateDirectories:YES attributes:nil error:nil];
            [fileManger createFileAtPath:[DoucmestPath stringByAppendingString:@"/image.png"]  contents:data attributes:nil];
            NSString*filePath=[[NSString alloc ]initWithFormat:@"%@%@",DoucmestPath,@"/image.png"];
            [self.Model_ImageArray8  addObject:[UIImage imageWithContentsOfFile:filePath]];
                           if (self.Model_ImageArray8.count>0) {
                    imageScrrollView7.hidden=YES;
                    imageScrrollView8.hidden=NO;
                }
          
             [picker dismissViewControllerAnimated:YES completion:nil];
            UIImage * baseImage = [UIImage imageWithContentsOfFile:filePath];
            UIImage * imagess = [self imageWithImage:baseImage scaledToSize:CGSizeMake(600,450)];
            NSData * daImage = UIImagePNGRepresentation(imagess);
            NSData * iamgeData2 = [daImage base64EncodedDataWithOptions:0];
           imageData8 = [[NSString alloc]initWithData:iamgeData2 encoding:NSUTF8StringEncoding];
            [self.KeyImageArray addObject:imageData8];
                   }
        [imageScrrollView8 cycleDirection:CycleDirectionLandscape pictures:self.Model_ImageArray8];
       
        

        
    }else if ([eqStr isEqualToString:@"9"]) {
        NSString*type=[info objectForKey:UIImagePickerControllerMediaType];
        if ([type isEqualToString:@"public.image"]) {
            UIImage*image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
            NSData*data;
            if (UIImagePNGRepresentation(image)==nil) {
                data=UIImageJPEGRepresentation(image, 1.0);
            }else
            {
                data=UIImagePNGRepresentation(image);
                
            }NSString*DoucmestPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSFileManager*fileManger=[NSFileManager defaultManager];
            
            [fileManger createDirectoryAtPath:DoucmestPath withIntermediateDirectories:YES attributes:nil error:nil];
            [fileManger createFileAtPath:[DoucmestPath stringByAppendingString:@"/image.png"]  contents:data attributes:nil];
            NSString*filePath=[[NSString alloc ]initWithFormat:@"%@%@",DoucmestPath,@"/image.png"];
            [self.Model_ImageArray8  addObject:[UIImage imageWithContentsOfFile:filePath]];
//            if (self.Model_ImageArray8.count>0) {
//                imageScrollView3.hidden=YES;
//                imageScrollView4.hidden=NO;
//            }
            [picker dismissViewControllerAnimated:YES completion:nil];
            UIImage * baseImage = [UIImage imageWithContentsOfFile:filePath];
            UIImage * imagess = [self imageWithImage:baseImage scaledToSize:CGSizeMake(600,450)];
            NSData * daImage = UIImagePNGRepresentation(imagess);
            NSData * iamgeData2 = [daImage base64EncodedDataWithOptions:0];
            imageData8 = [[NSString alloc]initWithData:iamgeData2 encoding:NSUTF8StringEncoding];
            [self.KeyImageArray addObject:imageData8];
        }
        [self.Custom_Room_PopoverView7.MainTableView reloadData];
        
        
        
        
    }else if ([eqStr isEqualToString:@"10"]) {
        NSString*type=[info objectForKey:UIImagePickerControllerMediaType];
        if ([type isEqualToString:@"public.image"]) {
            UIImage*image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
            NSData*data;
            if (UIImagePNGRepresentation(image)==nil) {
                data=UIImageJPEGRepresentation(image, 1.0);
            }else
            {
                data=UIImagePNGRepresentation(image);
                
            }NSString*DoucmestPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSFileManager*fileManger=[NSFileManager defaultManager];
            
            [fileManger createDirectoryAtPath:DoucmestPath withIntermediateDirectories:YES attributes:nil error:nil];
            [fileManger createFileAtPath:[DoucmestPath stringByAppendingString:@"/image.png"]  contents:data attributes:nil];
            NSString*filePath=[[NSString alloc ]initWithFormat:@"%@%@",DoucmestPath,@"/image.png"];
            [self.Model_ImageArray4  addObject:[UIImage imageWithContentsOfFile:filePath]];
//            if (self.Model_ImageArray4.count>0) {
//                imageScrrollView7.hidden=YES;
//                imageScrrollView8.hidden=NO;
//            }
            
            [picker dismissViewControllerAnimated:YES completion:nil];
            UIImage * baseImage = [UIImage imageWithContentsOfFile:filePath];
            UIImage * imagess = [self imageWithImage:baseImage scaledToSize:CGSizeMake(600,450)];
            NSData * daImage = UIImagePNGRepresentation(imagess);
            NSData * iamgeData2 = [daImage base64EncodedDataWithOptions:0];
            imageData8 = [[NSString alloc]initWithData:iamgeData2 encoding:NSUTF8StringEncoding];
            [self.KeyImageArray addObject:imageData8];
        }
       
        [self.Custom_Room_PopoverView7.MainTableView reloadData];

        
        
        
        
    }else if ([eqStr isEqualToString:@"11"]) {
        NSString*type=[info objectForKey:UIImagePickerControllerMediaType];
        if ([type isEqualToString:@"public.image"]) {
            UIImage*image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
            NSData*data;
            if (UIImagePNGRepresentation(image)==nil) {
                data=UIImageJPEGRepresentation(image, 1.0);
            }else
            {
                data=UIImagePNGRepresentation(image);
                
            }NSString*DoucmestPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSFileManager*fileManger=[NSFileManager defaultManager];
            
            [fileManger createDirectoryAtPath:DoucmestPath withIntermediateDirectories:YES attributes:nil error:nil];
            [fileManger createFileAtPath:[DoucmestPath stringByAppendingString:@"/image.png"]  contents:data attributes:nil];
            NSString*filePath=[[NSString alloc ]initWithFormat:@"%@%@",DoucmestPath,@"/image.png"];
            [self.Model_ImageArray2  addObject:[UIImage imageWithContentsOfFile:filePath]];
//            if (self.Model_ImageArray2.count>0) {
//                imageScrollView5.hidden=YES;
//                imageScrollView6.hidden=NO;
//            }
            
            [picker dismissViewControllerAnimated:YES completion:nil];
            UIImage * baseImage = [UIImage imageWithContentsOfFile:filePath];
            UIImage * imagess = [self imageWithImage:baseImage scaledToSize:CGSizeMake(600,450)];
            NSData * daImage = UIImagePNGRepresentation(imagess);
            NSData * iamgeData2 = [daImage base64EncodedDataWithOptions:0];
            imageData8 = [[NSString alloc]initWithData:iamgeData2 encoding:NSUTF8StringEncoding];
            [self.KeyImageArray addObject:imageData8];
        }
        
        [self.Custom_Room_PopoverView7.MainTableView reloadData];

        
        
        
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

#pragma mark-------------------RoomRquestModel--------------------------------
/**
 *  签赔的请求
 *
 *  @param signatureDic 传一个字典里面是请求的整合数据
 */
-(void)SignatureDic:(NSDictionary*)signatureDic
{
    PL_PROGRESS_SHOW;
    [[RoomRquestModel defalutRquestModel]signatureRquestModel:signatureDic BackValue:^(id obj,NSString*Result) {
        NSLog(@"%@",obj);
        PL_PROGRESS_DISMISS;
        PL_ALERT_SHOW(Result);
        [self.Custom_Room_PopoverView3.qianPeiData setTitle:@"" forState:0];
        self.Custom_Room_PopoverView3.qianPeiPrice.text=@"";
        self.Custom_Room_PopoverView3.qianPeiDataTextField.placeholder=@"选择";
        [self.Custom_Room_PopoverView2 removeFromSuperview];
        [self.Custom_Room_PopoverView removeFromSuperview];
        [self.Custom_Room_PopoverView3 removeFromSuperview];
        [self.Model_ImageArray2 removeAllObjects];
        [self.Model_ImageArray4 removeAllObjects];
        [self.Model_ImageArray8 removeAllObjects];
        [self.Model_ImageArray5 removeAllObjects];
        [self.DujiaImageArray removeAllObjects];
        [self.KeyImageArray removeAllObjects];
        imageScrollView2.hidden=YES;
        imageScrollView1.hidden=NO;

        
    }];
    
}
/**
 *  添加钥匙的请求
 *
 *  @param signatureDic 传一个字典里面是请求的整合数据
 */
-(void)AddForKeyModel:(NSDictionary*)Dic
{
    PL_PROGRESS_SHOW;
    [[RoomRquestModel defalutRquestModel]AddProKeyRquestModel:Dic BackValue:^(id obj, NSString *Result) {
        PL_PROGRESS_DISMISS;
        NSLog(@"%@",obj);
        PL_ALERT_SHOW(Result);
        
        [self.Custom_Room_PopoverView7 RowHeight:0.01];
        [self.Custom_Room_PopoverView7 RowHeight1:0.1];
        [self.Custom_Room_PopoverView7 RowHeight2:0.1];
        [self.Custom_Room_PopoverView7 RowHeight3:0.1];
        self.Custom_Room_PopoverView4.numKeyTextField.text=@"";
        [self.Custom_Room_PopoverView4.fenhangBtn setTitle:@"" forState:0];
        [self.Custom_Room_PopoverView4.salesmanBtn setTitle:@"" forState:0];
        self.Custom_Room_PopoverView4.PhoneNumber.text=@"";
        self.Custom_Room_PopoverView4.baoyuanBtn.selected=YES;
        self.Custom_Room_PopoverView4.hangjiaBtn.selected=NO;
        self.Custom_Room_PopoverView4.miMakeyBtn.selected=NO;
        self.Custom_Room_PopoverView4.beizhuTextView.text=@"";
        self.Custom_Room_PopoverView4.LinkmanView.hidden=YES;
        ContactMess=@"";
        CheckInUserId=@"";
        PasswordKeyStr=@"0";
        [self.KeyImageArray removeAllObjects];
        [self.Model_ImageArray2 removeAllObjects];
        [self.Model_ImageArray4 removeAllObjects];
        [self.Model_ImageArray8 removeAllObjects];
        [self.KeyImageArray removeAllObjects];
        [self.Model_ImageArray5 removeAllObjects];
        [self.Model_ImageArray8 removeAllObjects];
        [self.Custom_Room_PopoverView7 removeFromSuperview];
        [self.Custom_Room_PopoverView4 removeFromSuperview];
        [self.Custom_Room_PopoverView5 removeFromSuperview];
        imageScrollView5.hidden=YES;
        imageScrollView6.hidden=YES;
        imageScrrollView7.hidden=YES;
        imageScrrollView8.hidden=YES;
    }];
}
/**
 *  钥匙管理
 *
 *  @param signatureDic 传一个字典里面是请求的整合数据
 */
-(void)GetHouseKeyListModel:(NSDictionary*)dic
{
    
    PL_PROGRESS_SHOW;
    [[RoomRquestModel defalutRquestModel]GetHouseKeyListRquestModel:dic BackValue:^(id obj, NSString *Result) {
        if ([Result isEqualToString:@"奔溃性的错误"]) {
            PL_ALERT_SHOW(Result);
        }
        NSString*Jsonstr=obj;
        SBJSON*json=[[SBJSON alloc]init];
        NSDictionary*Dictionary=[json objectWithString:Jsonstr error:nil];
        if ([Dictionary[@"Key"] isEqualToString:@"[]"]) {
            PL_ALERT_SHOW(@"暂无数据");
              PL_PROGRESS_DISMISS;
        }else
        {
            NSMutableArray*arr=[json objectWithString: Dictionary[@"Key"]
                                                error:nil];
            [self.LookKeyArray addObject:arr];
            
            NSMutableArray*ImageArr=[json objectWithString:Dictionary[@"Pro"] error:nil];
             NSArray*imagear=[NSArray array];
            [self.DowdloadImageArray removeAllObjects];
            for (NSDictionary*dic in ImageArr) {
                NSString*ImageUrl=dic[@"ImgUrl"];
           imagear=[ImageUrl componentsSeparatedByString:@","];
            }
            
            for (int i=0; i<imagear.count; i++) {
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imagear[i]]];
                
                NSURLSessionDataTask*Task=[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    
                    if (!(data==nil)) {
                        UIImage*DownloadImage=[UIImage imageWithData:data];
                        
                        [self.DowdloadImageArray addObject:DownloadImage];
                        if (self.DowdloadImageArray.count==imagear.count) {
                            [_SELF presentViewController:self.LookKeyView animated:YES completion:nil];
                            PL_PROGRESS_DISMISS;

                            
                        }
                        
                    }else
                    {
                        PL_ALERT_SHOW(@"请求超时");
                     
 
                    }
                    
                    
                    
                }];
                [Task resume];
                
            }
            
            
        }
        
    }];
    
}

/**
 *  分行
 *
 *  @param signatureDic 传一个字典里面是请求的整合数据
 */
-(void)GetSelectYB_BranchModel:(NSDictionary*)dic
{
    PL_PROGRESS_SHOW;
    [[RoomRquestModel defalutRquestModel]GetSelectYB_BranchRquestModel:dic BackValue:^(NSMutableArray* obj) {
        PL_PROGRESS_DISMISS;
        if (obj.count>0) {
            [self.BranchArray removeAllObjects];

            for (NSDictionary*dic in obj) {
                if ([dic isEqual:@"[]"]) {
                    
                }
                else
                {
                 [self.BranchArray addObject:dic[@"Branch"]];

                }
            }
          
        }else
        {
             PL_ALERT_SHOW(@"没有数据");
        }
       
        
    }];
}
/**
 *  获取业务员
 *
 *  @param dic 字典模型
 */
-(void)Get_BranchModel:(NSDictionary*)dic
{
    PL_PROGRESS_SHOW;
    [[RoomRquestModel defalutRquestModel]GetSelectYB_BranchRquestModel:dic BackValue:^(NSMutableArray* obj) {
        PL_PROGRESS_DISMISS;
        
        if (obj.count>0) {
            [self.SalesmanArray removeAllObjects];
            UserIDarray=[NSMutableArray array];
            for (NSDictionary*dic in obj) {
                
                [self.SalesmanArray addObject:dic[@"UserName"]];
                
                [UserIDarray addObject:dic[@"UserID"]];
            }
            
        }
        
        
        
        [[RoomVC_ViewModel DefalutRoomVC]Custom_Room_PopoverView6_ListPickerView2Delegate:self DataSource:self];
        [self.Custom_Room_PopoverView4.salesmanBtn setTitle:self.SalesmanArray[0] forState:0];
        UserIDstring=UserIDarray [0];
        
    }];
}

#pragma mark ---分行和业务员的pickerview的代理方法
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView==self.Custom_Room_PopoverView6.ListPickerView) {
        return self.BranchArray.count;
    }else if (pickerView==self.Custom_Room_PopoverView6.ListPickerView2 )
    {
        return self.SalesmanArray.count;
    }
    return 1;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (pickerView==self.Custom_Room_PopoverView6.ListPickerView) {
        
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(pickerView.frame.size.width/2-100, 0, 100, 30)];
        
        label.text=self.BranchArray[row];
        label.font=[UIFont fontWithName:@"Helvetica-Bold" size:15 ];
        
        return label;
        
        
    }else if (pickerView==self.Custom_Room_PopoverView6.ListPickerView2)
    {
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(pickerView.frame.size.width/2-140, 0, 60, 30)];
        
        label.text=self.SalesmanArray[row];
        label.font=[UIFont fontWithName:@"Helvetica-Bold" size:15];
        
        return label;
    }
    return nil;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    UserIDstring=@"";
    
    if (pickerView==self.Custom_Room_PopoverView6.ListPickerView)
    {
        [self.Custom_Room_PopoverView4.fenhangBtn setTitle:self.BranchArray[row] forState:UIControlStateNormal];
        ContactMess=self.BranchArray[row];
       
        
    }else if (pickerView==self.Custom_Room_PopoverView6.ListPickerView2)
    {
        [self.Custom_Room_PopoverView4.salesmanBtn setTitle:self.SalesmanArray[row] forState:0];
//        CheckInUserId=self.SalesmanArray[row];
         UserIDstring=UserIDarray[row];
    }
    
    
    
}
#pragma mark 点击钥匙的按钮
-(void)ConfigurationPopoverView4AllButtonMethod
{
    WhereKeyStr=@"宝原";
    CheckInUserId=@"";
    ContactMess=@"";
    UserIDstring=@"";
    
    [self.Custom_Room_PopoverView4.fenhangBtn setTitle:@"" forState:0];
    [self.Custom_Room_PopoverView4.salesmanBtn setTitle:@"" forState:0];
    
    
    self.Custom_Room_PopoverView4.keyView.layer.masksToBounds = YES;
    self.Custom_Room_PopoverView4.keyView.layer.cornerRadius = 5;
    self.Custom_Room_PopoverView4.beizhuTextView.layer.masksToBounds = YES;
    self.Custom_Room_PopoverView4.beizhuTextView.layer.cornerRadius = 5;
    self.Custom_Room_PopoverView4.beizhuTextView.layer.borderWidth =1;
    self.Custom_Room_PopoverView4.beizhuTextView.layer.borderColor = [UIColor grayColor].CGColor;
    [_SELF.view addSubview:self.Custom_Room_PopoverView4];
    /**
     加载在自定义的View
     */
    [self.Custom_Room_PopoverView4.miMakeyBtn addTarget:self action:@selector(clickMiMakeyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.Custom_Room_PopoverView4.baoyuanBtn addTarget:self action:@selector(clickBaoyuanBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.Custom_Room_PopoverView4.hangjiaBtn addTarget:self action:@selector(clickHangjiaBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.Custom_Room_PopoverView4.fenhangBtn addTarget:self action:@selector(clickFenhangBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.Custom_Room_PopoverView4.salesmanBtn addTarget:self action:@selector(clickSalesmanBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.Custom_Room_PopoverView4.upXiuGaiBtn addTarget:self action:@selector(clickUpXiuGaiBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.Custom_Room_PopoverView4.cancelBtn addTarget:self action:@selector(clickCancelBtn4) forControlEvents:UIControlEventTouchUpInside];
    [self.Custom_Room_PopoverView4.lookKeyBtn addTarget:self action:@selector(ClicklookKeyBtn) forControlEvents:UIControlEventTouchUpInside];
    
    dispatch_queue_t ContactMessSubQueue=dispatch_queue_create(ContactMessSubQue, DISPATCH_QUEUE_SERIAL);
    dispatch_sync(ContactMessSubQueue, ^{
        
        NSDictionary*dic=[NSDictionary dictionary];
        dic=@{@"WhereKey":@"",
              @"userid":[PL_USER_STORAGE objectForKey:PL_USER_USERID ],
              @"token":[PL_USER_STORAGE objectForKey:PL_USER_TOKEN ],
              };
        
        [self GetSelectYB_BranchModel:dic];
    });
    
    
    [[RoomVC_ViewModel DefalutRoomVC]Custom_Room_PopoverView6_ListPickerView1Delegate:self DataSource:self];
}
#pragma mark 调用TouchesBegan的方法
-(void)CalltouchesBegan
{
    [self.Custom_Room_PopoverView3.qianPeiPrice resignFirstResponder];
    [self.Custom_Room_PopoverView4.numKeyTextField resignFirstResponder];
    [self.Custom_Room_PopoverView4.PhoneNumber resignFirstResponder];
    [self.Custom_Room_PopoverView4.beizhuTextView resignFirstResponder];
    
}
#pragma mark Custom_PopoverView7delegate
-(UITableViewCell*)TableView:(UITableView *)tableview CellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        UITableViewCell*VisitingCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VistingCell"];
       
        
        
        imageScrollView3=[[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, tableview.frame.size.width, 200)];
        [imageScrollView3 cycleDirection:CycleDirectionLandscape pictures:ModelimageArr1];
        
        [VisitingCell addSubview:imageScrollView3];
            imageScrollView4=[[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0,tableview.frame.size.width, 200)];

        [VisitingCell addSubview:imageScrollView4];

        if (self.Model_ImageArray8.count==0) {
            imageScrollView4.hidden=YES;
            imageScrollView3.hidden=NO;
            
        }else
        {
            [imageScrollView4 cycleDirection:CycleDirectionLandscape pictures:self.Model_ImageArray8];

            imageScrollView4.hidden=NO;
            imageScrollView3.hidden=YES;
            
        }
        return VisitingCell;
        
    }else if (indexPath.section==1)
    {
        
        UITableViewCell*ID_CardCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID_CardCell"];
        
        
        
        imageScrollView5=[[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, tableview.frame.size.width, 200)];
        [imageScrollView5 cycleDirection:CycleDirectionLandscape pictures:ModelimageArr1];
        
        [ID_CardCell addSubview:imageScrollView5];
        imageScrollView6=[[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, tableview.frame.size.width, 200)];
        if (self.Model_ImageArray4.count==0) {
            imageScrollView6.hidden=YES;
            imageScrollView5.hidden=NO;
        }else
        {
            [imageScrollView6 cycleDirection:CycleDirectionLandscape pictures:self.Model_ImageArray4];

            imageScrollView6.hidden=NO;
            imageScrollView5.hidden=YES;

        }
        [ID_CardCell addSubview:imageScrollView6];
        return ID_CardCell;
        
    }else if (indexPath.section==2)
    {
        UITableViewCell*KeyBookCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KeyBookCell"];
       
        imageScrrollView7=[[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, tableview.frame.size.width, 200)];
        [imageScrrollView7 cycleDirection:CycleDirectionLandscape pictures:ModelimageArr1];
        imageScrrollView7.hidden=YES;
        [KeyBookCell addSubview:imageScrrollView7];
        imageScrrollView8=[[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, tableview.frame.size.width, 200)];
        if (self.Model_ImageArray2.count==0) {
            imageScrrollView8.hidden=YES;
            imageScrrollView7.hidden=NO;
        }else
        {
            [imageScrrollView8 cycleDirection:CycleDirectionLandscape pictures:self.Model_ImageArray2];

            imageScrrollView8.hidden=NO;
            imageScrrollView7.hidden=YES;
            
        }
        [KeyBookCell addSubview:imageScrrollView8];
        return KeyBookCell;
        
    }
    
    return nil;
    
}
@end

