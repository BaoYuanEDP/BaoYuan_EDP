
//  RoomDetailVC.m
//  BYFCApp
//
//  Created by PengLee on 14/12/16.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import "RoomDetailVC.h"
#import "PL_Header.h"
#import "GetHouseImage.h"
#import "SHCDemoViewController.h"
#import "RoomVC_ViewModel.h"
const char*ContactMessSubQue;
const char *LoadMapViewQueue_GCD;
@interface RoomDetailVC ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,PopOverDelegate,AWActionSheetDelegate,UITextFieldDelegate,UIAlertViewDelegate>
#define PropertyID [[NSUserDefaults standardUserDefaults]objectForKey:@"PropertyId"]
{
//    ADDPropertyContactData *follow;
    UIScrollView * _scrollow;
    UIImageView * paizhaoImage;
    UIView * view;
    UILabel * fangshi;
    UIView * sousuoView;
    UILabel * style;
    UITextView * textViewLable;
    UIView * sousuoViewstyle;
    NSArray *styleArray;
     UITableView *styleTable;
    UILabel * count;
     TSPopoverController * _popoverController1;
    NSOperationQueue *queue;
    //激活人
    UILabel *statesNameStr;
    //激活时间
    UILabel *statesDateStr;
    //售价
    UILabel * zoomPriceLable;
    //租价
    UILabel  * roomstyleDetail;
    //单价
    UILabel  * danjiaLabele;
    //装修
    UILabel * countNumDetail;
    //独家签赔
    UIButton *exclusiveButton;
    //钥匙
    UIButton *keyButton;
    //存储房子修改情况字典
    NSDictionary *houseDictionary;
    //照片选择路径
    NSString * filePathImages;
    
       CGSize kbSize;
    JiuCuoCell *cell1;
    WriteLoadCell * loadCell;
    //房厅卫阳
    UILabel * sign1;
    //新值
    NSString *oldValue;
    //旧值
    NSString *newValue;
    
    //修改钥匙背景
    UIView *bgView;
    //修改钥匙界面
    UIView *keyChangView;
    
    //宝原
    UIButton *btn1;
    //行家
    UIButton *btn2;
    //选择文件
    
    //
    NSString *eqStr;
    

    NSMutableArray*imageArr1;
    NSMutableArray*imageArr3;
    NSMutableArray*imageArr5;
    
   

}
@property(nonatomic,strong)NSMutableArray*ImageDataArray;
@property(nonatomic,strong)NSMutableArray*ImageDataArray1;
@end

@implementation RoomDetailVC
@synthesize detailTableView;
/**
 *  重新懒加载MapView因为有几个地方都调用了相机，在相机Dismiss方法返回的时候重新调用了ViewWillAppear方法，地图视图在一开始进入界面的时候已经被加载过一次了，然后又创建，形成了冲突所以改成懒加载，在判断MapView为nil的时候再去创建
 *
 *
 */
-(BMKMapView*)mapView
{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, 210)];
        _mapView.mapType = BMKMapTypeStandard;
        
        
        //mapView.showsUserLocation = NO;
        _mapView.showMapScaleBar = YES;
        _mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
        
        _mapView.zoomLevel = 19.0;
        //    mapView.scrollEnabled = true;
        _mapView.zoomEnabled =YES;
        //    mapView.rotateEnabled = YES;
        _mapView.showsUserLocation = YES;
    }
    return _mapView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  获取当前Self
     */
    [[RoomVC_ViewModel DefalutRoomVC]Acquire_RoomDatailVC:self];
    


    imageArr1=[NSMutableArray array];
    [imageArr1 addObject:[UIImage imageNamed:@"ShowBinaryImg.jpg"]];
    [[RoomVC_ViewModel DefalutRoomVC]Acquire_ImageArr1:imageArr1];
    
    imageArr3 = [NSMutableArray array];
    [imageArr3 addObject:[UIImage imageNamed:@"ShowBinaryImg.jpg"]];
    [[RoomVC_ViewModel DefalutRoomVC]Acquire_ImageArr3:imageArr3];
   
    imageArrayContent = [NSMutableArray array];
    [imageArrayContent addObject:[UIImage imageNamed:@"ShowBinaryImg.jpg"]];
    self.navigationController.navigationBarHidden = NO;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeDrop) name:@"changeBTN" object:nil];
    [self request];
    [self genjinListRequest];
   
    if (_loupanArray.count>0) {
         loupanDic=[_loupanArray objectAtIndex:0];
    }
    

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [loupanDic objectForKey:@"EstateName"];
   self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
   
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSLog(@"%@",NSStringFromCGRect(self.navigationController.navigationBar.frame));
    detailTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    detailTableView.tableFooterView = [[UIView alloc]init];
    detailTableView.delegate = self;
    detailTableView.dataSource = self;
    detailTableView.backgroundColor = [UIColor clearColor];
    detailTableView.separatorInset = UIEdgeInsetsZero;
    detailTableView.separatorColor = [UIColor clearColor];
    detailTableView.estimatedRowHeight = 44.0f;
    detailTableView.rowHeight = UITableViewAutomaticDimension;
           // detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    detailTableView.tableFooterView.frame = CGRectZero;
    detailTableView.tableHeaderView.frame = CGRectZero;

    
    [self.view addSubview:detailTableView];
  
    
    
   
    
//    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(0, 0, 30, 40);
//    
//    [backBtn setImage:[UIImage imageNamed:@"return副本.png"] forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(callBackDetail) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
//    self.navigationItem.leftBarButtonItem = left;
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(10, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(callBackDetail) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;

    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    
    [rightBtn setImage:[UIImage imageNamed:@"灰心.png"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"hongxin.png"] forState:UIControlStateSelected];
    [rightBtn addTarget:self action:@selector(shoucang) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
    
    _scrollow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT)];
    _scrollow.backgroundColor = [UIColor clearColor];
    _scrollow.contentSize = CGSizeMake(PL_WIDTH,PL_HEIGHT*2.6);
    
    
//    [self postGetHouseValueUpd];
   
   // 增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow1:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //键盘消失
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide1:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    self.ImageDataArray = [NSMutableArray array];
    self.ImageDataArray1 = [NSMutableArray array];

}
- (void)request
{
    [[CountRequest defaultsRequest]GetLegelProperties:^(NSMutableString *string) {
                                                                    SBJSON *json=[[SBJSON alloc]init];
                                    _countArray=[json objectWithString:string error:nil];
                                } EstateID:[[NSUserDefaults standardUserDefaults]objectForKey:@"ESTATEID"] userid:[[NSUserDefaults standardUserDefaults]objectForKey:@"userName" ] token:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN]];
}
-(void)changeDrop
{
    fangshiBtn.selected=NO;
    
}

- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changeBTN" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"fangshi" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"style" object:nil];
    
    
}

#pragma mark --tabledelegate
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 620;
    }
    
    else if (section==1)
        
    {
        return 210;
    }
    else if (section==6)
    {
        return 69;
        
    }
    else
    {
        return 44;
    }
    
    
    return 0;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 10;
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
    
}

- (CGSize)getSizeWithWidth:(CGFloat)width content:(NSString *)str font:(int)font
{
    
    if (str.length == 0 || !str) {
        
        return CGSizeZero;
    }
    
    
    NSDictionary * attDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor whiteColor],[UIFont systemFontOfSize:font], nil] forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName,NSFontAttributeName, nil]];
    
    
    NSAttributedString * attStr = [[NSAttributedString alloc]initWithString:str attributes:attDic];
    NSRange range = NSMakeRange(0, attStr.length);
    NSDictionary * dic = [attStr attributesAtIndex:0 effectiveRange:&range];
    
    //
    CGRect  rect = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:Nil];
    return rect.size;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
//    if (indexPath.section==9||indexPath.section==7)
    if (indexPath.section==7)
    {
       // [detailTableView beginUpdates];
        
        return 180;
    }
    if (indexPath.section==8)
    {
        
        LouPanCell * cell =(LouPanCell *) [self tableView:detailTableView cellForRowAtIndexPath:indexPath];
              return cell.frame.size.height;
      
        
    }
    if (indexPath.section==2)
    {
        if (![[loupanDic objectForKey:@"Transportation"] length]) {
            return 30;
        }
        else
        {
            return 90;
        }
        
    }
    
    if (indexPath.section==3)
    {
        if (![[loupanDic objectForKey:@"Education"] length]) {
            return 30;
        }
        else
        {
            return 90;
        }
        
    }
    
    if (indexPath.section==4)
    {
        if (![[loupanDic objectForKey:@"Business"] length]) {
            return 30;
        }
        else
        {
            return 85;
        }
        
    }
   
    if (indexPath.section==5)
    {
        if (![[loupanDic objectForKey:@"Hospital"] length]) {
            return 30;
        }
        else
        {
            return 50;
        }
        
        
    }
    if (indexPath.section==6) {
        return 30;
    }
    if (indexPath.section == 9) {
        return 200;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return [self loadWithContentView];
    }
    else if(section==1)
    {
        return [self loadSection1VIEW];
        
    }
    else if (section==2)
    {
        return [self loadSection2View];
    }
    else if (section==3)
    {
        return [self loadSectionVeiw3];
    }
    else if (section==4)
    {
        return [self loadSectionView4];
    }
    else if(section==5)
    {
        return [self loadSectionView5];
    }
    else if (section==6)
    {
        return [self loadSectionView6];
    }
    else if (section==7)
    {
        return [self loadRecordView7];
    }
    else if (section==8)
    {
        return [self loadSection8];
    }
    else if (section==9)
    {
        return [self loadSectionView9];
    }
    return nil;
    
    
    
    
    
}

#pragma mark --图片加载+地图显示
- (UIView *)loadWithContentView
{
    detailDic=[_detailArray objectAtIndex:0];
    if ([[detailDic objectForKey:@"CollectionFlg"]isEqualToString:@"1"]) {
        rightBtn.selected=YES;
    }
    else
    {
        rightBtn.selected=NO;
    }
    
    CGFloat padding = 5;
    
    UIView * _view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH,620)];
    _view1.backgroundColor = [UIColor clearColor];
    UILabel * detailZuLable = [[UILabel alloc]init];
    detailZuLable.text = @"售价:";
    detailZuLable.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    detailZuLable.backgroundColor = [UIColor clearColor];
    [_view1 addSubview:detailZuLable];
    [detailZuLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@12);
        make.left.equalTo(@15);
        make.width.equalTo(@40);
        make.height.equalTo(@20);
    }];
     zoomPriceLable = [[UILabel alloc]init];
    NSLog(@"%@ %@",[houseDictionary objectForKey:@"PriceNew"],[houseDictionary objectForKey:@"UnitName"]);
    if ([[houseDictionary objectForKey:@"Trade"]isEqualToString:@"出售"]||[[houseDictionary objectForKey:@"Trade"]isEqualToString:@"租售"]||[[houseDictionary objectForKey:@"Trade"]isEqualToString:@""])
    {
        if([[houseDictionary objectForKey:@"PriceNew"] isKindOfClass:[NSNull class]])
        {
            zoomPriceLable.text=@"--万元";

        }
        else
        {
         zoomPriceLable.text=[NSString stringWithFormat:@"%@万元",[houseDictionary objectForKey:@"PriceNew"]];
        }
       
    }
    else
    {
        if([[houseDictionary objectForKey:@"PriceNew"] isKindOfClass:[NSNull class]])
        {
            zoomPriceLable.text=@"--万元";
            
        }
        else
        {
            zoomPriceLable.text=[NSString stringWithFormat:@"%@万元",[houseDictionary objectForKey:@"PriceNew"]];
        }
    }
    
    zoomPriceLable.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    
    [_view1 addSubview:zoomPriceLable];
    [zoomPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(detailZuLable.mas_right);
        
        make.centerY.equalTo(detailZuLable.mas_centerY);
        
        make.width.greaterThanOrEqualTo(detailZuLable.mas_width);
        make.height.equalTo(@25);
        
        
    }];
    //单价
    UILabel * shale1 = [[UILabel alloc]init];
    shale1.text = @"单价:";
    shale1.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    shale1.backgroundColor = [UIColor clearColor];
    [_view1 addSubview:shale1];
    [shale1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(detailZuLable.mas_left);
        make.top.equalTo(detailZuLable.mas_bottom).offset(5);
        make.width.equalTo(detailZuLable.mas_width);
        make.height.equalTo(detailZuLable.mas_height);
        
    }];
    danjiaLabele = [[UILabel alloc]init];
    if ([[houseDictionary objectForKey:@"Trade"]isEqualToString:@"出租"]||[[houseDictionary objectForKey:@"Trade"]isEqualToString:@"租售"]||[[houseDictionary objectForKey:@"Trade"]isEqualToString:@""])
    {
        if ([[houseDictionary objectForKey:@"PriceUnit"] isKindOfClass:[NSNull class]]) {
            danjiaLabele.text = [NSString stringWithFormat:@"%@元/㎡",[houseDictionary objectForKey:@"PriceUnit"]];
            danjiaLabele.text = [NSString stringWithFormat:@"--元/㎡"];
            
        }
        else
        {
            danjiaLabele.text = [NSString stringWithFormat:@"%@元/㎡",[houseDictionary objectForKey:@"PriceUnit"]];
            
        }
        
    }
    else{
        
        if ([[houseDictionary objectForKey:@"PriceUnit"] isKindOfClass:[NSNull class]]) {
            danjiaLabele.text = [NSString stringWithFormat:@"%@元/㎡",[houseDictionary objectForKey:@"PriceUnit"]];
            danjiaLabele.text = [NSString stringWithFormat:@"--元/㎡"];

        }
        else
        {
            danjiaLabele.text = [NSString stringWithFormat:@"%@元/㎡",[houseDictionary objectForKey:@"PriceUnit"]];
            
        }

        
    }
    
    danjiaLabele.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    [_view1 addSubview:danjiaLabele];
    [danjiaLabele mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shale1.mas_right);
        make.centerY.equalTo(shale1.mas_centerY);
        //make.width.equalTo(shaleLable.mas_width);
        make.width.greaterThanOrEqualTo(shale1.mas_width);
        make.height.equalTo(shale1.mas_height);
        
    }];
    
    //房型
    UILabel * siglelable = [[UILabel alloc]init];
    siglelable.text = @"房型:";
    siglelable.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    [_view1 addSubview:siglelable];
    [siglelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shale1.mas_left);
        make.top.greaterThanOrEqualTo(shale1.mas_bottom).offset(5);
        make.width.greaterThanOrEqualTo(shale1.mas_width);
        make.height.equalTo(shale1.mas_height);
        
    }];
    sign1 = [[UILabel alloc]init];
    sign1.text = [detailDic objectForKey:@"ROOMSTYLE"];
    //sign1.text = @"3000元/m²";
    sign1.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    
    [_view1 addSubview:sign1];
    [sign1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(siglelable.mas_right);
        make.centerY.equalTo(siglelable.mas_centerY);
        make.width.greaterThanOrEqualTo(siglelable.mas_width);
        make.height.greaterThanOrEqualTo(siglelable.mas_height);
    
    }];
    //栋座
    UILabel * nowStateLable = [UILabel new];
    nowStateLable.text = @"楼号:";
    nowStateLable.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    [_view1 addSubview:nowStateLable];
    [nowStateLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(siglelable.mas_centerX);
        make.left.equalTo(siglelable.mas_left);
        make.top.equalTo(siglelable.mas_bottom).offset(5);
        make.width.greaterThanOrEqualTo(siglelable.mas_width);
        make.height.equalTo(siglelable.mas_height);
        
    }];
    UILabel * stateDetail = [UILabel new];
    stateDetail.text = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"BuildingName"]];
    //stateDetail.text =@"--";
    stateDetail.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE ];
    [_view1 addSubview:stateDetail];
    [stateDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(nowStateLable.mas_right);
        make.centerY.equalTo(nowStateLable.mas_centerY);
        make.width.greaterThanOrEqualTo(nowStateLable.mas_width);
        make.height.equalTo(nowStateLable.mas_height);
        
    }];
    
    //楼层
    UILabel * housePerson = [[UILabel alloc]init];
    housePerson.text = @"楼层:";
    housePerson.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    
    [_view1 addSubview:housePerson];
    [housePerson mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nowStateLable.mas_left);
        make.top.equalTo(nowStateLable.mas_bottom).offset(5);
        make.width.equalTo(nowStateLable.mas_width);
        make.height.equalTo(nowStateLable.mas_height);
        
    }];
    
    UILabel * houseName = [UILabel new];
    houseName.text =[NSString stringWithFormat:@"%@",[detailDic objectForKey:@"Floor1"]];
    //houseName.text = @"吴建国";
    houseName.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    [_view1 addSubview:houseName];
    [houseName mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.greaterThanOrEqualTo(housePerson.mas_right);
        make.centerY.equalTo(housePerson.mas_centerY);
        make.width.greaterThanOrEqualTo(housePerson.mas_width);
        make.height.equalTo(housePerson.mas_height);
    }];
    //装修
    UILabel * countNumLable = [UILabel new];
    
    countNumLable.text = @"装修:";
    countNumLable.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    [_view1 addSubview:countNumLable];
    [countNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(housePerson.mas_left);
        make.top.greaterThanOrEqualTo(housePerson.mas_bottom).offset(5);
        make.width.equalTo(housePerson.mas_width);
        make.height.equalTo(housePerson.mas_height);
        
        
    }];
    
    countNumDetail = [UILabel new];
//    countNumDetail.backgroundColor = [UIColor greenColor];
    countNumDetail.text =[NSString stringWithFormat:@"%@",[detailDic objectForKey:@"PropertyDecoration"]];
    //countNumDetail.text = @"--";
    countNumDetail.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    [_view1 addSubview:countNumDetail];
    [countNumDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(countNumLable.mas_right);
        make.centerY.equalTo(countNumLable.mas_centerY);
        make.width.greaterThanOrEqualTo(countNumLable.mas_width);
        make.height.equalTo(countNumLable.mas_height);
    }];
    
    
    UILabel * styleLble = [UILabel new];
    styleLble.text = @"业主:";
    styleLble.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    [_view1 addSubview:styleLble];
    [styleLble mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(countNumLable.mas_left);
       make.top.greaterThanOrEqualTo(countNumLable.mas_bottom).offset(5);
        make.width.equalTo(countNumLable.mas_width);
        make.height.equalTo(countNumLable.mas_height);
    }];
    
    
    UILabel * stuyleDetaile = [UILabel new];
    stuyleDetaile.text =[NSString stringWithFormat:@"%@",[detailDic objectForKey:@"OwnerName"]];
    //stuyleDetaile.text = @"高层";
    stuyleDetaile.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
    
    [_view1 addSubview:stuyleDetaile];
    [stuyleDetaile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(styleLble.mas_right);
        make.centerY.equalTo(styleLble.mas_centerY);
        make.width.greaterThanOrEqualTo(styleLble.mas_width);
        make.height.equalTo(styleLble.mas_height);
        
    }];

  
    

          //类型
    UILabel * roomStyleLable= [[UILabel alloc]init];
    roomStyleLable.text = @"租价:";
    roomStyleLable.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    [_view1 addSubview:roomStyleLable];
    [roomStyleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_view1.mas_centerX).with.offset(3*padding-5);
        make.centerY.equalTo(detailZuLable.mas_centerY);
        make.width.equalTo(detailZuLable.mas_width);
        make.height.equalTo(detailZuLable.mas_height);
        
    }];
    
    roomstyleDetail = [[UILabel alloc]init];
   if ([[houseDictionary objectForKey:@"Trade"]isEqualToString:@"出租"]||[[houseDictionary objectForKey:@"Trade"]isEqualToString:@"租售"]||[[houseDictionary objectForKey:@"Trade"]isEqualToString:@""])
   {
       if([[houseDictionary objectForKey:@"RentPriceNew"] isKindOfClass:[NSNull class]]){
           roomstyleDetail.text = [NSString stringWithFormat:@"--元/月"];
       }
       else
       {
           roomstyleDetail.text = [NSString stringWithFormat:@"%@元/月",[houseDictionary objectForKey:@"RentPriceNew"]];

       }
   }else
    {
        if([[houseDictionary objectForKey:@"RentPriceNew"] isKindOfClass:[NSNull class]]){
            roomstyleDetail.text = [NSString stringWithFormat:@"--元/月"];
        }
        else
        {
            roomstyleDetail.text = [NSString stringWithFormat:@"%@元/月",[houseDictionary objectForKey:@"RentPriceNew"]];
            
        }

    }
   // roomstyleDetail.text = @"2-1-1-0";
    roomstyleDetail.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    [_view1 addSubview:roomstyleDetail];
    [roomstyleDetail mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(roomStyleLable.mas_right);
        make.centerY.equalTo(roomStyleLable.mas_centerY);
        make.width.greaterThanOrEqualTo(roomStyleLable.mas_width);
        make.height.equalTo(roomStyleLable.mas_height);
        
    }];
    UILabel * squreLable = [[UILabel alloc]init];
    squreLable.text = @"朝向:";
    squreLable.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    [_view1 addSubview:squreLable];
    [squreLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(roomStyleLable.mas_left);
        make.top.equalTo(roomStyleLable.mas_bottom).offset(5);
        make.width.equalTo(roomStyleLable.mas_width);
        make.height.equalTo(roomStyleLable.mas_height);
        
        
    }];
    UILabel * squreDetail = [[UILabel alloc]init];
    squreDetail.text = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"PropertyDirection"]];
    //squreDetail.text =@"60.17m²";
    squreDetail.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    
    [_view1 addSubview:squreDetail];
    [squreDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(squreLable.mas_right);
        make.centerY.equalTo(squreLable.mas_centerY);
        make.width.greaterThanOrEqualTo(squreLable.mas_width);
        make.height.equalTo(squreLable.mas_height);
        
    }];
    UILabel * roomNumberLable = [[UILabel alloc]init];
    roomNumberLable.text = @"面积:";
    roomNumberLable.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    [_view1 addSubview:roomNumberLable];
    [roomNumberLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(squreLable.mas_left);
        make.top.equalTo(squreLable.mas_bottom).offset(5);
        make.width.equalTo(squreLable.mas_width);
        make.height.equalTo(squreLable.mas_height);
        
        
    }];

    UILabel * roomNDetail = [[UILabel alloc]init];
    roomNDetail.text = [NSString stringWithFormat:@"%@ m²",[detailDic objectForKey:@"Square"]];
    //roomNDetail.text = @"--";
    roomNDetail.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    [_view1 addSubview:roomNDetail];
    [roomNDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(roomNumberLable.mas_right);
        make.centerY.equalTo(roomNumberLable.mas_centerY);
        make.width.greaterThanOrEqualTo(roomNumberLable.mas_width);
        make.height.equalTo(roomNumberLable.mas_height);
        
    }];

    UILabel * roomFloor = [[UILabel alloc]init];
    roomFloor.text = @"房号:";
    roomFloor.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    [_view1 addSubview:roomFloor];
    [roomFloor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(roomNumberLable.mas_left);
        make.top.equalTo(roomNumberLable.mas_bottom).offset(5);
        make.width.equalTo(roomNumberLable.mas_width);
        make.height.equalTo(roomNumberLable.mas_height);
        
        
    }];
    UILabel * floorDetail = [UILabel new];
    floorDetail.text =[NSString stringWithFormat:@"%@",[detailDic objectForKey:@"ROOMNO"]];
   // floorDetail.text = @"8/24";
    floorDetail.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    [_view1 addSubview:floorDetail];
    [floorDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(roomFloor.mas_right);
        make.centerY.equalTo(roomFloor.mas_centerY);
        make.width.greaterThanOrEqualTo(roomFloor.mas_width);
        make.height.equalTo(roomFloor.mas_height);
        
    }];
    UILabel * chaoxaingLable = [[UILabel alloc]init];
    
    chaoxaingLable.text = @"类型:";
    chaoxaingLable.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    [_view1 addSubview:chaoxaingLable];
    [chaoxaingLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(roomFloor.mas_left);
        make.top.equalTo(roomFloor.mas_bottom).offset(5);
        make.width.equalTo(roomFloor.mas_width);
        make.height.equalTo(roomFloor.mas_height);
        
        
    }];

    UILabel * chaoxaingDetail = [UILabel new];
    chaoxaingDetail.text =[NSString stringWithFormat:@"%@",[detailDic objectForKey:@"PropertyType"]];
    //chaoxaingDetail.text = @"南";
    chaoxaingDetail.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    [_view1 addSubview:chaoxaingDetail];
    [chaoxaingDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(chaoxaingLable.mas_right);
        make.centerY.equalTo(chaoxaingLable.mas_centerY);
        make.width.greaterThanOrEqualTo(chaoxaingLable.mas_width);
        make.height.equalTo(chaoxaingLable.mas_height);
        
    }];

    


    UILabel * zhuangxiuLable = [[UILabel alloc]init];
    zhuangxiuLable.text = @"现状:";
    zhuangxiuLable.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    [_view1 addSubview:zhuangxiuLable];
    [zhuangxiuLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chaoxaingLable.mas_left);
//        make.top.equalTo(chaoxaingLable.mas_bottom);
        make.width.equalTo(chaoxaingLable.mas_width);
        make.height.equalTo(chaoxaingLable.mas_height);
        make.centerY.equalTo(countNumLable.mas_centerY);
        
        
    }];

    UILabel * zhaungxiuDetail = [UILabel new];
      zhaungxiuDetail.text =[NSString stringWithFormat:@"%@",[detailDic objectForKey:@"PropertyOccupy"]];
    //zhaungxiuDetail.text = @"--";
    zhaungxiuDetail.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    [_view1 addSubview:zhaungxiuDetail];
    [zhaungxiuDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(zhuangxiuLable.mas_right);
        make.centerY.equalTo(zhuangxiuLable.mas_centerY);
        make.width.greaterThanOrEqualTo(zhuangxiuLable.mas_width);
        make.height.equalTo(zhuangxiuLable.mas_height);
        
    }];
    
    UILabel *statesName = [[UILabel alloc]init];
    statesName.text = @"激活人:";
    statesName.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    [_view1 addSubview:statesName];
    [statesName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(styleLble.mas_left);
        make.top.greaterThanOrEqualTo(styleLble.mas_bottom).offset(5);
        make.width.equalTo(styleLble.mas_width);
        make.height.equalTo(styleLble.mas_height);
    }];
    statesNameStr = [[UILabel alloc]init];
    if ([[houseDictionary objectForKey:@"UserName"] isKindOfClass:[NSNull class]]||[[houseDictionary objectForKey:@"UserName"] isEqualToString:@""]) {
        statesNameStr.text = @"";
    }
    else
    {
        statesNameStr.text = [NSString stringWithFormat:@"%@",[houseDictionary objectForKey:@"UserName"]];
        
    }
    statesNameStr.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
    [_view1 addSubview:statesNameStr];
    [statesNameStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(statesName.mas_right).with.offset(padding/2);
        make.centerY.equalTo(statesName.mas_centerY);
        make.height.equalTo(styleLble.mas_height);
        
    }];
    
    statesDateStr = [[UILabel alloc]init];
    statesDateStr.textAlignment = NSTextAlignmentLeft;
    if ([[houseDictionary objectForKey:@"StatusDate"] isKindOfClass:[NSNull class]]||[[houseDictionary objectForKey:@"StatusDate"] isEqualToString:@""]) {
        statesDateStr.text = @"激活时间:";
    }
    else
    {
        if( [statesNameStr.text isEqualToString:@""])
        {
            statesDateStr.text = @"激活时间:";
        }
        else
        {
            statesDateStr.text = [NSString stringWithFormat:@"激活时间:%@",[[houseDictionary objectForKey:@"StatusDate"] substringToIndex:10]];

            
        }
    }
    statesDateStr.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
    [_view1 addSubview:statesDateStr];
    [statesDateStr mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(roomStyleLable.mas_left);
        make.top.greaterThanOrEqualTo(styleLble.mas_bottom).offset(5);
        
        make.width.equalTo(@150);
        make.height.equalTo(styleLble.mas_height);
    }];
    
//    UILabel * yezhudianhua = [UILabel new];
//    yezhudianhua.text = @"业主电话";
//    yezhudianhua.textColor = [UIColor redColor];
//    yezhudianhua.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
//    [_view1 addSubview:yezhudianhua];
//    [yezhudianhua mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(callButton.mas_centerX);
//        make.top.equalTo(callButton.mas_bottom);
//        make.width.greaterThanOrEqualTo(callButton.mas_width);
//        make.height.equalTo(@25);
//        
//    }];
    //
//    UILabel * line1 = [[UILabel alloc]init];
//    line1.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.4];
//    [_view1 addSubview:line1];
//    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_view1.mas_left);
//        make.right.equalTo(_view1.mas_right);
//        make.height.equalTo(@1);
//        make.top.equalTo(countNumLable.mas_bottom);
//        
//        
//        
//    }];
    UILabel * lastChangeLable = [[UILabel alloc]init];
    lastChangeLable.text = @"最后成交价:";
    lastChangeLable.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    [_view1 addSubview:lastChangeLable];
    UILabel * lastPriceLable = [[UILabel alloc]init];
    NSString * lastcount = [detailDic objectForKey:@"LastTradeAmount"];
    if (!lastcount.length) {
        lastPriceLable.text = @"--";

    }
    else
    {
        lastPriceLable.text = [NSString stringWithFormat:@"%@万",[detailDic objectForKey:@"LastTradeAmount"]];
    }
    lastPriceLable.text = [NSString stringWithFormat:@"%@ 万元",[detailDic objectForKey:@"LastTradeAmount"]];
    lastPriceLable.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
    [_view1 addSubview:lastPriceLable];

    UILabel * lastDate = [[UILabel alloc]init];
     NSString * lastdate = [detailDic objectForKey:@"LastTradeDate"];
    lastDate.textAlignment = NSTextAlignmentLeft;
    if (!lastdate.length) {
        
         lastDate.text = @"最后成交时间:--";
    }
    else
    {
       lastDate.text = [NSString stringWithFormat:@"最后成交时间:%@",[detailDic objectForKey:@"LastTradeDate"]];
    }
   
    lastDate.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
    [_view1 addSubview:lastDate];
    [lastChangeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(statesName.mas_left);
        make.top.equalTo(statesName.mas_bottom).offset(5);
        make.width.equalTo(@70);

        make.height.equalTo(statesName.mas_height);
//
    }];
    [lastPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lastChangeLable.mas_right).with.offset(padding/2);
        make.centerY.equalTo(lastChangeLable.mas_centerY);
        make.height.equalTo(zhuangxiuLable.mas_height);
        
    }];

    [lastDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(roomStyleLable.mas_left);
        make.top.equalTo(statesName.mas_bottom).offset(5);
        make.width.equalTo(@150);
        make.height.greaterThanOrEqualTo(lastPriceLable.mas_height);
        
    }];
    
    //打电话红的按钮
    UIButton * callButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [callButton setBackgroundImage:[UIImage imageNamed:@"红电话@2x.png"] forState:UIControlStateNormal];
    //[callButton setImage:[UIImage imageNamed:@"redPhone_1@2x.png"]  attributeTitle:@"业主电话"];
    [callButton addTarget:self action:@selector(callTel) forControlEvents:UIControlEventTouchUpInside];
    [_view1 addSubview:callButton];
    
//    [callButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(countNumLable.mas_left);
//        make.top.greaterThanOrEqualTo(countNumLable.mas_bottom).offset(5);
//        make.width.equalTo(countNumLable.mas_width);
//        make.height.equalTo(countNumLable.mas_height);
//    }];
    
    [callButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@((PL_WIDTH-200)/6));
        make.top.equalTo(lastChangeLable.mas_bottom).offset(15)
        ;
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        
    }];

    //修改按钮
    UIButton *reviseButton = [UIButton new];
    [reviseButton setImage:[UIImage imageNamed:@"管理@2x.png"] forState:UIControlStateNormal];
    [reviseButton addTarget:self action:@selector(clickReviseButton:) forControlEvents:UIControlEventTouchUpInside];
    [_view1 addSubview:reviseButton];
//    [reviseButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        //        make.left.equalTo(roomNDetail.mas_right).with.offset(10*padding);
//        make.top.equalTo(callButton.mas_bottom).with.offset(3*padding);
//        make.right.equalTo(_view1).with.offset(-10);
//        make.width.equalTo(@40);
//        make.height.equalTo(@40);
//        
//    }];
    [reviseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(callButton.mas_right).offset((PL_WIDTH-200)/6);
        make.centerY.equalTo(callButton.mas_centerY);
        make.width.equalTo(callButton.mas_width);
        make.height.equalTo(callButton.mas_height);
        
    }];
    
    //约看的按钮
    UIButton *lookAboutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_view1 addSubview:lookAboutButton];
    [lookAboutButton setBackgroundImage:[UIImage imageNamed:@"约看@2x"] forState:UIControlStateNormal];
    [lookAboutButton addTarget:self action:@selector(clickLookAboutButton:) forControlEvents:UIControlEventTouchUpInside];
//    [lookAboutButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(_view1).with.offset(-10);
//        make.top.equalTo(reviseButton.mas_bottom).with.offset(3*padding);
//        make.height.equalTo(@40);
//        // make.centerY.equalTo(countNumDetail.mas_centerY);
//        make.width.equalTo(@40);
//        
//    }];
    [lookAboutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(reviseButton.mas_right).offset((PL_WIDTH-200)/6);
        make.centerY.equalTo(reviseButton.mas_centerY);
        make.width.equalTo(reviseButton.mas_width);
        make.height.equalTo(reviseButton.mas_height);
    }];
    
    //独家的按钮
    exclusiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_view1 addSubview:exclusiveButton];
    
    if([houseDictionary[@"PropertyTrust"] isEqualToString:@"独家"])
    {
        [exclusiveButton setBackgroundImage:[UIImage imageNamed:@"独家@2x.png"] forState:UIControlStateNormal];

    }
    else if([houseDictionary[@"PropertyTrust"] isEqualToString:@"签赔"])
    {
        [exclusiveButton setBackgroundImage:[UIImage imageNamed:@"签赔@2x.png"] forState:UIControlStateNormal];

    }
    else
    {
        [exclusiveButton setBackgroundImage:[UIImage imageNamed:@"独家灰@2x.png"] forState:UIControlStateNormal];
    }
    [exclusiveButton addTarget:self action:@selector(clickExclusiveButton:) forControlEvents:UIControlEventTouchUpInside];
    //    [lookAboutButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.equalTo(_view1).with.offset(-10);
    //        make.top.equalTo(reviseButton.mas_bottom).with.offset(3*padding);
    //        make.height.equalTo(@40);
    //        // make.centerY.equalTo(countNumDetail.mas_centerY);
    //        make.width.equalTo(@40);
    //
    //    }];
    [exclusiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lookAboutButton.mas_right).offset((PL_WIDTH-200)/6);
        make.centerY.equalTo(lookAboutButton.mas_centerY);
        make.width.equalTo(lookAboutButton.mas_width);
        make.height.equalTo(lookAboutButton.mas_height);
    }];

    
    //钥匙的按钮
    keyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_view1 addSubview:keyButton];
    if([houseDictionary[@"HouseKey"] isEqualToString:@"0"])
    {
        [keyButton setBackgroundImage:[UIImage imageNamed:@"钥匙灰@2x.png"] forState:UIControlStateNormal];
    }
    else
    {
        [keyButton setBackgroundImage:[UIImage imageNamed:@"钥匙@2x.png"] forState:UIControlStateNormal];

    }
    [keyButton addTarget:self action:@selector(clickKeyButton:) forControlEvents:UIControlEventTouchUpInside];
    //    [lookAboutButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.equalTo(_view1).with.offset(-10);
    //        make.top.equalTo(reviseButton.mas_bottom).with.offset(3*padding);
    //        make.height.equalTo(@40);
    //        // make.centerY.equalTo(countNumDetail.mas_centerY);
    //        make.width.equalTo(@40);
    //
    //    }];
    [keyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(exclusiveButton.mas_right).offset((PL_WIDTH-200)/6);
        make.centerY.equalTo(exclusiveButton.mas_centerY);
        make.width.equalTo(exclusiveButton.mas_width);
        make.height.equalTo(exclusiveButton.mas_height);
    }];

    
    UIImageView * huixianImage = [[UIImageView alloc]init];
    huixianImage.image = [UIImage imageNamed:@"heng_hui_duan.png"];
    [_view1 addSubview:huixianImage];
    [huixianImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_view1.mas_left);
        make.right.equalTo(_view1.mas_right).with.offset(0);
        make.top.equalTo(callButton.mas_bottom).with.offset(padding);
        make.height.equalTo(@1);
        
        
    }];
    UIButton * shakePhoto = [UIButton buttonWithType:UIButtonTypeCustom];
    [shakePhoto setBackgroundImage:[UIImage imageNamed:@"房源详情_新_拍照@2x.png"] forState:UIControlStateNormal];
    [shakePhoto addTarget:self action:@selector(loadImageView) forControlEvents:UIControlEventTouchUpInside];
    [_view1 addSubview:shakePhoto];
    
    [shakePhoto mas_makeConstraints:^(MASConstraintMaker *make) {
       
       
        make.right.equalTo(_view1.mas_right);
        
        make.height.equalTo(@25);
        make.top.equalTo(huixianImage.mas_bottom).with.offset(0);
        
        make.width.equalTo(@45);
        
    }];
    
    self.propertyID = [PL_USER_STORAGE objectForKey:@"PropertyId"];
//    [imageArrayContent addObject:[UIImage imageNamed:@"ShowBinaryImg.jpg"]];
     cycle =[[CycleScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(shakePhoto.frame)+5, PL_WIDTH, 256)];
    
    
    [cycle cycleDirection:CycleDirectionLandscape pictures:imageArrayContent];
    
    cycle.backgroundColor = [UIColor clearColor];
    
    [_view1 addSubview:cycle];
    [cycle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(shakePhoto.mas_bottom).with.offset(2);
        make.right.equalTo(@0);
        make.height.equalTo(@256);
        
    }];
        UIImageView * xiahuixianImage = [[UIImageView alloc]init];
    xiahuixianImage.image = [UIImage imageNamed:@"heng_hui_duan.png"];
    [_view1 addSubview:xiahuixianImage];
    [xiahuixianImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(@0);
        make.leading.equalTo(@0);
        make.top.equalTo(cycle.mas_bottom).with.offset(3);
        make.height.equalTo(@1);
        
    }];
    
    

#pragma mark --详情图片
    
    UILabel * addressLable = [[UILabel alloc]init];
    addressLable.text = @"地址:";
    addressLable.font = [UIFont systemFontOfSize:PL_ROOM_DETAIL_FONT_SIGN_SIZE];
    [_view1 addSubview:addressLable];
    [addressLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(xiahuixianImage.mas_bottom).with.offset(3*padding);
        make.width.equalTo(@40);
        make.height.equalTo(@25);
        
    }];
    UITextView  * addressDetail = [[UITextView alloc]init];
    addressDetail.text = [NSString stringWithFormat:@"%@",[loupanDic objectForKey:@"Address2"]];
    //addressDetail.text = @"东方路1800弄";
    addressDetail.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
    addressDetail.editable = NO;
    addressDetail.backgroundColor = [UIColor clearColor];
    addressDetail.contentMode = UIViewContentModeCenter;
    addressDetail.layer.cornerRadius = 5.0f;
    addressDetail.layer.masksToBounds = YES;
    [_view1 addSubview:addressDetail];
    
    [addressDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(addressLable.mas_right);
        make.centerY.greaterThanOrEqualTo(addressLable.mas_centerY).with.offset(5);
        
        make.width.equalTo(@(PL_WIDTH-65));
        make.height.greaterThanOrEqualTo(@40);
    }];
    
 
    return _view1;
    
}
#pragma mark -----点击约看按钮
-(void)clickLookAboutButton:(UIButton *)sender{
    
    
    LookSeeView *lookSeeView = [[LookSeeView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    lookSeeView.propertyIDString = self.propertyID;
    [lookSeeView addSelfInAView:self.view];
    
    lookSeeView.EstStr=loupanDic[@"EstateName"];
    lookSeeView.FloorStr=[NSString stringWithFormat:@"%@号%@室",self.aRoomData.roomBuildingName,self.aRoomData.roomROOMNO];

 }
#pragma mark 点击修改按钮
-(void)clickReviseButton:(UIButton *)sender
{
    SHCDemoViewController *shcVC = [[SHCDemoViewController alloc] initWithNibName:@"SHCDemoViewController" bundle:nil];
    shcVC.reviseRoomData = self.aRoomData;
    shcVC.housDic = houseDictionary;
    [self.navigationController pushViewController:shcVC animated:YES];
}
#pragma mark - 点击独家按钮
-(void)clickExclusiveButton:(UIButton *)sender
{
    NSString*DutyTypeName=[[NSUserDefaults standardUserDefaults]objectForKey:@"DutyTypeName"];
    if ([DutyTypeName isEqualToString:@"营业"]) {
        if ([houseDictionary[@"PropertyTrust"] isEqualToString:@"独家"]||[houseDictionary[@"PropertyTrust"] isEqualToString:@"签赔"]) {
            NSString *strs = [NSString stringWithFormat:@"是否取消%@",houseDictionary[@"PropertyTrust"]];
            UIAlertView *alertViewDujia=[[UIAlertView alloc]initWithTitle:@"提示" message:strs delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
            [alertViewDujia show];
        }
        else
        {
            if ([houseDictionary[@"Status"] isEqualToString:@"有效"]) {
                
                [[RoomVC_ViewModel DefalutRoomVC]ConfigurationPopoverView2AllButtonMethod];

            }
            else
            {
                PL_ALERT_SHOW(@"有效的房源才能发起独家、签赔!");
            }

        }
    }
    else
    {
        PL_ALERT_SHOW(@"您无权操作");
    }

}
#pragma mark -alertView代理
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        NSDictionary*dic=[NSDictionary dictionary];
        NSString *type;
        if ([houseDictionary[@"PropertyTrust"] isEqualToString:@"独家"]) {
            type = @"1";
        }
        else
        {
            type = @"2";
        }
        dic=@{@"PropertyID":PropertyID,
              @"PropertyType":type,
              @"PropertyTrust":@"",
              @"Price":@"",
              @"Date":@"",
              @"jsonData":@"",
              @"userid":[PL_USER_STORAGE objectForKey:PL_USER_USERID],
              @"token":[PL_USER_STORAGE objectForKey:PL_USER_TOKEN],
              };

        PL_PROGRESS_SHOW;
        [[RoomRquestModel defalutRquestModel]signatureRquestModel:dic BackValue:^(id obj,NSString*Result) {
            NSLog(@"%@",obj);
            PL_PROGRESS_DISMISS;
            PL_ALERT_SHOW(Result);
        }];
    }
    else
    {
        NSLog(@"no");
    }

}
#pragma mark - 点击钥匙按钮
-(void)clickKeyButton:(UIButton *)sender
{
    if ([houseDictionary[@"Status"] isEqualToString:@"有效"]) {
        NSString*DutyTypeName=[[NSUserDefaults standardUserDefaults]objectForKey:@"DutyTypeName"];
        
        if ([DutyTypeName isEqualToString:@"营业"]) {
            [[RoomVC_ViewModel DefalutRoomVC]ConfigurationPopoverView4AllButtonMethod];
            
        }
        else
        {
            PL_ALERT_SHOW(@"您无权操作");
        }

    }
    else
    {
        PL_ALERT_SHOW(@"有效的房源才能发起钥匙!");
    }
    
}

#pragma mark 加载iamgeView
- (void)initLoadImageView
{
   
//    PL_PROGRESS_SHOW;
    PL_PROGRESS_SHOW;
    [[GetHouseImage defaultsRequest]GetDetailHouseImage:^(NSMutableString *string) {
        NSLog(@"%@",string);
        PL_PROGRESS_DISMISS;
        if ([string isEqualToString:@"exception"]){
            PL_ALERT_SHOWNOT_OKAND_YES(@"服务器异常");
        }else if ([string isEqualToString:@"[]"]){
            return ;
        }
        else{
            SBJSON *json=[[SBJSON alloc]init];
            imageArray=[json objectWithString:string error:nil];
            // NSDictionary *ImageDic=[imageArray firstObject];
            [imageArrayContent removeAllObjects];
            if (imageArray && [imageArray isKindOfClass:[NSArray class]])
            {
                for (NSDictionary * dict  in imageArray) {
//                    NSString * strImage =[dict objectForKey:@"ImageContent"];
                    NSString *strUrl = [dict objectForKey:@"Url"];
                    if (strUrl)
                    {
//                        NSData * dataImage = [[NSData alloc]initWithBase64EncodedString:strImage options:0];
                        
//                        UIImage * bgimage = [UIImage imageWithData:dataImage];
                        UIImage *bgimage = [UIImage imageWithData:[NSData
                                                                   dataWithContentsOfURL:[NSURL URLWithString:strUrl]]];
                        if (bgimage==nil) {
                            bgimage = [UIImage imageNamed:@"ShowBinaryImg.jpg"];
                        }
                        paizhaoImage.image=bgimage;
                        [imageArrayContent addObject:bgimage];
                        [self.detailTableView reloadData];
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"有图片");
                    [cycle cycleDirection:CycleDirectionLandscape pictures:imageArrayContent];
                    
                    //                PL_PROGRESS_DISMISS;
                    
                });
            }
        }
//        if (![string isEqualToString:@"[]"]) {
//            SBJSON *json=[[SBJSON alloc]init];
//            imageArray=[json objectWithString:string error:nil];
//            // NSDictionary *ImageDic=[imageArray firstObject];
//            [imageArrayContent removeAllObjects];
//            if (imageArray && [imageArray isKindOfClass:[NSArray class]])
//            {
//                for (NSDictionary * dict  in imageArray) {
//                    NSString * strImage =[dict objectForKey:@"ImageContent"];
//                    if (strImage)
//                    {
//                        NSData * dataImage = [[NSData alloc]initWithBase64EncodedString:strImage options:0];
//                        
//                        UIImage * bgimage = [UIImage imageWithData:dataImage];
//                        
//                        paizhaoImage.image=bgimage;
//                        [imageArrayContent addObject:bgimage];
//                        
//                    }
//                }
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSLog(@"有图片");
//                    [cycle cycleDirection:CycleDirectionLandscape pictures:imageArrayContent];
//                    
//                    //                PL_PROGRESS_DISMISS;
//                    
//                });
//            }
//        }
//        else if ([string isEqualToString:@"exception"]){
//            PL_ALERT_SHOWNOT_OKAND_YES(@"服务器异常");
//        }else
//        {
//            PL_ALERT_SHOWNOT_OKAND_YES(@"服务器异常");
//        }
        
    } PropertyId:[[NSUserDefaults standardUserDefaults]objectForKey:@"PropertyId"] mode:@"2" userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]];
}
- (UIView *)loadSection1VIEW
{
    UIView * _view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, 210)];
    _view2.backgroundColor = [UIColor clearColor];
  
    // mapView.delegate = self;
    
  
   [_view2 addSubview:self.mapView];
    UIButton * scaleSmall = [UIButton buttonWithType:UIButtonTypeCustom];
    scaleSmall.frame = CGRectMake(2*PL_WIDTH/3-20, CGRectGetMidY(_view2.frame)+40, 45, 25);
    scaleSmall.tag = 10;
//    if (mapView.zoomLevel==3.0)
//    {
//        scaleSmall.enabled = NO;
//    }
//    else
//    {
//        scaleSmall.enabled = YES;
//    }
    [scaleSmall setTitle:@"" forState:UIControlStateNormal];
    [scaleSmall setBackgroundImage:[UIImage imageNamed:@"缩小.png"] forState:UIControlStateNormal];
    
    scaleSmall.backgroundColor = [UIColor clearColor];
    [scaleSmall addTarget:self action:@selector(scaleMapSize:) forControlEvents:UIControlEventTouchUpInside];
    
    [_view2 addSubview:scaleSmall];
    UIButton * scaleBig = [UIButton buttonWithType:UIButtonTypeCustom];
    scaleBig.frame = CGRectMake(CGRectGetMaxX(scaleSmall.frame), CGRectGetMinY(scaleSmall.frame), 45, 25);
    scaleBig.backgroundColor = [UIColor clearColor];
    [scaleBig addTarget:self action:@selector(scaleMapSize:) forControlEvents:UIControlEventTouchUpInside];
    [scaleBig setTitle:@"" forState:UIControlStateNormal];
    [scaleBig setBackgroundImage:[UIImage imageNamed:@"放大.png"] forState:UIControlStateNormal];
    scaleBig.tag = 20;
    [_view2 addSubview:scaleBig];
    
                      
                      
    
    return _view2;
    
}
#pragma mark --地图放大缩小
- (void)scaleMapSize:(UIButton *)sender
{
    if (sender.tag==10)
    {
        NSLog(@"xiao");
        CLLocationCoordinate2D coor;
        
        
        coor.latitude = [loupanDic[@"YBaidu"] doubleValue];
        coor.longitude = [loupanDic[@"XBaidu"]doubleValue];
        self.mapView.centerCoordinate = coor;
        
        if (self.mapView.zoomLevel >3.0)
        {
            self.mapView.zoomLevel--;
            
        }
        if (self.mapView.zoomLevel==3.0)
        {
            return;
            
        }
    }
    else
    {
        NSLog(@"大");
        CLLocationCoordinate2D coor;
        
        
        coor.latitude = [loupanDic[@"YBaidu"] doubleValue];
        coor.longitude = [loupanDic[@"XBaidu"]doubleValue];
        self.mapView.centerCoordinate = coor;
        if (self.mapView.zoomLevel <19.0)
        {
            self.mapView.zoomLevel++;
            
        }
        if (self.mapView.zoomLevel==19.0)
        {
            return;
            
        }

        
    }
}
- (UIView *)loadSection2View
{
    UIView * sectionView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, 44)];
    UIImageView * bgImageView = [[UIImageView alloc]init];
    bgImageView.image = [UIImage imageNamed:@"hengtiaobeijing.png"];
    [sectionView2 addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(sectionView2.mas_right);
        make.bottom.equalTo(sectionView2.mas_bottom);
        
        
    }];
    UILabel * trslateLable = [UILabel new];
    trslateLable.text = @"交通:";
    trslateLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
    
    [sectionView2 addSubview:trslateLable];
    [trslateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageView.mas_left).with.offset(20);
       // make.top.equalTo(bgImageView.mas_top).with.offset(5);
        make.centerY.equalTo(bgImageView.mas_centerY);
        
    }];
    
    
    return sectionView2;
    
}
- (UIView *)loadSectionVeiw3
{
    UIView * sectionView3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, 44)];
    UIImageView * bgImageView = [[UIImageView alloc]init];
    bgImageView.image = [UIImage imageNamed:@"hengtiaobeijing.png"];
    [sectionView3 addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(sectionView3.mas_right);
        make.bottom.equalTo(sectionView3.mas_bottom);
        
        
    }];
    UILabel * trslateLable = [UILabel new];
    trslateLable.text = @"教育:";
    trslateLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
    
    [sectionView3 addSubview:trslateLable];
    [trslateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageView.mas_left).with.offset(20);
       
        make.centerY.equalTo(bgImageView.mas_centerY);
        
    }];

    return sectionView3;
}
- (UIView *)loadSectionView4
{
    UIView * sectionView4 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, 44)];
    UIImageView * bgImageView = [[UIImageView alloc]init];
    bgImageView.image = [UIImage imageNamed:@"hengtiaobeijing.png"];
    [sectionView4 addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(sectionView4.mas_right);
        make.bottom.equalTo(sectionView4.mas_bottom);
        
        
    }];
    UILabel * trslateLable = [UILabel new];
    trslateLable.text = @"商业:";
    trslateLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
    
    [sectionView4 addSubview:trslateLable];
    [trslateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageView.mas_left).with.offset(20);
        // make.top.equalTo(bgImageView.mas_top).with.offset(5);
        make.centerY.equalTo(bgImageView.mas_centerY);
        
    }];

    return sectionView4;
    
}
- (UIView *)loadSectionView5
{
    UIView * sectionView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, 44)];
    UIImageView * bgImageView = [[UIImageView alloc]init];
    bgImageView.image = [UIImage imageNamed:@"hengtiaobeijing.png"];
    [sectionView2 addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(sectionView2.mas_right);
        make.bottom.equalTo(sectionView2.mas_bottom);
        
        
    }];
    UILabel * trslateLable = [UILabel new];
    trslateLable.text = @"医疗:";
    trslateLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
    
    [sectionView2 addSubview:trslateLable];
    [trslateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageView.mas_left).with.offset(20);
        // make.top.equalTo(bgImageView.mas_top).with.offset(5);
        make.centerY.equalTo(bgImageView.mas_centerY);
        
    }];

    return sectionView2;
    
}
- (UIView *)loadSectionView6
{
    UIView * sectionView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, 69)];
    UIImageView * bgImageView = [[UIImageView alloc]init];
    bgImageView.image = [UIImage imageNamed:@"hengtiaobeijing.png"];
    [sectionView2 addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(sectionView2.mas_right);
        make.height.equalTo(@44);
        
        
    }];
    UILabel * trslateLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 40)];
    trslateLable.text = @"跟进信息:";
    trslateLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
    
    [bgImageView addSubview:trslateLable];
    
    UIButton *allBtn=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH-60, 0, 60,50)];
    [allBtn setTitle:@"全部" forState:UIControlStateNormal];
    [allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    allBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [allBtn addTarget:self action:@selector(allBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [sectionView2 addSubview:allBtn];

    
    [trslateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageView.mas_left).with.offset(20);
        // make.top.equalTo(bgImageView.mas_top).with.offset(5);
        make.centerY.equalTo(bgImageView.mas_centerY).offset(0);
        
    }];
    UIView  * whiteView = [[UIView alloc]init];
    whiteView.backgroundColor = [UIColor clearColor];
    [sectionView2 addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(bgImageView.mas_bottom);
        make.width.equalTo(@(PL_WIDTH));
        make.height.equalTo(@25);
        
        
    }];
    NSInteger paddint  = 0;
    
    UILabel * lable1 = [[UILabel alloc]init];
    lable1.text = @"跟进人";
    lable1.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
    lable1.textColor = [UIColor redColor];
    lable1.textAlignment = NSTextAlignmentCenter;
    lable1.backgroundColor = [UIColor clearColor];
    [whiteView addSubview:lable1];
    
    UILabel * lable2 = [[UILabel alloc]init];
    lable2.text = @"跟进方式";
    lable2.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
    lable2.textColor = [UIColor redColor];
    lable2.backgroundColor = [UIColor clearColor];
    lable2.textAlignment = NSTextAlignmentCenter;
    [whiteView addSubview:lable2];
    UILabel * lable3 = [[UILabel alloc]init];
    lable3.text = @"跟进类型";
    lable3.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
    lable3.textColor = [UIColor redColor];
    lable3.backgroundColor = [UIColor clearColor];
    lable3.textAlignment = NSTextAlignmentCenter;
    [whiteView addSubview:lable3];
    UILabel * lable4 = [[UILabel alloc]init];
    lable4.text = @"客户反馈";
    lable4.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
    lable4.textColor = [UIColor redColor];
    [whiteView addSubview:lable4];
    lable4.backgroundColor = [UIColor clearColor];
    lable4.textAlignment = NSTextAlignmentCenter;
    UILabel * lable5 = [[UILabel alloc]init];
    lable5.text = @"跟进时间";
    lable5.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
    lable5.textColor = [UIColor redColor];
    [whiteView addSubview:lable5];
    lable5.backgroundColor = [UIColor clearColor];
    lable5.textAlignment = NSTextAlignmentCenter;
    UIView * myView = whiteView;
    
    [lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myView.mas_top).with.offset(paddint);
        make.left.equalTo(myView.mas_left).with.offset(paddint);
        make.bottom.equalTo(myView.mas_bottom).with.offset(0);
        make.right.equalTo(lable2.mas_left);
        make.width.equalTo(@[lable4.mas_width,lable2.mas_width,lable3.mas_width,lable5.mas_width]);
        
        make.height.equalTo(@[lable4.mas_height,lable2.mas_height,lable3.mas_height,lable5.mas_height]);
       // make.height.equalTo(@20);
      
    }];
    [lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(myView.mas_top).offset(paddint);
        make.left.greaterThanOrEqualTo(lable1.mas_right).offset(paddint).offset(-10);
        make.bottom.equalTo(myView.mas_bottom).offset(-paddint);
        make.right.equalTo(lable3.mas_left).offset(0);
        make.width.equalTo(@[lable1.mas_width,lable4.mas_width,lable3.mas_width,lable5.mas_width]);
        make.height.equalTo(@[lable1.mas_height,lable4.mas_height,lable3.mas_height,lable5.mas_height]);
        
    }];
    [lable3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(myView.mas_top).offset(paddint);
        make.left.greaterThanOrEqualTo(lable2.mas_right).offset(0);
        make.bottom.equalTo(myView.mas_bottom).offset(-paddint);
        make.right.equalTo(lable4.mas_left).offset(0);
        make.width.equalTo(@[lable1.mas_width,lable2.mas_width,lable4.mas_width,lable5.mas_width]);
        make.height.equalTo(@[lable1.mas_height,lable2.mas_height,lable4.mas_height,lable5.mas_height]);
        
    }];
    [lable4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(myView.mas_top).offset(paddint);
        make.left.greaterThanOrEqualTo(lable3.mas_right).offset(0);
        make.bottom.equalTo(myView.mas_bottom).offset(-paddint);
        make.right.equalTo(lable5.mas_left).offset(0);
        make.width.equalTo(@[lable1.mas_width,lable2.mas_width,lable3.mas_width,lable5.mas_width]);
        make.height.equalTo(@[lable1.mas_height,lable2.mas_height,lable3.mas_height,lable5.mas_height]);
        
    }];
    [lable5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(myView.mas_top).offset(paddint);
        make.left.greaterThanOrEqualTo(lable4.mas_right).offset(paddint);
        make.bottom.equalTo(myView.mas_bottom).offset(-paddint);
        make.right.equalTo(myView.mas_right).offset(-paddint);
        make.width.equalTo(@[lable1.mas_width,lable2.mas_width,lable3.mas_width,lable4.mas_width]);
        make.height.equalTo(@[lable1.mas_height,lable2.mas_height,lable3.mas_height,lable4.mas_height]);
        
    }];
    

    return sectionView2;
    
}
-(void)allBtnClick
{
    AllFollowRoomViewController *all=[[AllFollowRoomViewController alloc]init];
    [self.navigationController pushViewController:all animated:YES];
}
-(UIView *)loadRecordView7
{
    UIView * sectionView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, 44)];
    UIImageView * bgImageView = [[UIImageView alloc]init];
    bgImageView.image = [UIImage imageNamed:@"hengtiaobeijing.png"];
    [sectionView2 addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(sectionView2.mas_right);
        make.bottom.equalTo(sectionView2.mas_bottom);
        
        
    }];
    UILabel * trslateLable = [UILabel new];
    trslateLable.text = @"录入跟进信息:";
    trslateLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
    
    [sectionView2 addSubview:trslateLable];
    [trslateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageView.mas_left).with.offset(20);
        // make.top.equalTo(bgImageView.mas_top).with.offset(5);
        make.centerY.equalTo(bgImageView.mas_centerY);
        
    }];
    _button1 =[UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [sectionView2 addSubview:_button1];
    [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(trslateLable.mas_right);
        make.centerY.equalTo(trslateLable.mas_centerY);
        make.width.equalTo(@70);
        make.height.equalTo(@25);
      
        
    }];
   
    [_button1 setImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    // [_button1 setImage:[UIImage imageNamed:@"dropup.png"] forState:UIControlStateSelected];
    [_button1 addTarget:self action:@selector(genjinfangshiClick:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    _button1.tag = 1145;
    
    _button1.backgroundColor = [UIColor clearColor];
    [_button1 setImageEdgeInsets:UIEdgeInsetsMake(8, 55, 8, 0)];
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 55, 25)];
    
    _titleLable.text = @"跟进方式";
    [_titleLable bringSubviewToFront:_button1];
    _titleLable.userInteractionEnabled= YES;
    _titleLable.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
    [_button1 addSubview:_titleLable];
    
    button2=[UIButton buttonWithType:UIButtonTypeCustom];
    button2.tag = 1146;
    
    [button2 addTarget:self action:@selector(genjinfangshiClick:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    [sectionView2 addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_button1.mas_right).with.offset(20);
        make.centerY.equalTo(bgImageView.mas_centerY);
        make.width.equalTo(_button1.mas_width);
        make.height.equalTo(_button1.mas_height);
        
        
        
    }];
//    [button2 setTitle:@"跟进类型" forState:UIControlStateNormal];
//    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _titleLable1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 55, 25)];
    
    _titleLable1.text = @"跟进类型";
    _titleLable1.userInteractionEnabled= YES;
    [_titleLable1 bringSubviewToFront:button2];
    
    _titleLable1.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
    [button2 addSubview:_titleLable1];
    [button2 setImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    
    //[button2 setBackgroundImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    [button2 setImageEdgeInsets:UIEdgeInsetsMake(8, 55, 8, 0)];
    
    view2=[[UIView alloc]init];
    view2=sectionView2;
    return sectionView2;
    

}
- (UIView *)loadSection8
{
    UIView * sectionView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, 44)];
    UIImageView * bgImageView = [[UIImageView alloc]init];
    bgImageView.image = [UIImage imageNamed:@"hengtiaobeijing.png"];
    [sectionView2 addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(sectionView2.mas_right);
        make.bottom.equalTo(sectionView2.mas_bottom);
        
        
    }];
    UILabel * trslateLable = [UILabel new];
    trslateLable.text = @"楼盘（小区）:";
    
   // trslateLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
    NSMutableAttributedString * attributeing = [[NSMutableAttributedString alloc]initWithString:trslateLable.text];
    [attributeing addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ]} range:NSMakeRange(0, 2)];
    [attributeing addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} range:NSMakeRange(2, attributeing.length-2)];
    trslateLable.attributedText = attributeing;
    
    [sectionView2 addSubview:trslateLable];
    [trslateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageView.mas_left).with.offset(20);
        // make.top.equalTo(bgImageView.mas_top).with.offset(5);
        make.centerY.equalTo(bgImageView.mas_centerY);
        
    }];
    UILabel * areaLable = [UILabel new];
    areaLable.text =[loupanDic objectForKey:@"EstateName"];
    areaLable.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
    [sectionView2 addSubview:areaLable];
    [areaLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(trslateLable.mas_right);
        make.centerY.equalTo(bgImageView.mas_centerY);
        
    }];
    UILabel * youxiaoLable = [UILabel new];
    youxiaoLable.text = @"有效房源:";
    youxiaoLable.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
    [sectionView2 addSubview:youxiaoLable];
    [youxiaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.greaterThanOrEqualTo(bgImageView.mas_centerX).with.offset(120);
        make.centerY.equalTo(bgImageView.mas_centerY);
        
    }];
    UILabel * countRoom = [[UILabel alloc]init];
    NSDictionary *countDic=[_countArray objectAtIndex:0];
    countRoom.textColor = [UIColor redColor];
    countRoom.text =[NSString stringWithFormat:@"%@",[countDic objectForKey:@"EstateCount"]];
    countRoom.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
    [sectionView2 addSubview:countRoom];
    [countRoom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(youxiaoLable.mas_right);
        make.centerY.equalTo(youxiaoLable.mas_centerY);
        
    }];
    return sectionView2;
    

}
- (UIView *)loadSectionView9
{
//    UIView *ciew1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
//    ciew1.backgroundColor = [UIColor yellowColor];
//    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10,8, 44, 44)];
//    title.text = @"纠错";
//    [ciew1 addSubview:title];
//    return ciew1;
    UIView * sectionView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, 44)];
    UIImageView * bgImageView = [[UIImageView alloc]init];
    bgImageView.image = [UIImage imageNamed:@"hengtiaobeijing.png"];
    [sectionView2 addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(sectionView2.mas_right);
        make.bottom.equalTo(sectionView2.mas_bottom);
        
        
    }];
    /************************纠错*************************/
    UILabel * trslateLable = [UILabel new];
    trslateLable.text = @"纠错:";
    trslateLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
    
    [sectionView2 addSubview:trslateLable];
    [trslateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageView.mas_left).with.offset(20);
         make.top.equalTo(bgImageView.mas_top).with.offset(5);
        make.centerY.equalTo(bgImageView.mas_centerY);
        
    }];
    UIButton *upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    upBtn.tag = 1148;
    upBtn.selected=YES;
//    [upBtn setImage:[UIImage imageNamed:@"提交按钮.png"] forState:UIControlStateNormal];
    [upBtn setBackgroundImage:[UIImage imageNamed:@"提交按钮.png"] forState:UIControlStateNormal];
    [sectionView2 addSubview:upBtn];
    [upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgImageView.mas_right).with.offset(-15);
        make.centerY.equalTo(trslateLable.mas_centerY);
        make.width.equalTo(@77);
        make.height.equalTo(@30);
        
    }];
    [upBtn addTarget:self action:@selector(upBtnClick) forControlEvents:UIControlEventTouchUpInside];
    /************************纠错*************************/
    [button11 addTarget:self action:@selector(jiucuoClick:) forControlEvents:UIControlEventTouchUpInside];
    return sectionView2;
//    UILabel * houseRoom = [[UILabel alloc]init];
//    houseRoom.text = @"房源";
//    [sectionView2 addSubview:houseRoom];
//    houseRoom.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
//    [houseRoom mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(button11.mas_right).with.offset(10);
//        make.centerY.equalTo(button11.mas_centerY);
//        
//    }];
//     button22 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button22.tag = 1149;
//    
//    [button22 setImage:[UIImage imageNamed:@"no_checked_hui.png"] forState:UIControlStateNormal];
//    [button22 setImage:[UIImage imageNamed:@"checked_hui.png"]  forState:UIControlStateSelected];
//    [button22 addTarget:self action:@selector(jiucuoClick:) forControlEvents:UIControlEventTouchUpInside];
//    [sectionView2 addSubview:button22];
//    [button22 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(houseRoom.mas_right).with.offset(40);
//        make.centerY.equalTo(bgImageView.mas_centerY);
//        make.width.equalTo(@20);
//        make.height.equalTo(@20);
//    }];
//    UILabel * loupanLable = [[UILabel alloc]init];
//    loupanLable.text = @"楼盘（小区）";
//    [sectionView2 addSubview:loupanLable];
//    loupanLable.font = [UIFont systemFontOfSize:PL_USER_fONT_SIZE];
//    [loupanLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(button22.mas_right).with.offset(10);
//        make.centerY.equalTo(button22.mas_centerY);
//        
//    }];
//    NSMutableAttributedString * attributeing = [[NSMutableAttributedString alloc]initWithString:loupanLable.text];
//    [attributeing addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ]} range:NSMakeRange(0, 2)];
//    [attributeing addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} range:NSMakeRange(2, attributeing.length-2)];
//    loupanLable.attributedText = attributeing;
//
//    return sectionView2;

}
-(void)upBtnClick
{
//    [cell1.jiuCuoText resignFirstResponder];
//    [cell1.jiuCuoDescription resignFirstResponder];
    if([cell1.typeLabel.text isEqualToString:@"请选择"])
    {
        PL_ALERT_SHOW(@"请选择纠错类型");
    }
    else if([cell1.jiuCuoText.text isEqualToString:@""]){
        PL_ALERT_SHOW(@"请输入纠错信息");
    }
    else
    {
        if ([cell1.typeLabel.text isEqualToString:@"房间"]) {
            oldValue = [sign1.text substringWithRange:NSMakeRange(0, 1)];
        }
        else if([cell1.typeLabel.text isEqualToString:@"客厅"])
        {
            oldValue = [sign1.text substringWithRange:NSMakeRange(2, 1)];
        }
        else if([cell1.typeLabel.text isEqualToString:@"卫生间"]){
            oldValue = [sign1.text substringWithRange:NSMakeRange(4, 1)];
        }
        else if([cell1.typeLabel.text isEqualToString:@"阳台"]){
            oldValue = [sign1.text substringWithRange:NSMakeRange(6, 1)];
        }
        else if([cell1.typeLabel.text isEqualToString:@"栋座"]){
            oldValue = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"BuildingName"]];
        }
        else if([cell1.typeLabel.text isEqualToString:@"面积"]){
            oldValue = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"Square"]];
        }
        else if([cell1.typeLabel.text isEqualToString:@"房号"]){
            oldValue = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"ROOMNO"]];
        }
        else if([cell1.typeLabel.text isEqualToString:@"类型"]){
            oldValue = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"PropertyType"]];
        }
        else if([cell1.typeLabel.text isEqualToString:@"所在楼层"]){
            //        [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"Floor1"]];
            oldValue = [[NSString stringWithFormat:@"%@",[detailDic objectForKey:@"Floor1"]] substringWithRange:NSMakeRange(0, 1)];
        }
        else if([cell1.typeLabel.text isEqualToString:@"总楼层"]){
            oldValue = [[NSString stringWithFormat:@"%@",[detailDic objectForKey:@"Floor1"]] substringWithRange:NSMakeRange(2, 1)];
            
        }
        else if([cell1.typeLabel.text isEqualToString:@"朝向"]){
            oldValue = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"PropertyDirection"]];
        }
        else if([cell1.typeLabel.text isEqualToString:@"装修"]){
            oldValue = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"PropertyDecoration"]];
        }
        else if([cell1.typeLabel.text isEqualToString:@"业主"]){
            oldValue = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"OwnerName"]];
        }
        NSLog(@"这个是提纠错提交的按钮");
        PL_PROGRESS_SHOW;
        [[MyRequest defaultsRequest] addErrorPropertyPropertyId:[[NSUserDefaults standardUserDefaults]objectForKey:@"PropertyId" ] PropertyName:[loupanDic objectForKey:@"EstateName"] BuildingNo:[NSString stringWithFormat:@"%@",[detailDic objectForKey:@"BuildingName"]] RoomNo:[NSString stringWithFormat:@"%@",[detailDic objectForKey:@"ROOMNO"]] ErrorContent:cell1.jiuCuoDescription.text ContentType:cell1.typeLabel.text OldValue:oldValue NewValue:cell1.jiuCuoText.text userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completBack:^(id obj) {
            NSLog(@"%@",obj);
            PL_PROGRESS_DISMISS;
            NSString *string=obj;
            if ([string isEqualToString:@"OK"]) {
                PL_ALERT_SHOW(@"提交成功");
                cell1.typeLabel.text =@"请选择";
                cell1.jiuCuoDescription.text=@"";
                cell1.jiuCuoText.text = @"";
                cell1.btnImage.image = [UIImage imageNamed:@"xiala.png"];
            }
            else if ([string isEqualToString:@"exception"]) {
                PL_ALERT_SHOW(@"对不起,服务器异常,请稍后再试");
            }
            else  if ([string isEqualToString:@"ERR"]) {
                PL_ALERT_SHOW(@"提交失败");
            }
            else if ([string isEqualToString:@"1"])
            {
                PL_ALERT_SHOW(@"该房源的纠错审核正在处理中");
            }
            
        }];
    }
    
   }
- (void)genjinfangshiClick:(UIButton *)sender forEvent:(UIEvent *)event
{
    
    if (sender.tag==1145)
    {
         sender.selected=!sender.selected;
        [self popover:sender forEvent:event];
    }
    else
    {
//        NSLog(@"跟进类型");
        sender.selected=!sender.selected;
        [self popover2:sender forEvent:event];
        
        
    }
}
- (void)didSelectPopOverRowIndex:(NSIndexPath *)indexpath cellTitleText:(NSString *)title
{
    [_popoverController1 dismissPopoverAnimatd:YES];
    
   
    if (_popoverController1.view.tag==2541)
    {
         _titleLable.text = title;
        return;
    }
    if (_popoverController1.view.tag==2542)
    {
         _titleLable1.text = title;  
        return;
        
    }
   
    
    
}
-(void)popover:(id)sender forEvent:(UIEvent *)event
{
    
    [_popoverController1 dismissPopoverAnimatd:YES];
   
  
    RoomTableViewController *tableViewController = [[RoomTableViewController alloc] initWithStyle:UITableViewStylePlain];
    tableViewController.delegate = self;
    
   // [tableViewController loadWithData:titleArrayCount];
    
    tableViewController.view.frame = CGRectMake(0,0, 100, 190);
    _popoverController1 = [[TSPopoverController alloc] initWithContentViewController:tableViewController];
    
    _popoverController1.view.tag = 2541;
    
    _popoverController1.cornerRadius = 0;
    
    // popoverController.titleText = @"change order";
    _popoverController1.popoverBaseColor = PL_CUSTOM_COLOR(48, 48, 48, 1);
    _popoverController1.popoverGradient= NO;
    //    popoverController.arrowPosition = TSPopoverArrowPositionHorizontal;
    [_popoverController1 showPopoverWithTouch:event];
    [[MyRequest defaultsRequest]GetFollowWayList:^(NSMutableString *string) {
        if ([string isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
            return ;
            
        }
        else if(string.length)
        {
            SBJSON *json=[[SBJSON alloc]init];
            styleArray=[json objectWithString:string error:nil];
            NSMutableArray * resArray = [NSMutableArray array];
            
            for (NSDictionary * dict in styleArray)
            {
                NSString * followType = dict[PL_ROOM_DETAIL_FOLLOWWAY_LIST];
                [resArray addObject:followType];
                
                
            }
            [tableViewController loadWithData:resArray];
            [tableViewController.tableView reloadData];
            
        }
        else if ([string isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常,请检查网络");
        }
        else
        {
            PL_ALERT_SHOW(@"请求超时");
            return;
            
        }

    } userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]];
   
}

-(void)popover2:(id)sender forEvent:(UIEvent *)event
{
   
    
   // NSArray  * titleArrayCount = @[@"全部",@"出售房",@"出租房",@"待看房",@"收藏房"];
    
    RoomTableViewController *tableViewController = [[RoomTableViewController alloc] initWithStyle:UITableViewStylePlain];
    tableViewController.delegate = self;
   
    
    
    
    tableViewController.view.frame = CGRectMake(0,0,100, 190);
    _popoverController1 = [[TSPopoverController alloc] initWithContentViewController:tableViewController];
    
    
    _popoverController1.cornerRadius = 0;
    _popoverController1.view.tag = 2542;
    
    // popoverController.titleText = @"change order";
    _popoverController1.popoverBaseColor = PL_CUSTOM_COLOR(48, 48, 48, 1);
    _popoverController1.popoverGradient= NO;
    //    popoverController.arrowPosition = TSPopoverArrowPositionHorizontal;
    [_popoverController1 showPopoverWithTouch:event];
    [[MyRequest defaultsRequest]GetFollowTypeList:^(NSMutableString *string) {
        NSLog(@"%@",string);
        if ([string isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
            return ;
            
        }
        else if(string.length)
        {
            SBJSON *json=[[SBJSON alloc]init];
            styleArray=[json objectWithString:string error:nil];
            NSMutableArray * resArray = [NSMutableArray array];
            
            for (NSDictionary * dict in styleArray)
            {
                NSString * followType = dict[PL_ROOM_DETAIL_FOLLOWTYPE_LIST];
                [resArray addObject:followType];
                
                
            }
            [tableViewController loadWithData:resArray];
            [tableViewController.tableView reloadData];
            
        }
        else if ([string isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常,请检查网络");
        }
        else
        {
            PL_ALERT_SHOW(@"请求超时");
            return;
            
        }
        
    } userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]];
    
}



-(void)jiucuoClick:(UIButton *)sender
{
    if (sender.tag==1148)
    {
        button11.selected=YES;
        button22.selected=NO;
        
    }
    else
    {
        button22.selected= YES;
        button11.selected=NO;
    }
}
//纠错
-(void)commitClick
{
    NSString *correctStyle;
    if (button11.selected) {
        NSLog(@"11");
        correctStyle=@"房源";
    }
    else
    {
        correctStyle=@"楼盘";
    }
    
    NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:9];
    WriteLoadCell *write=(WriteLoadCell *)[detailTableView cellForRowAtIndexPath:index];
    
    if (write.genjinTextView.text.length) {
        PL_PROGRESS_SHOW;
        [[MyRequest defaultsRequest]afHandleRoomSourceUserName:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME] correctStyle:correctStyle content:write.genjinTextView.text userToken:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN] call:^(id obj) {
            NSString *string=obj;
            NSLog(@"%@",string);
            if ([string isEqualToString:@"exception"]) {
                PL_ALERT_SHOW(@"提交失败，请联系IT报修台");
            }
            if ([string isEqualToString:@"TRUE"]) {
                PL_ALERT_SHOW(@"提交成功");
            }
            PL_PROGRESS_DISMISS;
        }];
    }
    else
    {
        PL_ALERT_SHOW(@"请输入纠错信息");
        
        
        
    }
    
    
    
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
#pragma mark ---跟进确认按钮
-(void)commitClick2
{

    NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:7];
    WriteLoadCell *write=(WriteLoadCell *)[detailTableView cellForRowAtIndexPath:index];
    [write.genjinTextView resignFirstResponder];
    if ([_titleLable.text isEqualToString:@"跟进方式"]&&[_titleLable1.text isEqualToString:@"跟进类型"]&&[write.genjinTextView.text isEqualToString:@""]) {
        PL_ALERT_SHOW(@"跟进方式、跟进类型、跟进内容不能为空");
    }else if([_titleLable1.text isEqualToString:@"跟进类型"]&&[write.genjinTextView.text isEqualToString:@""]){
         PL_ALERT_SHOW(@"跟进类型、跟进内容不能为空");
    }else if([_titleLable.text isEqualToString:@"跟进方式"]&&[write.genjinTextView.text isEqualToString:@""]){
         PL_ALERT_SHOW(@"跟进方式、跟进内容不能为空");
    }else if([_titleLable.text isEqualToString:@"跟进方式"]&&[_titleLable1.text isEqualToString:@"跟进类型"]){
        PL_ALERT_SHOW(@"跟进方式、跟进类型不能为空");
    }else if([_titleLable.text isEqualToString:@"跟进方式"]){
        PL_ALERT_SHOW(@"跟进方式不能为空");
    }else if([_titleLable1.text isEqualToString:@"跟进类型"]){
        PL_ALERT_SHOW(@"跟进类型不能为空");
    }else if([write.genjinTextView.text isEqualToString:@""]){
         PL_ALERT_SHOW(@"跟进内容不能为空");
    }else if ([self validateNumber:write.genjinTextView.text]){
        PL_ALERT_SHOW(@"输入的内容不能含有电话号码");
    }
    else{
       ADDPropertyContactData * follow=[[ADDPropertyContactData alloc]init];
        follow.PropertyId=[[NSUserDefaults standardUserDefaults]objectForKey:@"PropertyId"];
        follow.FollowType=_titleLable1.text;
        follow.Content=write.genjinTextView.text;
        follow.FollowWay=_titleLable.text;
        follow.userid=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
        follow.token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        NSLog(@"%@  %@  %@  %@  %@  %@",follow.PropertyId,follow.FollowType,follow.Content,follow.FollowWay,follow.userid,follow.token);
        PL_PROGRESS_SHOW;
        [[MyRequest defaultsRequest]addPropertyContact:follow backInfoMessage:^(NSMutableString *string) {
            if ([string isEqualToString:@"NOLOGIN"]) {
                ViewController *login=[[ViewController alloc]init];
                [self.navigationController popToViewController:login animated:YES];
            }
            NSLog(@"string==%@",string);
            if ([string isEqualToString:@"exception"]) {
                PL_ALERT_SHOW(@"提交失败，请联系IT报修台");
                return ;
                
            }
            if ([string isEqualToString:@"OK"]) {
                _titleLable.text = @"跟进方式";
                _titleLable1.text =@"跟进类型";
                NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:7];
                WriteLoadCell *write=(WriteLoadCell *)[detailTableView cellForRowAtIndexPath:index];
                [write.genjinTextView resignFirstResponder];
                write.countNum.text=[NSString stringWithFormat:@"0/100"];
                PL_ALERT_SHOW(@"提交成功");
               
                
                [self ListRefresh];

            }
            else
            {
             PL_ALERT_SHOW(@"提交内容有敏感词汇!");
            }
            PL_PROGRESS_DISMISS;
        }];
        
         
    }

}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==phoneTable) {
        return phoneArr.count;
    }
    if (section==2)
    {
        return 1;
    } 
    if (section==3)
    {
        return 1;
    }
    if (section==4)
    {
        return 1;
    }
    if (section==5)
    {
        return 1;
    }
    if (section==6)
    {
        if (_genjinArray.count==0) {
            return 1;
        }
        else
        {
             return _genjinArray.count;
        }
       
    }
    if (section==7)
    {
        return 1;
    }
    if (section==8)
    {
        return 1;
    }
    if (section==9)
    {
        return 1;
    }
    return 0;
    
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==2||indexPath.section==3||indexPath.section==4||indexPath.section==5)
    {
        RoomDetailCell * cell = [detailTableView dequeueReusableCellWithIdentifier:@"description" ];
        if (cell==nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"RoomDetailCell" owner:nil options:nil] objectAtIndex:0];
        }
        if (indexPath.section==2) {
            if ([[loupanDic objectForKey:@"Transportation"] length]) {
                cell.descriptionLable.text =[NSString stringWithFormat:@"%@",[loupanDic objectForKey:@"Transportation"]];
            }
            else
            {
                cell.descriptionLable.text =@"暂无信息";
            }
            
        }
        else if (indexPath.section==3)
        {
            if ([[loupanDic objectForKey:@"Education"] length]) {
                cell.descriptionLable.text =[NSString stringWithFormat:@"%@",[loupanDic objectForKey:@"Education"]];
            }
            else
            {
                cell.descriptionLable.text =@"暂无信息";
            }
            
        }
        else if (indexPath.section==4)
        {
            if ([[loupanDic objectForKey:@"Business"] length]) {
                cell.descriptionLable.text =[NSString stringWithFormat:@"%@",[loupanDic objectForKey:@"Business"]];
            }
            else
            {
                cell.descriptionLable.text=@"暂无信息";
            }
            
        }
        else if (indexPath.section==5)
        {
             if ([[loupanDic objectForKey:@"Hospital"] length]) {
                 cell.descriptionLable.text =[NSString stringWithFormat:@"%@",[loupanDic objectForKey:@"Hospital"]];
             }
            else
            {
                cell.descriptionLable.text=@"暂无信息";
            }
            
        }
        else
        {
        }
        //cell.descriptionLable.text = @"123";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section==6)
    {
        static NSString * cellider = @"cellidertifer";
        WriteMessageCell * cell =[detailTableView dequeueReusableCellWithIdentifier:cellider];
        
        if (!cell)
        {
            cell = [[WriteMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellider];
        }
        if (_genjinArray.count>0) {
            NSDictionary *dict=[_genjinArray objectAtIndex:indexPath.row];
            cell.lable1.text =[dict objectForKey:@"UserName"];
            cell.lable2.text =[dict objectForKey:@"FollowWay"];
            cell.lable3.text = [dict objectForKey:@"FollowType"];
            cell.lable4.text = [dict objectForKey:@"Content"];
            NSArray * dateA = [[dict objectForKey:@"FollowDate"] componentsSeparatedByString:@" "];
            
            cell.lable5.text =dateA[0];
        }
        return cell;
    }
    if (indexPath.section==8)
    {
        LouPanCell * cell = [detailTableView dequeueReusableCellWithIdentifier:@"loupan" ];
        if (cell==nil)
        {
            cell = [[LouPanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"loupan"];
            cell.backgroundColor = [UIColor clearColor];
            
        }
      
        [cell setCellChangeHeight_roomDistrict:[loupanDic objectForKey:@"Address2"]];
        
    cell.squreLable.text=[NSString stringWithFormat:@"%@ ㎡",[loupanDic objectForKey:@"EstSquare"]];
       
        [cell.areaLable setText:[loupanDic objectForKey:@"DistArea"]];
        NSLog(@"%@1111",cell.areaLable.text);
        cell.countUser.text=[NSString stringWithFormat:@"%@ 户",[loupanDic objectForKey:@"EstRoom"]];
        cell.stopingCount.text=[NSString stringWithFormat:@"%@ 个",[loupanDic objectForKey:@"CarPark"]];
        //cell.componyLableName.text=[loupanDic objectForKey:@"DevCompany"];
        [cell.componyLableName setText:[loupanDic objectForKey:@"DevCompany"]];
        
        cell.areaPrice.text=[NSString stringWithFormat:@"%@月/㎡",[loupanDic objectForKey:@"MgtPrice"]];
        
        cell.completeTime.text=[NSString stringWithFormat:@"%@ 年",[loupanDic objectForKey:@"CompleteYear"]];
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
//    if (indexPath.section==7||indexPath.section==9)
        if (indexPath.section==7)
    {
        loadCell = [detailTableView dequeueReusableCellWithIdentifier:@"cellwrite" ];

        if (loadCell==nil)
        {
            loadCell = [[[NSBundle mainBundle]loadNibNamed:@"WriteLoadCell" owner:nil options:nil] objectAtIndex:0];
            loadCell.genjinTextView.delegate=self;
        }
        if (indexPath.section==7) {
            [loadCell.commitBtn addTarget:self action:@selector(commitClick2) forControlEvents:UIControlEventTouchUpInside];
        }
        if (indexPath.section==9)
        {
            loadCell.countNum.hidden = YES;
            [loadCell.commitBtn addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
        }
        loadCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return loadCell;
    }
    if (indexPath.section == 9) {
        NSString *strID = @"ID";
       cell1 = [tableView dequeueReusableCellWithIdentifier:strID];
        if (cell1 == nil) {
            cell1 = [[[NSBundle mainBundle] loadNibNamed:@"JiuCuoCell" owner:self options:nil] lastObject];
        }
        cell1.jiuCuoDescription.layer.borderWidth = 1;
        cell1.jiuCuoDescription.layer.borderColor = [UIColor grayColor].CGColor;
        cell1.jiuCuoText.layer.borderWidth = 1;
        cell1.jiuCuoText.layer.borderColor = [UIColor grayColor].CGColor;
         cell1.textField1.userInteractionEnabled = NO;
        cell1.textField1.layer.borderWidth =1;
        cell1.textField1.layer.borderColor =[UIColor grayColor].CGColor;
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.jiuCuoDescription.delegate=self;
        cell1.jiuCuoText.delegate=self;
        return cell1;
   
    }
    static NSString * identifer = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer ];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.backgroundColor =nil;
    if (tableView.tag==1523)
    {
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        NSLog(@"%ld",(unsigned long)_genjinArray.count);
        if (_genjinArray.count==0) {
            cell.textLabel.text=@"暂无跟进";
            //cell.textLabel.text = [NSString stringWithFormat:@"%ld  第%ld次跟进描述",(long)indexPath.row+1,(long)indexPath.row+1];
        }else
        {
            NSDictionary *dict=[_genjinArray objectAtIndex:indexPath.row];
            cell.textLabel.text=[NSString stringWithFormat:@"%ld. %@",(unsigned long)indexPath.row+1,[dict objectForKey:@"Content"]];
        }
        
        
    }
    if (tableView.tag==1524)
    {
        NSDictionary *dic=[styleArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [dic objectForKey:@"FollowType"];
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.textLabel.textColor=[UIColor whiteColor];
        cell.backgroundColor=[UIColor clearColor];
    }
    if (tableView==phoneTable) {
            
        
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.section);
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==6)
    {

        if (_genjinArray.count>0)
            
        {
            NSDictionary * dict = [_genjinArray objectAtIndex:indexPath.row];
            
            WriteMessageCell * cell = (WriteMessageCell *)[detailTableView cellForRowAtIndexPath:indexPath];
            GenjinView * genjin = [[GenjinView alloc]initWithUser_Name:cell.lable1.text writeFs:cell.lable2.text writeLX:cell.lable3.text contentString:cell.lable4.text writeDate:[dict objectForKey:@"FollowDate"]];
            [genjin showInView:self.view  animation:YES];
            
        }
        else
        {
            
        }
    }
    [cell1.jiuCuoDescription resignFirstResponder];
    [cell1.jiuCuoText resignFirstResponder];
    [loadCell.genjinTextView resignFirstResponder];
}



-(void)genjinListRequest
{
    NSLog(@" -%@ -%@ -%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"PropertyId"] ,[[NSUserDefaults standardUserDefaults]objectForKey:@"userName" ],[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN]);
        [[MyRequest defaultsRequest] GetPropertyContactListPropertyId:[[NSUserDefaults standardUserDefaults]objectForKey:@"PropertyId"] userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN]string:^(NSMutableString *string) {
            
                if ([string isEqual:PL_NO_LOGIN_])
                {
                    ViewController *login=[[ViewController alloc]init];
                    [self.navigationController popToViewController:login animated:YES];
                    return ;
            
                }
                else if ([string isEqual:@"[]"])
                {
                    // PL_ALERT_SHOWNOT_OKAND_YES(@"此账号暂无跟进信息");
                }
                else if ([string isEqual:@"expection"])
                {
                    PL_ALERT_SHOWNOT_OKAND_YES(string);
            
                }
                else if(string.length)
                {
                    SBJSON *json=[[SBJSON alloc]init];
                    _genjinArray=[json objectWithString:string error:nil];
                    NSLog(@"%ld",(unsigned long)_genjinArray.count);
                    [detailTableView reloadData];
                    
                }

        }];
    
//    [[MyRequest defaultsRequest]GetPropertyContactList:^(NSMutableString *string) {
//        NSLog(@"%@",string);
//
//       
//        
//        
//    } PropertyId:[[NSUserDefaults standardUserDefaults]objectForKey:@"PropertyId"] userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN]];
}


//收藏按钮
-(void)shoucang
{
    NSLog(@"收藏");
    PL_PROGRESS_SHOW;
   [[MyRequest defaultsRequest]CollectPropertyId:[[NSUserDefaults standardUserDefaults] objectForKey:@"PropertyId"] Mode:@"" userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] string:^(NSMutableString *string) {
       PL_PROGRESS_DISMISS;
       if ([string isEqualToString:@"OK"])
       {
           rightBtn.selected=YES;
           PL_ALERT_SHOW(@"收藏成功");
           
           
       }
       else if ([string isEqualToString:@"2"])
       {
           PL_ALERT_SHOW(@"收藏条数超过10条");
           
       }
       else if ([string isEqualToString:@"4"])
       {
           rightBtn.selected=NO;
           
           PL_ALERT_SHOW(@"取消收藏成功");
           
       }
       NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"PropertyId"]);

   }];
//    [[MyRequest defaultsRequest]CollectProperty:^(NSMutableString *string) {
//        if ([string isEqualToString:@"OK"])
//        {
//            rightBtn.selected=YES;
//            PL_ALERT_SHOW(@"收藏成功");
//            
//            
//        }
//        else if ([string isEqualToString:@"2"])
//        {
//            PL_ALERT_SHOW(@"收藏条数超过10条");
//            
//        }
//        else if ([string isEqualToString:@"4"])
//        {
//            rightBtn.selected=NO;
//           
//            PL_ALERT_SHOW(@"取消收藏成功");
//            
//        }
//        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"PropertyId"]);
//    } PropertyId:[[NSUserDefaults standardUserDefaults] objectForKey:@"PropertyId"] Mode:@"" userid:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME] token:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN]];
    
}
-(void)callBackDetail
{
    
    NSArray * arr = self.navigationController.viewControllers;
    RoomSourceVC * room =arr[arr.count-2];
    [self.navigationController popToViewController:room animated:YES];
    
}


#pragma mark - textField delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [cell1.jiuCuoText resignFirstResponder];
    }
       return YES;
}
#pragma mark --textView delegate
/*
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    textView.text=@"";
    return YES;
}
*/
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length >BOOKMARK_WORD_LIMIT)
    {
        textView.text = [textView.text substringToIndex:BOOKMARK_WORD_LIMIT];
       
        
    }
    else
    {
        NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:7];
        WriteLoadCell *write=(WriteLoadCell *)[detailTableView cellForRowAtIndexPath:index];
        
        write.countNum.text=[NSString stringWithFormat:@"%ld/100",(unsigned long)textView.text.length];
       
    }

    
}
-  (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
   
    if (![text isEqualToString:@""]) {
        placeholder.hidden=YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        placeholder.hidden=NO;
    }
    NSString * str = [NSString stringWithFormat:@"%@%@",textView.text,text];
    if (str.length >BOOKMARK_WORD_LIMIT)
    {
        textView.text = [textView.text substringToIndex:BOOKMARK_WORD_LIMIT];
        return NO;
    }
     if ([text isEqualToString:@"\n"])
      {
       
          [cell1.jiuCuoDescription resignFirstResponder];
       
        NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:7];
        WriteLoadCell *write=(WriteLoadCell *)[detailTableView cellForRowAtIndexPath:index];
        [write.genjinTextView resignFirstResponder];
      }
        return YES;
    
}


#pragma mark 请求房源修改前数据
-(void)postGetHouseValueUpd
{
    [[MyRequest defaultsRequest]afGetHouseValueUpdWithPropertyID:self.aRoomData.roomPropertyId completeBack:^(NSString *str) {
        NSLog(@">>>>>>>>%@",str);
        if ([str isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }else if ([str isEqualToString:@"[]"])
        {
            PL_ALERT_SHOW(@"暂无价格");
        }else if([str isEqualToString:@"exception"])
        {
            PL_ALERT_SHOW(@"服务器异常");
        }else
        {
            SBJSON *json=[[SBJSON alloc]init];
            NSArray *resultArray = [json objectWithString:str error:nil];
            houseDictionary = resultArray.firstObject;
            [[RoomVC_ViewModel DefalutRoomVC]Acquire_RoomHouseKey:houseDictionary[@"HouseKey"]];
            NSLog(@"<<<<%@",houseDictionary);
            [self refreshPice:houseDictionary];
        }
    }];
}
#pragma mark 刷新价格和装修情况
-(void)refreshPice:(NSDictionary *)dic
{
    if ([[houseDictionary objectForKey:@"PriceNew"]isKindOfClass:[NSNull class]]) {
        zoomPriceLable.text=@"--万元";
    }else
    {
        zoomPriceLable.text=[NSString stringWithFormat:@"%@万元",[houseDictionary objectForKey:@"PriceNew"]];
    }
    if ([[houseDictionary objectForKey:@"RentPriceNew"]isKindOfClass:[NSNull class]]) {
        roomstyleDetail.text = [NSString stringWithFormat:@"--元/月"];
    }else
    {
        roomstyleDetail.text = [NSString stringWithFormat:@"%@元/月",[houseDictionary objectForKey:@"RentPriceNew"]];
    }
    if([houseDictionary[@"PropertyTrust"] isEqualToString:@"独家"])
    {
        [exclusiveButton setBackgroundImage:[UIImage imageNamed:@"独家@2x.png"] forState:UIControlStateNormal];
        
    }
    else if([houseDictionary[@"PropertyTrust"] isEqualToString:@"签赔"])
    {
        [exclusiveButton setBackgroundImage:[UIImage imageNamed:@"签赔@2x.png"] forState:UIControlStateNormal];
        
    }
    else
    {
        [exclusiveButton setBackgroundImage:[UIImage imageNamed:@"独家灰@2x.png"] forState:UIControlStateNormal];
    }
    if([houseDictionary[@"HouseKey"] isEqualToString:@"0"])
    {
        [keyButton setBackgroundImage:[UIImage imageNamed:@"钥匙灰@2x.png"] forState:UIControlStateNormal];
    }
    else
    {
        [keyButton setBackgroundImage:[UIImage imageNamed:@"钥匙@2x.png"] forState:UIControlStateNormal];
        
    }
    
    if ([[houseDictionary objectForKey:@"PriceUnit"]isKindOfClass:[NSNull class]]) {
        danjiaLabele.text = [NSString stringWithFormat:@"--元/㎡"];
    }else
    {
        danjiaLabele.text = [NSString stringWithFormat:@"%@元/㎡",[houseDictionary objectForKey:@"PriceUnit"]];
    }
    if (!([dic[@"PropertyDecoration"] isKindOfClass:[NSNull class]] ||[dic[@"PropertyDecoration"] isEqual:nil])) {
        countNumDetail.text = dic[@"PropertyDecoration"];
    }
    if ([[houseDictionary objectForKey:@"UserName"] isKindOfClass:[NSNull class]]||[[houseDictionary objectForKey:@"UserName"] isEqualToString:@""]) {
        statesNameStr.text = @"";
    }
    else
    {
        statesNameStr.text = [NSString stringWithFormat:@"%@",[houseDictionary objectForKey:@"UserName"]];
        
    }

    if ([[houseDictionary objectForKey:@"StatusDate"] isKindOfClass:[NSNull class]]||[[houseDictionary objectForKey:@"StatusDate"] isEqualToString:@""]) {
        statesDateStr.text = @"激活时间:";
    }
    else
    {
        if( [statesNameStr.text isEqualToString:@""])
        {
            statesDateStr.text = @"激活时间:";
        }
        else
        {
            statesDateStr.text = [NSString stringWithFormat:@"激活时间:%@",[[houseDictionary objectForKey:@"StatusDate"] substringToIndex:10]];
            
        }
    }
   
}

#pragma mark viewlifecyle
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mapView=nil;
    [self.self.mapView viewWillAppear];
    [self LoadingMapView];
    [self initLoadImageView];
   }
/**
 *  在即将进入界面的时候加载地图
 */
-(void)LoadingMapView
{
    CLLocationCoordinate2D coor;
    
    
    coor.latitude = [loupanDic[@"YBaidu"] doubleValue];
    coor.longitude = [loupanDic[@"XBaidu"]doubleValue];
    //      coor.latitude = 31.2085760;
    //        coor.longitude = 121.5290310;
    
    self.mapView.centerCoordinate = coor;
    BMKPointAnnotation *    pointAnnotation = [[BMKPointAnnotation alloc]init];
    pointAnnotation.coordinate = coor;
    pointAnnotation.title = loupanDic[@"DevCompany"];
    pointAnnotation.subtitle = loupanDic[@"Transportation"];
    [self.mapView addAnnotation:pointAnnotation];
    [detailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(-35, 0, 0, 0));
        
    }];
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;//不用的时候置为nil，否则影响内存的释放
    [self postGetHouseValueUpd];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;//不用时置为nil
    self.mapView=nil;;
}
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{

    static NSString * AnnotationViewID = @"renameMark";
    BMKAnnotationView *newAnnotation = nil;
    
    if (newAnnotation == nil) {
        newAnnotation = [[BMKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        //设置颜色
        ((BMKPinAnnotationView *)newAnnotation).pinColor = BMKPinAnnotationColorGreen;
        //从天上掉下来的效果
        ((BMKPinAnnotationView *)newAnnotation).animatesDrop = YES;
        //设置可拖拽
        ((BMKAnnotationView *)newAnnotation).draggable = YES;
        
        UIView *customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
        customView.backgroundColor = [UIColor orangeColor];
        
        BMKActionPaopaoView *test = [[BMKActionPaopaoView alloc]initWithCustomView:customView];
        ((BMKPinAnnotationView *)newAnnotation).paopaoView = test;
        
    }
    return newAnnotation;
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"=======%s",__FUNCTION__);
    [_scrollow endEditing:YES];
    
    [[RoomVC_ViewModel DefalutRoomVC]CalltouchesBegan];
    
}


//-(void)sureClick
//{
//
//    if ([fangshi.text isEqualToString:@"跟进方式"]||[style.text isEqualToString:@"跟进类型"]||[loadCell.genjinTextView.text isEqualToString:@""]) {
//        PL_ALERT_SHOWNOT_OKAND_YES(@"跟进内容或跟进内容或跟进类型不能为空");
//    }else
//    {
//        ADDPropertyContactData *follow=[[ADDPropertyContactData alloc]init];
//        follow.PropertyId=[[NSUserDefaults standardUserDefaults]objectForKey:@"PropertyId"];
//        
////        if ([style.text isEqualToString:@"跟进类型"]) {
////            follow.FollowType=@"";
////            //PL_ALERT_SHOW(@"跟进类型不能为空");
////        }else
////        {
//            follow.FollowType=style.text;
////        }
//        
////        follow.Content=textViewLable.text;
//        follow.Content=loadCell.genjinTextView.text;
//        //        if ([fangshi.text isEqualToString:@"跟进方式"]) {
////            follow.FollowWay=@"";
////            // PL_ALERT_SHOW(@"跟进方式不能为空");
////        }else{
//            follow.FollowWay=fangshi.text;
////        }
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
//            else
//            {
//                PL_ALERT_SHOWNOT_OKAND_YES(string);
//                 [self ListRefresh];
//            }
//          
//           
//        }];
//    }
//
//    
//   }
-(void)ListRefresh
{
    NSLog(@" %@ %@ %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"PropertyId"] ,[[NSUserDefaults standardUserDefaults]objectForKey:@"userName" ],[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN]);
    [[VisitersRequest defaultsRequest]GetPropertyContactList:^(NSMutableString *string) {
        NSLog(@"%@",string);
        if ([string isEqualToString:PL_NO_LOGIN_])
        {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController popToViewController:login animated:YES];
            return ;
            
        }
        else if ([string isEqualToString:@"[]"])
        {
            PL_ALERT_SHOWNOT_OKAND_YES(@"此账号暂无跟进信息");
        }
        else if ([string isEqualToString:@"expection"])
        {
            PL_ALERT_SHOWNOT_OKAND_YES(string);
            
        }
        else if(string.length)
        {
            SBJSON *json=[[SBJSON alloc]init];
            _genjinArray=[json objectWithString:string error:nil];
            NSLog(@"******%ld",(unsigned long)_genjinArray.count);
            [detailTableView reloadData];
            
        }

        
        
    } PropertyId:[[NSUserDefaults standardUserDefaults]objectForKey:@"PropertyId"] userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN]];
    
}


-(void)callTel
{
    NSLog(@"打电话");

    NSDictionary *phoneDic=[_detailArray objectAtIndex:0];
    NSString *phoneStr=[phoneDic objectForKey:@"OwnerTel"];
    
    phoneArr=[phoneStr componentsSeparatedByString:@","];
    TelViewAlert * alert = [[TelViewAlert alloc]initWithconnectWithArray:phoneArr Calltype:callType_Room custId:self.propertyID];
    [alert showTelWindow:self.view];
    alert.stringTitle = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"OwnerName"]];
   
    
}
-(void)deleteClick
{
    [phonebg removeFromSuperview];
    
}
-(void)loadImageView
{

    AWActionSheet *sheet = [[AWActionSheet alloc] initWithIconSheetDelegate:self ItemCount:[self numberOfItemsInActionSheet]];
    [sheet show];
    

}
-(int)numberOfItemsInActionSheet
{
    return 7;
}

-(AWActionSheetCell *)cellForActionAtIndex:(NSInteger)index
{
    NSArray * imageArr = @[[UIImage imageNamed:@"卧室.png"],[UIImage imageNamed:@"客厅.png"],[UIImage imageNamed:@"厨房.png"],[UIImage imageNamed:@"卫生间.png"],[UIImage imageNamed:@"阳台.png"],[UIImage imageNamed:@"户型图.png"],[UIImage imageNamed:@"其他.png"]];
    
    AWActionSheetCell* cell = [[AWActionSheetCell alloc] init];
    
    
    cell.iconView.image = imageArr[index] ;
    
    
    cell.index = (int)index;
    return cell;
}
-  (void)DidTapOnItemAtIndex:(NSInteger)index title:(NSString *)name
{
    NSLog(@"tap on %d--- titl%@",(int)index,name);
    NSArray * titleArr = @[@"卧室",@"客厅",@"厨房",@"卫生间",@"阳台",@"户型图",@"其他"];
    _photoCacheType = titleArr[index];
    
    
    //[TapToShowActionsheet setText:[NSString stringWithFormat:@"Selected Item %d",(int)index]];
    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"使用手机相册",@"打开相机拍照" ,nil];
    [actionSheet showInView:self.view];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
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
    eqStr = @"1";
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    picker.allowsEditing =YES;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
//    [self.view addSubview:picker.view];
}
//打开照相机
-(void)openCarama
{
    eqStr = @"1";
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else
    {
        
    }
}
//选中图片
#pragma mark --图片处理的方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
     if([eqStr isEqualToString:@"1"])
    {
        NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
        
        //当选择的类型是图片
        if ([type isEqualToString:@"public.image"])
        {
            //先把图片转成NSData
            UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            NSData *data;
            if (UIImagePNGRepresentation(image) == nil)
            {
                data = UIImagePNGRepresentation(image);
            }
            else
            {
                data = UIImageJPEGRepresentation(image, 1.0);
            }
            //图片保存的路径
            //这里将图片放在沙盒的documents文件夹中
            NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            
            //文件管理器
            NSFileManager *fileManager = [NSFileManager defaultManager];
            
            //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
            [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
            [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
            
            //得到选择后沙盒中图片的完整路径
            filePathImage = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
            UIImage * baseImage = [UIImage imageWithContentsOfFile:filePathImage];
            //        UIImage * imagess = [self imageWithImage:baseImage scaledToSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
            UIImage * imagess = [self imageWithImage:baseImage scaledToSize:CGSizeMake(600,450)];
            
            NSData * daImage = UIImagePNGRepresentation(imagess);
            NSData * iamgeData = [daImage base64EncodedDataWithOptions:0];
            NSString * lipeng = [[NSString alloc]initWithData:iamgeData encoding:NSUTF8StringEncoding];
            //关闭相册界面
            [picker dismissViewControllerAnimated:YES completion:NULL];
            NSString *strG = [NSString string];
            if ([_photoCacheType isEqualToString:@"卧室"]) {
                strG = @"1";
            }else
            {
                strG = @"0";
            }
            PL_PROGRESS_IMAGE;
            [[MyRequest defaultsRequest]uploadImage:[NSString stringWithFormat:@"%@",self.propertyID] type:_photoCacheType phovalue:@"房源" photoValue:strG imagebytes:lipeng userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] string:^(NSString *str) {
                PL_PROGRESS_DISMISS;
                
                if ([str isEqualToString:@"OK"])
                {
                    PL_ALERT_SHOW(@"图片网上业务发展部审核中.....");
                    [self initLoadImageView];
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
//当键盘出现或改变时调用
- (void)keyboardWillShow1:(NSNotification *)aNotification
{
    //创建一个仿射变换，平移(0, -100)视图上移100像素
    CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, -200);
//    //使视图使用这个变换
  detailTableView.transform = pTransform;
 }


//当键退出时调用
- (void)keyboardWillHide1:(NSNotification *)aNotification
{
    //创建一个仿射变换，平移(0, -100)视图上移100像素
    CGAffineTransform pTransform = CGAffineTransformMakeTranslation(0, 0);
//    //使视图使用这个变换
    detailTableView.transform = pTransform;
    
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
