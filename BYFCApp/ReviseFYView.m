//
//  ReviseFYView.m
//  BYFCApp
//
//  Created by PengLee on 15/5/15.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//
#import "ReviseFYView.h"
#import "PL_Header.h"
#import "MyRequest.h"
@interface ReviseFYView()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UITextFieldDelegate>
{
    UITableView *_topSetTableView;
    UITableView *_topSetTableView1;
    UITableView *_topSetTableView2;
    UITableView *_topSetTableView3;
    UIDatePicker *_datePicker;

    NSString    * _statusString;
    NSString    * _decorationString;
    //置顶
    NSString    * _topSetString;
    //交易类型
    NSString    * _topSetSenderString;
    UILabel *label;
    NSString *lastRentDateString;
    UITextField *field;
    UIAlertView *aler1;
}
@property(nonatomic,strong)NSArray * titleArray;
@property(nonatomic,strong)NSArray * topSetArray;
@property(nonatomic,strong)NSArray * topSetSenderArray;
@property(nonatomic,strong)NSMutableArray * jiaoYiArray;
@property(nonatomic,strong)NSArray * jiShouArray;
@property(nonatomic,strong)NSArray * zhuangXiuArray;
@property(nonatomic,strong)NSArray * jingLiArray;
@property(nonatomic,strong) RoomRevisInfo *newRoomRevisInfo;
@property(nonatomic,strong) UIButton *buton1;
@end
@implementation ReviseFYView
//-(NSArray *)topSetArray
//{
//    if (!_topSetArray) {
//        _topSetArray = @[@"不置顶",@"永久置顶",@"3天",@"7天",@"15天",@"30天"];
//    }
//    return _topSetArray;
//}
////交易类型数组
//- (NSArray *)topSetSenderArray
//{
//    if (!_topSetSenderArray) {
//        _topSetSenderArray = @[@"出租",@"出售",@"租售"];
//    }
//    return _topSetSenderArray;
//}
////委托状态
//-(NSArray *)jiaoYiArray
//{
//    if (!_jiaoYiArray) {
//        _jiaoYiArray = @[@"有效",@"无效",@"已租",@"已售"];
//    }
//    return _jiaoYiArray;
//}
//-(NSArray *)titleArray
//{
//    if(!_titleArray)
//    {
//        _titleArray = @[@"售价",@"租价",@"急售",@"装修",@"置顶设置",@"交易类型",@"经理推荐",@"委托状态"];
//    }
//    return _titleArray;
//}

-(RoomRevisInfo *)newRoomRevisInfo
{
    if (!_newRoomRevisInfo ) {
        _newRoomRevisInfo = [[RoomRevisInfo alloc]init];
    }
    return _newRoomRevisInfo;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
    if (self = [super initWithFrame:frame]) {
        self = [[NSBundle mainBundle]loadNibNamed:@"ReviseFYView" owner:self options:nil].lastObject;
//        isEq = YES;
        self.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
        self.backgroundColor = [UIColor purpleColor];
        [self loadView:frame];
    }
    return self;
}



-(void)awakeFromNib
{
    NSLog(@"%s",__FUNCTION__);
    [super awakeFromNib];
    _statusString = @"";
    _jingLiTuiJianString = @"";
    _jiShouString = @"";
    
    self.needButton.hidden = YES;
    _jiaoYiArray = [NSMutableArray array];
    if(_isEq)
    {
        _titleArray = @[@"售价",@"租价",@"急售",@"装修",@"置顶设置",@"交易类型",@"经理推荐",@"委托状态"];
    }
    else
    {
//        _titleArray = @[@"售价",@"租价",@"急售",@"装修",@"交易类型",@"经理推荐",@"委托状态"];
        _titleArray = @[@"售价",@"租价",@"急售",@"装修",@"置顶设置",@"交易类型",@"经理推荐",@"委托状态"];

    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tag = 10008;
    self.tableView.scrollEnabled = NO;
    self.tableView.layer.borderWidth = 1;
    self.tableView.layer.borderColor =PL_CUSTOM_COLOR(223, 223, 225, 1).CGColor;
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
    [self addSubview:_topSetTableView];
    [self addSubview:_topSetTableView1];
    [self addSubview:_topSetTableView2];
    [self addSubview:_topSetTableView3];
    _topSetTableView.hidden = YES;
    _topSetTableView1.hidden = YES;
    _topSetTableView2.hidden = YES;
    _topSetTableView3.hidden = YES;
    [self loadData];
    [self loadData1];
    
}
- (void)loadData
{
    PL_PROGRESS_SHOW;
    
    NSString *strid = [[NSUserDefaults standardUserDefaults] objectForKey:@"SHC"];
    [[MyRequest defaultsRequest]afGetHouseMarksWithPropertyID:strid call:^(NSArray *array) {
        for (NSDictionary *dic in array) {
            NSLog(@"+++%@",dic);
            _jiShouString = dic[@"FastSell"];
            _jingLiTuiJianString =dic[@"Recommend"];
           
            PL_PROGRESS_DISMISS;
            [_tableView reloadData];
//            self.newRoomRevisInfo.recommendString  = dic[@"Recommend"];
//            self.newRoomRevisInfo.schoolString     = dic[@"School"];
//            self.newRoomRevisInfo.houseMarksString = dic[@"HouseMarks"];
        }
    }];
    
    
}

-(void)loadData1

{
    
    PL_PROGRESS_SHOW;
    NSString *strid1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"SHC"];
    [[MyRequest defaultsRequest]afGetHouseValueWithPropertyID:strid1 Name:@"Status" call:^(NSMutableString *str) {
        NSLog(@">>>>>>>>>>>+++++%@",[str componentsSeparatedByString:@":"].lastObject);
        NSLog(@"%@",_statusString);
        _statusString = [[str componentsSeparatedByString:@":"].lastObject stringByReplacingOccurrencesOfString:@"}]" withString:@""];
        PL_PROGRESS_DISMISS;
        [_tableView reloadData];
    }];
    

}



-(NSString *)followListdutyCode{
    
    NSLog(@"%@",[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE]);
    _followListdutyCode = [[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE]substringWithRange:NSMakeRange([[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE] length] - 1, 1)];
    return _followListdutyCode;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}
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
            _rentPriceTextField =[[UITextField alloc] initWithFrame:CGRectMake(PL_WIDTH-120, 10, 80, 20)];
//            _rentPriceTextField.text =@"";
            _rentPriceTextField.delegate = self;
            _rentPriceTextField.userInteractionEnabled = NO;
            _rentPriceTextField.textAlignment = NSTextAlignmentRight;
            _rentPriceTextField.font = [UIFont systemFontOfSize:14.0f];
            label = [[UILabel alloc] initWithFrame:CGRectMake(_rentPriceTextField.frame.origin.x+_rentPriceTextField.frame.size.width, 10, 40, 20)];
            label.font = [UIFont systemFontOfSize:14.0f];
            label.text = @"万元";
            [cell addSubview:label];
            [cell addSubview:_rentPriceTextField];
        }
        else if (indexPath.row ==1)
        {
            _salePriceTextField =[[UITextField alloc] initWithFrame:CGRectMake(PL_WIDTH-120, 10, 80, 20)];
            _salePriceTextField.text = @"";
            _salePriceTextField.delegate = self;
            _salePriceTextField.userInteractionEnabled = NO;
            _salePriceTextField.textAlignment = NSTextAlignmentRight;
            _salePriceTextField.font =[UIFont systemFontOfSize:14.0f];
            label = [[UILabel alloc] initWithFrame:CGRectMake(_salePriceTextField.frame.origin.x+_salePriceTextField.frame.size.width, 10, 40, 20)];
            label.font = [UIFont systemFontOfSize:14.0f];
            label.text = @"元/月";
            [cell addSubview:label];
            [cell addSubview:_salePriceTextField];
        }
        else if (indexPath.row ==2)
        {
            label = [[UILabel alloc] initWithFrame:CGRectMake(PL_WIDTH-20-120, 10, 120, 20)];
            label.textAlignment = NSTextAlignmentRight;
            label.text = _jiShouString;
            label.tag = indexPath.row+10000;
            label.font = [UIFont systemFontOfSize:14.0f];
            [cell addSubview:label];
        }
        else if (indexPath.row ==6)
        {
            label = [[UILabel alloc] initWithFrame:CGRectMake(PL_WIDTH-20-120, 10, 120, 20)];
            label.textAlignment = NSTextAlignmentRight;
            NSLog(@"%@",label.text);
            NSLog(@"%@",_jingLiTuiJianString);
            label.text = _jingLiTuiJianString;
            label.tag = indexPath.row+10000;
            label.font = [UIFont systemFontOfSize:14.0f];
            [cell addSubview:label];
        }
        else if (indexPath.row ==7)
        {//委托
            label = [[UILabel alloc] initWithFrame:CGRectMake(PL_WIDTH-20-120, 10, 120, 20)];
            label.textAlignment = NSTextAlignmentRight;
            label.text = _statusString;
            label.tag = indexPath.row+10000;
            label.font = [UIFont systemFontOfSize:14.0f];
            [cell addSubview:label];
            
        }
        else
        {
            label = [[UILabel alloc] initWithFrame:CGRectMake(PL_WIDTH-20-120, 10, 120, 20)];
            label.textAlignment = NSTextAlignmentRight;
            label.tag = indexPath.row+10000;
            label.font = [UIFont systemFontOfSize:14.0f];
            [cell addSubview:label];
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
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
    

}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"textfield");
    return YES;
}
-(void)datePickerAction
{
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    [fomatter setDateFormat:@"yyyy-mm-dd"];
    lastRentDateString = [fomatter stringFromDate:_datePicker.date];
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
            NSLog(@"急售");
            label = (UILabel *)[self viewWithTag:10002];
            if([label.text isEqualToString:@"是"])
            {
                roomReviseInfo.fastSellString = @"0";
            }
            else
            {
//                label.text = @"是";
                roomReviseInfo.fastSellString = @"1";
            }
            if ([self.ViewDelegate respondsToSelector:@selector(transFormSetHouseMarks:)]) {
                [self.ViewDelegate transFormSetHouseMarks:roomReviseInfo];
            }
             label.text = _jiShouString;
            _topSetTableView.hidden = YES;
            _topSetTableView1.hidden = YES;
            _topSetTableView2.hidden = YES;
            _topSetTableView3.hidden = YES;
            [_salePriceTextField resignFirstResponder];
            [_rentPriceTextField resignFirstResponder];
            self.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
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
            self.frame = CGRectMake(0, -128, PL_WIDTH, PL_HEIGHT+128);
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
                self.frame = CGRectMake(0, -128, PL_WIDTH, PL_HEIGHT+128);
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
            self.frame = CGRectMake(0, -128, PL_WIDTH, PL_HEIGHT+128);
            NSLog(@"5");
        }
        else if(indexPath.row == 6)
        {
            NSLog(@"6");
            label = (UILabel *)[self viewWithTag:10006];
            if([label.text isEqualToString:@"是"])
            {
//                label.text = @"否";
                 roomReviseInfo.recommendString = @"0";
            }
            else
            {
//                label.text = @"是";
                 roomReviseInfo.recommendString = @"1";
            }
            if ([self.ViewDelegate respondsToSelector:@selector(transFormSetHouseMarks:)]) {
                [self.ViewDelegate transFormSetHouseMarks:roomReviseInfo];
            }
            
            _topSetTableView.hidden = YES;
            _topSetTableView1.hidden = YES;
            _topSetTableView2.hidden = YES;
            _topSetTableView3.hidden = YES;
            [_salePriceTextField resignFirstResponder];
            [_rentPriceTextField resignFirstResponder];
            label.text = _jingLiTuiJianString;
            self.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
        }
        else if(indexPath.row == 7)
        {
            [_jiaoYiArray removeAllObjects];
            NSLog(@"7");
//            _topSetTableView = (UITableView *)[self viewWithTag:10014];
             NSArray *arrayData1 =  @[@"有效",@"无效",@"已租",@"已售"];
            [_jiaoYiArray addObjectsFromArray:arrayData1];
            [_topSetTableView3 reloadData];
            _topSetTableView3.hidden = NO;
            _topSetTableView1.hidden = YES;
            _topSetTableView2.hidden = YES;
            _topSetTableView.hidden = YES;
            [_salePriceTextField resignFirstResponder];
            [_rentPriceTextField resignFirstResponder];
            self.frame = CGRectMake(0, -128, PL_WIDTH, PL_HEIGHT+128);
        }
    }
    else if(tableView.tag == 10011)
    {
        label = (UILabel *)[self viewWithTag:10003];
        label.text = _jiaoYiArray[indexPath.row];
        self.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
        _topSetTableView.hidden = YES;
       
    }
    else if(tableView.tag == 10012)
    {//置顶
        label = (UILabel *)[self viewWithTag:10004];
        label.text = _jiaoYiArray[indexPath.row];
        self.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
        _topSetTableView1.hidden = YES;
      if([label.text isEqualToString:@"不置顶"])
      {
          _topSetString = @"0";
      }
      else if ([label.text isEqualToString:@"永久置顶"])
      {
          _topSetString = @"1";
      }
      else if ([label.text isEqualToString:@"3天"])
      {
          _topSetString = @"3";
      }
      else if ([label.text isEqualToString:@"7天"])
      {
          _topSetString = @"7";
      }
      else if ([label.text isEqualToString:@"15天"])
      {
          _topSetString = @"15";
      }
      else if ([label.text isEqualToString:@"30天"])
      {
          _topSetString = @"30";
      }
    }
    else if(tableView.tag == 10013)
    {//交易类型
        label = (UILabel *)[self viewWithTag:10005];
        label.text = _jiaoYiArray[indexPath.row];
        self.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
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
       label = (UILabel *)[self viewWithTag:10007];
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
//           
//            UIView *bgView= [[UIView alloc] initWithFrame:CGRectMake(0, PL_HEIGHT-216, PL_WIDTH,216) ];
//            bgView.backgroundColor = [UIColor whiteColor];
//            _datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(30, PL_HEIGHT-216, PL_WIDTH,186)];
//            _datePicker.datePickerMode=UIDatePickerModeDate;
//            _datePicker.backgroundColor=[UIColor whiteColor];
//            [_datePicker addTarget:self action:@selector(datePickerAction) forControlEvents:UIControlEventValueChanged];
//            [_datePicker setAccessibilityLanguage:@"Chinese"];
//            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(PL_WIDTH-60, 0, PL_WIDTH, 30)];
//            [btn setTitle:@"确定" forState:UIControlStateNormal];
//            btn.backgroundColor = [UIColor redColor];
//            [btn addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
//            [bgView addSubview:_datePicker];
//            [bgView addSubview:btn];
//            [self addSubview:bgView];

        }
        else
        {
             label.text = _jiaoYiArray[indexPath.row];
        }

       self.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
        _topSetTableView3.hidden = YES;
    }
}
-(void)btn
{
    [self postSetStatus];
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
            if ([self.ViewDelegate respondsToSelector:@selector(clickViewSender:)]) {
                [self.salePriceTextField resignFirstResponder];
                [self.rentPriceTextField resignFirstResponder];
                self.newRoomRevisInfo.priceString = self.salePriceTextField.text.length == 0 ? @"":self.salePriceTextField.text;
                self.newRoomRevisInfo.rentpriceString = self.rentPriceTextField.text.length == 0 ? @"":self.rentPriceTextField.text;
//                self.newRoomRevisInfo.daysString = [NSString stringWithFormat:@"%ld",(long)self.topset] == 0 ? @"":[NSString stringWithFormat:@"%ld",(long)self.topset];
                self.newRoomRevisInfo.decorationString = _decorationString.length == 0 ? @"":_decorationString;
                self.newRoomRevisInfo.daysString = _topSetString.length == 0 ? @"":_topSetString;
                self.newRoomRevisInfo.custom = _topSetSenderString;
                [self.ViewDelegate clickViewSender:self.newRoomRevisInfo];
            }else{
                
            }
        }
        
    }
    
    
}
-(void)postSetStatus
{
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]SetStatusWithPropertyID:self.propertyIDString Status:_statusString LastRentDate:lastRentDateString call:^(NSString *str) {
        NSLog(@"%@",str);
        PL_PROGRESS_DISMISS;
        if ([str isEqualToString:@"OK"])
        {
            
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _topSetTableView.hidden = YES;
    _topSetTableView1.hidden = YES;
    _topSetTableView2.hidden = YES;
    _topSetTableView3.hidden = YES;
    [_salePriceTextField resignFirstResponder];
    [_rentPriceTextField resignFirstResponder];
    self.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
}

- (IBAction)sendAction:(id)sender {
    
        if ([_rentPriceTextField.text isEqualToString:@""] || [_rentPriceTextField.text isEqualToString: [_arrayData objectForKey:@"PriceNew"]]) {
            if ([_salePriceTextField.text isEqualToString:@""] || [_salePriceTextField.text isEqualToString:[_arrayData objectForKey:@"RentPriceNew"]]) {
                if (_decorationString == nil) {
                    if(_topSetSenderString == nil){
                        if([self.topSetButton.titleLabel.text isEqualToString:@"置顶设置"]){
                            PL_ALERT_SHOWNOT_OKAND_YES(@"请至少选一项");
                            return;
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
        
        
        UIAlertView *aery = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您要提交吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" ,nil];
        aery.tag = 1110;
        [aery show];
        
    }
    
}

- (IBAction)cancelAction:(id)sender {
    if ([self.ViewDelegate respondsToSelector:@selector(clickClearButton)])
    {
        
        [self.ViewDelegate clickClearButton];
    }

}

-(void)refreshUI:(RoomData *)roomInfo
{
    
    NSLog(@"id  %@,marks %@,pricef %@,pricet %@,priceu %@,price %@,trade %@",roomInfo.roomPropertyId,roomInfo.roomHouseMarks,roomInfo.roomPriceFrom,roomInfo.roomPriceTo,roomInfo.roomPriceUnit,roomInfo.roomPRICE,roomInfo.roomTrade);

}


-(void)loadView:(CGRect)fram
{
    
    
}
-(void)addSelfOnAView:(UIView *)view
{

    
    [view.window addSubview:self];
    self.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.6];

    
    [self bringSubviewToFront:view.window];
    [self fadeIn];
}


- (IBAction)clickSenderButton:(UIButton *)sender {
}
- (IBAction)clickClearButton:(UIButton *)sender {
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

//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self clearTel:nil];
//}
//- (void)clearTel:(UIGestureRecognizer *)tap
//{
//    [self fadeOut];
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
