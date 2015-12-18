
//  XJSubViewController.m
//  BYFCApp
//
//  Created by 王鹏 on 15/8/28.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "XJSubViewController.h"
#import "XJViewController.h"
#import "HolidayCustomCell.h"
#import "PL_Header.h"
#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#import "CalendarDayModel.h"
#import "CycleScrollView.h"
#import "HolidayCell.h"
#import "SingleHoulidayModel.h"
@interface XJSubViewController ()<UITextFieldDelegate,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>
{
    
   
    NSArray*array;
    UIDatePicker* DatePicker;
    UIView*DatebackView;
    NSString*updataTypeStr;
    int hourString;
    NSString *lipeng;
    NSString *imageFlg;
    UIAlertView *alertView;
    NSString *start;
    NSString *end;
    NSString *typeNum;
//   获取的时间
    NSString*str1;
    NSString*str2;
    NSString*str3;
    NSString*str4;
    NSString*dateString;
    NSString*DateString2;
    CalendarHomeViewController*chvc;
//  弹出的二级添加假期的列表
    UITableView*AddHolidayTableView;
//    弹出的背景view
    UIView*BackGroundView;
       UIImageView*imageView;
//    图片的数组
    NSMutableArray*imageArray;
    //图片滚动ScrollView
    CycleScrollView *cycleScroll;
    NSMutableArray*imageArray2;
    CycleScrollView*cycleScrollHid;
    UITextView*reasonTextView;
    UILabel*reasonlabel;

    UIView*footerView;
    UIButton*addFuJianBtn;
    UIButton*addHoliday;
//    单条数据的字典
    NSDictionary*OneDic;
//    弹出请假类型的列表
    NSMutableArray *arrayData;
//    请假类型
    NSString*TypeStr;
//    数字型的请假类型
    NSString*Num_Str;
//    数字的类型
    NSNumber*numberStr;
//    请求的时间
    int AfterComputingTime;
    int Annualleave;
    int Paidsickleave;
    int Offleave;
//    请求来的数据
    NSArray*ARR;
    
//    提前延后续假的制定数字传值
    NSString*ApprovalType;
//    旧的时间
    NSString*OldStarData;
//    附属的arraydata
    NSMutableArray*arrayData2;
    
}
@property(nonatomic)BOOL isTextFile1;
//新添加的假期数组
@property(nonatomic,strong)NSMutableArray*HoulidayArray;
//请假类型数组
@property(nonatomic,strong)NSMutableArray*TypeArray;
//请假类型PickerView
@property(nonatomic,strong)   UIPickerView*TypePickerView;
//时间选择器
@property(nonatomic,strong)UIPickerView*HousPicker;
//时间选择器2
@property(nonatomic,strong)UIPickerView*HousPicker2;
//传的字典数据
@property(nonatomic,strong)NSDictionary*MultibarDic;
//图片的data数组
@property(nonatomic,strong)NSMutableArray*ImageDataArray;
@end

@implementation XJSubViewController
//lazy loading imagedatarray
-(NSMutableArray*)ImageDataArray
{
    if (!_ImageDataArray) {
        _ImageDataArray=[NSMutableArray array];
    }
    return _ImageDataArray;
}
//lazy loadding
-(NSDictionary*)MultibarDic
{
    if (!_MultibarDic) {
        _MultibarDic=[NSDictionary dictionary];
    }
    return _MultibarDic;
    
    
}
//lazy loading
-(UIPickerView*)HousPicker2
{
    if (!_HousPicker2) {
     
    _HousPicker2=[[UIPickerView alloc]initWithFrame:CGRectMake(0, AddHolidayTableView.frame.origin.y+AddHolidayTableView.frame.size.height+50, PL_WIDTH, 200)];
    _HousPicker2.backgroundColor=[UIColor whiteColor];
    _HousPicker2.delegate=self;
    _HousPicker2.dataSource=self;
    _HousPicker2.hidden=YES;
    [BackGroundView addSubview:_HousPicker2];
    

    }
    return _HousPicker2;
}
-(UIPickerView*)HousPicker
{
    if (!_HousPicker) {
_HousPicker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, AddHolidayTableView.frame.origin.y+AddHolidayTableView.frame.size.height+50, PL_WIDTH, 200)];
    _HousPicker.backgroundColor=[UIColor whiteColor];
    _HousPicker.delegate=self;
    _HousPicker.dataSource=self;
    _HousPicker.hidden=YES;
    [BackGroundView addSubview:_HousPicker];
    }
    return _HousPicker;
}
-(UIPickerView*)TypePickerView
{
    if (!_TypePickerView) {
        _TypePickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, AddHolidayTableView.frame.origin.y+AddHolidayTableView.frame.size.height+70, PL_WIDTH, 200)];
        _TypePickerView.dataSource=self;
        _TypePickerView.delegate=self;
        _TypePickerView.hidden=YES;
        _TypePickerView.backgroundColor=[UIColor whiteColor];
        [BackGroundView addSubview:_TypePickerView];
    }
    return _TypePickerView;
}
-(NSMutableArray*)TypeArray
{
    if (!_TypeArray) {
        _TypeArray=[NSMutableArray array];
    }
    return _TypeArray;
    
    
}
-(NSMutableArray*)HoulidayArray
{
    if (!_HoulidayArray) {
        _HoulidayArray=[NSMutableArray array];
    }
    return _HoulidayArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    ApprovalType=@"1";
    self.title = @"请假申请修改";
    ARR=[NSArray array];
    NSDateFormatter*datef=[[NSDateFormatter alloc]init];
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    datef.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    _StarTime.text=[datef stringFromDate:DatePicker.date];
    _EndTime.text=[datef stringFromDate:DatePicker.date];
    _StarTime.delegate=self;
    _EndTime.delegate=self;
  
    [self requestHolidayList];
    
    
    
    UIImageView *heng=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, PL_WIDTH,1)];
    heng.image=[UIImage imageNamed:@"heng_hong.png"];
    [self.view addSubview:heng];
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTouch)];
    [self.view addGestureRecognizer:tap];
    _advancedimage.image=[UIImage imageNamed:@"BlueIosCheCkBox"];
    _postponeimage.image=[UIImage imageNamed:@"chechkboxhover"];
    _successorimage.image=[UIImage imageNamed:@"chechkboxhover"];
    updataTypeStr=@"1";
    lipeng = @"";
    [self PopBackGroundView];
    [self initTableViewFootView];
    self.tableViewList.delegate = self;
    self.tableViewList.dataSource = self;
    self.tableViewList.backgroundColor=[UIColor redColor];
    
    
   }

-(void)requestHolidayList
{
    PL_PROGRESS_SHOW;
    arrayData  = [NSMutableArray array];
    arrayData2=[NSMutableArray array];
    [[MyRequest defaultsRequest]GetAskForLeave_ListprocessId:[self.presosIdStr substringFromIndex:5] userid:[PL_USER_STORAGE objectForKey:PL_USER_USERID] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] string:^(NSMutableArray *arr) {
        if([arr[0] isEqual:@"exception"])
        {
            PL_ALERT_SHOW(@"奔溃性的错误");
        }else if ([arr[0] isEqual:@"1"])
        {
            PL_ALERT_SHOW(@"此假期已有修改申请，或所申请的假期期间已被销假");
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            
            [arrayData2 addObjectsFromArray:arr];
            [arrayData addObjectsFromArray:arr];
            [self.tableViewList reloadData];
            [self.MainTableView reloadData];
            [self Type_HolidayRequest];
        }
        PL_PROGRESS_DISMISS;

    }];
}
#pragma mark--TableViewViewInitialize
-(void)PopBackGroundView
{
    BackGroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT)];
    BackGroundView.backgroundColor= PL_CUSTOM_COLOR(0, 0, 0, 0.5);
    BackGroundView.hidden=YES;
    [self.view addSubview:BackGroundView];
    imageArray=[NSMutableArray array];
    AddHolidayTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,100, PL_WIDTH, 228) style:UITableViewStylePlain];
    AddHolidayTableView.delegate=self;
    AddHolidayTableView.dataSource=self;
    AddHolidayTableView.hidden=NO;
    AddHolidayTableView.scrollEnabled=NO;
    [BackGroundView addSubview:AddHolidayTableView];
   
   }
//loading TabelViewFooterView
-(void)initTableViewFootView
{
    
    footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, 400)];
    
    imageArray = [NSMutableArray array];
    imageArray2 = [NSMutableArray array];
    [imageArray2 addObject:[UIImage imageNamed:@"ShowBinaryImg.jpg"]];
    reasonlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
    reasonlabel.text = @"请假事由:";
    reasonlabel.font = [UIFont systemFontOfSize:13.0f];
    [footerView addSubview:reasonlabel];
    reasonTextView = [[UITextView alloc] initWithFrame:CGRectMake(85, 10, PL_WIDTH-10-85, 75)];
        reasonTextView.layer.borderColor = PL_CUSTOM_COLOR(227, 227, 229, 1).CGColor;
    reasonTextView.layer.borderWidth = 1;
    reasonTextView.delegate=self;
    reasonTextView.returnKeyType=UIReturnKeyDone;
    [footerView addSubview:reasonTextView];
    addFuJianBtn = [[UIButton alloc] initWithFrame:CGRectMake(PL_WIDTH-70,reasonTextView.frame.origin.y+reasonTextView.frame.size.height+15, 60, 30)];
    [addFuJianBtn setBackgroundImage:[UIImage imageNamed:@"upload_modal_15.png"] forState:UIControlStateNormal];
    [addFuJianBtn setTitle:@"添加附件" forState:UIControlStateNormal];
    addFuJianBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [addFuJianBtn addTarget:self action:@selector(addFuJianAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:addFuJianBtn];
    
    addHoliday = [[UIButton alloc] initWithFrame:CGRectMake(20,reasonTextView.frame.origin.y+reasonTextView.frame.size.height+15, 30, 30)];
    [addHoliday setBackgroundImage:[UIImage imageNamed:@"添加@2x.png"] forState:UIControlStateNormal];
    [addHoliday addTarget:self action:@selector(addHolidayAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:addHoliday];
    
    cycleScroll =[[CycleScrollView alloc]initWithFrame:CGRectMake(0,addFuJianBtn.frame.origin.y+addFuJianBtn.frame.size.height+15, PL_WIDTH, 229)];
    
    cycleScroll.backgroundColor = [UIColor clearColor];
    cycleScroll.hidden=YES;
    [footerView addSubview:cycleScroll];
    cycleScrollHid =[[CycleScrollView alloc]initWithFrame:CGRectMake(0,addFuJianBtn.frame.origin.y+addFuJianBtn.frame.size.height+15, PL_WIDTH, 229)];
    [cycleScrollHid cycleDirection:CycleDirectionLandscape pictures:imageArray2];
    cycleScrollHid.backgroundColor = [UIColor clearColor];
    [footerView addSubview:cycleScrollHid];

    
}
//PopViewControoler
-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//Tap Touch
-(void)tapTouch
{
    [reasonTextView resignFirstResponder];
    DatebackView.hidden=YES;
    _tabelview.frame=CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT-44);
        if([_StarTime.text isEqualToString:@""])
    {
        _starTimerNotfaction.hidden = NO;
    }
    else
    {
        _starTimerNotfaction.hidden = YES;
        
    }
    
    if([_EndTime.text isEqualToString:@""])
    {
        _endTimerNotifaction.hidden = NO;
    }
    else
    {
        _endTimerNotifaction.hidden = YES;
        
    }

}
///Date Compare
- (int)compareTime:(NSString *)startStr withTime:(NSString *)endStr
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate * date = [[NSDate alloc]init];
    date = [dateFormatter dateFromString:startStr];
    //    NSString * dateStr2 = @"2015-10-05 18:00:00";
    NSDate * date2 = [[NSDate alloc]init];
    date2 = [dateFormatter dateFromString:endStr];
    NSTimeInterval ti = [date2 timeIntervalSinceDate:date];
    int time = ti;
    int dete = time%(3600*24);
    int dete2 = time/(3600*24)*8;
    int deteTime = dete / 3600 ;
    if (deteTime > 5) {
        dete2 += 1;
    }else if(deteTime >0 && deteTime <= 5){
        dete2 += 0.5;
    }
    return dete2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark--tableDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.MainTableView) {
        return self.HoulidayArray.count;
    }else if (tableView==AddHolidayTableView)
    {
        return 4;
    }
    else if (tableView==self.tableViewList)
    {
        return arrayData2.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==self.MainTableView) {
        self.tableViewList.frame = CGRectMake(0, 0, PL_WIDTH, arrayData2.count*40);
        NSLog(@"%f",self.tableViewList.frame.size.height);
         return self.tableViewList.frame.size.height+107;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView==self.MainTableView) {
        return 400;

    }
    return 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView==self.MainTableView) {
        return self.HeaderView;
    }
    return nil;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{if (tableView==self.MainTableView) {
    return footerView;
}
    return nil;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.MainTableView) {
        
        HolidayCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
         cell=[[[NSBundle mainBundle]loadNibNamed:@"HolidayCell" owner:self options:nil]lastObject];
        }
        if (self.HoulidayArray.count>0) {
            SingleHoulidayModel*model2=[SingleHoulidayModel TransferDictionary:self.HoulidayArray[indexPath.row]];
            cell.TypeLabel.text=model2.Type_Str;
            cell.Satr_label.text=model2.Star_Time;
            cell.End_label.text=model2.End_Time;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }
        return cell;
         }else if (tableView==AddHolidayTableView)
        {
        if (indexPath.row==0) {
            _cell7.selectionStyle=UITableViewCellSelectionStyleNone;
            return _cell7;
        }else if (indexPath.row==1)
        {
            _cell3.selectionStyle=UITableViewCellSelectionStyleNone;

            return _cell3;
        }else if (indexPath.row==2)
        {
            _cell4.selectionStyle=UITableViewCellSelectionStyleNone;

            return _cell4;
        }else if (indexPath.row==3)
        {
            _cell8.selectionStyle=UITableViewCellSelectionStyleNone;

            return _cell8;
        }
        
        
    }
    else if (tableView==self.tableViewList)
    {
        HolidayCell*cell=(HolidayCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HolidayCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        SingleHoulidayModel *model2= arrayData[indexPath.row];
        [cell cellForListModel:model2];
        
        return cell;
        
    }
    return nil;
    }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.MainTableView) {
        
        return 40;
        
    }else if (tableView==AddHolidayTableView)
    {
        return 56;
    }else if (self.tableViewList)
    {
        return 40;
    }
    return 0;
    
   }
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.MainTableView){
        return YES;
    }
    return NO;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        if (tableView==self.MainTableView) {
            
            [self.HoulidayArray removeObjectAtIndex:indexPath.row];
            [self.MainTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
            
            
            
        }
        
        
        
        
    }
}
#pragma mark--Xib按钮的方法确认提交和取消按钮
//取消提交
- (IBAction)CanleAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
//确认提交
- (IBAction)SureAction:(UIButton *)sender {
    if(reasonTextView.text.length == 0)
    {
        PL_ALERT_SHOW(@"请填写休假信息");
    }
    else
    {
        if(self.HoulidayArray.count==0)
        {
            PL_ALERT_SHOW(@"请填写休假时间");
        }
        else{
            start=[NSString stringWithFormat:@"%@",_StarTime.text];
            end=[NSString stringWithFormat:@"%@",_EndTime.text];
            NSLog(@"%d",[self compareTime:start withTime:end]>3);
            if([start compare:end options:NSNumericSearch]==NSOrderedDescending||[start compare:end options:NSNumericSearch]==NSOrderedSame){
                PL_ALERT_SHOW(@"请填写正确的休假时间");
            }
            else
            {
                
                [self HoliDayPostRequset];
                
            }
            
        }

}
}
#pragma mark--Post_ReauestHoliday
-(void)HoliDayPostRequset
{
    [self imgFlg];
    PL_PROGRESS_SHOW;
    NSArray*lastArry=[self SortDescriptorAscending:self.HoulidayArray];
    SingleHoulidayModel *model2= arrayData[0];
    NSString*oldate =model2.Star_Time;
     self.MultibarDic=@{@"TableAskForLeave":lastArry,
                        @"Summary":@"",
                        @"IsFile":imageFlg,
                        @"ProcessId":@"0",
                        @"ApprovalType":ApprovalType,
                        @"OldProcessId":[self.presosIdStr substringFromIndex:5],
                        @"OldStartDate":oldate,
                        @"FileList":self.ImageDataArray,
                        @"Reason":reasonTextView.text};
    
    NSData*jsonDatas=[NSJSONSerialization dataWithJSONObject:self.MultibarDic
                                                     options:NSJSONWritingPrettyPrinted error:nil];

    [[MyRequest defaultsRequest]MultibarHouliDayJsonData:[[NSString alloc]initWithData:jsonDatas encoding:NSUTF8StringEncoding]  userID:[PL_USER_STORAGE objectForKey:PL_USER_NAME] Token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] complteBack:^(NSString *string) {
        
        if ([string isEqualToString:@"OK"]) {
            PL_ALERT_SHOW(@"已成功发起流程，请等待审核");
            [self.HoulidayArray removeAllObjects];
            [self.MainTableView reloadData];
            reasonTextView.text=@"";
             [cycleScroll cycleDirection:CycleDirectionLandscape pictures:imageArray2];
        }else if ([string isEqualToString:@"1"])
        {
            PL_ALERT_SHOW(@"职位编码有误");
            
        }else if ([string isEqualToString:@"2"])
        {
            PL_ALERT_SHOW(@"流程发起失败");
        }else if ([string isEqualToString:@"3"])
        {
            PL_ALERT_SHOW(@"假期信息保存失败，请联系IT部");
        }else if ([string isEqualToString:@"4"])
        {
            PL_ALERT_SHOW(@"数据保存失败，请联系IT部");
        }else if ([string isEqualToString:@"5"])
        {
            PL_ALERT_SHOW(@"附件上次失败");
        }else if ([string isEqualToString:@"6"])
        {
            PL_ALERT_SHOW(@"附件信息保存失败，请联系IT部");
        }else if ([string isEqualToString:@"7"])
        {
            PL_ALERT_SHOW(@"所选择时间已申请过");
        }else if ([string isEqualToString:@"8"])
        {
            PL_ALERT_SHOW(@"申请日期不能选择1天以前的日期");
        }else if ([string isEqualToString:@"9"])
        {
            PL_ALERT_SHOW(@"申请开始日期不能选择30天以后的日期");
        }else if ([string isEqualToString:@"10"])
        {
            PL_ALERT_SHOW(@"申请结束日期不能选择1天以前的日期");
        }else if ([string isEqualToString:@"11"])
        {
            PL_ALERT_SHOW(@"产假和产检家申请结束日期不能选择6个月以后的日期");
        }else if ([string isEqualToString:@"12"])
        {
            PL_ALERT_SHOW(@"申请结束日期不能选择30天以后的日期");
        }else if ([string isEqualToString:@"13"])
        {
            PL_ALERT_SHOW(@"请假申请不能跨月");
        }else if ([string isEqualToString:@"14"])
        {
            PL_ALERT_SHOW(@"未获取到这次假期的开始时间 ");
        }else if ([string isEqualToString:@"15"])
        {
            PL_ALERT_SHOW(@"所选开始日期的上一个工作日有请假信息，请进行续假操作");
        }else if ([string isEqualToString:@"16"])
        {
            PL_ALERT_SHOW(@"计算上一个工作日时出错");
        }else if ([string isEqualToString:@"17"])
        {
            PL_ALERT_SHOW(@"没有足够多的剩余年假可申请");
        }else if ([string isEqualToString:@"18"])
        {
            PL_ALERT_SHOW(@"没有足够多的带薪病假可申请");
        }else if ([string isEqualToString:@"19"])
        {
            PL_ALERT_SHOW(@"没有足够多的剩余调休可申请");
        }else if ([string isEqualToString:@"20"])
        {
            PL_ALERT_SHOW(@"请假提前开始时间不能延后");
        }else if ([string isEqualToString:@"21"])
        {
            PL_ALERT_SHOW(@"请假延后开始时间不能提前");
        }else if ([string isEqualToString:@"22"])
        {
            PL_ALERT_SHOW(@"请假延后开始时间不能延后超过10天");
        }else if ([string isEqualToString:@"23"])
        {
            PL_ALERT_SHOW(@"请假提前不能跨月");
        }else if ([string isEqualToString:@"24"])
        {
            PL_ALERT_SHOW(@"未获取到上个假期的结束时间或这次假期的开始时间");
        }else if ([string isEqualToString:@"25"])
        {
            PL_ALERT_SHOW(@"计算下一个工作日时出错");
        }else if ([string isEqualToString:@"26"])
        {
            PL_ALERT_SHOW(@"请假日期必须是连续的工作日");
        }else if([string isEqualToString:@"exception"])
        {
            PL_ALERT_SHOW(@"请假申请错误，请联系IT部");
        }
        PL_PROGRESS_DISMISS;
    }];
}
-(void)imgFlg
{
    
    for (int i=0; i<self.HoulidayArray.count; i++) {
        NSString*str=self.HoulidayArray[i][@"Character01"];
        if(![str isEqualToString:@"年假"])
        {
            if(![str isEqualToString:@"事假"])
            {
                if (![str isEqualToString:@"调休"]) {
                    
                    if (imageArray.count==0) {
                        imageFlg=@"0";
                    }else
                    {
                        imageFlg = @"1";
                    }
                    return;
                }else
                {
                    imageFlg=@"2";
                }

                    
                }else
                {
                  imageFlg=@"2";
                }
           }
        else
        {
            imageFlg = @"2";
        }
        
        
    }
    
    
    
    
}


#pragma mark ---排序多条请假信息的时间

-(NSArray*)SortDescriptorAscending:(NSMutableArray*)MutableArray
{
    NSMutableArray *dataArray=[NSMutableArray array];
    
    for (NSMutableDictionary*dicsub in MutableArray) {
        NSMutableDictionary*dic=[NSMutableDictionary dictionary];
        [dic setObject:dicsub[@"EndDate"] forKey:@"EndDate"];
        [dic setObject:dicsub[@"StartDate"] forKey:@"StartDate"];
        [dic setObject:dicsub[@"Type"] forKey:@"Type"];
        [dic setObject:dicsub[@"Character01"] forKey:@"Character01"];
        [dic setObject:dicsub[@"Hours"] forKey:@"Hours"];
        [dic setObject:dicsub[@"EmpCode"] forKey:@"EmpCode"];
        [dic setObject:dicsub[@"EmpName"] forKey:@"EmpName"];
        [dataArray addObject:dic];
    }
    NSSortDescriptor*sorter=[[NSSortDescriptor alloc]initWithKey:@"StartDate" ascending:YES];
    NSMutableArray *sortDescriptors=[[NSMutableArray alloc]initWithObjects:&sorter count:1];
    NSArray *sortArray=[dataArray sortedArrayUsingDescriptors:sortDescriptors];
    return sortArray;
}

#pragma mark pickerViewDelegate
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component

{
    
    return 40;
    
}
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (pickerView==self.HousPicker) {
        array=@[@"09:00",@"14:00"];
        UILabel*lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
        lab.text=[array objectAtIndex:row];
        lab.font=[UIFont systemFontOfSize:17];
        return lab;
        }else if (pickerView==self.TypePickerView)
        {
            if (self.TypeArray.count>0) {
                UILabel*lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
                lab.text=[self.TypeArray objectAtIndex:row];
                lab.font=[UIFont systemFontOfSize:17];
                return lab;
            }
           
        }
    else if(pickerView==self.HousPicker2)
    {
        array=@[@"14:00",@"18:00"];
        UILabel*lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
        lab.text=[array objectAtIndex:row];
        lab.font=[UIFont systemFontOfSize:17];
        return lab;
        
    }
    return nil;
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView==self.TypePickerView) {
        return self.TypeArray.count;
    }
    return 2;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
        return 100;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
       if (pickerView==self.HousPicker) {
          _StarTime.text=[NSString stringWithFormat:@"%@ %@:00",dateString,array[row]];
           
           
    }
    else if (pickerView==self.TypePickerView)
    {
        NSString*TypeStrLabel=self.TypeArray[row];
        
        TypeStr=self.TypeArray[row];
        
        [self.TypebtnLabel setTitle:self.TypeArray[row] forState:0];
        self.TypebtnLabel.titleLabel.textColor=[UIColor blackColor];
        
        if ([ApprovalType isEqualToString:@"3"]) {
            self.StarTime.enabled=NO;
          if (![TypeStrLabel isEqualToString:@"陪产假"]) {
            self.TypeNotfationLabel.hidden=YES;
            self.EndTime.text=@"";
            self.endTimerNotifaction.hidden=NO;
              self.EndTime.enabled=YES;
            
        }else if (![TypeStrLabel isEqualToString:@"婚假"])
        {
            self.TypeNotfationLabel.hidden=YES;

            self.EndTime.text=@"";
            self.endTimerNotifaction.hidden=NO;
            self.EndTime.enabled=YES;
        }
            if([TypeStrLabel isEqualToString:@"婚假"])
            {
                self.TypeNotfationLabel.hidden=YES;
                self.EndTime.enabled=NO;
                if ([str4 isEqualToString:@"0"] ) {
                    
                    self.EndTime.text=[self marriageTime:self.StarTime.text withDate:3];
                    
                    if ([self.EndTime.text isEqualToString:@""]) {
                        self.endTimerNotifaction.hidden =NO;
                    }
                    else
                    {
                        self.endTimerNotifaction.hidden = YES;
                    }
                    
                    
                }else if([str4 isEqualToString:@"1"])
                {
                    self.EndTime.text=[self marriageTime:self.StarTime.text withDate:10];
                    
                    if ([self.EndTime.text isEqualToString:@""]) {
                        self.endTimerNotifaction.hidden =NO;
                    }
                    else
                    {
                        self.endTimerNotifaction.hidden = YES;
                    }
                    
                }
            }else if ([TypeStrLabel isEqualToString:@"陪产假"])
        {
            self.TypeNotfationLabel.hidden=YES;
            if ([ApprovalType isEqualToString:@"3"]) {
                 self.StarTime.enabled=NO;
                self.EndTime.enabled=NO;
            }
            self.EndTime.text=[self marriageTime:self.StarTime.text withDate:3];
            if ([self.EndTime.text isEqualToString:@""]) {
                
                self.endTimerNotifaction.hidden =NO;
            }
            else
            {
                self.endTimerNotifaction.hidden = YES;
                           }
            
            
        }
        }else
        {
            if (![TypeStrLabel isEqualToString:@"陪产假"]) {
                self.TypeNotfationLabel.hidden=YES;
                self.EndTime.text=@"";
                self.endTimerNotifaction.hidden=NO;
                self.EndTime.enabled=YES;
                self.StarTime.enabled=YES;
                
            }else if (![TypeStrLabel isEqualToString:@"婚假"])
            {
                self.TypeNotfationLabel.hidden=YES;
                
                self.EndTime.text=@"";
                self.endTimerNotifaction.hidden=NO;
                self.EndTime.enabled=YES;
                self.StarTime.enabled=YES;
            }
            if([TypeStrLabel isEqualToString:@"婚假"])
            {
                self.EndTime.enabled=NO;
                self.TypeNotfationLabel.hidden=YES;
                
                if ([str4 isEqualToString:@"0"] ) {
                    
                    self.EndTime.text=[self marriageTime:self.StarTime.text withDate:3];
                    
                    if ([self.EndTime.text isEqualToString:@""]) {
                        self.endTimerNotifaction.hidden =NO;
                    }
                    else
                    {
                        self.endTimerNotifaction.hidden = YES;
                    }
                    
                    
                }else if([str4 isEqualToString:@"1"])
                {
                    self.EndTime.text=[self marriageTime:self.StarTime.text withDate:10];
                    
                    if ([self.EndTime.text isEqualToString:@""]) {
                        self.endTimerNotifaction.hidden =NO;
                    }
                    else
                    {
                        self.endTimerNotifaction.hidden = YES;
                    }
                    
                }
            }else if ([TypeStrLabel isEqualToString:@"陪产假"])
            {
                self.EndTime.enabled=NO;
                self.TypeNotfationLabel.hidden=YES;
                if ([ApprovalType isEqualToString:@"3"]) {
                    self.StarTime.enabled=NO;
                    self.EndTime.enabled=NO;
                }
                self.EndTime.text=[self marriageTime:self.StarTime.text withDate:3];
                if ([self.EndTime.text isEqualToString:@""]) {
                    
                    self.endTimerNotifaction.hidden =NO;
                }
                else
                {
                    self.endTimerNotifaction.hidden = YES;
                }
                
                

            
        }

        if (![self.TypebtnLabel.titleLabel.text isEqualToString:@""]) {
             self.TypeNotfationLabel.hidden=YES;
            TypeStr=self.TypeArray[row];
            NSDictionary*dic=[ARR objectAtIndex:row];
            numberStr=[dic objectForKey:@"Number03"];
        }

        }
        
    }
    else   {
        if (_StarTime.text.length>16) {
              _EndTime.text=[NSString stringWithFormat:@"%@ %@:00",DateString2,array[row]];
        }else
        {
            _EndTime.text=[NSString stringWithFormat:@"%@ %@",DateString2,array[row]];
  
        }
      
        
        
    }
  
     }
#pragma mark--textViewDelagate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
      if([_StarTime.text isEqualToString:@""])
    {
        _starTimerNotfaction.hidden = NO;
    }
    else
    {
        _starTimerNotfaction.hidden = YES;
        
    }
    
    if([_EndTime.text isEqualToString:@""])
    {
        _endTimerNotifaction.hidden = NO;
    }
    else
    {
        _endTimerNotifaction.hidden = YES;
        
    }

    if (textField==_StarTime) {
        _isTextFile1=YES;
        self.HousPicker.hidden=NO;
        self.TypePickerView.hidden=YES;
        self.HousPicker2.hidden=YES;
        if (!chvc) {
            
            chvc = [[CalendarHomeViewController alloc]init];
            
            [chvc setAirPlaneToDay:365 ToDateforString:nil];
            
        }
        [self presentViewController:chvc animated:YES completion:^{
            __block XJSubViewController*blockSelf=self;
            __block NSNumber*nunstr=numberStr;
            __block NSString*newStr4=str4;
            chvc.calendarblock = ^(CalendarDayModel *model){
              
                blockSelf.StarTime.text= [NSString stringWithFormat:@"%@ 09:00:00",[model toString]];
                dateString=[NSString stringWithFormat:@"%@",[model toString]];
                
                if([nunstr.stringValue isEqualToString:@"3"])
                {
                    if ([newStr4 isEqualToString:@"0"] ) {
                        
                         blockSelf.EndTime.text=[blockSelf marriageTime:blockSelf.StarTime.text withDate:3];
                        
                        if ([blockSelf.EndTime.text isEqualToString:@""]) {
                            blockSelf.endTimerNotifaction.hidden =NO;
                        }
                        else
                        {
                            blockSelf.endTimerNotifaction.hidden = YES;
                            blockSelf.EndTime.enabled=NO;
                        }
                        
                        
                    }
                    if([newStr4 isEqualToString:@"1"])
                    {
                        blockSelf.EndTime.text=[blockSelf marriageTime:blockSelf.StarTime.text withDate:10];
                       
                        if ([blockSelf.EndTime.text isEqualToString:@""]) {
                            blockSelf.endTimerNotifaction.hidden =NO;
                        }
                        else
                        {
                            blockSelf.endTimerNotifaction.hidden = YES;
                            blockSelf.EndTime.enabled=NO;
                        }
                        
                    }
                }else if ([nunstr.stringValue isEqualToString:@"12"])
                {
                    
                    blockSelf.EndTime.text=[blockSelf marriageTime:blockSelf.StarTime.text withDate:3];
                    if ([blockSelf.EndTime.text isEqualToString:@""]) {
                        
                        blockSelf.endTimerNotifaction.hidden =NO;
                    }
                    else
                    {
                        blockSelf.endTimerNotifaction.hidden = YES;
                        blockSelf.EndTime.enabled=NO;
                    }
                    
                    
                }

                
            };
        }];
        _starTimerNotfaction.hidden=YES;
        [self.HousPicker selectRow:0 inComponent:0 animated:YES];
        [self.HousPicker reloadAllComponents];
    }
    else if(textField==_EndTime)
    {
        _isTextFile1=NO;
        self.HousPicker2.hidden=NO;
        self.TypePickerView.hidden=YES;
        self.HousPicker.hidden=YES;
        if (!chvc) {
            
            chvc = [[CalendarHomeViewController alloc]init];
            
            [chvc setAirPlaneToDay:365 ToDateforString:nil];
            
        }
        [self presentViewController:chvc animated:YES completion:^{
            __block XJSubViewController*blockSelf=self;
            chvc.calendarblock = ^(CalendarDayModel *model){
                
                blockSelf.EndTime.text= [NSString stringWithFormat:@"%@ 14:00:00",[model toString]];
                DateString2=[NSString stringWithFormat:@"%@",[model toString]];
                
                
            };
        }];

        _endTimerNotifaction.hidden=YES;
        [self.HousPicker selectRow:0 inComponent:0 animated:YES];
        [self.HousPicker reloadAllComponents];
        
    }
    
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    DatebackView.hidden=YES;
//    _TextViewNotiFation.hidden=YES;
   }
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ( [text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
   
    return YES;
}
//提前按钮
- (IBAction)advancedBut:(UIButton*)sender {
    ApprovalType=@"1";
    [reasonTextView resignFirstResponder];
       _tabelview.frame=CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT-44);
    self.HousPicker.hidden=YES;
    self.HousPicker2.hidden=YES;
    _advancedimage.image=[UIImage imageNamed:@"BlueIosCheCkBox"];
    _postponeimage.image=[UIImage imageNamed:@"chechkboxhover"];
    _successorimage.image=[UIImage imageNamed:@"chechkboxhover"];
    updataTypeStr=@"1";
    _StarTime.text=@"";
    _EndTime.text = @"";
    reasonTextView.text = @"";
    
    if([_StarTime.text isEqualToString:@""])
    {
        _starTimerNotfaction.hidden = NO;
    }
    else
    {
        _starTimerNotfaction.hidden = YES;

    }

    if([_EndTime.text isEqualToString:@""])
    {
        _endTimerNotifaction.hidden = NO;
    }
    else
    {
        _endTimerNotifaction.hidden = YES;
        
    }

}
//延后按钮
- (IBAction)postponeBut:(UIButton *)sender {
    ApprovalType=@"2";
       [reasonTextView resignFirstResponder];
    _tabelview.frame=CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT-44);
    self.HousPicker.hidden=YES;
    self.HousPicker2.hidden=YES;
    _postponeimage.image=[UIImage imageNamed:@"BlueIosCheCkBox"];
    _advancedimage.image=[UIImage imageNamed:@"chechkboxhover"];
    _successorimage.image=[UIImage imageNamed:@"chechkboxhover"];
    updataTypeStr=@"2";
    _StarTime.text=@"";
    _EndTime.text = @"";
    reasonTextView.text = @"";
    if([_StarTime.text isEqualToString:@""])
    {
        _starTimerNotfaction.hidden = NO;
    }
    else
    {
        _starTimerNotfaction.hidden = YES;
        
    }
    if([_EndTime.text isEqualToString:@""])
    {
        _endTimerNotifaction.hidden = NO;
    }
    else
    {
        _endTimerNotifaction.hidden = YES;
        
    }
}
#pragma mark--请假类型
- (IBAction)TypeBtn:(UIButton *)sender {
    self.TypePickerView.hidden=NO;
    [self.TypePickerView selectRow:0 inComponent:0 animated:YES];
    self.HousPicker.hidden=YES;
    self.HousPicker2.hidden=YES;
   
   
    
}
#pragma mark--Type_HolidayRequest
-(void)Type_HolidayRequest
{
    [[MyRequest defaultsRequest]afGetSelectLeaveInfo:[PL_USER_STORAGE objectForKey:PL_USER_NAME] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(id obj) {
        NSString*STR=obj;
        SBJSON *json=[[SBJSON alloc]init];
        ARR= [json objectWithString:STR error:nil];
        if (ARR && [ARR isKindOfClass:[NSArray class]]) {
            
            for (NSDictionary * dict in ARR)
            {
                if (dict && [dict isKindOfClass:[NSDictionary class]])
                {
                    NSString *str=[dict objectForKey:@"Character01"];
                    str1= [dict objectForKey:@"Annualleave"];
                    Annualleave=str1.intValue;
                    str2 = [dict objectForKey:@"Paidsickleave"];
                    Paidsickleave=str2.intValue;
                    str3 = [dict objectForKey:@"Offleave"];
                    Offleave=str3.intValue;
                    str4 = [dict objectForKey:@"LeaveFlag"];
                    [self.TypeArray addObject:str];
                    
                }
            }
            [self.TypePickerView reloadAllComponents];
            PL_PROGRESS_DISMISS;
        }
    }];
}
//续假按钮
- (IBAction)successorBut:(UIButton *)sender {
    ApprovalType=@"3";
    [reasonTextView resignFirstResponder];
    _tabelview.frame=CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT-44);
    self.HousPicker.hidden=YES;
    self.HousPicker2.hidden=YES;
    _successorimage.image=[UIImage imageNamed:@"BlueIosCheCkBox"];
    _postponeimage.image=[UIImage imageNamed:@"chechkboxhover"];
    _advancedimage.image=[UIImage imageNamed:@"chechkboxhover"];
    updataTypeStr=@"3";
    SingleHoulidayModel*model=[arrayData2 lastObject];
    _ValueStr=model.End_Time;
    NSString *hours=[self.ValueStr substringFromIndex:11];
    NSLog(@"%@",hours);
    if([hours isEqualToString:@"18:00:00"])
        
    {
      
       self.StarTime.text=[self marriageTime:_ValueStr withDate:15];

    }
    else
    {
        self.StarTime.text =_ValueStr;
    }
    _EndTime.text = @"";
    reasonTextView.text = @"";

    if([_StarTime.text isEqualToString:@""])
    {
        _starTimerNotfaction.hidden = NO;
    }
    else
    {
        _starTimerNotfaction.hidden = YES;
        
    }
    if([_EndTime.text isEqualToString:@""])
    {
        _endTimerNotifaction.hidden = NO;
    }
    else
    {
        _endTimerNotifaction.hidden = YES;
        
    }
}
//添加假期的按钮
- (void)addHolidayAction{
    [self.TypebtnLabel setTitle:@"" forState:0];
    self.EndTime.text=@"";
    
    BackGroundView.hidden=NO;
    if ([ApprovalType isEqualToString:@"3"]) {
        if (self.HoulidayArray.count>0) {
            
           NSString*New_Endstr=[self.HoulidayArray lastObject][@"EndDate"];
            NSString *hours=[New_Endstr substringFromIndex:11];

            if([hours isEqualToString:@"18:00:00"])
                
            {
                
                self.StarTime.text=[self marriageTime:New_Endstr withDate:15];
                
            }
            else
            {
                self.StarTime.text =New_Endstr;
            }

            
            self.StarTime.enabled=NO;
            self.EndTime.text=@"";
            self.TypeNotfationLabel.hidden=NO;
            self.starTimerNotfaction.hidden=YES;
            self.endTimerNotifaction.hidden=NO;
        }else
        {
            SingleHoulidayModel*OldModel=[arrayData2 lastObject];
        
            NSString *hours=[OldModel.End_Time substringFromIndex:11];
            NSString*Old_EndStr=OldModel.End_Time;
            NSLog(@"%@",hours);
            if([hours isEqualToString:@"18:00:00"])
                
            {
                
                self.StarTime.text=[self marriageTime:Old_EndStr withDate:15];
                
            }
            else
            {
                self.StarTime.text =Old_EndStr;
            }

            
           
            self.StarTime.enabled=NO;
            self.EndTime.text=@"";
            self.TypeNotfationLabel.hidden=NO;
            self.starTimerNotfaction.hidden=YES;
            self.endTimerNotifaction.hidden=NO;
            
        }
        
    }else
    {
        [self.TypebtnLabel setTitle:@"" forState:0];
        self.EndTime.text=@"";
        self.StarTime.text=@"";
        self.StarTime.enabled=YES;
        self.TypeNotfationLabel.hidden=NO;
        self.starTimerNotfaction.hidden=NO;
        self.endTimerNotifaction.hidden=NO;
    }
    
}
//根据开始时间计算结束时间
- (NSString*)marriageTime:(NSString *)startStr withDate:(NSTimeInterval)timerInterval
{
    NSString * dateStr = @"";
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [dateFormatter dateFromString:startStr];
    if([startStr isEqualToString:@""])
    {
        return nil;
    }
    NSString *hour = [startStr substringWithRange:NSMakeRange(11, 2)];
    if([hour isEqualToString:@"09"])
    {
        NSDate * date2 = [NSDate dateWithTimeInterval:(timerInterval*24*60*60-15*60*60) sinceDate:date];
        dateStr = [dateFormatter stringFromDate:date2];
    }
    else if([hour isEqualToString:@"18"])
    {
        NSDate * date2 = [NSDate dateWithTimeInterval:timerInterval*60*60 sinceDate:date];
        dateStr = [dateFormatter stringFromDate:date2];
    }
    else
    {
        NSDate * date2 = [NSDate dateWithTimeInterval:timerInterval*24*60*60 sinceDate:date];
        dateStr = [dateFormatter stringFromDate:date2];
        
    }
    return dateStr;
}

- (void)addFuJianAction{
    
    if(self.HoulidayArray.count==0)
    {
        PL_ALERT_SHOW(@"请至少添加一条请假信息");
    }
    else
    {
        if(reasonTextView.text.length == 0)
        {
            PL_ALERT_SHOW(@"请填写休假信息");
        }
        else{
    
            alertView=[[UIAlertView alloc]initWithTitle:@"请上传附件证明" message:nil delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"拍照",@"本地相册" ,nil];
            [alertView show];
        }
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        NSLog(@"取消");
    }else if(buttonIndex==1)
    {
        NSLog(@"拍照");
        [self openCarama];
        
        
    }else
    {
        [self locaPhonto];
    }
    
    
}
//打开本地相册
-(void)locaPhonto
{
    UIImagePickerController*ImagePickerC=[[UIImagePickerController alloc]init];
    ImagePickerC.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    ImagePickerC.delegate=self;
    ImagePickerC.allowsEditing=YES;
    [self presentViewController:ImagePickerC animated:YES completion:nil];
    [self.view addSubview:ImagePickerC.view];
}
//打开系统相机
-(void)openCarama
{
    UIImagePickerController*imagePickerC=[[UIImagePickerController alloc]init];
    imagePickerC.sourceType=UIImagePickerControllerSourceTypeCamera;
    imagePickerC.delegate=self;
    imagePickerC.allowsEditing=NO;
    [self presentViewController:imagePickerC animated:YES completion:nil];
    [self.view addSubview: imagePickerC.view];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString*Type=[info objectForKey:UIImagePickerControllerMediaType];
    
    if ([Type isEqualToString:@"public.image"]) {
        UIImage*image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData*data;
        if (UIImagePNGRepresentation(image)==nil) {
            data=UIImageJPEGRepresentation(image, 1.0);
        }else
        {
            data=UIImagePNGRepresentation(image);
            
        }
        NSString*DoucmestPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSFileManager*fileManger=[NSFileManager defaultManager];
        
        [fileManger createDirectoryAtPath:DoucmestPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManger createFileAtPath:[DoucmestPath stringByAppendingString:@"/image.png"]  contents:data attributes:nil];
        NSString*filePath=[[NSString alloc ]initWithFormat:@"%@%@",DoucmestPath,@"/image.png"];
     
        [imageArray addObject:[UIImage imageWithContentsOfFile:filePath]];
        if (imageArray.count>0) {
            cycleScroll.hidden=NO;
            cycleScrollHid.hidden=YES;
        }

        [picker dismissViewControllerAnimated:YES completion:nil];
        UIImage * baseImage = [UIImage imageWithContentsOfFile:filePath];
        UIImage * imagess = [self imageWithImage:baseImage scaledToSize:CGSizeMake(600,450)];
               NSData * daImage = UIImagePNGRepresentation(imagess);
        NSData * iamgeData = [daImage base64EncodedDataWithOptions:0];
        lipeng = [[NSString alloc]initWithData:iamgeData encoding:NSUTF8StringEncoding];
        [self.ImageDataArray addObject:lipeng];
         [cycleScroll cycleDirection:CycleDirectionLandscape pictures:imageArray];

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
#pragma mark 小提交按钮的方法
- (IBAction)ComitBut:(UIButton *)sender {
    
    if(self.TypebtnLabel.titleLabel.text.length==0)
    {
        PL_ALERT_SHOW(@"请选择请假类型");
    }
    else if(self.StarTime.text.length == 0|| self.EndTime.text.length == 0)
    {
        PL_ALERT_SHOW(@"请填写休假时间");
    }else if ([self EquelSatrTime:self.StarTime.text])
    {
        PL_ALERT_SHOW(@"只能补前一天假期");
    } else if ([self.StarTime.text compare:self.EndTime.text options:NSNumericSearch]==NSOrderedDescending||[self.StarTime.text compare:self.EndTime.text options:NSNumericSearch]==NSOrderedSame)
    {
        PL_ALERT_SHOW(@"请假的起始日期时间必须小于截止的日期时间");
        if ([ApprovalType isEqualToString:@"3"]) {
            self.EndTime.text=@"";
        }else
        {
         self.EndTime.text=@"";
          self.StarTime.text=@"";
        }
      
       
        
    }else if ([self.StarTime.text isEqualToString:@""]||[self.EndTime.text isEqualToString:@""])
    {
        PL_ALERT_SHOW(@"请填写休假时间");
    }else if ([numberStr.stringValue isEqualToString:@"5"])
    {
        if([self compareTime: self.StarTime.text withTime:self.EndTime.text]>3)
        {
            PL_ALERT_SHOW(@"丧假指定为3天以内");
        }else
        {
            [self CalculationHolidayDate];
            
        }
    }
    else
    {
        [self CalculationHolidayDate];
       
    }
    
}
//判断是不是同一天的请假
-(BOOL)EquelSatrTime:(NSString*)str2_Time
{
    
    NSDate*locaDate=[NSDate date];
    
    NSDateFormatter*datef=[[NSDateFormatter alloc]init];
    [datef setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString*str=[datef stringFromDate:locaDate];
    str2_Time=self.StarTime.text;
    
    NSDate*date1=[[datef dateFromString:str]initWithTimeIntervalSinceNow:8*60*60];
    NSDate*date2=[[datef dateFromString:str2_Time]dateByAddingTimeInterval:8*60*60];
    
    NSTimeInterval TimeIn=[date1 timeIntervalSinceDate:date2];
    
    if (TimeIn>24*60*60){
        return YES;
    }
    return NO;
    
    
}
#pragma mark--CalulationHolidayDate
-(void)CalculationHolidayDate
{
    NSString*PrevEndDate=[self.HoulidayArray lastObject][@"EndDate"];
    if (PrevEndDate==nil) {
        PrevEndDate=@"";
    }
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest] CheckLeaveLeaveType:TypeStr StartDate:self.StarTime.text EndDate:self.EndTime.text PrevEndDate:PrevEndDate userid:[PL_USER_STORAGE objectForKey:PL_USER_USERID] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] complteBack:^(NSString *str) {
        
        if ([str isEqualToString:@"ERR1"]) {
            PL_ALERT_SHOW(@"请假日期必须是连续的工作日");
        }else if ([str isEqualToString:@"exception"])
        {
            PL_ALERT_SHOW(@"奔溃性的错误");
        }else
        {
            if ([TypeStr isEqualToString:@"有薪病假"]||[TypeStr isEqualToString:@"调休"]||[TypeStr isEqualToString:@"年假"]) {
                
                AfterComputingTime=str.intValue;
                if ([TypeStr isEqualToString:@"年假"])
                {
                    if(Annualleave <AfterComputingTime)
                    {
                        PL_ALERT_SHOW(@"没有足够多的年假可申请，请删除表单中的年假");
                        self.TypeNotfationLabel.hidden=NO;
                        self.starTimerNotfaction.hidden=NO;
                        self.endTimerNotifaction.hidden=NO;
                        [self.TypebtnLabel setTitle:@"" forState:0];
                        self.HousPicker2.hidden=YES;
                       self.StarTime.text=@"";
                        self.EndTime.text=@"";
                    
                        
                    }else
                    {
                        [self AddMutabarHoliday];
                        Annualleave=Annualleave-AfterComputingTime;
                        
                    }
                }else if ([TypeStr isEqualToString:@"有薪病假"])
                {
                    if(Paidsickleave <AfterComputingTime)
                    {
                        PL_ALERT_SHOW(@"没有足够多的带薪病假可申请，请删除表单中的有薪病假");
                        self.TypeNotfationLabel.hidden=NO;
                        self.starTimerNotfaction.hidden=NO;
                        self.endTimerNotifaction.hidden=NO;
                        [self.TypebtnLabel setTitle:@"" forState:0];
                        self.HousPicker2.hidden=YES;
                        self.StarTime.text=@"";
                        self.EndTime.text=@"";

                                           }else
                    {
                        [self AddMutabarHoliday];
                        Paidsickleave=Paidsickleave-AfterComputingTime;
                      
                    }
                }else if ([TypeStr isEqualToString:@"调休"])
                {
                    if(Offleave <AfterComputingTime)
                    {
                        PL_ALERT_SHOW(@"没有足够多的调休可申请，请删除表单中的调休");
                        self.TypeNotfationLabel.hidden=NO;
                        self.starTimerNotfaction.hidden=NO;
                        self.endTimerNotifaction.hidden=NO;
                        [self.TypebtnLabel setTitle:@"" forState:0];
                        self.HousPicker2.hidden=YES;
                        self.StarTime.text=@"";
                        self.EndTime.text=@"";


                    }else
                    {
                        [self AddMutabarHoliday];
                        Offleave=Offleave-AfterComputingTime;
                      
                    }
                }
            }else
            {
                [self AddMutabarHoliday];
            }
        }
        PL_PROGRESS_DISMISS;
    }];
    
}

-(void)AddMutabarHoliday
{
    [self initWithFromtNumber];
    OneDic=@{@"Type":Num_Str,
             @"StartDate":self.StarTime.text,
             @"EndDate":self.EndTime.text,
             @"Character01":self.TypebtnLabel.titleLabel.text,
             @"Hours":@"0",
             @"EmpCode":[PL_USER_STORAGE objectForKey:PL_USER_code],
             @"EmpName":[PL_USER_STORAGE objectForKey:PL_USER_TRUE_NAME]};
    [self.HoulidayArray addObject:OneDic];
    BackGroundView.hidden=YES;
    self.HousPicker.hidden=YES;
    self.HousPicker2.hidden=YES;
    [self.MainTableView reloadData];
}
-(void)initWithFromtNumber
{
    if ([TypeStr isEqualToString:@"事假"])  {
        Num_Str=@"1";
    }
    else if ([TypeStr isEqualToString:@"婚假"])  {
        
        Num_Str = @"3";
    }
    else if ([TypeStr isEqualToString:@"产假"])  {
        Num_Str = @"4";
    }
    else if ([TypeStr isEqualToString:@"丧假"])  {
        Num_Str = @"5";
    }
    else if ([TypeStr isEqualToString:@"产检假"])  {
        Num_Str = @"18";
    }
    else if ([TypeStr isEqualToString:@"哺乳假"])  {
        Num_Str = @"8";
    }
    else if ([TypeStr isEqualToString:@"调休"])  {
        
        Num_Str = @"9";
    }
    else if ([TypeStr isEqualToString:@"无薪病假"])  {
        
        Num_Str = @"10";
    }
    else if ([TypeStr isEqualToString:@"陪产假"])  {
        
        Num_Str = @"12";
    }
    else if ([TypeStr isEqualToString:@"其他"])  {
        Num_Str = @"14";
    }else if ([TypeStr isEqualToString:@"有薪病假"])  {
        Num_Str = @"2";
    }
    else if ([TypeStr isEqualToString:@"年假"])  {
        Num_Str = @"15";
    }
    
}

- (IBAction)CanBtn:(UIButton *)sender {
     BackGroundView.hidden=YES;
  self.HousPicker.hidden=YES;
   self.HousPicker2.hidden=YES;
    [self.TypebtnLabel setTitle:@"" forState:0];
    self.StarTime.text=@"";
    self.EndTime.text=@"";
    self.TypeNotfationLabel.hidden=NO;
    self.starTimerNotfaction.hidden=NO;
    self.endTimerNotifaction.hidden=NO;
    self.TypePickerView.hidden=YES;
}

@end
