//
//  ReviseFYViewController.m
//  BYFCApp
//
//  Created by PengLee on 15/5/18.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "ReviseFYViewController.h"
#import "PL_Header.h"

@interface ReviseFYViewController ()<ReviseFYViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet ReviseFYView *sourcesView;
@property(strong,nonatomic) RoomRevisInfo *roomRevisInfo;
//@property (nonatomic,strong) NSString *strIDCode;


@property (nonatomic,strong) NSString *strData;

@end

@implementation ReviseFYViewController

-(RoomRevisInfo *)roomRevisInfo
{
    if (_roomRevisInfo == nil) {
        _roomRevisInfo = [[RoomRevisInfo alloc]init];
    }
    return _roomRevisInfo;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"%s",__FUNCTION__);
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults] setObject:self.reviseRoomData.roomPropertyId forKey:@"SHC"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.title = @"销售管理";
    self.sourcesView = [[NSBundle mainBundle]loadNibNamed:@"ReviseFYView" owner:self options:nil].lastObject;
//    _strIDCode = [[NSUserDefaults standardUserDefaults] objectForKey:PL_USER_DutyCodeIsE];
//    if ([_strIDCode isEqualToString:@"1"]) {
////        [self.sourcesView.topSetButton setHidden:YES];
////        [self.sourcesView.topImage setHidden:YES];
//        self.sourcesView.isEq = YES;
//    }
    self.sourcesView.propertyIDString = self.reviseRoomData.roomPropertyId;
    self.sourcesView.ViewDelegate = self;
    NSLog(@">>>>>>>>%@",self.reviseRoomData.roomPropertyId);
    self.view = self.sourcesView;
    [self getHouseMarks];
    [self getHouseValue];
    [self getHouseValueUpd];
    
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 12, 18);
    
    [backBtn setImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(callBackDetail) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = left;
    
    // Do any additional setup after loading the view from its nib.
}
#pragma mark -- GetHouseValueUpd
-(void)getHouseValueUpd
{
    [[MyRequest defaultsRequest]afGetHouseValueUpdWithPropertyID:self.reviseRoomData.roomPropertyId completeBack:^(NSString *str) {
        if ([str isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        else if ([str isEqualToString:@"[]"] ) {
            PL_ALERT_SHOW(@"暂无价格");
            
        }
        
        else  if ([str isEqualToString:@"exception"])
        {
            PL_ALERT_SHOW(@"服务器异常");
            
        }
        else
        {
            SBJSON *json=[[SBJSON alloc]init];
            NSArray *resultArray = [json objectWithString:str error:nil];
            [self refreshPice:resultArray.firstObject];
            self.sourcesView.arrayData = resultArray.firstObject;
        }
    }];
}




#pragma mark -- 刷新页面
-(void)refreshPice:(NSDictionary *)dic
{
    if (!([dic[@"RentPriceNew"] isKindOfClass:[NSNull class]] ||[dic[@"RentPriceNew"] isEqual:nil])) {
        self.sourcesView.salePriceTextField.text = [NSString stringWithFormat:@"%@",dic[@"RentPriceNew"]];
    }
    if (!([dic[@"PriceNew"] isKindOfClass:[NSNull class]] ||[dic[@"PriceNew"] isEqual:nil])) {
        self.sourcesView.rentPriceTextField.text = [NSString stringWithFormat:@"%@",dic[@"PriceNew"]];
    }
}
#pragma mark -- 获取房源指定数据
-(void)getHouseValue
{
    NSLog(@"%@",self.reviseRoomData.roomPropertyId);
    [[MyRequest defaultsRequest]afGetHouseValueWithPropertyID:self.reviseRoomData.roomPropertyId Name:@"Status" call:^(NSMutableString *str) {
        NSLog(@">>>>>>>>>>>+++++%@",[str componentsSeparatedByString:@":"].lastObject);
        self.roomRevisInfo.statusString = [[str componentsSeparatedByString:@":"].lastObject stringByReplacingOccurrencesOfString:@"}]" withString:@""];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self refreshValidButton:self.roomRevisInfo.statusString];
        });
       
//        [self.sourcesView refreshUI:self.reviseRoomData];

    }];
}
-(void)refreshValidButton:(NSString *)str
{
    if ([str isEqualToString:@"\"有效\""])
    {
//        [self.sourcesView.validButton setImage:[UIImage imageNamed:@"有"] forState:UIControlStateNormal];
        self.sourcesView.statusString = @"有效";
    }
    else if ([str isEqualToString:@"\"无效\""])
    {
        self.sourcesView.statusString = @"无效";
    }
    else if ([str isEqualToString:@"\"已租\""])
    {
        self.sourcesView.statusString = @"已租";
    }
    else if ([str isEqualToString:@"\"已售\""])
    {
        self.sourcesView.statusString = @"已售";
    }
    
}
-(void)getHouseMarks
{
    [[MyRequest defaultsRequest]afGetHouseMarksWithPropertyID:self.reviseRoomData.roomPropertyId call:^(NSArray *array) {
        for (NSDictionary *dic in array) {
            NSLog(@"+++%@",dic);
            self.roomRevisInfo.fastSellString   = dic[@"FastSell"];
            _strData = dic[@"FastSell"];
            self.roomRevisInfo.recommendString  = dic[@"Recommend"];
            self.roomRevisInfo.schoolString     = dic[@"School"];
            self.roomRevisInfo.houseMarksString = dic[@"HouseMarks"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self refreshMarksButton:self.roomRevisInfo];

        });
        [self refreshMarksButton:self.roomRevisInfo];
    }];
}


-(void)refreshMarksButton:(RoomRevisInfo *)info
{
    self.sourcesView.jiShouString = _strData;
    NSLog(@">>>>>>>>%@",info.fastSellString);
    if ([info.fastSellString isEqualToString:@"0"]) {
        self.sourcesView.jiShouString = @"否";
    }
    else
    {

        self.sourcesView.jiShouString = @"是";

    }
    NSLog(@"%@",info.recommendString);
    if ([info.recommendString isEqualToString:@"0"]) {
        self.sourcesView.jingLiTuiJianString = @"否";
    }
    else
    {
         self.sourcesView.jingLiTuiJianString = @"是";
    }
}
-(void)clickClearButton
{
    [self refreshMarksButton:self.roomRevisInfo];
    [self refreshValidButton:self.roomRevisInfo.statusString];
    self.sourcesView.rentPriceTextField.text = nil;
    self.sourcesView.rentPriceTextField.placeholder = @"请输入租价";
    self.sourcesView.salePriceTextField.text = nil;
    self.sourcesView.salePriceTextField.placeholder = @"请输入售价";
    
    
}
//-(void)transFormSetHouseMarks:(RoomRevisInfo *)info
//{
//    PL_PROGRESS_SHOW;
//        info.properIDString   = self.reviseRoomData.roomPropertyId;
//        info.houseMarksString = self.roomRevisInfo.houseMarksString;
//        [self SetHouseMarks:info];
//
//}

//#pragma mark --houseMark
//-(void)SetHouseMarks:(RoomRevisInfo *)info
//{
//    NSLog(@"%@,%@,%@,%@,%@",info.properIDString,info.recommendString,info.fastSellString,info.schoolString,info.houseMarksString);
//    [[MyRequest defaultsRequest]afSetHousMarks:info call:^(NSMutableString *str) {
//        PL_PROGRESS_DISMISS;
//        NSLog(@"housMark %@",str);
//        if ([str isEqualToString:@"OK"]) {
//            [self getHouseMarks];
//            PL_ALERT_SHOW(@"修改成功");
//        }
//        if ([str isEqualToString:@"ERR"]) {
//            PL_ALERT_SHOW(@"修改失败");
//        }
//        if ([str isEqualToString:@"1"]) {
//            PL_ALERT_SHOW(@"您无权修改");
//        }
//        
//    }];
//}
#pragma mark 提交
-(void)clickViewSender:(RoomRevisInfo *)roomInfo
{
       PL_PROGRESS_SHOW;
    roomInfo.properIDString = self.reviseRoomData.roomPropertyId;
  
    NSLog(@">>>>>>>>>>>>>> %@,%@,%@,%@,%@,%@",roomInfo.properIDString,roomInfo.priceString,roomInfo.rentpriceString,roomInfo.daysString,roomInfo.decorationString,roomInfo.custom);
    [[MyRequest defaultsRequest]afSetHouseUpdate:roomInfo call:^(NSString *str) {
        
        NSLog(@"nnnnnnnn %@",str);
        
        PL_PROGRESS_DISMISS;
        NSLog(@"houseUpDATE %@",str);
        if ([str isEqualToString:@"OK"]) {
            PL_ALERT_SHOW(@"修改成功");
            [self getHouseValueUpd];
            [self callBackDetail];
        }
        if ([str isEqualToString:@"ERR"]) {
             PL_ALERT_SHOW(@"修改失败");
        }
        if ([str isEqualToString:@"1"]) {
            PL_ALERT_SHOW(@"修改价格超过限制");
        }
        if ([str isEqualToString:@"9"]) {
            PL_ALERT_SHOW(@"什么也没改");
        }
        if ([str isEqualToString:@"2"]) {
            PL_ALERT_SHOW(@"您无权修改置顶设置");
            [self callBackDetail];
        }
        
    }];
    
}
-(void)callBackDetail
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
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
