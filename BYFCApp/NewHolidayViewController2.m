//
//  NewHolidayViewController2.m
//  BYFCApp
//
//  Created by PengLee on 15/9/1.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "NewHolidayViewController2.h"
#import "PL_Header.h"
#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
@interface NewHolidayViewController2 ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSString *str1;
    NSString *str2;
    NSString *str3;
    NSString *str4;
    UIAlertView*alertView;
    NSString *_dateString;
    
    NSString *start;
    NSString *end;
    NSString *nowTime;
    NSArray *arr;
    NSString * lipeng;
    NSString *imageFlg;
    NSString*_dateString2;
    CalendarHomeViewController*chvc;
    BOOL isTrueCell;
}
@property (weak, nonatomic) IBOutlet UIPickerView *hourPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *hourPicker2;
@end

@implementation NewHolidayViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"请假申请";
    _name.text = [PL_USER_STORAGE objectForKey:PL_USER_TRUE_NAME];
    _bianhao.text = [PL_USER_STORAGE objectForKey:PL_USER_code];
    self.navigationController.navigationBarHidden=NO;
    self.view.backgroundColor = PL_CUSTOM_COLOR(239, 239, 244, 1);
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    UIButton*but=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH-80,10, 100, 30)];
    [but setTitle:@"申请历史" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
    but.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [but setTitleEdgeInsets:UIEdgeInsetsMake(0, 35, 0, 0)];
    [but addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithCustomView:but];
    self.navigationItem.rightBarButtonItem=right;
    _typeTableView = [[UITableView alloc]init];
    _typeTableView.frame = CGRectMake(0, PL_HEIGHT-180, PL_WIDTH, 180);
    _typeTableView.delegate = self;
    _typeTableView.dataSource = self;
    _typeTableView.layer.borderColor =PL_CUSTOM_COLOR(227, 227, 229, 1).CGColor;
    _typeTableView.layer.borderWidth = 1;
    _typeTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _typeTableView.hidden = YES;
    [self.view addSubview:_typeTableView];
    UIImageView *heng=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, PL_WIDTH,1)];
    heng.image=[UIImage imageNamed:@"heng_hong.png"];
    [self.view addSubview:heng];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.layer.borderColor = PL_CUSTOM_COLOR(277, 277, 229, 1).CGColor;
//    _tableView.layer.borderWidth = 1;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self requestHour];
    
    
    
    _hourstr = @"";
    
  
    _hourPicker.delegate = self;
    _hourPicker.dataSource = self;
    
   
    _hourPicker2.delegate = self;
    _hourPicker2.dataSource = self;
    _printTextView.delegate  =self;
      _hourPicker.hidden=YES;
    _hourPicker2.hidden=YES;
          lipeng = @"";
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
    else
    {
        NSDate * date2 = [NSDate dateWithTimeInterval:timerInterval*24*60*60 sinceDate:date];
        dateStr = [dateFormatter stringFromDate:date2];
    }
    return dateStr;
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
    if (pickerView==_hourPicker) {
        arr=@[@"09:00",@"14:00"];
    }
    else
    {
        arr=@[@"14:00",@"18:00"];
    }
    UILabel*lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    lab.text=[arr objectAtIndex:row];
    lab.font=[UIFont systemFontOfSize:14];

    return lab;
    
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 20;
    
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 60;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView==_hourPicker){
        
        self.startTime.text = [NSString stringWithFormat:@"%@ %@:00",[_dateString substringWithRange:NSMakeRange(0, 10)],arr[row]];
        _select2.hidden = YES;
        if([_numStr.stringValue isEqualToString:@"3"])
        {
            if ([str4 isEqualToString:@"0"] ) {
                
                _endTime.text = [self marriageTime:_startTime.text withDate:3];
            }
            if([str4 isEqualToString:@"1"])
            {
                _endTime.text = [self marriageTime:_startTime.text withDate:10];
            }
            
            if ([_endTime.text isEqualToString:@""]) {
                _select3.hidden = NO;
            }
            else
            {
                _select3.hidden = YES;
            }
            
            
        }
    }
    else    {
        self.endTime.text =[NSString stringWithFormat:@"%@ %@:00",[_dateString2 substringWithRange:NSMakeRange(0, 10)],arr[row]];;
        if ([_endTime.text isEqualToString:@""]) {
            _select3.hidden = NO;
        }
        else
        {
            _select3.hidden = YES;
        }
    }
}

//输入框
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.pushView.hidden = YES;
    self.view.frame = CGRectMake(0, -216, PL_WIDTH, PL_HEIGHT);
    _select4.hidden = YES;
    _sureBut.hidden = YES;
    _cancelBut.hidden = YES;
    _typeTableView.hidden = YES;
    
    NSLog(@"wdwdwdw");
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        self.view.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
        _sureBut.hidden = NO;
        _cancelBut.hidden = NO;
        if([_printTextView.text isEqualToString:@""])
        {
            _select4.text = @"请输入";
        }
        else
        {
            _select4.text = @"";
        }
    }
    return YES;
}

-(void)requestHour
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
                        str2 = [dict objectForKey:@"Paidsickleave"];
                        str3 = [dict objectForKey:@"Offleave"];
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
                    styleArr=[[NSMutableArray alloc]initWithArray:tempArr];
                    _yearHour.text = [NSString stringWithFormat:@"%@小时",str1];
                    _moneyHour.text = [NSString stringWithFormat:@"%@小时",str2];
                    _tiaoXiuHour.text = [NSString stringWithFormat:@"%@小时",str3];
//                    [_tableView reloadData];
                    [_typeTableView reloadData];
                    NSLog(@"******-----%lu",(unsigned long)styleArr.count);
                    
                });
                
            }
            else
            {
                NSLog(@"暂无数据");
                
            }
        }
        
    }];

}
#pragma mark - UITableView代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == _tableView)
    {
        return 2;
    }
    if (tableView == _typeTableView) {
        return 1;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView == _tableView)
    {
        if(section == 0)
        {
            return 20.0f;
        }
        if(section == 1)
        {
            return 10.0f;
        }
    }
    if(tableView == _typeTableView)
    {
        return 0.01;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(tableView == _tableView)
    {
        return 0.1;
    }
    if(tableView == _typeTableView)
    {
        return 0.1;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _typeTableView)
    {
        return 45.0f;
    }

    else if(tableView == _tableView)
    {
        if (indexPath.section==0) {
            if(indexPath.row == 0)
            {
                return 73;
            }
            
        }
        if(indexPath.section == 1)
        {
            if(indexPath.row == 0)
            {
                return 43;
            }
            else if(indexPath.row == 1)
            {
                return 43;
            }
            else if(indexPath.row == 2)
            {
                return 43;
            }
            else if(indexPath.row == 3)
            {
                return 90;
            }
            else if(indexPath.row == 4)
            {
                return 172;
            }
        }

    }
     return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _typeTableView)
    {
        static NSString *cellName = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        cell.textLabel.text = styleArr[indexPath.row];
        return cell;
    }

    else if(tableView == _tableView)
    {
        if(indexPath.section==0)
        {
            if(indexPath.row==0)
            {
                _cell1.selectionStyle = UITableViewCellSelectionStyleNone;
                _cell1.layer.borderColor = PL_CUSTOM_COLOR(227, 227, 229, 1).CGColor;
                _cell1.layer.borderWidth = 1;
                return _cell1;
            }
        }
        if(indexPath.section==1)
        {
            if(indexPath.row == 0)
            {
                _cell2.selectionStyle = UITableViewCellSelectionStyleNone;
                _cell2.layer.borderColor = PL_CUSTOM_COLOR(227, 227, 229, 1).CGColor;
                _cell2.layer.borderWidth = 1;
                return _cell2;
            }
            else if(indexPath.row == 1)
            {
                _cell3.selectionStyle = UITableViewCellSelectionStyleNone;
                _cell3.layer.borderColor = PL_CUSTOM_COLOR(227, 227, 229, 1).CGColor;
                _cell3.layer.borderWidth = 0.5;

                return _cell3;
            }
            else if(indexPath.row == 2)
            {
                _cell4.selectionStyle = UITableViewCellSelectionStyleNone;
                _cell4.layer.borderColor = PL_CUSTOM_COLOR(227, 227, 229, 1).CGColor;
                _cell4.layer.borderWidth = 0.5;
                return _cell4;
            }
            else if(indexPath.row == 3)
            {
                _cell5.selectionStyle = UITableViewCellSelectionStyleNone;
                _cell5.layer.borderColor = PL_CUSTOM_COLOR(227, 227, 229, 1).CGColor;
                _cell5.layer.borderWidth = 0.5;
                return _cell5;
            }
            else if(indexPath.row == 4)
            {
                _cell6.selectionStyle = UITableViewCellSelectionStyleNone;
                _cell6.layer.borderColor = PL_CUSTOM_COLOR(227, 227, 229, 1).CGColor;
                _cell6.layer.borderWidth = 0.5;
                return _cell6;
            }
        }
    }
      return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _tableView)
    {
        if(section == 0)
        {
            return 1;
        }
        else if(section==1)
        {
            return 5;
        }

    }
  if (tableView == _typeTableView)
    {
        return styleArr.count;
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _tableView)
    {
        if(indexPath.section == 0)
        {
            _typeTableView.hidden = YES;
            _sureBut.hidden = NO;
            _cancelBut.hidden = NO;
            self.view.frame = CGRectMake(0,0, PL_WIDTH, PL_HEIGHT);
            self.pushView.hidden = YES;
            [_printTextView resignFirstResponder];
        }
       else if(indexPath.section==1)
        {
            if(indexPath.row == 0)
            {
                _typeTableView.hidden = NO;
                _sureBut.hidden = YES;
                _cancelBut.hidden = YES;
                self.view.frame = CGRectMake(0,0, PL_WIDTH, PL_HEIGHT);

                self.pushView.hidden = YES;
                [_printTextView resignFirstResponder];
            }
           if(indexPath.row ==1)
            {
                _isStart = YES;
                if ( [_type.text isEqualToString:@""]) {
                    PL_ALERT_SHOW(@"请先选择请假类型");
                    _sureBut.hidden = NO;
                    _cancelBut.hidden = NO;
                }
                else if ([str4 isEqualToString:@"2"]) {
                    PL_ALERT_SHOW(@"你的年龄不符合");
                    _sureBut.hidden = NO;
                    _cancelBut.hidden = NO;
                    self.pushView.hidden =YES;
                }
                else
                {
                    _hourPicker.hidden=NO;
                    _sureBut.hidden = NO;
                    _cancelBut.hidden = NO;
                    [_hourPicker selectRow:arr.count inComponent:0 animated:YES];
                    [_hourPicker reloadAllComponents];
                    [_printTextView resignFirstResponder];
                    if([_printTextView.text isEqualToString:@""])
                    {
                        _select4.hidden =NO;
                    }
                    else
                    {
                        _select4.hidden = YES;
                    }
                    _select2.hidden = YES;
                    

                     [self clickCalenDar];
                    
                }
                _typeTableView.hidden = YES;
            }
          else if(indexPath.row ==2)
            {
                if ( [_type.text isEqualToString:@""]) {
                    PL_ALERT_SHOW(@"请先选择请假类型");
                    _sureBut.hidden = NO;
                    _cancelBut.hidden = NO;
                }
                else if([_numStr.stringValue isEqualToString:@"3"])
                {
                    PL_ALERT_SHOW(@"婚假填写开始时间即可");
                    _sureBut.hidden = NO;
                    _cancelBut.hidden = NO;
                    self.pushView.hidden = YES;
                    self.view.frame = CGRectMake(0,0, PL_WIDTH, PL_HEIGHT);
                    [_printTextView resignFirstResponder];
                    
                }
                else
                {
                    _isStart = NO;
                    _hourPicker2.hidden=NO;
                    _sureBut.hidden = NO;
                    _cancelBut.hidden = NO;
                    [_hourPicker reloadAllComponents];
                    [_hourPicker selectRow:arr.count inComponent:0 animated:YES];
                    [_printTextView resignFirstResponder];
                    if([_printTextView.text isEqualToString:@""])
                    {
                        _select4.hidden = NO;
                    }
                    else
                    {
                        _select4.hidden = YES;
                    }
                   _select3.hidden = YES;
                

                    if (!chvc) {
                        
                        chvc = [[CalendarHomeViewController alloc]init];
                        
                        [chvc setAirPlaneToDay:365 ToDateforString:nil];
                        
                    }
                    [self presentViewController:chvc animated:YES completion:^{
                        __block NewHolidayViewController2*blockSelf=self;
                        chvc.calendarblock = ^(CalendarDayModel *model){
                            _dateString2= [NSString stringWithFormat:@"%@ 14:00:00",[model toString]];
            blockSelf.endTime.text= [NSString stringWithFormat:@"%@ 14:00:00",[model toString]];
                            
                            
                        };
                        
                        
                    }];
                    
                }

                _typeTableView.hidden = YES;
            }
          else if(indexPath.row ==3)
            {
                _sureBut.hidden = NO;
                _cancelBut.hidden = NO;
                self.view.frame = CGRectMake(0,0, PL_WIDTH, PL_HEIGHT);
                self.pushView.hidden = YES;
                [_printTextView resignFirstResponder];
                
                if([_printTextView.text isEqualToString:@""])
                {
                    _select4.hidden = NO;
                }
                else
                {
                    _select4.hidden =YES;
                }
                
                _typeTableView.hidden = YES;
            }
            else if(indexPath.row == 4)
            {
                _sureBut.hidden = NO;
                _cancelBut.hidden = NO;
                self.view.frame = CGRectMake(0,0, PL_WIDTH, PL_HEIGHT);
                self.pushView.hidden = YES;
                [_printTextView resignFirstResponder];
                
                if([_printTextView.text isEqualToString:@""])
                {
                    _select4.hidden = NO;
                }
                else
                {
                    _select4.hidden = YES;
                }
                
                _typeTableView.hidden = YES;
            }
        }
    }
   else if(tableView == _typeTableView)
    {
        _hourPicker.hidden=YES;
        _hourPicker2.hidden=YES;
        _type.text = styleArr[indexPath.row];
        _startTime.text = @"";
        _endTime.text = @"";
        _printTextView.text = @"";
        NSDictionary *dic = [_array objectAtIndex:indexPath.row];
        _numStr = [dic objectForKey:@"Number03"];
        if (![_type.text isEqualToString:@""]) {
            _select1.hidden = YES;
        }
        else
        {
            _select1.hidden = NO;
        }
        
        if (![_startTime.text isEqualToString:@""]) {
            _select2.hidden = YES;
        }
        else
        {
            _select2.hidden = NO;
        }
        
        if (![_endTime.text isEqualToString:@""]) {
            _select3.hidden = YES;
        }
        else
        {
            _select3.hidden = NO;
        }
        
        if (![_printTextView.text isEqualToString:@""]) {
            _select4.hidden = YES;
        }
        else
        {
            _select4.hidden = NO;
        }
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _sureBut.hidden = NO;
    _cancelBut.hidden = NO;
    self.view.frame = CGRectMake(0,0, PL_WIDTH, PL_HEIGHT);
    self.pushView.hidden = YES;
    [_printTextView resignFirstResponder];
    
    if([_printTextView.text isEqualToString:@""])
    {
        _select4.hidden = NO;
    }
    else
    {
        _select4.hidden = YES;
    }

    _typeTableView.hidden = YES;
}
//开始时间
-(void)clickCalenDar
{
    
    if (!chvc) {
        
        chvc = [[CalendarHomeViewController alloc]init];
        
        chvc.calendartitle = @"日历";
        
        [chvc setAirPlaneToDay:365 ToDateforString:nil];
        
    }
    
    [self presentViewController:chvc animated:YES completion:^{
           __block NewHolidayViewController2*blockSelf=self;
        __block NSString *newStr4 = str4;
        chvc.calendarblock = ^(CalendarDayModel *model){
         
            NSLog(@"%@",[model toString]);
           blockSelf.startTime.text= [NSString stringWithFormat:@"%@ 09:00:00",[model toString]];
            _dateString=[NSString stringWithFormat:@"%@ 09:00:00",[model toString]];
            if([blockSelf.numStr.stringValue isEqualToString:@"3"])
            {
                if ([newStr4 isEqualToString:@"0"] ) {
                    
                    blockSelf.endTime.text = [blockSelf marriageTime:blockSelf.startTime.text withDate:3];
                }
                if([newStr4 isEqualToString:@"1"])
                {
                    blockSelf.endTime.text = [blockSelf marriageTime:blockSelf.startTime.text withDate:10];
                }
                if ([blockSelf.endTime.text isEqualToString:@""]) {
                    blockSelf.select3.hidden =NO;
                }
                else
                {
                    blockSelf.select3.hidden = YES;
                }
            }

            
        };
        
        
    }];
    
//    if(isStart){
//        self.startTime.text = [NSString stringWithFormat:@"%@ %@:00",_dateString,_hourstr];
//        if ([_startTime.text isEqualToString:@""]) {
//            _select2.hidden = NO;
//        }
//        else
//        {
//            _select2.hidden = YES;
//        }
       //
//        
//    }
//    else
//    {
//        self.endTime.text =[NSString stringWithFormat:@"%@ %@:00",_dateString,_hourstr];;
//        if ([_endTime.text isEqualToString:@""]) {
//            _select3.hidden = NO;
//        }
//        else
//        {
//            _select3.hidden = YES;
//        }
//        
//    }
//    
//    

    
    
}

-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightClick
{
    XJViewController *xj=[[XJViewController alloc]init];
    [self.navigationController pushViewController:xj animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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

- (IBAction)sureButAction:(id)sender {
    if(_type.text.length == 0)
    {
        PL_ALERT_SHOW(@"请选择请假类型");
    }
    else if(_printTextView.text.length == 0)
    {
        PL_ALERT_SHOW(@"请填写休假信息");
    }
    else if(_startTime.text.length == 0|| _endTime.text.length == 0)
    {
        PL_ALERT_SHOW(@"请填写休假时间");
    }
    
    else{
        start=[NSString stringWithFormat:@"%@",_startTime.text];
        end=[NSString stringWithFormat:@"%@",_endTime.text];
        NSLog(@"%d",[_numStr.stringValue isEqualToString:@"5"]);
        NSLog(@"%d",[self compareTime:start withTime:end]>3);
        if([start compare:end options:NSNumericSearch]==NSOrderedDescending||[start compare:end options:NSNumericSearch]==NSOrderedSame){
            PL_ALERT_SHOW(@"请填写正确的休假时间");
        }
        else if([_numStr.stringValue isEqual:@"5"])
        {
            if([self compareTime:start withTime:end]>3)
            {
                //丧假只能指定为3天
                PL_ALERT_SHOW(@"丧假指定为3天以内");
            }
            else
            {
                if([lipeng isEqualToString:@""])
                {
                    PL_ALERT_SHOW(@"请添加附件");
                }
                else
                {
                    imageFlg = @"1";
                     [self request];
                }
            }
        }
        else if([_numStr.stringValue isEqual:@"3"])
        {
            if ([str4 isEqualToString:@"2"]) {
                PL_ALERT_SHOW(@"没有出生日期，请联系人事部，否则不能请婚假");
            }
            else
            {
                if([lipeng isEqualToString:@""])
                {
                    imageFlg = @"0";
                }
                else
                {
                    imageFlg = @"1";
                }
                [self request];
                
            }
        }
        else
        {
            if([lipeng isEqualToString:@""])
            {
                imageFlg = @"0";
            }
            else
            {
                imageFlg = @"1";
            }
            [self request];
        }
    }

}
-(void)request
{
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]afGetLeaveLeaveType:_numStr.stringValue StartDate:start EndDate:end Reason:_printTextView.text  ImageFlg:imageFlg Imagebytes:lipeng userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] completeBack:^(id obj) {
        NSLog(@"%@",obj);
        PL_PROGRESS_DISMISS;
        NSString *string=obj;
        if ([string isEqualToString:@"OK"]) {
            PL_ALERT_SHOW(@"申请成功，等待审核");
            _printTextView.text = @"";
            _startTime.text = @"";
            _endTime.text = @"";
            _type.text = @"";
            _upImage.image = [UIImage imageNamed:@""];
            _hourPicker.hidden=YES;
            _hourPicker2.hidden=YES;
            if (![_type.text isEqualToString:@""]) {
                _select1.hidden = YES;
            }
            else
            {
                _select1.hidden = NO;
            }
            
            if (![_startTime.text isEqualToString:@""]) {
                _select2.hidden = YES;
            }
            else
            {
                _select2.hidden = NO;
            }
            
            if (![_endTime.text isEqualToString:@""]) {
                _select3.hidden = YES;
            }
            else
            {
                _select3.hidden = NO;
            }

            _select4.hidden = NO;
        }
        else if ([string isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"有错误发生");
        }
        else  if ([string isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        else if ([string isEqualToString:@"[]"])
        {
            PL_ALERT_SHOW(@"暂无数据");
        }
        else if ([string isEqualToString:@"STISHOLIDAY"])
        {
            PL_ALERT_SHOW(@"请假开始日期不能为节假日");
        }
        else if ([string isEqualToString:@"ETISHOLIDAY"])
        {
            PL_ALERT_SHOW(@"请假结束日期不能为节假日");
        }
        else if ([string isEqualToString:@"ISHASTHESAMELEAVE"])
        {
            PL_ALERT_SHOW(@"已经存在此条请假信息");
        }
        else if ([string isEqualToString:@"NotEnoughAnnualleave"])
        {
            PL_ALERT_SHOW(@"没有足够的年假");
        }
        else if ([string isEqualToString:@"NotEnoughPaidsickleave"])
        {
            PL_ALERT_SHOW(@"没有足够的有薪年假");
        }
        else if ([string isEqualToString:@"NotEnoughOffleave"])
        {
            PL_ALERT_SHOW(@"没有足够的调休");
        }
        else if ([string isEqualToString:@"4"])
        {
//            NSDate *nowDate = [NSDate date];
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//            nowTime = [dateFormatter stringFromDate:nowDate];
//            NSLog(@"********=====%@",nowTime);
//            
//            int day = [[nowTime substringWithRange:NSMakeRange(8,2)] intValue];
//            int month = [[nowTime substringWithRange:NSMakeRange(5, 2)] intValue];
//            if(day>7)
//            {
//                NSString *str = [NSString stringWithFormat:@"开始时间请选择在%d月%d日之后",month,day-7];
//                PL_ALERT_SHOW(str);
//            }
//            else
//            {
//                NSString *message = [NSString stringWithFormat:@"开始时间请选择在%d月1日",month];
//                PL_ALERT_SHOW(message);
//            }
            PL_ALERT_SHOW(@"申请开始日期不能选择1天以前的日期");
        }
        else if ([string isEqualToString:@"5"])
        {
            PL_ALERT_SHOW(@"申请开始日期不能选择30天以后的日期");
        }
        else if ([string isEqualToString:@"6"])
        {
//            NSDate *nowDate = [NSDate date];
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//            nowTime = [dateFormatter stringFromDate:nowDate];
//            NSLog(@"********=====%@",nowTime);
//            
//            int day = [[nowTime substringWithRange:NSMakeRange(8,2)] intValue];
//            int month = [[nowTime substringWithRange:NSMakeRange(5, 2)] intValue];
//            if(day>7)
//            {
//                NSString *str = [NSString stringWithFormat:@"结束时间请选择在%d月%d日之后",month,day-7];
//                PL_ALERT_SHOW(str);
//            }
//            else
//            {
//                NSString *message = [NSString stringWithFormat:@"结束时间请选择在%d月1日",month];
//                PL_ALERT_SHOW(message);
//            }
            PL_ALERT_SHOW(@"申请结束日期不能选择1天以前的日期");
        }
        else if ([string isEqualToString:@"7"])
        {
            PL_ALERT_SHOW(@"申请结束日期不能选择30天以后的日期");
        }
        else if ([string isEqualToString:@"8"])
        {
            PL_ALERT_SHOW(@"申请结束日期不能选择6个月以后的日期");
        }
        else if ([string isEqualToString:@"9"])
        {
            PL_ALERT_SHOW(@"请假申请开始日期不能向前跨月");
        }
        else if ([string isEqualToString:@"10"])
        {
            PL_ALERT_SHOW(@"请假申请结束日期不能向前跨月");
        }

        else if ([string isEqualToString:@"11"])
        {
            PL_ALERT_SHOW(@"计算上一个工作日时出错，对假期申请记录的验证失败");
        }

        else if ([string isEqualToString:@"12"])
        {
            PL_ALERT_SHOW(@"所选开始日期的上一个工作日有请假信息，若要请假，请进行续假操作");
        }
        else if ([string isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
        }
        else if ([string isEqualToString:@"ProcessError"]) {
            PL_ALERT_SHOW(@"流程发起失败");
        }
        else
        {
            PL_ALERT_SHOW(@"请求超时");
        }

    }];
}

- (IBAction)cancelButAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)upButAction:(id)sender {
    if(_type.text.length == 0)
    {
        PL_ALERT_SHOW(@"请选择请假类型");
    }
    else if(_printTextView.text.length == 0)
    {
        PL_ALERT_SHOW(@"请填写休假信息");
    }
    else if(_startTime.text.length == 0|| _endTime.text.length == 0)
    {
        PL_ALERT_SHOW(@"请填写休假时间");
    }
    else
    {
        alertView=[[UIAlertView alloc]initWithTitle:@"请上传附件证明" message:nil delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"拍照",@"本地相册" ,nil];
        [alertView show];
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
        [self image:_upImage rotation:image.imageOrientation];
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
        
        _upImage.image=[UIImage imageWithContentsOfFile:filePath];

        [picker dismissViewControllerAnimated:YES completion:nil];
        
          UIImage * baseImage = [UIImage imageWithContentsOfFile:filePath];
        UIImage * imagess = [self imageWithImage:baseImage scaledToSize:CGSizeMake(600,450)];
        NSData * daImage = UIImagePNGRepresentation(imagess);
        NSData * iamgeData = [daImage base64EncodedDataWithOptions:0];
        lipeng = [[NSString alloc]initWithData:iamgeData encoding:NSUTF8StringEncoding];
//        [[MyRequest defaultsRequest]holiDayUpDowloadData:lipeng userid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] Token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] uPpic:^(NSString *str) {
//         if([str isEqualToString:@"OK"])
//                {
//                    PL_ALERT_SHOW(@"上传成功");
//                    }
//            else if([str isEqualToString:@"ERR"])
//                {
//                    PL_ALERT_SHOW(@"上传失败");
//                    }
//            else if([str isEqualToString:@"exception"])
//                {
//                    PL_ALERT_SHOW(@"崩溃性错误");
//                    }
//            }];
        _sureBut.hidden = NO;
        _cancelBut.hidden = NO;
    }
}
-(UIImageView *)image:(UIImageView *)imageView rotation:(UIImageOrientation)orientation
{
    switch (orientation) {
        case UIImageOrientationLeft:
            imageView.transform = CGAffineTransformMakeRotation(-M_PI/2);
            break;
        case UIImageOrientationRight:
            imageView.transform = CGAffineTransformMakeRotation(M_PI/2);
            break;
        case UIImageOrientationDown:
            imageView.transform = CGAffineTransformMakeRotation(M_PI);
            break;
        default:
            imageView.transform = CGAffineTransformMakeRotation(0);
            
            break;
    }
    return imageView;
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

@end
