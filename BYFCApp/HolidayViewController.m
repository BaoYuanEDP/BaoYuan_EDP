//
//  HolidayViewController.m
//  BYFCApp
//
//  Created by zzs on 15/3/12.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "HolidayViewController.h"
#import "CycleScrollView.h"
#import "PL_Header.h"
#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#import "SingleHoulidayModel.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetRepresentation.h>

@interface HolidayViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    //图片滚动ScrollView
    CycleScrollView *cycleScroll;
    //添加附件按钮
    UIButton *addFuJianBtn;
    //请假理由label
    UILabel *reasonlabel;
    //请假理由textView
    UITextView *reasonTextView;
    //
    //添加假期
    UIButton *addHoliday;
    UIView *blackView;
    //图片数组
    NSMutableArray * imageArray;
    //图片数组
    NSMutableArray * imageArray2;
    //添加附件背景
    UIView *footerView;
    NSInteger count;
    //请假类型的数组
    NSMutableArray*StyleArray;
    //添加附件的提示框
    UIAlertView*HoliDayAview;
    //有薪病假时间
    int Paidsickleave;
    //年假的时间
    int Annualleave;
    //调休的时间
    int Offleave;
    //类型转换后的字符串编号
    NSString*Num_Str;
/************获取的请假各项数据**********/
    NSString*str1;
    NSString*str2;
    NSString*str3;
    NSString*str4;
    //类型
    NSString*TypeStr;
    //pickerViewArray
    NSArray*PickerArray;
    //弹出提示拍照
    UIAlertView*alertViewimage;
    //    图片字符数据
    NSString*imageData;
    //    传不传图片的判定
    NSString*imageFlg;
    //    日历插件
    CalendarHomeViewController*cavc;
    //    预留时间用来传值
    NSString*starDateString;
    NSString*endDateString;
    //    类型的字符串
    NSNumber*numberStr;
    //    单次的字典请假
    NSDictionary*OneDic;
    //    隐藏的scroolView
    CycleScrollView*cycleScrollHid;
    //    决定重复的请假的Bool
    BOOL isHolidayType;
    //    计算好的时间
    int AfterComputingTime;
//    清空按钮
    UIButton*CleanBtn;
   }
//获取请求下来的数据
@property(nonatomic,strong)NSArray*array;
//    请假提交的类型
//@property(nonatomic,strong)
//    开始时间
@property(nonatomic,strong)  NSString*starTime;
//    结束时间
@property(nonatomic,strong) NSString*endTime;
//开始时间的pickerView
@property(nonatomic,strong)UIPickerView*Star_PickerView;
//结束时间的PickerView
@property(nonatomic,strong)UIPickerView*End_PickerView;
//存放单条请假的数组
@property(nonatomic,strong)NSMutableArray*HoulidayArray;
//多条请假的JsonData
@property(nonatomic,strong) NSMutableArray*JsonData;
//多条请假的字典
@property(nonatomic,strong)NSDictionary*MultibarDic;
//多条附件的图片DataArray
@property(nonatomic,strong)NSMutableArray*ImageDataArray;
@end

@implementation HolidayViewController
//Mulitibar Dictionary lazy loading
-(NSDictionary*)MultibarDic
{
    if (!_MultibarDic) {
        _MultibarDic=[NSDictionary dictionary];
    }
    return _MultibarDic;
 
}
//jsondata lazy loading
-(NSMutableArray*)JsonData
{
    if (!_JsonData) {
        _JsonData=[NSMutableArray array];
    }
    return _JsonData;
}
#pragma mark 初始加载
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"请假申请";
    count = 1;
   [self AcquiresHolidayTimes];
    _User.text = [PL_USER_STORAGE objectForKey:PL_USER_TRUE_NAME];
    _Code.text = [PL_USER_STORAGE objectForKey:PL_USER_code];
    imageArray = [NSMutableArray array];
    imageArray2 = [NSMutableArray array];
    [imageArray2 addObject:[UIImage imageNamed:@"ShowBinaryImg.jpg"]];
    self.navigationController.navigationBarHidden=NO;
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    UIButton*but=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH-80,10, 100, 30)];
    [but setTitle:@"申请历史" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
    but.titleLabel.font=[UIFont systemFontOfSize:15.0f];
    [but setTitleEdgeInsets:UIEdgeInsetsMake(0, 35, 0, 0)];
    [but addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithCustomView:but];
    self.navigationItem.rightBarButtonItem=right;
    [self initView];
    
    self.HoulidayArray=[NSMutableArray array];
    self.ImageDataArray=[NSMutableArray array];
    
  }


//initialize View
-(void)initView
{
  
    footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, PL_WIDTH, 400)];
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
    
    addFuJianBtn = [[UIButton alloc] initWithFrame:CGRectMake(PL_WIDTH-90, 100, 80, 30)];
    [addFuJianBtn setBackgroundImage:[UIImage imageNamed:@"选择附件"] forState:UIControlStateNormal];
    addFuJianBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [addFuJianBtn addTarget:self action:@selector(addFuJianAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:addFuJianBtn];
    
    addHoliday = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 80, 30)];
    [addHoliday setBackgroundImage:[UIImage imageNamed:@"添加内容"] forState:UIControlStateNormal];
    [addHoliday addTarget:self action:@selector(addHolidayAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:addHoliday];
    CleanBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 60, 30)];
    [CleanBtn setBackgroundImage:[UIImage imageNamed:@"清空"] forState:UIControlStateNormal];
    [CleanBtn addTarget:self action:@selector(CleanAllHoliday) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:CleanBtn];
    cycleScroll =[[CycleScrollView alloc]initWithFrame:CGRectMake(10,addFuJianBtn.frame.origin.y+addFuJianBtn.frame.size.height+5, PL_WIDTH-20, 250)];
    
     cycleScroll.backgroundColor = [UIColor clearColor];
    cycleScroll.hidden=YES;
    [footerView addSubview:cycleScroll];
    cycleScrollHid =[[CycleScrollView alloc]initWithFrame:CGRectMake(10,addFuJianBtn.frame.origin.y+addFuJianBtn.frame.size.height+5, PL_WIDTH-20,  (PL_WIDTH-20)/1.2)];
        [cycleScrollHid cycleDirection:CycleDirectionLandscape pictures:imageArray2];
        cycleScrollHid.backgroundColor = [UIColor clearColor];
    [footerView addSubview:cycleScrollHid];
    self.holidayTableView.delegate = self;
    self.holidayTableView.dataSource = self;
    [self tableViewLine];
    //灰色背景
    blackView = [[UIView alloc] init];
    blackView.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
    blackView.backgroundColor = PL_CUSTOM_COLOR(0, 0, 0, 0.5);
    [self.view addSubview:blackView];
    
    self.pushView.frame =CGRectMake(0, PL_HEIGHT/3, PL_WIDTH, 182);
    self.pushView.layer.borderWidth = 1;
    self.pushView.layer.borderColor = PL_CUSTOM_COLOR(227, 227, 229, 1).CGColor;
    [blackView addSubview:self.pushView];
    blackView.hidden = YES;
    
    self.StyleTableView.frame=CGRectMake(0,[UIScreen mainScreen].bounds.size.height-140, blackView.frame.size.width,140);
    self.StyleTableView.delegate=self;
    self.StyleTableView.dataSource=self;
      self.StyleTableView.hidden=YES;
    self.StyleTableView.bounces=NO;
    
    [blackView addSubview:self.StyleTableView];

    _Star_PickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height-140, [UIScreen mainScreen].bounds.size.width, 140)];
    _Star_PickerView.dataSource=self;
    _Star_PickerView.delegate=self;
    _Star_PickerView.hidden=YES;
    _Star_PickerView.backgroundColor=[UIColor whiteColor];
    [blackView addSubview:_Star_PickerView];
    
    _End_PickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-140, [UIScreen mainScreen].bounds.size.width,140)];
    _End_PickerView.dataSource=self;
    _End_PickerView.delegate=self;
    _End_PickerView.hidden=YES;
    _End_PickerView.backgroundColor=[UIColor whiteColor];
    [blackView addSubview:_End_PickerView];
    
    UITapGestureRecognizer*TapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(FooterViewTapGestureClick)];
    [footerView addGestureRecognizer:TapGesture];
    UITapGestureRecognizer*TapGesture2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HeaderViewTapGestureClick)];
    [self.headerView addGestureRecognizer:TapGesture2];
}
//add Holiday Action
-(void)addHolidayAction
{
    
 
    self.selectBtn1.hidden=NO;
    self.selectBtn2.hidden=NO;
    self.selectBtn3.hidden=NO;
    [self.btnLabel1 setTitle:@"" forState:UIControlStateNormal];
    [self.btnLabel2 setTitle:@"" forState:UIControlStateNormal];
    [self.btnLabel3 setTitle:@"" forState:UIControlStateNormal];
    blackView.hidden = NO;
    [reasonTextView resignFirstResponder];
    

}
//Add Enclosure Action
-(void)addFuJianAction
{
       alertViewimage=[[UIAlertView alloc]initWithTitle:@"请上传附件证明" message:nil delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"拍照",@"本地相册" ,nil];
        [alertViewimage show];
      
}
#pragma mark--TapGresture Action
-(void)FooterViewTapGestureClick
{
[reasonTextView resignFirstResponder];
}
-(void)HeaderViewTapGestureClick
{
[reasonTextView resignFirstResponder];
}
#pragma mark--AlertView提示
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView==HoliDayAview) {
        if (buttonIndex==0) {
            NSLog(@"是");
      }else
        {
             imageFlg=@"0";
            [self requestPost_JsonData];
           
        }
        
    }else
    {
    if (buttonIndex==0) {
        NSLog(@"取消");
    }else if (buttonIndex==1)
    {
        NSLog(@"拍照");
         [self openCarama];
    }else
    {
        NSLog(@"相册");
         [self locaPhonto];
    }
    }
    
}
//打开相机
-(void)openCarama
{
    UIImagePickerController*imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
   imagePicker.allowsEditing=YES;
    imagePicker.delegate=self;
    [self presentViewController:imagePicker animated:YES completion:nil];
    [self.view addSubview:imagePicker.view];
    
   
    
}
//打开相册
-(void)locaPhonto
{
    UIImagePickerController*ImagePicker=[[UIImagePickerController alloc]init];
    ImagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    ImagePicker.delegate=self;
   ImagePicker.allowsEditing=YES;
    [self presentViewController:ImagePicker animated:YES completion:nil];
    [self.view addSubview:ImagePicker.view];
    
}
#pragma mark CameraDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
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
        [imageArray addObject:[UIImage imageWithContentsOfFile:filePath]];
        if (imageArray.count>0) {
            cycleScroll.hidden=NO;
            cycleScrollHid.hidden=YES;
             }
        [picker dismissViewControllerAnimated:YES completion:nil];
               UIImage * baseImage = [UIImage imageWithContentsOfFile:filePath];
        UIImage * imagess = [self imageWithImage:baseImage scaledToSize:CGSizeMake(600,450)];
        NSData * daImage = UIImagePNGRepresentation(imagess);
        NSData * iamgeData2 = [daImage base64EncodedDataWithOptions:0];
       imageData = [[NSString alloc]initWithData:iamgeData2 encoding:NSUTF8StringEncoding];
        [_ImageDataArray addObject:imageData];
        [cycleScroll cycleDirection:CycleDirectionLandscape pictures:imageArray];
       }
}
//图片转新图片的大小
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
//获取请假的时间
#pragma mark 请求请假的时间和个人信息
-(void)AcquiresHolidayTimes;
{
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]afGetSelectLeaveInfo:[PL_USER_STORAGE objectForKey:PL_USER_NAME] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(id obj) {
        PL_PROGRESS_DISMISS;
        NSString *str=obj;
        if ([str isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
        }
        else  if ([str isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        else if ([str isEqualToString:@"[]"])
        {
            PL_ALERT_SHOW(@"暂无数据");
        }
        else
        {
            SBJSON *json=[[SBJSON alloc]init];
            _array = [json objectWithString:str error:nil];
            if (_array && [_array isKindOfClass:[NSArray class]]) {
                NSMutableArray *tempArr=[NSMutableArray array];
                for (NSDictionary * dict in _array)
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
                        if ((NSNull *)str!=[NSNull null]) {
                            [tempArr addObject:str];
                        }
                        else
                        {
                            NSLog(@"数据为空%@",str);
                        }
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    StyleArray=[[NSMutableArray alloc]initWithArray:tempArr];
                    _yearHour.text = [NSString stringWithFormat:@"%@小时",str1];
                    _moneyHour.text = [NSString stringWithFormat:@"%@小时",str2];
                    _tiaoxiuHour.text = [NSString stringWithFormat:@"%@小时",str3];
                });
                
            }
            else
            {
                NSLog(@"暂无数据");
                
            }
        }
        
    }];
    

    
}

//tableView15像素删除
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

//删除15像素线
-(void)tableViewLine
{
    if ([self.holidayTableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.holidayTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.holidayTableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.holidayTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}
#pragma mark TableViewDelegate
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==self.StyleTableView) {
        return 1;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView==self.holidayTableView) {
        return 400;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableView==self.holidayTableView) {
        return footerView;
    }
    
       return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==self.holidayTableView) {
        return 120;
    }
    
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView==self.holidayTableView) {
        return self.headerView;
    }
   
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.StyleTableView) {
        static NSString *cellId2 = @"cellID";

        UITableViewCell*cell3=[tableView dequeueReusableCellWithIdentifier:cellId2];
        if (!cell3) {
            cell3=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId2];
           
        }
        cell3.textLabel.text=StyleArray[indexPath.row];

     return cell3;
    }
    if(tableView==self.holidayTableView)
    {
        if (indexPath.section == 0) {
            
        {
            static NSString *cellId = @"cellID";
            HolidayCell *cell = (HolidayCell*)[tableView dequeueReusableCellWithIdentifier:cellId];
            if(!cell)
            {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"HolidayCell" owner:self options:nil] lastObject];
            }
            if (self.HoulidayArray.count>0) {
                SingleHoulidayModel*model2=[SingleHoulidayModel TransferDictionary:self.HoulidayArray[indexPath.row]];
                cell.TypeLabel.text=model2.Type_Str;
                cell.Satr_label.text=model2.Star_Time;
                cell.End_label.text=model2.End_Time;
                 cell.selectionStyle=UITableViewCellSelectionStyleNone;
                
            }
           
            return cell;
           
        }
    }
        
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.holidayTableView) {
        return 40.0f;
    }
    return 35.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.StyleTableView) {
        return StyleArray.count;
    }
    
        return self.HoulidayArray.count;
}
//tableviewCell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.StyleTableView) {
        UITableViewCell*cell=[tableView cellForRowAtIndexPath:indexPath];
        TypeStr=cell.textLabel.text;
        isHolidayType=YES;
        for (NSDictionary*dic in self.HoulidayArray ) {
            SingleHoulidayModel*modelType=[SingleHoulidayModel RecstTypeString:dic];
            if ([modelType.Type_Str isEqualToString:@"陪产假"]) {
                if ([modelType.Type_Str isEqualToString:cell.textLabel.text]) {
                    PL_ALERT_SHOW(@"陪产假不能重复申请，如果日期有误请先删除，再重新选择");
                    [self.btnLabel1 setTitle:@"" forState:0];
                    self.selectBtn1.hidden=NO;
                    isHolidayType=NO;
                }

            }else if ([modelType.Type_Str isEqualToString:@"产假"])
            {
                if ([modelType.Type_Str isEqualToString:cell.textLabel.text]) {
                    PL_ALERT_SHOW(@"产假不能重复申请，如果日期有误请先删除，再重新选择");
                    [self.btnLabel1 setTitle:@"" forState:0];
                    self.selectBtn1.hidden=NO;
                    isHolidayType=NO;
                }

                
            }else if ([modelType.Type_Str isEqualToString:@"婚假"])
            {
                if ([modelType.Type_Str isEqualToString:cell.textLabel.text]) {
                    PL_ALERT_SHOW(@"婚假不能重复申请，如果日期有误请先删除，再重新选择");
                    [self.btnLabel1 setTitle:@"" forState:0];
                    self.selectBtn1.hidden=NO;
                    isHolidayType=NO;
                }
                
            }else if ([modelType.Type_Str isEqualToString:@"产检假"])
            {
                if ([modelType.Type_Str isEqualToString:cell.textLabel.text]) {
                    PL_ALERT_SHOW(@"产检假不能重复申请，如果日期有误请先删除，再重新选择");
                    [self.btnLabel1 setTitle:@"" forState:0];
                    self.selectBtn1.hidden=NO;
                    isHolidayType=NO;
                }
                
            }else if ([modelType.Type_Str isEqualToString:@"丧假"])
            {
                if ([modelType.Type_Str isEqualToString:cell.textLabel.text]) {
                    PL_ALERT_SHOW(@"丧假不能重复申请，如果日期有误请先删除，再重新选择");
                    [self.btnLabel1 setTitle:@"" forState:0];
                    self.selectBtn1.hidden=NO;
                    isHolidayType=NO;
                }

                
            }
           
        }
   
    
        if (isHolidayType) {
            [self.btnLabel1 setTitle:cell.textLabel.text forState:0];
            self.selectBtn1.hidden=YES;
            [reasonTextView resignFirstResponder];
            NSDictionary*dic=[_array objectAtIndex:indexPath.row];
            numberStr=[dic objectForKey:@"Number03"];
            if ([TypeStr isEqualToString:@"事假"])
            {
                if (str1.intValue>0) {
                    PL_ALERT_SHOW(@"有可申请的年假时长，不可申请事假");
                    self.selectBtn2.hidden=NO;
                    self.selectBtn3.hidden=NO;
                    self.End_PickerView.hidden=YES;
                    [self.btnLabel1 setTitle:@"" forState:0];
                    [self.btnLabel2 setTitle:@"" forState:0];
                    [self.btnLabel3 setTitle:@"" forState:0];
                }
                
            }else if ([TypeStr isEqualToString:@"无薪病假"])
            {
                if (str2.intValue>0) {
                     PL_ALERT_SHOW(@"有可申请的有薪病假，不可申请无薪病假");
                    [self.btnLabel1 setTitle:@"" forState:0];
                    self.selectBtn1.hidden=NO;

                }
                
            }else if ([numberStr.stringValue isEqualToString:@"3"])
            {
                if ([str4 isEqualToString:@"2"]) {
                    
                    PL_ALERT_SHOW(@"没有出生日期，请联系人事部，否则不能请婚假");

                }
            }

        }
        
        
    }
    
    
   }
#pragma mark tableView清空按钮的操作
-(void)CleanAllHoliday
{
_yearHour.text=[NSString stringWithFormat:@"%@小时",str1];

_moneyHour.text=[NSString stringWithFormat:@"%@小时",str2];

_tiaoxiuHour.text=[NSString stringWithFormat:@"%@小时",str3];
    
    [self.HoulidayArray removeAllObjects];
    [self.holidayTableView reloadData];
    
}
//PopView响应
-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//申请历史的按钮
-(void)rightClick
{
    HolidayListViewController *xj=[[HolidayListViewController alloc]init];
    xj.modeStr = @"2";
    [self.navigationController pushViewController:xj animated:YES];
}
//确认提交请假申请
- (IBAction)sureBtnAction:(id)sender
{
    
    if  (self.HoulidayArray.count==0)
    {
        PL_ALERT_SHOW(@"无请假信息，不能提交。请先点击“加号”按钮");
        
     }else if ([reasonTextView.text isEqualToString:@""])
    {
        PL_ALERT_SHOW(@"请假事由不能为空");
        
    }else if (imageArray.count==0)
     {
            
    HoliDayAview=[[UIAlertView alloc]initWithTitle:@"提示" message:@"没有上传附件是否仍要提交申请？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    [HoliDayAview show];
            
    }else
    {
        if ([TypeStr isEqualToString:@"年假"]) {
            imageFlg=@"2";
            [self requestPost_JsonData];
            
        }else if ([TypeStr isEqualToString:@"事假"])
        {
            imageFlg=@"2";
            [self requestPost_JsonData];
            
        }else
        {
            imageFlg=@"1";
            [self requestPost_JsonData];
            
        }
        
    }
}

#pragma mark 开始时间的日历方法

-(void)PresentCalenDarView_Star
{
    
    
    
    if (!cavc) {
        
        cavc = [[CalendarHomeViewController alloc]init];
        
        
        [cavc setAirPlaneToDay:365 ToDateforString:nil];
        
    }
    
    [self presentViewController:cavc animated:YES completion:^{
       
        __block HolidayViewController*blockSelf=self;
        __block NSString *newStr4 = str4;
        __block NSNumber*numstr=numberStr;
               cavc.calendarblock = ^(CalendarDayModel *model){
            
            NSLog(@"%@",[model toString]);
             [blockSelf.btnLabel2 setTitle: [NSString stringWithFormat:@"%@ 09:00:00",[model toString]] forState:UIControlStateNormal];
            starDateString=[NSString stringWithFormat:@"%@ 09:00:00",[model toString]];
                  _starTime= [NSString stringWithFormat:@"%@ 09:00:00",[model toString]];
                    blockSelf.selectBtn2.hidden=YES;
              if([numstr.stringValue isEqualToString:@"3"])
            {
                if ([newStr4 isEqualToString:@"0"] ) {
                    
                   [blockSelf.btnLabel3 setTitle:[blockSelf marriageTime:blockSelf.starTime withDate:3] forState:0];
                    blockSelf.endTime=[blockSelf marriageTime:blockSelf.starTime withDate:3];
                    if ([blockSelf.endTime isEqualToString:@""]) {
                        blockSelf.selectBtn3.hidden =NO;
                    }
                    else
                    {
                        blockSelf.selectBtn3.hidden = YES;
                    }

                    
                }
                if([newStr4 isEqualToString:@"1"])
                {
                    [blockSelf.btnLabel3 setTitle:[blockSelf marriageTime:blockSelf.starTime withDate:10] forState:0];
                     blockSelf.endTime=[blockSelf marriageTime:blockSelf.starTime withDate:10];
                    if ([blockSelf.endTime isEqualToString:@""]) {
                        blockSelf.selectBtn3.hidden =NO;
                    }
                    else
                    {
                        blockSelf.selectBtn3.hidden = YES;
                    }

                }
            }else if ([numstr.stringValue isEqualToString:@"12"])
            {
                [blockSelf.btnLabel3 setTitle:[blockSelf marriageTime:blockSelf.starTime withDate:3] forState:0];
                blockSelf.endTime=[blockSelf marriageTime:blockSelf.starTime withDate:3];
                if ([blockSelf.endTime isEqualToString:@""]) {
                    blockSelf.selectBtn3.hidden =NO;
                }
                else
                {
                    blockSelf.selectBtn3.hidden = YES;
                }
                

            }
               
         };
        }];
    
   }
#pragma mark 结束时间的日历方法

-(void)PresentCalenDarView_End
{
    
    if (!cavc) {
        
        cavc = [[CalendarHomeViewController alloc]init];
        
        
        [cavc setAirPlaneToDay:365 ToDateforString:nil];
        
    }
    
    [self presentViewController:cavc animated:YES completion:^{
               __block HolidayViewController*blockSelf=self;
             cavc.calendarblock = ^(CalendarDayModel *model){
            
            NSLog(@"%@",[model toString]);
            [blockSelf.btnLabel3 setTitle: [NSString stringWithFormat:@"%@ 14:00:00",[model toString]] forState:UIControlStateNormal];
            endDateString=[NSString stringWithFormat:@"%@ 14:00:00",[model toString]];
            _endTime=[NSString stringWithFormat:@"%@ 14:00:00",[model toString]];
               blockSelf.selectBtn3.hidden=YES;
                 
     };
        
        
    }];
    
    }
#pragma mark--请假类型对应的数字
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
#pragma mark 提交申请请求
-(void)requestPost_JsonData
{
    [self imgFlg];
    PL_PROGRESS_SHOW;
    NSArray*LastArray=[self SortDescriptorAscending:self.HoulidayArray];
    _MultibarDic=@{@"TableAskForLeave":LastArray,
                   @"Summary":@"",
                   @"IsFile":imageFlg,
                   @"ProcessId":@"0",
                   @"ApprovalType":@"0",
                   @"OldProcessId":@"0",
                   @"OldStartDate":@"",
                   @"FileList":self.ImageDataArray,
                   @"Reason":reasonTextView.text};
    
    NSData*jsonDatas=[NSJSONSerialization dataWithJSONObject:_MultibarDic
                                                     options:NSJSONWritingPrettyPrinted error:nil];
    NSArray*ForamtArray=[NSArray arrayWithArray:self.ImageDataArray];
    if (ForamtArray.count==0) {
        ForamtArray=@[];
    }
    
       [[MyRequest defaultsRequest]MultibarHouliDayJsonData: [[NSString alloc]initWithData:jsonDatas encoding:NSUTF8StringEncoding]userID:[PL_USER_STORAGE objectForKey:PL_USER_NAME] Token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] complteBack:^(NSString *string) {
        if ([string isEqualToString:@"OK"]) {
            PL_ALERT_SHOW(@"已成功发起流程，请等待审核");
            [self.HoulidayArray removeAllObjects];
            [imageArray removeAllObjects];
            [cycleScroll cycleDirection:CycleDirectionLandscape pictures:imageArray2];
            
            [self.holidayTableView reloadData];
            
            reasonTextView.text=@"";
          
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
    
        
    
        
}];
    PL_PROGRESS_DISMISS;
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
          }
        else
        {
            imageFlg = @"2";
        }
        
        
    }else
    {
       imageFlg = @"2";
    }
    
    
    
    
    }
    
}

#pragma mark--xib按钮的方法
//取消请假申请
- (IBAction)cancelBtnAction:(id)sender {
    self.HoulidayArray=nil;
    count=1;
    [self.holidayTableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
    
    }
//请假类型
- (IBAction)selectBtn1Action:(id)sender {
    
   
   self.StyleTableView.hidden=NO;
      self.Star_PickerView.hidden=YES;
    self.End_PickerView.hidden=YES;
    [self.btnLabel2 setTitle:@"" forState:0];
    [self.btnLabel3 setTitle:@"" forState:0];
    self.selectBtn2.hidden=NO;
    self.selectBtn3.hidden=NO;
    [self.StyleTableView reloadData];

    
    
}
//开始时间
- (IBAction)selectBtn2Action:(id)sender {
    self.StyleTableView.hidden=YES;
    if ( [TypeStr isEqualToString:@""]) {
        PL_ALERT_SHOW(@"请先选择请假类型");
    }
    else if ([str4 isEqualToString:@"2"]) {
        PL_ALERT_SHOW(@"你的年龄不符合");
        self.pushView.hidden =YES;
    }else
    {
        [self PresentCalenDarView_Star];
        self.Star_PickerView.hidden=NO;
        self.End_PickerView.hidden=YES;
        [self.Star_PickerView selectRow:0 inComponent:0 animated:YES];
        [self.Star_PickerView reloadAllComponents];
        
    }
    
    
    
}
//结束时间
- (IBAction)selectBtn3Action:(id)sender {
    self.StyleTableView.hidden=YES;

      if ( [TypeStr isEqualToString:@""]) {
        PL_ALERT_SHOW(@"请先选择请假类型");
       
    }
    else if([numberStr.stringValue isEqualToString:@"3"])
    {
        PL_ALERT_SHOW(@"婚假填写开始时间即可");
    }else if([numberStr.stringValue isEqualToString:@"12"])
    {
        PL_ALERT_SHOW(@"陪产假填写开始时间即可");
    }else
      {
          [self PresentCalenDarView_End];
          self.End_PickerView.hidden=NO;
          self.Star_PickerView.hidden=YES;
          [self.End_PickerView selectRow:0 inComponent:0 animated:YES];
          [self.End_PickerView reloadAllComponents];

      }
        }
//填写时间的提交按钮
#pragma mark--小提交请求
- (IBAction)upAction:(id)sender {
    
    
    if(TypeStr.length == 0)
    {
        PL_ALERT_SHOW(@"请选择请假类型");
    }
    else if(_starTime.length == 0|| _endTime.length == 0)
    {
        PL_ALERT_SHOW(@"请填写休假时间");
    }else if ([self EquelSatrTime:_starTime])
    {
        PL_ALERT_SHOW(@"只能补前一天假期");
    } else if ([self.starTime compare:self.endTime options:NSNumericSearch]==NSOrderedDescending||[self.starTime compare:self.endTime options:NSNumericSearch]==NSOrderedSame)
    {
        PL_ALERT_SHOW(@"请假的起始日期时间必须小于截止的日期时间");
        [self.btnLabel2 setTitle:@"" forState:0];
        [self.btnLabel3 setTitle:@"" forState:0];
    }else if ([self.btnLabel2.titleLabel.text isEqualToString:@""]||[self.btnLabel3.titleLabel.text isEqualToString:@""])
    {
        PL_ALERT_SHOW(@"请填写休假时间");
    }else if ([numberStr.stringValue isEqualToString:@"5"])
    {
        if([self compareTime: self.starTime withTime:self.endTime]>3)
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

-(void)CalculationHolidayDate
{
    NSString*PrevEndDate=[self.HoulidayArray lastObject][@"EndDate"];
    if (PrevEndDate==nil) {
        PrevEndDate=@"";
    }
    [[MyRequest defaultsRequest] CheckLeaveLeaveType:TypeStr StartDate:self.btnLabel2.titleLabel.text EndDate:self.btnLabel3.titleLabel.text PrevEndDate:PrevEndDate userid:[PL_USER_STORAGE objectForKey:PL_USER_USERID] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] complteBack:^(NSString *str) {
        
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
                        self.selectBtn2.hidden=NO;
                        self.selectBtn3.hidden=NO;
                        self.End_PickerView.hidden=YES;
                        [self.btnLabel2 setTitle:@"" forState:0];
                        [self.btnLabel3 setTitle:@"" forState:0];
                        
                        
                    }else
                    {
                        [self AddHolidayMutiBar];
                        Annualleave=Annualleave-AfterComputingTime;
                        _yearHour.text=[NSString stringWithFormat:@"%d小时",Annualleave];
                    }
                }else if ([TypeStr isEqualToString:@"有薪病假"])
                {
                    if(Paidsickleave <AfterComputingTime)
                    {
                        PL_ALERT_SHOW(@"没有足够多的带薪病假可申请，请删除表单中的有薪病假");
                        self.selectBtn2.hidden=NO;
                        self.selectBtn3.hidden=NO;
                        self.End_PickerView.hidden=YES;
                        [self.btnLabel2 setTitle:@"" forState:0];
                        [self.btnLabel3 setTitle:@"" forState:0];
                    }else
                    {
                        [self AddHolidayMutiBar];
                        Paidsickleave=Paidsickleave-AfterComputingTime;
                        _moneyHour.text=[NSString stringWithFormat:@"%d小时",Paidsickleave];
                    }
                }else if ([TypeStr isEqualToString:@"调休"])
                {
                    if(Offleave <AfterComputingTime)
                    {
                        PL_ALERT_SHOW(@"没有足够多的调休可申请，请删除表单中的调休");
                        self.selectBtn2.hidden=NO;
                        self.selectBtn3.hidden=NO;
                        self.End_PickerView.hidden=YES;
                        [self.btnLabel2 setTitle:@"" forState:0];
                        [self.btnLabel3 setTitle:@"" forState:0];
                    }else
                    {
                        [self AddHolidayMutiBar];
                        Offleave=Offleave-AfterComputingTime;
                        _tiaoxiuHour.text=[NSString stringWithFormat:@"%d小时",Offleave];
                    }
                }
            }else
            {
                [self AddHolidayMutiBar];
            }
        }
    }];

}
//添加单条请假信息的方法
-(void)AddHolidayMutiBar
{
        [self initWithFromtNumber];
        OneDic=@{@"Type":Num_Str,
                 @"StartDate":self.btnLabel2.titleLabel.text,
                 @"EndDate":self.btnLabel3.titleLabel.text,
                 @"Character01":TypeStr,
                 @"Hours":@"0",
                 @"EmpCode":_Code.text,
                 @"EmpName":_User.text};
        [self.HoulidayArray addObject:OneDic];
        blackView.hidden = YES;
        self.StyleTableView.hidden=YES;
        self.Star_PickerView.hidden=YES;
        self.End_PickerView.hidden=YES;
        [self.holidayTableView reloadData];

    
    

}
//填写时间的取消按钮
- (IBAction)dismissAction:(id)sender {
    blackView.hidden=YES;
    self.StyleTableView.hidden=YES;
    self.Star_PickerView.hidden=YES;
    self.End_PickerView.hidden=YES;
}
//类型_请选择
- (IBAction)pleaseSelect_Type:(UIButton *)sender {
    self.StyleTableView.hidden=NO;
    self.Star_PickerView.hidden=YES;
    self.End_PickerView.hidden=YES;
    [self.btnLabel2 setTitle:@"" forState:0];
    [self.btnLabel3 setTitle:@"" forState:0];
    self.selectBtn2.hidden=NO;
    self.selectBtn3.hidden=NO;
    [self.StyleTableView reloadData];
}
//开始时间——请选择
- (IBAction)PleaseSelect_StarTime:(UIButton *)sender {
    self.StyleTableView.hidden=YES;
    if(TypeStr.length == 0)
    {
        PL_ALERT_SHOW(@"请选择请假类型");
    }else
    {
        [self PresentCalenDarView_Star];
        self.Star_PickerView.hidden=NO;
        self.End_PickerView.hidden=YES;
        
    }

   
}
//结束时间——请选择
- (IBAction)PleaseSelect_EndTime:(UIButton *)sender {
    self.StyleTableView.hidden=YES;
    if(TypeStr.length == 0)
    {
        PL_ALERT_SHOW(@"请选择请假类型");
    }else
    {
        [self PresentCalenDarView_End];
        self.Star_PickerView.hidden=YES;
        self.End_PickerView.hidden=NO;
        
        
    }


    

    
}
#pragma mark TextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
    }
    return YES;
}
/******时间比较的方法**********/
#pragma mark --时间比较的方法
- (float)compareTime:(NSString *)startStr withTime:(NSString *)endStr
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
    float dete2 = time/(3600*24);
    int deteTime = dete / 3600 ;
    if (deteTime > 5) {
        dete2 += 1;
    }else if(deteTime >0 && deteTime <= 5){
        dete2 += 0.5;
    }
    return dete2;
}
//根据开始时间计算结束时间
- (NSString*)marriageTime:(NSString *)startStr withDate:(NSTimeInterval)timerInterval
{
    NSString * dateStr = @"";
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [dateFormatter dateFromString:startStr];
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
//判断是不是同一天的请假
-(BOOL)EquelSatrTime:(NSString*)str2_Time
{
    
    NSDate*locaDate=[NSDate date];
    
    NSDateFormatter*datef=[[NSDateFormatter alloc]init];
    [datef setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString*str=[datef stringFromDate:locaDate];
    str2_Time=self.starTime;
    
    NSDate*date1=[[datef dateFromString:str]initWithTimeIntervalSinceNow:8*60*60];
    NSDate*date2=[[datef dateFromString:str2_Time]dateByAddingTimeInterval:8*60*60];
    
    NSTimeInterval TimeIn=[date1 timeIntervalSinceDate:date2];
    
    if (TimeIn>24*60*60){
      return YES;
    }
     return NO;
    
    
}
#pragma mark - pickerView代理
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (pickerView==self.Star_PickerView) {
        PickerArray=@[@"09:00",@"14:00"];
    }
    else
    {
        PickerArray=@[@"14:00",@"18:00"];
    }
    UILabel*lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60,40)];
    lab.text=[PickerArray objectAtIndex:row];
    lab.font=[UIFont systemFontOfSize:16];
    
    return lab;
    
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView==self.Star_PickerView){
        
        [self.btnLabel2 setTitle:[NSString stringWithFormat:@"%@ %@:00",[starDateString substringWithRange:NSMakeRange(0, 10)],PickerArray[row]] forState:UIControlStateNormal];
        _starTime=[NSString stringWithFormat:@"%@ %@:00",[starDateString substringWithRange:NSMakeRange(0, 10)],PickerArray[row]];
        self.selectBtn2.hidden = YES;
        if([numberStr.stringValue isEqualToString:@"3"])
        {
            if ([str4 isEqualToString:@"0"] ) {
                
                [self.btnLabel3 setTitle:[self marriageTime:_starTime withDate:3] forState:0];
                _endTime=[self marriageTime:_starTime withDate:3];
                
                
            }
            if([str4 isEqualToString:@"1"])
            {
                 [self.btnLabel3 setTitle:[self marriageTime:_starTime withDate:10] forState:0];
                _endTime=[self marriageTime:_starTime withDate:10];
            }
            if ([_endTime isEqualToString:@""]) {
                self.selectBtn3.hidden = NO;
            }
            else
            {
                self.selectBtn3.hidden = YES;
            }

            
        }else if ([numberStr.stringValue isEqualToString:@"12"])
        {
            [self.btnLabel3 setTitle:[self marriageTime:_starTime withDate:3] forState:0];
            _endTime=[self marriageTime:_starTime withDate:3];
            if ([_endTime isEqualToString:@""]) {
                self.selectBtn3.hidden = NO;
            }
            else
            {
                self.selectBtn3.hidden = YES;
            }

            
        }
    }
    else    {
        [self.btnLabel3 setTitle:[NSString stringWithFormat:@"%@ %@:00",[endDateString substringWithRange:NSMakeRange(0, 10)],PickerArray[row]] forState:UIControlStateNormal];
        _endTime=[NSString stringWithFormat:@"%@ %@:00",[endDateString substringWithRange:NSMakeRange(0, 10)],PickerArray[row]];
        if ([_endTime isEqualToString:@""]) {
            self.selectBtn3.hidden = NO;
        }
        else
        {
            self.selectBtn3.hidden = YES;
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
@end
