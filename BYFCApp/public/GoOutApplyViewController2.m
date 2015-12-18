//
//  GoOutApplyViewController2.m
//  BYFCApp
//
//  Created by 王鹏 on 15/7/24.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "GoOutApplyViewController2.h"
#import "PL_Header.h"
#import "GoOutApplyListViewController.h"
#import "MyRequest.h"
#import "ApplyViewController.h"

#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
@interface GoOutApplyViewController2 ()
{
    UITableView*ordtableView;
    UITableViewCell *cell;
    BOOL isture;
    NSString*Typeam;
    UIView*DateView;
    CalendarHomeViewController *chvc;
}
@end

@implementation GoOutApplyViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_queue_t queue=dispatch_queue_create("firstQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        [[MyRequest defaultsRequest]GetGoutCheckForgetExemptUserid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] Token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] string:^(NSString *str) {
            if ([str isEqualToString:@"true"]) {
                NSLog(@"可以豁免%@",str);
            }else if ([str isEqualToString:@"false"])
            {
                _specialBtn.hidden=YES;
                _goOutBtn.hidden=YES;
                _image1.hidden=YES;
                _image2.hidden=YES;
                NSLog(@"不可豁免%@",str);
            }
        }];
        
    });
    self.title = @"外出申请";
    Typeam=@"0";
    _AmImage.hidden=YES;
    _Pmimage.hidden=YES;
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    _staName.text=[PL_USER_STORAGE objectForKey:PL_USER_TRUE_NAME];
    _staNum.text=[PL_USER_STORAGE objectForKey:PL_USER_code];
    _image1.image = [UIImage imageNamed:@"radio-button_on33.png"];
    _datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, PL_HEIGHT-216, PL_WIDTH, 216)];
    _datePicker.datePickerMode=UIDatePickerModeDate;
    _datePicker.  backgroundColor=[UIColor whiteColor];
    [_datePicker setAccessibilityLanguage:@"Chinese"];
    [self.view addSubview:_datePicker];
    _datePicker2=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, PL_HEIGHT-150, PL_WIDTH, 216)];
    _datePicker2.datePickerMode=UIDatePickerModeTime;
    _datePicker2.  backgroundColor=[UIColor whiteColor];
    [_datePicker2 addTarget:self action:@selector(ClickTimer2:)
           forControlEvents:UIControlEventValueChanged ];
    [_datePicker setAccessibilityLanguage:@"Chinese"];
    [self.view addSubview:_datePicker2];
    UIImageView *heng=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, PL_WIDTH,1)];
    heng.image=[UIImage imageNamed:@"heng_hong.png"];
    [self.view addSubview:heng];

    _datePicker2.hidden=YES;
    _datePicker.hidden=YES;
    _StarTextFile.delegate=self;
    _EndTextFile.delegate=self;
    _textView2.delegate=self;
    _textfile1.delegate=self;
    UIButton * lookItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lookItemBtn.frame = CGRectMake(PL_WIDTH-80,10, 100, 30);
    [lookItemBtn setTitle:@"申请历史" forState:UIControlStateNormal];
    lookItemBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [lookItemBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 35, 0, 0)];
    
    [lookItemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lookItemBtn addTarget:self action:@selector(lookClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]initWithCustomView:lookItemBtn];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    _imageAM.hidden=YES;
    _imagePM.hidden=YES;
    
    
    UITapGestureRecognizer*tp=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclcikck)];
    [self.view addGestureRecognizer:tp];
    
    
}
//外出日期选择
- (IBAction)GoToTimer:(id)sender {
    
    if ([_textfile1 resignFirstResponder]) {
        
        self.view.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
        
    }else{
        _datePicker.frame=CGRectMake(0, PL_HEIGHT-216+20, PL_WIDTH, 216);
        
    }
    if ([_textfile1.text isEqualToString:@""]) {
        
        _textfileLabel.text=@"请输入";
    }
    if ([_textView2.text isEqualToString:@""]) {
        _textViewLabel.text=@"请输入";
    }
//    _datePicker.hidden=NO;
//    if (_datePicker2.hidden==NO) {
//        _datePicker.hidden=NO;
//        _datePicker2.hidden=YES;
//        self.view.frame=CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
//    }
    
    
    
    [self clickCalenDar];
    
    
    
    self.SureBut.hidden=YES;
    self.CanlceBut.hidden=YES;
    NSDate*date=_datePicker.date;
    NSDateFormatter*dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    _DateLabel.text=[dateFormatter stringFromDate:date];
    
    _ButLabel.hidden=YES;
    [_datePicker addTarget:self action:@selector(ClickTimer:) forControlEvents:UIControlEventValueChanged];
    [self.textfile1 resignFirstResponder];
    
    [_textView2 resignFirstResponder];
    [_textfile1 resignFirstResponder];
    
}

-(void)clickCalenDar
{
    
    if (!chvc) {
        
        chvc = [[CalendarHomeViewController alloc]init];
        
        chvc.calendartitle = @"日历";
        
        [chvc setAirPlaneToDay:365 ToDateforString:nil];//飞机初始化方法
        
    }
    __block GoOutApplyViewController2  *blockself = self;
    [self presentViewController:chvc animated:YES completion:^{
        chvc.calendarblock = ^(CalendarDayModel *model){
         blockself.DateLabel.text= [NSString stringWithFormat:@"%@",[model toString]];
        };
        
        
    }];
    
    
    
}

//点击后选择指定的日期
-(void)ClickTimer:(id)sender
{
    NSDateFormatter*dateF=[[NSDateFormatter alloc]init];
    [dateF setDateFormat:@"yyyy-MM-dd"];
    _DateLabel.text=[dateF stringFromDate:_datePicker.date];
    _ButLabel.text=@"";;
    
}
-(void)ClickTimer2:(UIDatePicker*)datepicker
{
    
    if (_isFlag==YES) {
        NSDateFormatter*datef=[[NSDateFormatter alloc]init];
        datef.dateFormat=@"HH:mm";
        
        _starlabelshow.text=[datef stringFromDate:_datePicker2.date];
        _SureBut.hidden=NO;
        _CanlceBut.hidden=NO;
        // self.view.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
    }else if (_isFlag==NO)
    {
        NSDateFormatter*datef=[[NSDateFormatter alloc]init];
        datef.dateFormat=@"HH:mm";
        _endLabelShow.text=[datef stringFromDate:_datePicker2.date];
        _SureBut.hidden=NO;
        _CanlceBut.hidden=NO;
        
        //         self.view.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
    }
    
    
    //
}
//PopView
-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 键盘弹出收回
//弹出键盘TextView
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _textViewLabel.text=@"";
    self.view.frame = CGRectMake(0, -200, self.view.frame.size.width, self.view.frame.size.height);
    
    _datePicker.hidden=YES;
    _datePicker2.hidden=YES;
    self.SureBut.hidden=YES;
    self.CanlceBut.hidden=YES;
    
    if ([_textView2.text isEqualToString:@""]) {
        _textViewLabel.text=@"请输入";
    }else
    {
        _textViewLabel.text=@"";
    }
    if ([_textfile1.text isEqualToString:@""]) {
        _textfileLabel.text=@"请输入";
    }else
    {
        _textfileLabel.text=@"";
    }
    return YES;
}

//    弹出键盘TextFile
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField ==_textfile1) {
        if ([_textView2.text isEqualToString:@""]) {
            _textViewLabel.text=@"请输入";
        }else
        {
            _textViewLabel.text=@"";
        }
//        if ([_textfile1.text isEqualToString:@""]) {
//            _textfileLabel.text=@"请输入";
//        }else
//        {
//            _textfileLabel.text=@"";
//        }
        
    }
    _datePicker.hidden=YES;
    _datePicker2.hidden=YES;
    self.view.frame = CGRectMake(0, -160, self.view.frame.size.width, self.view.frame.size.height);
    self.SureBut.hidden=YES;
    self.CanlceBut.hidden=YES;
    return YES;
}
//回车收回键盘
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        self.view.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
        self.SureBut.hidden=NO;
        self.CanlceBut.hidden=NO;
        
        [_textView2 resignFirstResponder];
        if ([_textView2.text isEqualToString:@""]) {
            
            _textViewLabel.text=@"请输入";
        }else
        {
            _textViewLabel.text=@"";
        }
    }
    return YES;
}

//回车收回键盘
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //    _textfileLabel.hidden=NO;
    if ([string isEqualToString:@"\n"]) {
        self.view.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
        [_textfile1 resignFirstResponder];
        self.SureBut.hidden=NO;
        self.CanlceBut.hidden=NO;
    }
    if ([_textView2.text isEqualToString:@""]) {
        _textViewLabel.text=@"请输入";
    }else
    {
        _textViewLabel.text=@"";
    }
    if ([_textfile1.text isEqualToString:@""]) {
        _textfileLabel.text=@"请输入";
    }else
    {
        _textfileLabel.text=@"";
    }
    return YES;
}
//触摸屏幕收回键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _datePicker2.hidden=YES;
    self.SureBut.hidden=NO;
    self.CanlceBut.hidden=NO;
    self.view.frame = CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
    [self.textfile1 resignFirstResponder];
    [_textView2 resignFirstResponder];
    
    if ([_textView2.text isEqualToString:@""]) {
        _textViewLabel.text=@"请输入";
    }else
    {
        _textViewLabel.text=@"";
    }
    if ([_textfile1.text isEqualToString:@""]) {
        _textfileLabel.text=@"请输入";
    }else
    {
        _textfileLabel.text=@"";
    }
    if (_datePicker.hidden==NO) {
        _SureBut.hidden=YES;
        _CanlceBut.hidden=YES;
    }if (![_DateLabel.text isEqualToString:@""]) {
        _datePicker.hidden=YES;
        _SureBut.hidden=NO;
        _CanlceBut.hidden=NO;
    }
    //    if ([_textView2.text isEqualToString:@""]) {
    //        _textfileLabel.text=@"请输入";
    //        _textViewLabel.text=@"请输入";
    //    }if (![_textfile1.text isEqualToString:@""]) {
    //        _textfileLabel.text=@"";
    //
    //    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==_textfile1) {
        _textfileLabel.text=@"";
        if ([_textView2.text isEqualToString:@""]) {
            _textViewLabel.text=@"请输入";
        }else
        {
            _textViewLabel.text=@"";
        }
//        if ([_textfile1.text isEqualToString:@""]) {
//            _textfileLabel.text=@"请输入";
//        }else
//        {
//            _textfileLabel.text=@"";
//        }
//        
    }
    if (textField ==_StarTextFile) {
        [textField resignFirstResponder];
        _isFlag=YES;
        [_textView2 resignFirstResponder];
        [_textfile1 resignFirstResponder];
        
        _datePicker2.hidden=NO;
        NSDateFormatter*datef=[[NSDateFormatter alloc]init];
        datef.dateFormat=@"HH:mm";
        self.view.frame=CGRectMake(0, -100, PL_WIDTH, PL_HEIGHT);
        
        _starlabelshow.text=[datef stringFromDate:_datePicker2.date];
        if (![_starlabelshow.text isEqualToString:@""]) {
            _StarLabel.text=@"";
        }
        
    }
    if (textField==_EndTextFile) {
        [textField resignFirstResponder];
        [_textView2 resignFirstResponder];
        [_textfile1 resignFirstResponder];
        
        self.view.frame=CGRectMake(0,-100, PL_WIDTH, PL_HEIGHT);
        _datePicker2.hidden=NO;
        NSDateFormatter*datef=[[NSDateFormatter alloc]init];
        datef.dateFormat=@"HH:mm";
        _endLabelShow.text=[datef stringFromDate:_datePicker2.date];
        if (![_endLabelShow.text isEqualToString:@""]) {
            _EndLabel.text=@"";
            _isFlag=NO;
        }
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    _textViewLabel.text=@"";
//    if ([_textView2.text isEqualToString:@""]) {
//        _textViewLabel.text=@"请输入";
//    }else
//    {
//        _textViewLabel.text=@"";
//    }
    if ([_textfile1.text isEqualToString:@""]) {
        _textfileLabel.text=@"请输入";
    }else
    {
        _textfileLabel.text=@"";
    }
    
}
#pragma mark 确认申请数据请求
// 确认申请按钮点击事件
- (IBAction)pushin:(id)sender {
    if(_DateLabel.text.length==0)
    {
        PL_ALERT_SHOW(@"请填写外出日期");
    }
    else if([Typeam isEqualToString:@"0"])
    {
        if(_starlabelshow.text.length==0 || _endLabelShow.text.length==0)
        {
            PL_ALERT_SHOW(@"请填写外出时间");
        }
        else if(_textfile1.text.length == 0)
        {
            PL_ALERT_SHOW(@"请填写外出地点");
        }
        else if(_textView2.text.length == 0)
        {
            PL_ALERT_SHOW(@"请填写事由");
        }
        else
        {
            int start = [_starlabelshow.text substringToIndex:2].intValue * 60 + [_starlabelshow.text substringWithRange:NSMakeRange(3, 2)].intValue;
            int end =[_endLabelShow.text substringToIndex:2].intValue * 60 + [_endLabelShow.text substringWithRange:NSMakeRange(3, 2)].intValue;
            if(start>=end)
            {
                PL_ALERT_SHOW(@"结束时间必须大于开始时间");
            }
            else
            {
                [self surePost];
            }
            
        }
    }
    else
    {
        
        if(_textfile1.text.length == 0)
        {
            PL_ALERT_SHOW(@"请填写外出地点");
        }
        else if(_textView2.text.length == 0)
        {
            PL_ALERT_SHOW(@"请填写事由");
        }
        else
        {
            [self surePost];
        }
    }
}
-(void)surePost
{
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]getGoutCommitSaveGoOutUserid:[PL_USER_STORAGE objectForKey:PL_USER_NAME] Token:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] ForgetDate:_DateLabel.text Type:Typeam OutofPlace:_textfile1.text Reason:_textView2.text Summary:@"" StartTime:_starlabelshow.text  EndTime:_endLabelShow.text string:^(NSString *str) {
        PL_PROGRESS_DISMISS;
        if ([str isEqualToString:@"OK"]) {
            PL_ALERT_SHOW(@"申请成功请等待审核");
            _textfile1.text = @"";
            _textView2.text = @"";
            _DateLabel.text=@"";
            _StarTextFile.text=@"";
            _EndTextFile.text=@"";
            _ButLabel.hidden=NO;
            _ButLabel.text=@"请选择";
            _StarLabel.text=@"请选择";
            _EndLabel.text=@"请选择";
            _starlabelshow.text=@"";
            _endLabelShow.text=@"";
            
            _textViewLabel.text=@"请输入";
            _textfileLabel.text=@"请输入";
            
        }else if([str isEqualToString:@"1"]  ){
            PL_ALERT_SHOW(@"员工号不能为空");
        }else if([str isEqualToString:@"2"]  ){
            PL_ALERT_SHOW(@"员工姓名不能为空");
        }else if([str isEqualToString:@"3"]  ){
            PL_ALERT_SHOW(@"申请日期不能为空");
            
        }else if([str isEqualToString:@"4"]  ){
            PL_ALERT_SHOW(@"申请日期格式有误");
            
        }else if([str isEqualToString:@"5"]  ){
            PL_ALERT_SHOW(@"申请日期输入有误");
            
        }else if([str isEqualToString:@"6"]  ){
            PL_ALERT_SHOW(@"申请日期不能选择1天以前的日期");
        }else if([str isEqualToString:@"7"]  ){
            PL_ALERT_SHOW(@"申请日期不能选择7天以后的日期");
            
        }else if([str isEqualToString:@"8"]  ){
            PL_ALERT_SHOW(@"外出地点不能为空");
        }else if([str isEqualToString:@"9"]  ){
            PL_ALERT_SHOW(@"外出事由不能为空");
            
        }else if([str isEqualToString:@"10"]  ){
            PL_ALERT_SHOW(@"保存数据失败");
            
        }else if([str isEqualToString:@"11"]  ){
            PL_ALERT_SHOW(@"保存数据出错");
        }else if([str isEqualToString:@"12"]  ){
            PL_ALERT_SHOW(@"流程发起失败");
            
        }else if([str isEqualToString:@"14"]  ){
            PL_ALERT_SHOW(@"数据更新失败，请联系IT部");
            
        }else if([str isEqualToString:@"15"]  ){
        PL_ALERT_SHOW(@"已经有此条信息，不能重复申请");
        
        }else if([str isEqualToString:@"16"]  ){
            PL_ALERT_SHOW(@"不能申请未发生的豁免");
            
        }
     
    }];
    
}


 //取消申请点击事件
- (IBAction)canclecBut:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//查看申请历史点击事件
-(void)lookClick
{
    GoOutApplyListViewController *vc = [[GoOutApplyListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)goOutAction:(id)sender {
    
    
    
    self.title=@"外出申请";
    Typeam = @"0";
    _StarTimerLabel.text=@"开始时间";
    _EngTimerLabel.text=@"结束时间";
    _image1.image = [UIImage imageNamed:@"radio-button_on33.png"];
    _image2.image = [UIImage imageNamed:@"radio-button_off33.png"];
    _imageAM.hidden=YES;
    _imagePM.hidden=YES;
    _StarLabel.hidden=NO;
    _EndLabel.hidden=NO;
    _StarTextFile.enabled=YES;
    _EndTextFile.enabled=YES;
    _AmImage.hidden=YES;
    _Pmimage.hidden=YES;
    _endLabelShow.hidden=NO;
    _starlabelshow.hidden=NO;
    _starlabelshow.text=@"";
    _endLabelShow.text=@"";
    
    
}

- (IBAction)specialAction:(id)sender {
    self.title=@"特殊豁免申请";
    Typeam = @"1";
    _StarTimerLabel.text=@"上午外出";
    _EngTimerLabel.text=@"下午外出";
    _image2.image = [UIImage imageNamed:@"radio-button_on33.png"];
    _image1.image = [UIImage imageNamed:@"radio-button_off33.png"];
    _AmImage.image=[UIImage imageNamed:@"checked33.png"];
    _Pmimage.image=[UIImage imageNamed:@"no_checked.png"];
    _imageAM.hidden=NO;
    _imagePM.hidden=NO;
    _AmImage.hidden=NO;
    _Pmimage.hidden=NO;
    _StarLabel.hidden=YES;
    _EndLabel.hidden=YES;
    _StarTextFile.enabled=NO;
    _EndTextFile.enabled=NO;
    _endLabelShow.hidden=YES;
    _starlabelshow.hidden=YES;
    
    _textView2.text=@"";
    _textfile1.text=@"";
    _DateLabel.text=@"";
    _StarTextFile.text=@"";
    _EndTextFile.text=@"";
    _ButLabel.hidden=NO;
    _ButLabel.text=@"请选择";
    _StarLabel.text=@"请选择";
    _EndLabel.text=@"请选择";
    _textfileLabel.text=@"请选择";
    _textViewLabel.text=@"请选择";
    
    
    
}
- (IBAction)StarButImage:(UIButton *)sender {
    
    if (sender.selected==NO) {
        Typeam=@"1";
    }
    _AmImage.image=[UIImage imageNamed:@"checked33.png"];
    
    _Pmimage.image=[UIImage imageNamed:@"no_checked.png"];
    NSLog(@">>>>>>>%@",Typeam);
}
- (IBAction)EndButImage:(UIButton *)sender {
    
    if (sender.selected==NO) {
        Typeam=@"2";
    }
    _Pmimage.image=[UIImage imageNamed:@"checked33.png"];
    _AmImage.image=[UIImage imageNamed:@"no_checked.png"];
    NSLog(@">>>>>>>%@",Typeam);
}
-(void)tapclcikck
{
    [_textfile1 resignFirstResponder];
    [_textView2 resignFirstResponder];
}
 @end
