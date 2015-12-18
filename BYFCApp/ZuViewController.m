//
//  ZuViewController.m
//  BYFCApp
//
//  Created by zzs on 14/12/18.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import "ZuViewController.h"
#import "PL_Header.h"

@interface ZuViewController ()<CustomDelegate>

@end

@implementation ZuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ksyWillAnimation:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self initView];
}
- (void)ksyWillAnimation:(NSNotification *)note
{
    UIView * fview = [self.view firstResponder];
    NSLog(@"%@",note);
    
    CGFloat fy = CGRectGetMaxY(fview.frame);
    NSDictionary * dict = note.userInfo;
    CGRect endFrame = [[dict objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat delta = endFrame.origin.y - fy-40;
    if (delta <0)
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.center = CGPointMake(self.view.center.x, self.view.center.y+delta);
        }];
        
        
        
    }
    else
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.center = CGPointMake(self.view.center.x, self.view.bounds.size.height/2);
            
        }];
        
        
    }

}
-(void)initView
{
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(28, 20, 100, 40)];
   // title.backgroundColor=[UIColor blueColor];
    title.font=[UIFont systemFontOfSize:20];
    title.text=@"增加客源";
    [self.view addSubview:title];
    UIButton *delete=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH-40, 30, 25, 25)];
    [delete setImage:[UIImage imageNamed:@"close_call_phone_activity.png.png"] forState:UIControlStateNormal];
    [delete addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delete];
    
    UILabel  *line=[[UILabel alloc]initWithFrame:CGRectMake(0, 60, PL_WIDTH, 1)];
    line.backgroundColor=[UIColor redColor];
    [self.view addSubview:line];
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(PL_WIDTH/16, CGRectGetMaxY(line.frame)+10, 80, 30)];
    name.text=@"客  户  名:";
    //name.backgroundColor=[UIColor redColor];
    [self.view addSubview:name];
    nameTF=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(name.frame), CGRectGetMaxY(line.frame)+12, PL_WIDTH-200, 20)];
    nameTF.textAlignment=NSTextAlignmentCenter;
    nameTF.background=[UIImage imageNamed:@"red_edittext_bg.png"];
    nameTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    [self.view addSubview:nameTF];
    
    sex=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameTF.frame)+15, CGRectGetMaxY(line.frame)+3, 60, 40)];
    [sex setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [sex setTitle:@"先生" forState:UIControlStateNormal];
//    [sex setTitle:@"女士" forState:UIControlStateSelected];
    [sex setImage:[UIImage imageNamed:@"nanshi.png"] forState:UIControlStateNormal];
    [sex setImage:[UIImage imageNamed:@"nvshi"] forState:UIControlStateSelected];
    [sex addTarget:self action:@selector(sexClick:) forControlEvents:UIControlEventTouchUpInside];
    sexStr=@"先生";
    [self.view addSubview:sex];
    
    UILabel *phone=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(name.frame), CGRectGetMaxY(name.frame)+5, 80, 30)];
    phone.text=@"联系电话:";
    //phone.backgroundColor=[UIColor redColor];
    [self.view addSubview:phone];
    phoneTF=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phone.frame), CGRectGetMaxY(name.frame)+7, PL_WIDTH-120, 20)];
    phoneTF.textAlignment=NSTextAlignmentCenter;
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    phoneTF.background=[UIImage imageNamed:@"red_edittext_bg.png"];
    [self.view addSubview:phoneTF];
    
    UILabel *area=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(phone.frame), CGRectGetMaxY(phone.frame)+5, 80, 30)];
    area.text=@"意向城区:";
    //area.backgroundColor=[UIColor redColor];
    [self.view addSubview:area];
    areaTF=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(area.frame), CGRectGetMaxY(phone.frame)+7, PL_WIDTH-120, 20)];
    areaTF.textAlignment=NSTextAlignmentCenter;
    areaTF.enabled=NO;
    areaTF.background=[UIImage imageNamed:@"red_edittext_bg.png"];
    [self.view addSubview:areaTF];
    areaBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    areaBtn.frame = CGRectMake(CGRectGetMaxX(area.frame), CGRectGetMaxY(phone.frame)+7, PL_WIDTH-120, 20);
    
    areaBtn.contentMode = UIViewContentModeScaleAspectFit|UIViewContentModeLeft;
    [areaBtn addTarget:self action:@selector(areaClick) forControlEvents:UIControlEventTouchUpInside];
    areaBtn.backgroundColor = [UIColor clearColor];
    [areaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:areaBtn];
    
    
    UILabel *yixiangdu=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(area.frame), CGRectGetMaxY(area.frame)+5, 60, 30)];
    yixiangdu.text=@"意向度:";
    //yixiangdu.backgroundColor=[UIColor redColor];
    [self.view addSubview:yixiangdu];
    
    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(yixiangdu.frame), CGRectGetMaxY(area.frame)+3, 100, 30) numberOfStars:5];
    self.starRateView.scorePercent = 0;
    self.starRateView.allowIncompleteStar = NO;
    self.starRateView.hasAnimation = YES;
    self.starRateView.delegate=self;
    [self.view addSubview:self.starRateView];
    /*
    UITextField *yixiangduTF=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(yixiangdu.frame), CGRectGetMaxY(area.frame)+5, 150, 25)];
    yixiangduTF.textAlignment=NSTextAlignmentCenter;
    yixiangduTF.background=[UIImage imageNamed:@"blue_edittext_bg(1).png"];
    [self.view addSubview:yixiangduTF];
    */
    //最大面积
    UILabel *squareMax=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(yixiangdu.frame), CGRectGetMaxY(yixiangdu.frame)+10, 70, 20)];
    squareMax.text=@"最大面积:";
    squareMax.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:squareMax];
    SMF=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(squareMax.frame)-6, CGRectGetMaxY(yixiangdu.frame)+8, 40, 20)];
    SMF.font=[UIFont systemFontOfSize:15];
    SMF.textAlignment=NSTextAlignmentCenter;
    SMF.keyboardType = UIKeyboardTypeNumberPad;
    SMF.background=[UIImage imageNamed:@"red_edittext_bg.png"];
    [self.view addSubview:SMF];
    UILabel *m2=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(SMF.frame)+2, CGRectGetMaxY(yixiangdu.frame)+10, 20, 20)];
    m2.text=@"m²";
    m2.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:m2];
    //最小面积
    UILabel *squareMin=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(m2.frame)+50, CGRectGetMaxY(yixiangdu.frame)+10, 70, 20)];
    squareMin.text=@"最小面积:";
    squareMin.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:squareMin];
    SMF2=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(squareMin.frame)-6, CGRectGetMaxY(yixiangdu.frame)+8, 40, 20)];
    SMF2.font=[UIFont systemFontOfSize:15];
    SMF2.textAlignment=NSTextAlignmentCenter;
    SMF2.keyboardType = UIKeyboardTypeNumberPad;
    SMF2.background=[UIImage imageNamed:@"red_edittext_bg.png"];
    [self.view addSubview:SMF2];
    UILabel *m22=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(SMF2.frame)+2, CGRectGetMaxY(yixiangdu.frame)+10, 20, 20)];
    m22.text=@"m²";
    m22.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:m22];
    //*************
    UILabel *priceMax=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(yixiangdu.frame), CGRectGetMaxY(squareMax.frame)+10, 70, 20)];
    priceMax.text=@"最大购价:";
    priceMax.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:priceMax];
    priceMaxTF=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(squareMax.frame)-6, CGRectGetMaxY(squareMax.frame)+8, 40, 20)];
    priceMaxTF.font=[UIFont systemFontOfSize:15];
    priceMaxTF.keyboardType = UIKeyboardTypeNumberPad;
    priceMaxTF.textAlignment=NSTextAlignmentCenter;
    priceMaxTF.background=[UIImage imageNamed:@"red_edittext_bg.png"];
    [self.view addSubview:priceMaxTF];
    UILabel *wan=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceMaxTF.frame)+2, CGRectGetMaxY(squareMax.frame)+10, 20, 20)];
    wan.text=@"万";
    wan.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:wan];
    
    //**************
    UILabel *priceMin=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(wan.frame)+50, CGRectGetMaxY(squareMin.frame)+10, 70, 20)];
    priceMin.text=@"最小购价:";
    priceMin.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:priceMin];
    priceMinTF=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceMin.frame)-6, CGRectGetMaxY(squareMin.frame)+8, 40, 20)];
    priceMinTF.textAlignment=NSTextAlignmentCenter;
    priceMinTF.background=[UIImage imageNamed:@"red_edittext_bg.png"];
    [self.view addSubview:priceMinTF];
    priceMinTF.keyboardType = UIKeyboardTypeNumberPad;
    UILabel *wan2=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceMinTF.frame)+2, CGRectGetMaxY(squareMin.frame)+10, 20, 20)];
    wan2.text=@"万";
    wan2.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:wan2];
    //****************
    UILabel *zupriceMax=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(yixiangdu.frame), CGRectGetMaxY(priceMax.frame)+10, 70, 20)];
    zupriceMax.text=@"最大租价:";
    zupriceMax.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:zupriceMax];
    zupriceMaxTF=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(squareMax.frame)-6, CGRectGetMaxY(priceMax.frame)+8, 40, 20)];
    zupriceMaxTF.textAlignment=NSTextAlignmentCenter;
    zupriceMaxTF.keyboardType = UIKeyboardTypeNumberPad;
    zupriceMaxTF.background=[UIImage imageNamed:@"red_edittext_bg.png"];
    [self.view addSubview:zupriceMaxTF];
    UILabel *danwei=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(zupriceMaxTF.frame)+2, CGRectGetMaxY(priceMax.frame)+10, 30, 20)];
    danwei.text=@"元/月";
    danwei.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:danwei];
    //**********
    //**************
    UILabel *zupriceMin=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(wan.frame)+50, CGRectGetMaxY(priceMin.frame)+10, 70, 20)];
    zupriceMin.text=@"最小租价:";
    zupriceMin.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:zupriceMin];
    zupriceMinTF=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(zupriceMin.frame)-6, CGRectGetMaxY(priceMin.frame)+8, 40, 20)];
    zupriceMinTF.textAlignment=NSTextAlignmentCenter;
    zupriceMinTF.background=[UIImage imageNamed:@"red_edittext_bg.png"];
    [self.view addSubview:zupriceMinTF];
    
    zupriceMinTF.keyboardType = UIKeyboardTypeNumberPad;
    UILabel *danwei2=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(zupriceMinTF.frame)+2, CGRectGetMaxY(priceMin.frame)+10, 30, 20)];
    danwei2.text=@"元/月";
    danwei2.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:danwei2];
    
    UIButton *add=[[UIButton alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(zupriceMax.frame)+30, PL_WIDTH*2/3-5, 40)];
    add.backgroundColor=[UIColor redColor];
    [add setTitle:@"添加客源信息" forState:UIControlStateNormal];
    [add setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [add addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:add];
    
    UIButton *reset=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(add.frame)+10, CGRectGetMaxY(zupriceMax.frame)+30, PL_WIDTH/3-15, 40)];
    reset.backgroundColor=[UIColor redColor];
    reset.alpha=0.5;
    [reset setTitle:@"清空" forState:UIControlStateNormal];
    [reset setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reset addTarget:self action:@selector(resetClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reset];
    _string2 = @"";
    _string1 = @"";
    if ([_tradeStr isEqualToString:@"求购"]) {
        zupriceMaxTF.text=@"--";
        zupriceMinTF.text=@"--";
        zupriceMaxTF.enabled=NO;
         zupriceMinTF.enabled=NO;
    }
    else
    {
        priceMaxTF.text=@"--";
        priceMinTF.text=@"--";
        priceMaxTF.enabled=NO;
        priceMinTF.enabled=NO;
    }
}
-(void)resetClick
{
    nameTF.text=@"";
    phoneTF.text=@"";
    areaTF.text=@"";
    SMF.text=@"";
    SMF2.text=@"";
    areaBtn.titleLabel.text = @"";
    if ([_tradeStr isEqualToString:@"求购"]) {
        zupriceMaxTF.text=@"--";
        zupriceMinTF.text=@"--";
        priceMaxTF.text=@"";
        priceMinTF.text=@"";
    }
    else
    {
        priceMaxTF.text=@"--";
        priceMinTF.text=@"--";
        zupriceMaxTF.text=@"";
        zupriceMinTF.text=@"";
        
    }
    
    _string1 = @"";
    _string2 = @"";
    self.starRateView.scorePercent = 0;
}
- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent
{
     score=newScorePercent*5;
    NSLog(@"%ld",(long)score);
}

-(void)sexClick:(UIButton *)sender
{
    sender.selected=!sender.selected;
    if (sender.selected) {
        sexStr=@"女士";
    }
    else
    {
        sexStr=@"先生";
    }
}

-(void)addClick
{
    if (!phoneTF.text.length) {
        PL_ALERT_SHOW(@"请输入电话号码");
       
    }
    else
    {
        if ([phoneTF.text checkPhoneNumberInPut])
        {
        
        }
        else
        {
            PL_ALERT_SHOW(@"请输入正确的手机号码或者固话");
            return;
        }
    }
     if (!nameTF.text.length)
     {
         PL_ALERT_SHOW(@"请输入客户名");
         return;
     }
    
    
    if (nameTF.text.length&&phoneTF.text.length) {
            _signArray = [NSMutableArray array];
            AddData *add=[[AddData alloc]init];
            add.userid=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
            add.CustName=nameTF.text;
            add.CustLevel=[NSString stringWithFormat:@"%ld",(long)score];
        if ([sexStr isEqualToString:@"先生"]) {
            add.Sex=@"男";
        }
        else
        {
            add.Sex=@"女";
        }
            //add.Sex=sex.titleLabel.text;
            //add.Sex=@"";
            add.BirthYear=@"";
            add.CustTel=phoneTF.text;
            add.Remark=@"";
            add.Trade=_tradeStr;
            NSLog(@"+++++----+++++%@",add.Trade);
            add.DistrictName=_string1;
            add.AreaID=areaId;
            add.CountF=@"";
            add.CountT=@"";
            add.CountW=@"";
            add.SquareMin=SMF2.text;
            add.SquareMax=SMF.text;
            if ([priceMinTF.text isEqualToString:@"--"]) {
                add.PriceMin=@"";
            }
            else
            {
                add.PriceMin=priceMinTF.text;
            }
            if ([priceMaxTF.text isEqualToString:@"--"]) {
                add.PriceMax=@"";
            }
            else
            {
                add.PriceMax=priceMaxTF.text;
            }
        
            if ([zupriceMaxTF.text isEqualToString:@"--"]) {
                add.RentalMax=@"";
            }
            else
            {
                add.RentalMax=zupriceMinTF.text;
            }
            if ([zupriceMinTF.text isEqualToString:@"--"]) {
                add.RentalMin=@"";
            }
            else
            {
                add.RentalMin=zupriceMinTF.text;
            }
        
        if(SMF.text.intValue < SMF2.text.intValue){
            PL_ALERT_SHOW(@"最大意向面积必须大于最小意向面积");
        }else if(priceMaxTF.text.intValue < priceMinTF.text.intValue){
            PL_ALERT_SHOW(@"最大意向购价必须大于最小意向购价");
        }else if(zupriceMaxTF.text.intValue < zupriceMinTF.text.intValue){
            PL_ALERT_SHOW(@"最大意向租价必须大于最小意向租价");
        }else{
        
            add.Floor=@"";
            add.PropertyDirection=@"";
            add.token=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN];
        PL_PROGRESS_SHOW;
            [[MyRequest defaultsRequest]afCustomCreate:add callBack:^(NSMutableString *string) {
                 PL_PROGRESS_DISMISS;
                if ([string isEqualToString:@"OK"]){
                    PL_ALERT_SHOW(@"添加成功");
                
//                    [UIAlertView showAlertViewWithMessage:@"添加成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else if ([string isEqualToString:@"3"])
                {
                    PL_ALERT_SHOW(@"该客源已存在");
                }
                else if([string isEqualToString:@"2"])
                {
                    PL_ALERT_SHOW(@"请输入正确的客户电话");
                }
                else
                {
                    PL_ALERT_SHOW(@"添加失败");
                }
           
            }];
        }

    }
    else
    {
        
    }
}

-(void)areaClick
{
    [self.view endEditing:YES];
     [[VisitersRequest defaultsRequest] requestAreaInfoMessage:@"2" roomDistrictId:@"" roomDisName:@"" userName:[PL_USER_STORAGE objectForKey:PL_USER_NAME] userTokne:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] backInfoMessage:^(NSMutableArray *array) {
        
         NSLog(@"array---%@",array);
        if (array.count>0)
        {
//            NSLog(@"=========%s",__FUNCTION__);
            NSMutableArray * tempArray = [NSMutableArray array];
            
            for (NSDictionary * dict in array)
            {
                roomAreaPlace * room = [[roomAreaPlace alloc]init];
                
                room.areaDistrictId = dict[@"DistrictId"];
                room.areaDistrictName =dict[@"DistrictName"];
                NSLog(@"++++++%@,%@",room.areaDistrictId,room.areaDistrictName);
                [tempArray addObject:room];
                
                
            }
            roomAreaPlace * virtuRoom = [[roomAreaPlace alloc]init];
            virtuRoom.areaDistrictName = @"不限";
            virtuRoom.areaDistrictId   = @"";
            [tempArray insertObject:virtuRoom atIndex:0];
            CustomAddView * addView = [[CustomAddView alloc]initWithArray:tempArray];
            addView.delegate = nil;
            addView.delegate = self;
            
            NSLog(@"temparray----%@",tempArray);
            
            [addView showInView:self.view animation:YES];
        }
        else
        {
            PL_ALERT_SHOWNOT_OKAND_YES(@"暂无区域数据");
            
        }

    } string:^(NSString *string) {
        
    }];
    

   
    
}

//宝山区
-(void)didSelectRowIndexPath:(NSIndexPath *)indexPath administrativeArea:(NSString *)adminnistat
{
    [areaBtn setTitle:adminnistat forState:UIControlStateNormal];
    if ([adminnistat isEqualToString:@"不限"]) {
        _string1 = @"";
        _string2 = @"";
    }
    else
    {
    _string1 = adminnistat;
    _string2 = @"";
    }
}
//
-(void)didSelectRowIndexPath:(NSIndexPath *)indexPath sadministativeArea:(NSString *)adminnistat
{
    
    if ([adminnistat isEqualToString:@"全部片区"])
    {
        _string2 = @"";
    }
    else
    {
    [areaBtn setTitle:[areaBtn.titleLabel.text stringByAppendingFormat:@" %@",adminnistat] forState:UIControlStateNormal];
        _string2 = adminnistat;
    }
}
-(void)didSelectRowIndexPath:(NSIndexPath *)indexPath AreaID:(NSString *)areaID{
    
    if ([areaId isEqualToString:@"全部片区"])
    {
        areaId = @"";
    }
    else
    {
        areaId = areaID;
    }
    
    
}
//- (void)didSelRowIndexPath:(NSIndexPath *)indexPath titleName:(NSString *)string xingzhengqu:(NSString *)string1
//{
//    NSLog(@"%@  -%ld++ %@",string,(long)indexPath.row,string1);
//    NSLog(@">>>>>>%@",areaBtn.titleLabel.text);
//    self.titleArea = [NSString stringWithFormat:@"%@ %@",string1,string];
//    [areaBtn setTitle:_titleArea forState:UIControlStateNormal];
//    
//    _string1 = string1;
//    _string2 = string;
//     NSLog(@"<<<<<<<<<<%@",areaBtn.titleLabel.text);
//    
//    
//    
//}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
