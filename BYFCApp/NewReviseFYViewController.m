 //
//  NewReviseFYViewController.m
//  BYFCApp
//
//  Created by PengLee on 15/8/20.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "NewReviseFYViewController.h"

@interface NewReviseFYViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *_topSetTableView;
    UITableView *_topSetTableView1;
    UITableView *_topSetTableView2;
    UITableView *_topSetTableView3;
    NSString    * _statusString;
    NSString    * _decorationString;
    //置顶
    NSString    * _topSetString;
    //交易类型
    NSString    * _topSetSenderString;
    NSString *lastRentDateString;
    UILabel *label1;
    UILabel *label2;

    UITextField*TextFile;
    UIWindow* win;
    UIView*baview;
    UIView*BigBgView;
    UIDatePicker*datepicker;
    NSString *rentStr;
    NSString *saleStr;


}
@property(strong,nonatomic) RoomRevisInfo *roomRevisInfo;
//@property (nonatomic,strong) NSString *strIDCode;
@property (nonatomic, strong) UILabel *lable1;
@property (nonatomic ,strong) NSString *strName;

@end

@implementation NewReviseFYViewController

-(RoomRevisInfo *)roomRevisInfo
{
    if (_roomRevisInfo == nil) {
        _roomRevisInfo = [[RoomRevisInfo alloc]init];
    }
    return _roomRevisInfo;
}
-(RoomRevisInfo *)neRoomRevisInfo
{
    if (!_neRoomRevisInfo ) {
        _neRoomRevisInfo = [[RoomRevisInfo alloc]init];
    }
    return _neRoomRevisInfo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _strName = @"heaven";
    self.title = @"销售管理";
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 12, 18);
    
    [backBtn setImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(callBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = left;
    _titleArray = @[@"售价",@"租价",@"急售",@"装修",@"置顶设置",@"交易类型",@"经理推荐",@"委托状态"];
    _jiaoYiArray = [NSMutableArray array];
    self.propertyIDString = self.reviseRoomData.roomPropertyId;
//    _strIDCode = [[NSUserDefaults standardUserDefaults] objectForKey:PL_USER_DutyCodeIsE];

//    if ([_strIDCode isEqualToString:@"1"]) {
//        //        [self.sourcesView.topSetButton setHidden:YES];
//        //        [self.sourcesView.topImage setHidden:YES];
//        _isEq = YES;
//    }
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.layer.borderWidth = 1;
    _mainTableView.layer.borderColor = PL_CUSTOM_COLOR(223, 223, 225, 1).CGColor;
    _topSetTableView = [[UITableView alloc] init];
    _topSetTableView.frame = CGRectMake(0, PL_HEIGHT, PL_WIDTH, 132);
    _topSetTableView.delegate = self;
    _topSetTableView.dataSource = self;
    _topSetTableView.layer.borderWidth = 1;
    _topSetTableView.layer.borderColor = PL_CUSTOM_COLOR(223, 223, 225, 1).CGColor;
    _topSetTableView.tag = 10011;
    
    _topSetTableView1 = [[UITableView alloc] init];
    _topSetTableView1.frame = CGRectMake(0, PL_HEIGHT, PL_WIDTH, 132);
    _topSetTableView1.delegate = self;
    _topSetTableView1.dataSource = self;
    _topSetTableView1.layer.borderWidth = 1;
    _topSetTableView1.layer.borderColor = PL_CUSTOM_COLOR(223, 223, 225, 1).CGColor;
    _topSetTableView1.tag = 10012;
    
    _topSetTableView2 = [[UITableView alloc] init];
    _topSetTableView2.frame = CGRectMake(0, PL_HEIGHT, PL_WIDTH, 132);
    _topSetTableView2.delegate = self;
    _topSetTableView2.dataSource = self;
    _topSetTableView2.layer.borderWidth = 1;
    _topSetTableView2.layer.borderColor = PL_CUSTOM_COLOR(223, 223, 225, 1).CGColor;
    _topSetTableView2.tag = 10013;
    
    _topSetTableView3 = [[UITableView alloc] init];
    _topSetTableView3.frame = CGRectMake(0, PL_HEIGHT, PL_WIDTH, 132);
    _topSetTableView3.delegate = self;
    _topSetTableView3.dataSource = self;
    _topSetTableView3.layer.borderWidth = 1;
    _topSetTableView3.layer.borderColor = PL_CUSTOM_COLOR(223, 223, 225, 1).CGColor;
    _topSetTableView3.tag = 10014;
       _topSetTableView.hidden = YES;
    _topSetTableView1.hidden = YES;
    _topSetTableView2.hidden = YES;
    _topSetTableView3.hidden = YES;
    [self.view addSubview:_topSetTableView];
    [self.view addSubview:_topSetTableView1];
    [self.view addSubview:_topSetTableView2];
    [self.view addSubview:_topSetTableView3];

    [self getHouseMarks];
    [self getHouseValue];
    [self getHouseValueUpd];
}
-(void)getHouseMarks
{
    [[MyRequest defaultsRequest]afGetHouseMarksWithPropertyID:self.reviseRoomData.roomPropertyId call:^(NSArray *array) {
        for (NSDictionary *dic in array) {
            NSLog(@"+++%@",dic);
            self.roomRevisInfo.fastSellString   = dic[@"FastSell"];
            self.roomRevisInfo.recommendString  = dic[@"Recommend"];
            self.roomRevisInfo.schoolString     = dic[@"School"];
            self.roomRevisInfo.houseMarksString = dic[@"HouseMarks"];

        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self refreshMarksButton:self.roomRevisInfo];
            [_mainTableView reloadData];

        });
    }];
}
-(void)getHouseValue
{
    NSLog(@"%@",self.reviseRoomData.roomPropertyId);
    [[MyRequest defaultsRequest]afGetHouseValueWithPropertyID:self.reviseRoomData.roomPropertyId Name:@"Status" call:^(NSMutableString *str) {
        NSLog(@">>>>>>>>>>>+++++%@",[str componentsSeparatedByString:@":"].lastObject);
        self.roomRevisInfo.statusString = [[str componentsSeparatedByString:@":"].lastObject stringByReplacingOccurrencesOfString:@"}]" withString:@""];
//        self.statusString = [[str componentsSeparatedByString:@":"].lastObject stringByReplacingOccurrencesOfString:@"}]" withString:@""];
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
            [self refreshValidButton:self.roomRevisInfo.statusString];
        [_mainTableView reloadData];
//        });
        
        //        [self.sourcesView refreshUI:self.reviseRoomData];
        
    }];
}
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
            self.arrayData = resultArray.firstObject;
        }
    }];
}
#pragma mark -- 刷新页面
-(void)refreshPice:(NSDictionary *)dic
{
    if (!([dic[@"RentPriceNew"] isKindOfClass:[NSNull class]] ||[dic[@"RentPriceNew"] isEqual:nil])) {
       self.salePriceTextField.text = [NSString stringWithFormat:@"%@",dic[@"RentPriceNew"]];
        saleStr=dic[@"RentPriceNew"];
          }
    if (!([dic[@"PriceNew"] isKindOfClass:[NSNull class]] ||[dic[@"PriceNew"] isEqual:nil])) {
        self.rentPriceTextField.text = [NSString stringWithFormat:@"%@",dic[@"PriceNew"]];
        rentStr=dic[@"PriceNew"];
     
    }
}
-(void)refreshValidButton:(NSString *)str
{
    if ([str isEqualToString:@"\"有效\""])
    {
        //        [self.sourcesView.validButton setImage:[UIImage imageNamed:@"有"] forState:UIControlStateNormal];
        self.statusString = @"有效";
    }
    else if ([str isEqualToString:@"\"无效\""])
    {
        self.statusString = @"无效";
    }
    else if ([str isEqualToString:@"\"已租\""])
    {
        self.statusString = @"已租";
    }
    else if ([str isEqualToString:@"\"已售\""])
    {
        _statusString = @"已售";
    }
    
}
-(void)refreshMarksButton:(RoomRevisInfo *)info
{
    NSLog(@">>>>>>>>%@",info.fastSellString);
    if ([info.fastSellString isEqualToString:@"0"]) {
        self.jiShouString = @"否";
    }
    else
    {
        
        self.jiShouString = @"是";
        
    }
    NSLog(@"%@",info.recommendString);
    if ([info.recommendString isEqualToString:@"0"]) {
        self.jingLiTuiJianString = @"否";
    }
    else
    {
        self.jingLiTuiJianString = @"是";
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1108) {
        if (buttonIndex == 0) {
            lastRentDateString = @"";
            [self postSetStatus];
        }else{
            
        }
    }
    if (alertView.tag == 1109) {
        if (buttonIndex == 0) {
            lastRentDateString = @"";
            [self postSetStatus];
        }else{
            
        }
    }
    
    if (alertView.tag == 1110) {
        if (buttonIndex == 0) {
            if ([self respondsToSelector:@selector(clickViewSender:)]) {
                [self.salePriceTextField resignFirstResponder];
                [self.rentPriceTextField resignFirstResponder];
                self.neRoomRevisInfo.priceString = self.salePriceTextField.text.length == 0 ? @"":self.salePriceTextField.text;
                self.neRoomRevisInfo.rentpriceString = self.rentPriceTextField.text.length == 0 ? @"":self.rentPriceTextField.text;
//                self.neRoomRevisInfo.daysString = [NSString stringWithFormat:@"%ld",(long)self.topset] == 0 ? @"":[NSString stringWithFormat:@"%ld",(long)self.topset];
                self.neRoomRevisInfo.decorationString = _decorationString.length == 0 ? @"":_decorationString;
                self.neRoomRevisInfo.daysString = _topSetString.length == 0 ? @"":_topSetString;
                self.neRoomRevisInfo.custom = _topSetSenderString;
                [self clickViewSender:self.neRoomRevisInfo];
            }else{
                
            }
        }
        
    }
    
    
}
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
            [self callBack];
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
            [self callBack];
        }
        
    }];
    
}

-(void)postSetStatus
{
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]SetStatusWithPropertyID:self.propertyIDString Status:_statusString LastRentDate:lastRentDateString call:^(NSString *str) {
        NSLog(@"%@",str);
        PL_PROGRESS_DISMISS;
        if ([str isEqualToString:@"OK"])
        {
            _label = (UILabel *)[self.view viewWithTag:10007];
            _label.text = _statusString;

            [_mainTableView reloadData];
            PL_ALERT_SHOW(@"修改成功,正在审核中");
            //            if ([sender.currentImage isEqual:[UIImage imageNamed:@"有"]]) {
            //                [sender setImage:[UIImage imageNamed:@"租_灰"] forState:UIControlStateNormal];
            //                _statusString = @"无效";
            //            }
            //            else
            //            {
            //                [sender setImage:[UIImage imageNamed:@"有"] forState:UIControlStateNormal];
            //                _statusString = @"有效";
            //
            //            }
            
        }else if ([str isEqualToString:@"exception"])
        {
            PL_ALERT_SHOW(@"对不起，服务器异常，请稍后再试。");
        }else if ([str isEqualToString:@"ERR"])
        {
            PL_ALERT_SHOW(@"修改失败");
        }else if ([str isEqualToString:@"1"]){
            PL_ALERT_SHOW(@"您没有权限修改");
        }else if ([str isEqualToString:@"2"]){
            PL_ALERT_SHOW(@"售价或租价不可为0,请先提交");
        }else if ([str isEqualToString:@"3"])
        {
            PL_ALERT_SHOW(@"正在审核中，不能修改");
        }
    }];
}

-(void)callBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _topSetTableView.hidden = YES;
    _topSetTableView1.hidden = YES;
    _topSetTableView2.hidden = YES;
    _topSetTableView3.hidden = YES;
    [_salePriceTextField resignFirstResponder];
    [_rentPriceTextField resignFirstResponder];
    self.view.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
}


#pragma mark - TableView代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 10008) {
        return self.titleArray.count;
    }else
    {
        return _jiaoYiArray.count;
    }

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView.tag == 10008) {
        static NSString *cellName = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.textLabel.text = self.titleArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.row == 0)
        {
            _rentPriceTextField =[[UITextField alloc] initWithFrame:CGRectMake(PL_WIDTH-130, 10, 80, 20)];
//           _rentPriceTextField.text =rentStr;
            
            _rentPriceTextField.delegate = self;
            _rentPriceTextField.userInteractionEnabled = NO;
            _rentPriceTextField.textAlignment = NSTextAlignmentRight;
            _rentPriceTextField.font = [UIFont systemFontOfSize:14.0f];
            _label = [[UILabel alloc] initWithFrame:CGRectMake(_rentPriceTextField.frame.origin.x+_rentPriceTextField.frame.size.width, 10, 50, 20)];
            _label.font = [UIFont systemFontOfSize:14.0f];
            _label.text = @"万元";
            [cell addSubview:_label];
            [cell addSubview:_rentPriceTextField];
        }
        else if (indexPath.row ==1)
        {
            _salePriceTextField =[[UITextField alloc] initWithFrame:CGRectMake(PL_WIDTH-130, 10, 80, 20)];
//           _salePriceTextField.text =saleStr;
            _salePriceTextField.delegate = self;
            _salePriceTextField.userInteractionEnabled = NO;
            _salePriceTextField.textAlignment = NSTextAlignmentRight;
            _salePriceTextField.font =[UIFont systemFontOfSize:14.0f];
            _label = [[UILabel alloc] initWithFrame:CGRectMake(_salePriceTextField.frame.origin.x+_salePriceTextField.frame.size.width, 10, 50, 20)];
            _label.font = [UIFont systemFontOfSize:14.0f];
            _label.text = @"元/月";
            [cell addSubview:_label];
            [cell addSubview:_salePriceTextField];
        }
        else if (indexPath.row ==2)
        {
            label1 = [[UILabel alloc] initWithFrame:CGRectMake(PL_WIDTH-20-120, 10, 120, 20)];
            label1.textAlignment = NSTextAlignmentRight;
            label1.backgroundColor = [UIColor whiteColor];
            label1.text = _jiShouString;
            label1.tag = indexPath.row+10000;
            label1.font = [UIFont systemFontOfSize:14.0f];
            [cell addSubview:label1];
        }
        else if (indexPath.row ==6)
        {
            label2 = [[UILabel alloc] initWithFrame:CGRectMake(PL_WIDTH-20-120, 10, 120, 20)];
            label2.textAlignment = NSTextAlignmentRight;
            label2.backgroundColor = [UIColor whiteColor];
            label2.text = _jingLiTuiJianString;
            label2.tag = indexPath.row+10000;
            label2.font = [UIFont systemFontOfSize:14.0f];
            [cell addSubview:label2];
        }
        else if (indexPath.row ==7)
        {//委托
            _label = [[UILabel alloc] initWithFrame:CGRectMake(PL_WIDTH-20-120, 10, 120, 20)];
            _label.textAlignment = NSTextAlignmentRight;
            _label.backgroundColor = [UIColor whiteColor];
            _label.text = _statusString;
            _label.tag = indexPath.row+10000;
            _label.font = [UIFont systemFontOfSize:14.0f];
            [cell addSubview:_label];
            
        }
        else
        {
            _label = [[UILabel alloc] initWithFrame:CGRectMake(PL_WIDTH-20-120, 10, 120, 20)];
            _label.textAlignment = NSTextAlignmentRight;
            _label.backgroundColor = [UIColor whiteColor];
            _label.tag = indexPath.row+10000;
            _label.font = [UIFont systemFontOfSize:14.0f];
            [cell addSubview:_label];
        }
        
        return cell;
    }else if (tableView.tag == 10011){
        static NSString *cellName = @"cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.textLabel.text = self.jiaoYiArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
    else if(tableView.tag == 10012)
    {
        static NSString *cellName = @"cell3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.textLabel.text = self.jiaoYiArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
    else if(tableView.tag == 10013)
    {
        static NSString *cellName = @"cell4";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.textLabel.text = self.jiaoYiArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
    else if(tableView.tag == 10014)
    {
        static NSString *cellName = @"cell5";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.textLabel.text = self.jiaoYiArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RoomRevisInfo *roomReviseInfo = [[RoomRevisInfo alloc]init];
    roomReviseInfo.schoolString     = @"";
    roomReviseInfo.recommendString  = @"";
    roomReviseInfo.fastSellString   = @"";
    roomReviseInfo.statusString     = _statusString;
    
    if (tableView.tag == 10008) {
        
        if(indexPath.row == 0)
        {
            NSLog(@"出售");
            if(_rentPriceTextField.userInteractionEnabled == NO&& _topSetSenderString ==nil)
            {
                PL_ALERT_SHOW(@"请选择交易类型.");
            }
            _topSetTableView.hidden = YES;
            _topSetTableView1.hidden = YES;
            _topSetTableView2.hidden = YES;
            _topSetTableView3.hidden = YES;
        }
        else if(indexPath.row == 1)
        {
            NSLog(@"出租");
            if(_salePriceTextField.userInteractionEnabled == NO&&_topSetSenderString ==nil)
            {
                PL_ALERT_SHOW(@"请选择交易类型.");
            }
            _topSetTableView.hidden = YES;
            _topSetTableView1.hidden = YES;
            _topSetTableView2.hidden = YES;
            _topSetTableView3.hidden = YES;
        }
        else if(indexPath.row == 2)
        {
//            _strName = @"Gemini";
//            [_mainTableView reloadData];
            NSLog(@"急售");
//            _label = (UILabel *)[self.view viewWithTag:10002];
//            _label.text = _jiShouString;
            if([_jiShouString isEqualToString:@"是"])
            {
                roomReviseInfo.fastSellString = @"0";
            }
            else
            {
                //                label.text = @"是";
                roomReviseInfo.fastSellString = @"1";
            }
            [self transFormSetHouseMarks:roomReviseInfo];

            _topSetTableView.hidden = YES;
            _topSetTableView1.hidden = YES;
            _topSetTableView2.hidden = YES;
            _topSetTableView3.hidden = YES;
            [_salePriceTextField resignFirstResponder];
            [_rentPriceTextField resignFirstResponder];
            self.view.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
        }
        else if(indexPath.row == 3)
        {   NSLog(@"装修");
            NSArray *arrayData1 = @[@"精装",@"豪装",@"简装",@"中装",@"毛坯"];
            [_jiaoYiArray removeAllObjects];
            [_jiaoYiArray addObjectsFromArray:arrayData1];
            [_topSetTableView reloadData];
            _topSetTableView.hidden = NO;
            _topSetTableView1.hidden = YES;
            _topSetTableView2.hidden = YES;
            _topSetTableView3.hidden = YES;
            [_salePriceTextField resignFirstResponder];
            [_rentPriceTextField resignFirstResponder];
            self.view.frame = CGRectMake(0, -128, PL_WIDTH, PL_HEIGHT+128);
            NSLog(@"3");
        }
        else if(indexPath.row == 4)
        {
            if(_isEq)
            {
                PL_ALERT_SHOW(@"您无权修改置顶设置");
            }
            else
            {
                NSArray *arrayData1 = @[@"不置顶",@"永久置顶",@"3天",@"7天",@"15天",@"30天"];
                [_jiaoYiArray removeAllObjects];
                [_jiaoYiArray addObjectsFromArray:arrayData1];
                [_topSetTableView1 reloadData];
                _topSetTableView1.hidden = NO;
                _topSetTableView.hidden = YES;
                _topSetTableView2.hidden = YES;
                _topSetTableView3.hidden = YES;
                [_salePriceTextField resignFirstResponder];
                [_rentPriceTextField resignFirstResponder];
                self.view.frame = CGRectMake(0, -128, PL_WIDTH, PL_HEIGHT+128);
                NSLog(@"4");
                
            }
            
        }
        else if(indexPath.row == 5)
        {
            NSArray *arrayData1 = @[@"出租",@"出售",@"租售"];
            [_jiaoYiArray removeAllObjects];
            [_jiaoYiArray addObjectsFromArray:arrayData1];
            [_topSetTableView2 reloadData];
            _topSetTableView2.hidden = NO;
            _topSetTableView1.hidden = YES;
            _topSetTableView.hidden = YES;
            _topSetTableView3.hidden = YES;
            [_salePriceTextField resignFirstResponder];
            [_rentPriceTextField resignFirstResponder];
            self.view.frame = CGRectMake(0, -128, PL_WIDTH, PL_HEIGHT+128);
            NSLog(@"5");
        }
        else if(indexPath.row == 6)
        {
            NSLog(@"6");
//            _label = (UILabel *)[self.view viewWithTag:10002];
//            _label.text = _jingLiTuiJianString;
            if([_jingLiTuiJianString isEqualToString:@"是"])
            {
                roomReviseInfo.recommendString = @"0";
            }
            else
            {
                //                label.text = @"是";
                roomReviseInfo.recommendString = @"1";
            }
            [self transFormSetHouseMarks:roomReviseInfo];
            
            _topSetTableView.hidden = YES;
            _topSetTableView1.hidden = YES;
            _topSetTableView2.hidden = YES;
            _topSetTableView3.hidden = YES;
            [_salePriceTextField resignFirstResponder];
            [_rentPriceTextField resignFirstResponder];
            self.view.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);

            self.view.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
        }
        else if(indexPath.row == 7)
        {
            [_jiaoYiArray removeAllObjects];
            NSLog(@"7");
            NSArray *arrayData1 =  @[@"有效",@"无效",@"已租",@"已售"];
            [_jiaoYiArray addObjectsFromArray:arrayData1];
            [_topSetTableView3 reloadData];
            _topSetTableView3.hidden = NO;
            _topSetTableView1.hidden = YES;
            _topSetTableView2.hidden = YES;
            _topSetTableView.hidden = YES;
            [_salePriceTextField resignFirstResponder];
            [_rentPriceTextField resignFirstResponder];
            self.view.frame = CGRectMake(0, -128, PL_WIDTH, PL_HEIGHT+128);
        }
    }
    else if(tableView.tag == 10011)
    {
        _label = (UILabel *)[self.view viewWithTag:10003];
        _label.text = _jiaoYiArray[indexPath.row];
        self.view.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
        _topSetTableView.hidden = YES;
        
    }
    else if(tableView.tag == 10012)
    {//置顶
        _label = (UILabel *)[self.view viewWithTag:10004];
        _label.text = _jiaoYiArray[indexPath.row];
        self.view.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
        _topSetTableView1.hidden = YES;
        if([_label.text isEqualToString:@"不置顶"])
        {
            _topSetString = @"0";
        }
        else if ([_label.text isEqualToString:@"永久置顶"])
        {
            _topSetString = @"1";
        }
        else if ([_label.text isEqualToString:@"3天"])
        {
            _topSetString = @"3";
        }
        else if ([_label.text isEqualToString:@"7天"])
        {
            _topSetString = @"7";
        }
        else if ([_label.text isEqualToString:@"15天"])
        {
            _topSetString = @"15";
        }
        else if ([_label.text isEqualToString:@"30天"])
        {
            _topSetString = @"30";
        }
    }
    else if(tableView.tag == 10013)
    {//交易类型
        _label = (UILabel *)[self.view viewWithTag:10005];
        _label.text = _jiaoYiArray[indexPath.row];
        self.view.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
        _topSetSenderString =_jiaoYiArray[indexPath.row];
        _topSetTableView2.hidden = YES;
        if([_topSetSenderString isEqualToString:@"出售"])
        {
            _rentPriceTextField.userInteractionEnabled = YES;
            _salePriceTextField.userInteractionEnabled = NO;
            if ([[_arrayData objectForKey:@"RentPriceNew"] isKindOfClass:[NSNull class]]) {
                _salePriceTextField.text = @"";
            }else{
                _salePriceTextField.text = [_arrayData objectForKey:@"RentPriceNew"];
            }
            
        }
        else if ([_topSetSenderString isEqualToString:@"出租"]) {
            _rentPriceTextField.userInteractionEnabled = NO;
            _salePriceTextField.userInteractionEnabled = YES;
            if ([[_arrayData objectForKey:@"PriceNew"] isKindOfClass:[NSNull class]]) {
                _rentPriceTextField.text = @"";
            }else
            {
                //                _rentPriceTextField.text = [_arrayData objectForKey:@"PriceNew"];
            }
        }
        else{
            _rentPriceTextField.userInteractionEnabled = YES;
            _salePriceTextField.userInteractionEnabled = YES;
        }
    }
    else if(tableView.tag == 10014)
    {//委托状态
        _label = (UILabel *)[self.view viewWithTag:10007];
        _statusString = _jiaoYiArray[indexPath.row];
        if ([_statusString isEqualToString:@"无效"]) {
            UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"您好" message:@"是否修改为无效" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            aler.tag = 1108;
            [aler show];
        }else if ([_statusString isEqualToString:@"有效"]){
            UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"您好" message:@"是否修改为有效" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            aler.tag = 1109;
            [aler show];
        }
        else if([_statusString isEqualToString:@"已租"])
        {
            [self alertViewinit];
            
        }
        else
        {
            lastRentDateString = @"";
            [self postSetStatus];
        }
        self.view.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
        _topSetTableView3.hidden = YES;
    }
}
-(void)alertViewinit
{
    
    
    self.view.userInteractionEnabled=NO;
    baview=[[UIView alloc]initWithFrame:CGRectMake(40, PL_HEIGHT/3, PL_WIDTH-80, 150)];
    baview.backgroundColor=[UIColor whiteColor];
    baview.layer.cornerRadius=6;
    baview.layer.masksToBounds=YES;
    TextFile=[[UITextField alloc]initWithFrame:CGRectMake(10, 60, PL_WIDTH-100, 25)];
    TextFile.backgroundColor=[UIColor whiteColor];
    
    TextFile.borderStyle=UITextBorderStyleRoundedRect;
    TextFile.placeholder=@"请选择时间";
    TextFile.delegate=self;
    [baview addSubview:TextFile];
    UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(130, 5, 100, 30)];
    lable.text=@"提示";
    [baview addSubview:lable];
    UIButton*but1=[[UIButton alloc]initWithFrame:CGRectMake(0, 110, baview.frame.size.width/2, 40)];
    [but1 setTitle:@"取消" forState:UIControlStateNormal];
    [but1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    but1.backgroundColor=[UIColor whiteColor];
    but1.layer.borderColor=[[UIColor grayColor]CGColor];
    but1.layer.borderWidth=0.5;
    [but1 addTarget:self action:@selector(CanBut:) forControlEvents:UIControlEventTouchUpInside];
    [baview addSubview:but1];
    UIButton*but2=[[UIButton alloc]initWithFrame:CGRectMake(but1.frame.size.width, 110, baview.frame.size.width/2, 40)];
    but2.backgroundColor=[UIColor whiteColor];
    [but2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [but2 setTitle:@"确定" forState:UIControlStateNormal];
    but2.layer.borderWidth=0.5;
    but2.layer.borderColor=[[UIColor grayColor]CGColor];
    [but2 addTarget:self action:@selector(SureBut:) forControlEvents:UIControlEventTouchUpInside];
    [baview addSubview:but2];
    //    datepicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, PL_HEIGHT-216, PL_WIDTH, 216)];
    if (PL_HEIGHT>=736) {
        
        datepicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 520, PL_WIDTH, 216)];
    }else if(PL_HEIGHT>=667)
    {
        datepicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 450, PL_WIDTH, 216)];
    }
    else  if (PL_HEIGHT>=568)
    {
        datepicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,370, PL_WIDTH, 216)];
    }else
    {
        datepicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 325, PL_WIDTH, 216)];
        
        
    }
    
    datepicker.datePickerMode=UIDatePickerModeDate;
    datepicker.  backgroundColor=[UIColor whiteColor];
    [UIDatePicker setAccessibilityLanguage:@"Chinese"];
    NSDateFormatter*daf=[[NSDateFormatter alloc]init];
    [daf setDateFormat:@"YYYY-MM-dd"];
    TextFile.text=[daf stringFromDate:datepicker.date];
    [datepicker addTarget:self action:@selector(datePickerAction) forControlEvents:UIControlEventValueChanged];
    win=[[UIApplication sharedApplication].windows lastObject];
    BigBgView=[[UIView alloc]initWithFrame:win.frame];
    BigBgView.backgroundColor=[UIColor colorWithWhite:0.6 alpha:0.4];
    [win addSubview:BigBgView];
    [BigBgView addSubview:baview];
    [BigBgView addSubview:datepicker];
    
    [self.view addSubview:win];
}
-(void)datePickerAction

{
    datepicker.hidden=NO;
    NSDateFormatter*daf=[[NSDateFormatter alloc]init];
    [daf setDateFormat:@"YYYY-MM-dd"];
    
    TextFile.text=[daf stringFromDate:datepicker.date];
    NSLog(@"确定时间后%@",datepicker.date);
    
    
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField ==_rentPriceTextField) {
        [textField isFirstResponder];
        _rentPriceTextField.backgroundColor = [UIColor whiteColor];
        
        textField.keyboardType=UIKeyboardTypeDecimalPad;
    }else if(textField ==_salePriceTextField)
    {
        _salePriceTextField.backgroundColor = [UIColor whiteColor];
        textField.keyboardType=UIKeyboardTypeDecimalPad;
        [textField isFirstResponder];
    }else
    {
         [textField resignFirstResponder];
    }
        
    
    datepicker.hidden=NO;
    NSDateFormatter*daf=[[NSDateFormatter alloc]init];
    [daf setDateFormat:@"YYYY-MM-DD"];
    
      textField.text=[daf stringFromDate:datepicker.date];
    
   
    
    
    
    
}
-(void)CanBut:(UIButton*)but{
    
    NSLog(@"取消");
    [BigBgView removeFromSuperview];
    [baview removeFromSuperview];
    [datepicker removeFromSuperview];
    self.view.userInteractionEnabled=YES;
    
    
}
-(void)SureBut:(UIButton*)sender
{
    NSLog(@"确定");
    
    lastRentDateString = TextFile.text;
    [self postSetStatus];
    [BigBgView removeFromSuperview];
    [baview removeFromSuperview];
    [datepicker removeFromSuperview];
    self.view.userInteractionEnabled=YES;
    
    
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

- (IBAction)sureBut:(id)sender {
    if ([_rentPriceTextField.text isEqualToString:@""] || [_rentPriceTextField.text isEqualToString: [_arrayData objectForKey:@"PriceNew"]]) {
        if ([_salePriceTextField.text isEqualToString:@""] || [_salePriceTextField.text isEqualToString:[_arrayData objectForKey:@"RentPriceNew"]]) {
            if (_decorationString == nil) {
                if(_topSetSenderString == nil){
//                    if([self.topSetButton.titleLabel.text isEqualToString:@"置顶设置"]){
                        PL_ALERT_SHOWNOT_OKAND_YES(@"请至少选一项");
                        return;
//                    }
                    
                }
            }
        }
    }
    
        if([_topSetSenderString isEqualToString:@"出租"]){
            if ([_salePriceTextField.text isEqualToString:@""] || [_salePriceTextField.text floatValue] == 0.0 ) {
                PL_ALERT_SHOW(@"价格必须大于0");
                if ([[_arrayData objectForKey:@"RentPriceNew"] isKindOfClass:[NSNull class]]) {
                    _salePriceTextField.text = @"";
                }else{
                    _salePriceTextField.text = [_arrayData objectForKey:@"RentPriceNew"];
                }
                //                _decorationString = nil;
                
                return ;
            }
        }
        if([_topSetSenderString isEqualToString:@"出售"]){
            if ([_rentPriceTextField.text isEqualToString:@""] || [_rentPriceTextField.text floatValue ] == 0.0) {
                PL_ALERT_SHOW(@"价格必须大于0");
                if ([[_arrayData objectForKey:@"PriceNew"] isKindOfClass:[NSNull class]]) {
                    _rentPriceTextField.text = @"";
                }else
                {
                    _rentPriceTextField.text = [_arrayData objectForKey:@"PriceNew"];
                }
                
                
                return ;
            }
        }if([_topSetSenderString isEqualToString:@"租售"]){
            if ([_rentPriceTextField.text isEqualToString:@""] || [_rentPriceTextField.text floatValue ] == 0.0 || [_salePriceTextField.text isEqualToString:@""] || [_salePriceTextField.text floatValue] == 0.0 ) {
                PL_ALERT_SHOW(@"价格必须大于0");
                return ;
            }
        }
        
        else
        {
        UIAlertView *aery = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您要提交吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" ,nil];
        aery.tag = 1110;
        [aery show];
        }
}

- (IBAction)cancelBut:(id)sender {
    [self refreshMarksButton:self.roomRevisInfo];
    [self refreshValidButton:self.roomRevisInfo.statusString];
    self.rentPriceTextField.text = nil;
    self.rentPriceTextField.placeholder = @"请输入租价";
    self.salePriceTextField.text = nil;
    self.salePriceTextField.placeholder = @"请输入售价";
}

#pragma mark ---判断领导与业务员
-(void)isBoss{
    
    if ([_roomdutycode isEqualToString:@"E"]) {
        flagSubs =@"0";
        _dutyCode  = _roomdutycode;
    }else
    {
        flagSubs = @"1";
    }
}
-(void)transFormSetHouseMarks:(RoomRevisInfo *)info
{
    PL_PROGRESS_SHOW;
    info.properIDString   = self.reviseRoomData.roomPropertyId;
    info.houseMarksString = self.roomRevisInfo.houseMarksString;
    [self SetHouseMarks:info];
    
}
#pragma mark --houseMark
-(void)SetHouseMarks:(RoomRevisInfo *)info
{
    NSLog(@"%@,%@,%@,%@,%@",info.properIDString,info.recommendString,info.fastSellString,info.schoolString,info.houseMarksString);
    [[MyRequest defaultsRequest]afSetHousMarks:info call:^(NSMutableString *str) {
        PL_PROGRESS_DISMISS;
        NSLog(@"housMark %@",str);
        if ([str isEqualToString:@"OK"]) {
////            if ( _label.tag==10002) {
//                if ([_jiShouString isEqualToString:@"是"]) {
//                    _jiShouString = @"否";
//                }else{
//                    _jiShouString = @"是";
//                }
////            }
////            if( _label.tag==10006) {
//                if ([_jingLiTuiJianString isEqualToString:@"是"]) {
//                    _jingLiTuiJianString = @"否";
//                }else{
//                    _jingLiTuiJianString = @"是";
//                }
////            } 
////            if ([_jingLiTuiJianString isEqualToString:@"是"]) {
////                _jingLiTuiJianString = @"否";
////            }else{
////                _jingLiTuiJianString = @"是";
////            }
//
            [self getHouseMarks];
//            [_mainTableView reloadData];
            PL_ALERT_SHOW(@"修改成功");
        }
        if ([str isEqualToString:@"ERR"]) {
            PL_ALERT_SHOW(@"修改失败");
        }
        if ([str isEqualToString:@"1"]) {
            PL_ALERT_SHOW(@"您无权修改");
        }
        if ([str isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
        }
    }];
}

-(NSString *)followListdutyCode{
    
    NSLog(@"%@",[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE]);
    _followListdutyCode = [[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE]substringWithRange:NSMakeRange([[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE] length] - 1, 1)];
    return _followListdutyCode;
}
@end
