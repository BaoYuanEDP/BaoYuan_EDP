//
//  TelViewAlert.m
//  BYFCApp
//
//  Created by PengLee on 15/2/11.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "TelViewAlert.h"
#import "Utility+Encrypt.h"
#import "SHCPublicRoom.h"
@interface TelViewAlert()<UITableViewDataSource,UITableViewDelegate,PhoneNumberTableViewCellDelegate>
{   UINib *_phoneNumTableViewCellNib;
    PhoneNumberTableViewCell *_phoneNumCell;
    //临时存储电话号码
    NSString *oldPhoneNumString;
    NSString *newPhoneNumString;
    NSString *custID;
    NSString *callTypeString;
    NSString *strIDC;
    UIView *bgView;
    UIView *genjinView;
    UIButton *footerButton;
    BOOL isloadOver;
    //判断添加电话
    BOOL isClick1;
}
@end
@implementation TelViewAlert
- (instancetype)initWithconnectWithArray:(NSArray *)array Calltype:(callType)type custId:(NSString *)ID
{
    oldPhoneNumString = @"";
    newPhoneNumString = @"";
    isClick1 = YES;
    custID            = ID;
    callTypeString    = [NSString stringWithFormat:@"%ld",(long)type];
    CGRect rect = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
    
    if (self = [super initWithFrame:rect])
    {
        self.frame = rect;
        isloadOver = NO;
        [self loadView:rect];
        
        
    }
    return self;
    
}
- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.4, 1.4);
    self.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}
- (void)fadeOut
{
    [UIView animateWithDuration:.25 animations:^{
        self.transform = CGAffineTransformMakeScale(1.4, 1.4);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)loadView:(CGRect )frame
{
    
    self.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
    
    _telTableView = [[UITableView alloc]initWithFrame:CGRectMake(20,PL_HEIGHT/6, PL_WIDTH-40,400) style:UITableViewStylePlain];
    
    _telTableView.delegate = self;
    _telTableView.dataSource = self;
    //_telTableView.scrollsToTop = NO;
    _telTableView.rowHeight = 60;
    _telTableView.bounces = NO;
    //    _telTableView.tableFooterView = [[UIView alloc]init];
    _telTableView.separatorInset =UIEdgeInsetsZero;
    _telTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self addSubview:_telTableView];
    __block int index = 0;
    //    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clearTel:)];
    //    [self addGestureRecognizer:tap];
    NSLog(@"%d",index);
    [[MyRequest defaultsRequest]afGetPhoneID:custID type:callTypeString completeBack:^(NSMutableString *str) {
        NSLog(@">>>>>>>>%@",str);
        
        index++;
        NSArray *array = [str componentsSeparatedByString:@":"];
        
        NSLog(@"=====%@",[[array.lastObject stringByReplacingOccurrencesOfString:@"\"" withString:@""] componentsSeparatedByString:@","]);
        self.acceptArray =[NSMutableArray arrayWithArray:[[array.lastObject stringByReplacingOccurrencesOfString:@"\"" withString:@""] componentsSeparatedByString:@","]] ;
        
        NSLog(@"----------%@",self.acceptArray);
        //        _telTableView.frame = CGRectMake(20,PL_HEIGHT/6, PL_WIDTH-40,self.acceptArray.count>=4?(4*_telTableView.rowHeight+49+50):(self.acceptArray.count>0?(self.acceptArray.count*_telTableView.rowHeight+49+50):(44+49+50)));
        isloadOver =YES;
        [_telTableView reloadData];
        
    }];
    
    //    self.acceptArray = [NSMutableArray arrayWithArray:array];
    // NSLog(@"arr%d",self.acceptArray.count);
    
    
    
    
}
#pragma mark --tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return self.acceptArray.count;
    }
    else
    {
        return 0;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifer = @"cell";
    if (!_phoneNumTableViewCellNib) {
        _phoneNumTableViewCellNib = [UINib nibWithNibName:@"PhoneNumberTableViewCell" bundle:nil];
        [tableView registerNib:_phoneNumTableViewCellNib forCellReuseIdentifier:identifer];
    }
    _phoneNumCell   = [tableView dequeueReusableCellWithIdentifier:identifer];
    _phoneNumCell.phoneNumberDelegate = self;
    _phoneNumCell.phoneNumTextfield.borderStyle = UITextBorderStyleRoundedRect;
    _phoneNumCell.phoneNumTextfield.font = [UIFont systemFontOfSize:13.0f];
    //    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    //    if (cell==nil)
    //    {
    //        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    //
    //    }
    
    if (self.acceptArray.count>0)
    {
        NSString * telStr  = self.acceptArray[indexPath.row];
        
        if (![telStr isEqualToString:@"|"])
        {
            NSArray * arrTel = [telStr componentsSeparatedByString:@"|"];
            //cell.textLabel.text = arrTel[0];
            
            NSLog(@"%@",arrTel[0]);
            NSString *currentStr=arrTel[0];
            if (currentStr.length==11) {
                _phoneNumCell.phoneNumTextfield.text =[NSString stringWithFormat:@"%@",arrTel[0]];
                UIImage *image=[UIImage imageNamed:@"call_mobile.png"];
                CGSize itemSize = CGSizeMake(30, 30);
                UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
                CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
                [image drawInRect:imageRect];
                
                _phoneNumCell.PhoneTypeImageView.image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
            }
            else
            {
                if([arrTel[0] isEqualToString:@""]||[arrTel[0] isEqualToString:@"}]"])
                {
                    _phoneNumCell.phoneNumTextfield.placeholder = @"";
                }
                if([arrTel[0] isEqualToString:@""]||[arrTel[0] isEqualToString:@"}]"])
                {
                    _phoneNumCell.phoneNumTextfield.text =@"";
                }
                else
                {
                    _phoneNumCell.phoneNumTextfield.text =[NSString stringWithFormat:@"%@",arrTel[0]];
                    
                }
                UIImage *image=[UIImage imageNamed:@"call_phone.png"];
                CGSize itemSize = CGSizeMake(30, 30);
                UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
                CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
                [image drawInRect:imageRect];
                
                _phoneNumCell.PhoneTypeImageView.image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
            }
            
        }
        
    }
    else
    {
        _phoneNumCell.phoneNumTextfield.text = @"暂无客户电话";
        
    }
    // cell.backgroundColor = [UIColor redColor];
    
    return _phoneNumCell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, 30)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 48, PL_WIDTH, 1)];
    label.backgroundColor = [UIColor grayColor];
    
    [view addSubview:label];
    UILabel * connectLable = [[UILabel alloc]init];
    connectLable.text = self.stringTitle;
    connectLable.font = [UIFont boldSystemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
    [view addSubview:connectLable];
    //    connectLable.backgroundColor = [UIColor greenColor];
    [connectLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@25);
        make.top.equalTo(@10);
        make.width.greaterThanOrEqualTo(@40);
        make.height.equalTo(@25);
        
    }];
    
    UIButton * clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clearButton.frame = CGRectMake(CGRectGetMidX(view.frame)+75, 10,25, 25);
    clearButton.backgroundColor = [UIColor clearColor];
    
    [clearButton setBackgroundImage:[UIImage imageNamed:@"close_call_phone_activity.png.png"] forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(removeClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:clearButton];
    //    [view setBackgroundColor:[UIColor purpleColor]];
    return view;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    footerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
    
    [footerButton setImage:[UIImage imageNamed:@"call_phone_add"] forState:UIControlStateNormal];
    [footerButton addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
    return footerButton;
}
- (void)removeClick:(UIButton *)button
{
    [self clearTel:nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 49;
    }
    else
    {
        return 0;
        
    }
    
    
}
- (void)showTelWindow:(UIView *)myview
{
    
    [myview.window addSubview:self];
    [self bringSubviewToFront:myview.superview.window];
    
    
    [self fadeIn];
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    //    if (cell.selected)
    //    {
    //        cell.backgroundColor = [UIColor blueColor];
    //    }
    _phoneNumCell = (PhoneNumberTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if(_phoneNumCell.phoneNumTextfield.userInteractionEnabled==YES)
    {
        
    }
    else
    {
        NSString * telStr  = [self.acceptArray[indexPath.row] stringByReplacingOccurrencesOfString:@"}]" withString:@""];
        NSLog(@">>>>>>>>>>>%@",telStr);
        
        NSArray * arrTel = [telStr componentsSeparatedByString:@"|"];
        NSLog(@"%@",arrTel.lastObject);
        if (arrTel.count>0)
        {
            if ([arrTel.lastObject isEqualToString:@""]||[[PL_USER_STORAGE objectForKey:PL_USER_PHONEnUM]  isEqualToString:@""]) {
                
            }
            else
            {
                PL_ALERT_SHOW(@"系统正在拨打，请稍后");
                PL_PROGRESS_SHOW;
                if ([callTypeString isEqualToString:@"1"]) {
                    [[MyRequest defaultsRequest]afDialCustTelephone:[PL_USER_STORAGE objectForKey:PL_USER_PHONEnUM] CustPhone:arrTel.lastObject ID:custID Type:callTypeString FromCode:[PL_USER_STORAGE objectForKey:PL_USER_SUPCODE] userid:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSMutableString *str)
                     {
                         PL_PROGRESS_DISMISS;
                         NSLog(@"%@",str);
                         strIDC = str;
                         if ([[strIDC substringToIndex:1] isEqualToString:@"T"]) {
                             [self clearTel:nil];
                             
                             if ([strIDC isEqualToString:@"True"]) {
                                 
                             }
                             else
                             {
                                 NSString *str1 =[strIDC substringFromIndex:5];
                                 [[NSUserDefaults standardUserDefaults] setObject:str1 forKey:@"ROOMFOLLOWID"];
                                 
                             }
                             [[NSNotificationCenter defaultCenter] postNotificationName:@"sunH" object:nil];
                             
                         }
                         else if([strIDC isEqualToString:@"1"])
                         {
                             PL_ALERT_SHOW(@"您好,今天已超过拨打次数");
                         }
                         else if([strIDC isEqualToString:@"ERR"])
                         {
                             PL_ALERT_SHOW(@"对不起,通话记录保存异常，请联系IT部");
                         }
                         else{
                             
                             PL_ALERT_SHOW(@"对不起,您的号码异常，请联系IT部");
                             
                         }
                         
                     }];
                    
                }else
                {
                    [self clearTel:nil];
                    PL_PROGRESS_SHOW;
                    [[MyRequest defaultsRequest]afDialCustTelephone:[PL_USER_STORAGE objectForKey:PL_USER_PHONEnUM] CustPhone:arrTel.lastObject ID:custID Type:callTypeString FromCode:[PL_USER_STORAGE objectForKey:PL_USER_SUPCODE] userid:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userToken:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(NSMutableString *str)
                     {
                         PL_PROGRESS_DISMISS;
                         NSLog(@"%@",str);
                         strIDC = str;
                         if ([[strIDC substringToIndex:1] isEqualToString:@"T"]) {
                             [self clearTel:nil];
                             if ([strIDC isEqualToString:@"True"]) {
                                 
                             }
                             else
                             {
                                 NSString *str1 =[strIDC substringFromIndex:5];
                                 [[NSUserDefaults standardUserDefaults] setObject:str1 forKey:@"FOLLOWID"];
                                 
                             }
                             [[NSNotificationCenter defaultCenter] postNotificationName:@"sunhaichen" object:nil];
                             
                         }
                         else if([strIDC isEqualToString:@"1"])
                         {
                             PL_ALERT_SHOW(@"您好,今天已超过拨打次数");
                         }
                         else if([strIDC isEqualToString:@"ERR"])
                         {
                             PL_ALERT_SHOW(@"对不起,通话记录保存异常，请联系IT部");
                         }
                         else{
                             PL_ALERT_SHOW(@"对不起,您的号码异常，请联系IT部");
                             
                         }
                         
                     }];
                }
                
            }
        }
        _telTableView.frame = CGRectMake(0, 0, 0, 0);
    }
    
    
    //
}
- (void)creatorSHC
{
    
    //    //背景
    //    bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT)];
    //    //bgView.backgroundColor=[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:108.0/255.0 alpha:0.9];
    //    bgView.backgroundColor=[[UIColor grayColor]colorWithAlphaComponent:0.5];
    //    [self addSubview:bgView];
    //
    //
    //    //小背景
    //    genjinView=[[UIView alloc]initWithFrame:CGRectMake(20, PL_HEIGHT/3-30, PL_WIDTH-40, 200+30)];
    //    genjinView.alpha=1;
    //    genjinView.backgroundColor=[UIColor whiteColor];
    //    [bgView addSubview:genjinView];
    //
    //    UILabel *yi=[[UILabel alloc]initWithFrame:CGRectMake(40, 10, 60, 20)];
    //    yi.text=@"意向度:";
    //    [genjinView addSubview:yi];
    //    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(100, 5, 150, 30) numberOfStars:5];
    //    self.starRateView.scorePercent = _sunIn/5.0;
    //    self.starRateView.allowIncompleteStar = NO;
    //    self.starRateView.hasAnimation = YES;
    //    self.starRateView.delegate=self;
    //    [genjinView addSubview:self.starRateView];
    //
    //    //标题
    //    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(PL_WIDTH/2-80, 5+30, 200, 30)];
    //    title.text=@"录入跟进信息";
    //    [genjinView addSubview:title];
    //    //跟进方式、按钮
    //    UIButton *FSBtn=[[UIButton alloc]initWithFrame:CGRectMake(20+20, 30+30, 80, 30)];
    //    [FSBtn addTarget:self action:@selector(fangshiClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [genjinView addSubview:FSBtn];
    //
    //    fangshi=[[UILabel alloc]initWithFrame:CGRectMake(20+20, 35+30, 50, 20)];
    //    fangshi.text=@"跟进方式";
    //    fangshi.font=[UIFont systemFontOfSize:12];
    //    fangshi.textAlignment=NSTextAlignmentCenter;
    //    [genjinView addSubview:fangshi];
    //    fangshiBtn=[[UIButton alloc]initWithFrame:CGRectMake(71+20, 40+30, 10, 10)];
    //    [fangshiBtn setImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    //    [fangshiBtn setImage:[UIImage imageNamed:@"dropup.png"] forState:UIControlStateSelected];
    //    [fangshiBtn addTarget:self action:@selector(fangshiClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [genjinView addSubview:fangshiBtn];
    //    //跟进方式
    //    NSMutableArray * arrTitle = [NSMutableArray arrayWithObjects:@"电话",@"手机",@"微信",@"QQ", nil];
    //    sousuoView = [[UIView alloc]initWithFrame:CGRectMake(20+20, 55+30, 80, 30*arrTitle.count)];
    //    UIImageView * viewBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"black.png"]];
    //    viewBg.frame = CGRectMake(0, 0, CGRectGetWidth(sousuoView.frame), CGRectGetHeight(sousuoView.frame));
    //    [sousuoView addSubview:viewBg];
    //    for (int i=0; i<3; i++)
    //    {
    //        UIImageView * sousuoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,i*28+26+10+5, 80, 1)];
    //        sousuoImage.image = [UIImage imageNamed:@"black_in_hengxian.png"];
    //        sousuoImage.backgroundColor = [UIColor clearColor];
    //        [sousuoView addSubview:sousuoImage];
    //    }
    //
    //    for (int j=0; j<arrTitle.count; j++)
    //    {
    //        UIButton * buttonLable = [UIButton buttonWithType:UIButtonTypeCustom];
    //        buttonLable.frame = CGRectMake(0, j*28+18, 80, 20);
    //        buttonLable.backgroundColor = [UIColor clearColor];
    //        buttonLable.titleLabel.font=[UIFont systemFontOfSize:18];
    //        [buttonLable setTitle:[arrTitle objectAtIndex:j] forState:UIControlStateNormal];
    //        [buttonLable setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //
    //        buttonLable.tag =2500+j;
    //        [buttonLable addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    //        [sousuoView addSubview:buttonLable];
    //    }
    //
    //    sousuoView.backgroundColor = [UIColor clearColor];
    //    //跟进类型、按钮
    //    UIButton *STBtn=[[UIButton alloc]initWithFrame:CGRectMake(120+40, 30+30, 80, 30)];
    //    [STBtn addTarget:self action:@selector(styleClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [genjinView addSubview:STBtn];
    //
    //    style=[[UILabel alloc]initWithFrame:CGRectMake(120+40, 35+30, 50, 20)];
    //    style.text=@"跟进类型";
    //    style.font=[UIFont systemFontOfSize:12];
    //    [genjinView addSubview:style];
    //    styleBtn=[[UIButton alloc]initWithFrame:CGRectMake(171+40, 40+30, 10, 10)];
    //    [styleBtn setImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    //    [styleBtn setImage:[UIImage imageNamed:@"dropup.png"] forState:UIControlStateSelected];
    //    [styleBtn addTarget:self action:@selector(styleClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [genjinView addSubview:styleBtn];
    //    sousuoViewstyle = [[UIView alloc]initWithFrame:CGRectMake(120+40, 55+30, 80, 80+40)];
    //
    //    //输入框
    //    textView1=[[UITextView alloc]initWithFrame:CGRectMake(20, 55+30, PL_WIDTH-40-40, 100)];
    //    textView1.layer.borderWidth=1.5;
    //    textView1.layer.borderColor = [UIColor grayColor].CGColor;
    //    textView1.delegate=self;
    //    [genjinView addSubview:textView1];
    //
    //    placeholder=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH-40, 30)];
    //    placeholder.text=@"请输入跟进内容";
    //    placeholder.textColor=[UIColor grayColor];
    //    placeholder.font=[UIFont systemFontOfSize:13];
    //    [textView1 addSubview:placeholder];
    //
    //    //统计
    //    count=[[UILabel alloc]initWithFrame:CGRectMake(25, 157+30, 100, 20)];
    //    count.text=[NSString stringWithFormat:@"0/100"];
    //    [genjinView addSubview:count];
    //    //确认按钮
    //    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH-135, 150+40, 77, 30)];
    //    [button setImage:[UIImage imageNamed:@"提交按钮.png"] forState:UIControlStateNormal];
    //    [button addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    //    [genjinView addSubview:button];
    //    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapbgView)];
    //    gesture.delegate = self;
    //    gesture.numberOfTapsRequired = 1;
    //    gesture.numberOfTouchesRequired = 1;
    //    [bgView addGestureRecognizer:gesture];
    
}
#pragma mark cell的代理方法
-(void)editPhoneNumber:(CGPoint)point
{
    NSLog(@"%@",_phoneNumCell.phoneNumTextfield.text);
    if ([_phoneNumCell.phoneNumTextfield.text isEqualToString:@""]) {
        PL_ALERT_SHOW(@"请输入电话号码");
        isClick1 = NO;
        _phoneNumCell.phoneNumTextfield.userInteractionEnabled =YES;
    }
    else
    {
        NSIndexPath *indexPath = [_telTableView indexPathForRowAtPoint:point];
        _phoneNumCell = (PhoneNumberTableViewCell *)[_telTableView cellForRowAtIndexPath:indexPath];
        oldPhoneNumString =  [self.acceptArray[indexPath.row]stringByReplacingOccurrencesOfString:@"}]" withString:@""];
        _phoneNumCell.phoneNumTextfield.borderStyle            = UITextBorderStyleNone;
        _phoneNumCell.phoneNumTextfield.userInteractionEnabled = NO;
        newPhoneNumString = _phoneNumCell.phoneNumTextfield.text;
        _phoneNumCell.phoneNumTextfield.text = newPhoneNumString;
        NSLog(@"%@,%@",oldPhoneNumString,newPhoneNumString);
        _phoneNumCell.editButton.hidden = YES;
        [_telTableView reloadData];
        //    if ( ![Utility isMobileNumber:newPhoneNumString]) {
        //        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"手机号座机号无效" message:@"请输入正确的电话号码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        //        alert.tag = 1003;
        //        [alert show];
        //        [self.acceptArray removeObjectAtIndex:indexPath.row];
        //        [_telTableView reloadData];
        //        _phoneNumCell.phoneNumTextfield.text = strNum;
        //        return;
        //    }
        [self freshPhoneNumberWithcompleteBack:^(NSMutableString *resultStr) {
            if ([resultStr isEqualToString:@"1"]) {
                PL_ALERT_SHOW(@"该号码已存在,请勿重复添加");
                //                [self.acceptArray removeObjectAtIndex:self.acceptArray.count-1];
                _phoneNumCell.phoneNumTextfield.borderStyle = UITextBorderStyleRoundedRect;
                _phoneNumCell.phoneNumTextfield.userInteractionEnabled = YES;
                isClick1 = NO;
                _phoneNumCell.editButton.hidden = NO;
                
                //                [_telTableView reloadData];
            }
            else if ([resultStr isEqualToString:@"OK"]) {
                PL_ALERT_SHOW(@"添加成功");
                isClick1 = YES;
                [self.acceptArray removeAllObjects];
                [[MyRequest defaultsRequest]afGetPhoneID:custID type:callTypeString completeBack:^(NSMutableString *str) {
                    NSLog(@"%@",str);
                    NSArray *array = [str componentsSeparatedByString:@":"];
                    
                    self.acceptArray =[NSMutableArray arrayWithArray:[[array.lastObject stringByReplacingOccurrencesOfString:@"\"" withString:@""] componentsSeparatedByString:@","]] ;
                    [_telTableView reloadData];
                    
                }];
            }
            else if([resultStr isEqualToString:@"2"])
            {
                isClick1 = NO;
                PL_ALERT_SHOW(@"电话号码不正确");
                _phoneNumCell.phoneNumTextfield.borderStyle = UITextBorderStyleRoundedRect;
                _phoneNumCell.editButton.hidden = NO;
                _phoneNumCell.phoneNumTextfield.userInteractionEnabled = YES;
                
            }
            else if ([resultStr isEqualToString:@"EER"]) {
                isClick1 = NO;
                PL_ALERT_SHOW(@"添加失败");
                _phoneNumCell.phoneNumTextfield.borderStyle = UITextBorderStyleRoundedRect;
                _phoneNumCell.editButton.hidden = NO;
                _phoneNumCell.phoneNumTextfield.userInteractionEnabled = YES;
                
            }
            NSLog(@"%@",resultStr);
        }];
        //    if ([[self freshPhoneNumber] isEqual:@"1"])
        //    {
        //        NSLog(@"REPEAT");
        //           }
        //    if ([[self freshPhoneNumber] isEqual:@"OK"]) {
        //        NSLog(@"SUCCESS");
        //    }
        //    if ([[self freshPhoneNumber] isEqual:@"ERR"]) {
        //        NSLog(@"ERR");
        //    }
        
        
    }
    
}
-(void)deletePhoneNumber:(CGPoint)point
{
    NSIndexPath *indexPath = [_telTableView indexPathForRowAtPoint:point];
    NSLog(@"++++++%lu",(unsigned long)self.acceptArray.count);
    oldPhoneNumString  = [self.acceptArray[indexPath.row]stringByReplacingOccurrencesOfString:@"}]" withString:@""];
    newPhoneNumString  = @"";
    [self freshPhoneNumberWithcompleteBack:^(NSMutableString *resultStr) {
        
        if ([resultStr isEqualToString:@"OK"]) {
            [self.acceptArray removeObjectAtIndex:indexPath.row];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_telTableView beginUpdates];
                NSArray *deleteRowsArray = [NSArray arrayWithObject:indexPath];
                [_telTableView deleteRowsAtIndexPaths:deleteRowsArray withRowAnimation:UITableViewRowAnimationRight];
                [_telTableView endUpdates];
                
            });
            [self.acceptArray removeAllObjects];
            [[MyRequest defaultsRequest]afGetPhoneID:custID type:callTypeString completeBack:^(NSMutableString *str) {
                NSLog(@"%@",str);
                NSArray *array = [str componentsSeparatedByString:@":"];
                
                self.acceptArray =[NSMutableArray arrayWithArray:[[array.lastObject stringByReplacingOccurrencesOfString:@"\"" withString:@""] componentsSeparatedByString:@","]] ;
                [_telTableView reloadData];
                
            }];
        }
        else
        {
            PL_ALERT_SHOW(@"删除失败");
        }
        
        NSLog(@"+++++++++%@",resultStr);
    }];
    
    
}
-(void)clickAddButton:(UIButton *)sender
{
    if(isloadOver == NO)
    {
        NSLog(@"数据没加载完");
    }
    else if(isClick1 == NO)
    {
        
    }
    else
    {
        
        [_telTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:self.acceptArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        [self.acceptArray addObject:@""];
        NSArray *addRowsArray = [NSArray arrayWithObject:[NSIndexPath indexPathForItem:self.acceptArray.count - 1 inSection:0]];
        [_telTableView beginUpdates];
        [_telTableView insertRowsAtIndexPaths:addRowsArray withRowAnimation:UITableViewRowAnimationBottom];
        [_telTableView endUpdates];
        _phoneNumCell = (PhoneNumberTableViewCell *)[_telTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:self.acceptArray.count - 1 inSection:0]];
        _phoneNumCell.phoneNumTextfield.userInteractionEnabled = YES;
        _phoneNumCell.phoneNumTextfield.borderStyle = UITextBorderStyleRoundedRect;
        _phoneNumCell.phoneNumTextfield.placeholder = @"请输入电话号码";
        [_phoneNumCell.phoneNumTextfield becomeFirstResponder];
        [_phoneNumCell.editButton setImage:[UIImage imageNamed:@"tijiao"] forState:UIControlStateNormal];
        [_telTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:self.acceptArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
    }
}
#pragma mark --更新电话号码
-(void)freshPhoneNumberWithcompleteBack:(void (^)(NSMutableString *resultStr))backblock
{
    self.backBlock = backblock;
    __block  NSMutableString *resultString;
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]afSetPhoneUpdOrInsID:custID OldPhone:[oldPhoneNumString componentsSeparatedByString:@"|"].lastObject NewPhone:newPhoneNumString Mode:callTypeString completeBack:^(NSMutableString *str)
     {
         self.backBlock(str);
         NSLog(@">>>>>>>>%@",str);
         resultString = str;
         PL_PROGRESS_DISMISS;
     }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self clearTel:nil];
}
- (void)clearTel:(UIGestureRecognizer *)tap
{
    [self fadeOut];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
