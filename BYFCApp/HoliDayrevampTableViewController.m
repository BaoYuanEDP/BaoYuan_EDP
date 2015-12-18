//
//  HoliDayrevampTableViewController.m
//  BYFCApp
//
//  Created by 王鹏 on 15/8/27.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "HoliDayrevampTableViewController.h"
#import "PL_Header.h"
@interface HoliDayrevampTableViewController ()<UITextFieldDelegate>
{
//    弹出的主视图
    UIView*MainView;
    UITextField*StarTextFiled;
    UITextField*EndTextFiled;
    UIDatePicker*datePicker;
    UITableView*tableviewSub;
    UIButton*AccBut;
      UIButton*AccBut2;
    UITableViewCell*SubCel;
}

@end

@implementation HoliDayrevampTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.scrollEnabled=NO;
   self.title=@"假期调整";
    UIButton*leftBut=[[UIButton alloc]initWithFrame: CGRectMake(20, 10, 10, 20)];
    [leftBut setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
        [leftBut addTarget:self action:@selector(BackView) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem*barBut=[[UIBarButtonItem alloc]initWithCustomView:leftBut];
        self.navigationItem.leftBarButtonItem=barBut;
    
    
    }
-(void)BackView
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView==tableviewSub) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==tableviewSub) {
        return 10;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.text=@"ssd";
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (tableView==self.tableView) {
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                self.Cell1.selectionStyle=UITableViewCellSelectionStyleNone;
                return self.Cell1;
            }
            
        }

    }
       if (tableView==tableviewSub) {
           SubCel=[tableView dequeueReusableCellWithIdentifier:@"Cell" ];
           if (SubCel==nil) {
            SubCel=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            SubCel.textLabel.text=@"djdj";
              SubCel.selectionStyle=UITableViewCellSelectionStyleNone;
               AccBut=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH-100, 5, 20, 20)];
                [AccBut setBackgroundImage:[UIImage imageNamed:@"no_checked33.png" ] forState:UIControlStateNormal];
               
               [AccBut addTarget:self action:@selector(checkBut:) forControlEvents:UIControlEventTouchUpInside];
               [SubCel addSubview:AccBut];
               AccBut2=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH-25, 5, 20, 20)];
               [AccBut2 setBackgroundImage:[UIImage imageNamed:@"no_checked33.png" ] forState:UIControlStateNormal];
               [AccBut2 addTarget:self action:@selector(checkBut:) forControlEvents:UIControlEventTouchUpInside];
               [SubCel addSubview:AccBut2];
               UILabel*MorningLabel=[[UILabel alloc]initWithFrame:CGRectMake(PL_WIDTH-140, 5, 40, 20)];
               MorningLabel.text=@"上午";
               [SubCel addSubview:MorningLabel];
               UILabel*afternoonLabel=[[UILabel alloc]initWithFrame:CGRectMake(PL_WIDTH-70, 5, 40, 20)];
               afternoonLabel.text=@"下午";
               [SubCel addSubview:afternoonLabel];
               AccBut.tag=indexPath.row;
              AccBut2.tag=indexPath.row;
           
               
           }
           
      
        return SubCel;
    }
    
    
    return cell;
}
-(void)checkBut:(UIButton*)sender
{
    
    NSLog(@">>%ld",(long)sender.tag);
    
    if (sender.tag==0) {
       if (!sender.selected) {
            [sender setBackgroundImage:[UIImage imageNamed:@"checked33.png" ] forState:UIControlStateSelected ];
              }
        sender.selected=!sender.selected;
    }
    if (sender.tag) {
        if (!sender.selected) {
            [sender setBackgroundImage:[UIImage imageNamed:@"checked33.png" ] forState:UIControlStateSelected ];
            
            
        }
        sender.selected=!sender.selected;
    }
    

    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tableView) {
        switch (indexPath.row) {
            case 0:
                return 80;
                break;
            case 1:
                return 45;
            default:
                break;
        }

    }
        return 40;
    
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView==self.tableView) {
        switch (section) {
            case 0:
                return @"假期修改";
                break;
            case 1:
                return @"销假";
            default:
                break;
        }

    }
       return @"";
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==tableviewSub) {
        return 1;
    }
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(void)InitPopView
{
    MainView=[[UIView alloc]initWithFrame:CGRectMake(0, PL_HEIGHT+10, PL_WIDTH, PL_HEIGHT/2)];
    MainView.backgroundColor=[UIColor whiteColor];
        tableviewSub=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainView.frame.size.width, PL_HEIGHT-56) style:UITableViewStylePlain];
    tableviewSub.bounces=YES;
    tableviewSub.delegate=self;
    tableviewSub.dataSource=self;
    tableviewSub.backgroundColor=[UIColor clearColor];
    [MainView addSubview:tableviewSub];
    [self.view addSubview:MainView];
     UIButton*AllSure=[[UIButton alloc]initWithFrame:CGRectMake(0, PL_HEIGHT-120, MainView.frame.size.width/3, 56)];
          AllSure.backgroundColor=[UIColor grayColor];
    [AllSure setTitle:@"全选" forState: UIControlStateNormal];
      [AllSure addTarget:self action:@selector(selectBut:) forControlEvents:UIControlEventTouchUpInside];
    AllSure.tag=201;
    [AllSure setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [MainView addSubview:AllSure];
    UIButton*ButSure=[[UIButton alloc]initWithFrame:CGRectMake(AllSure.frame.size.width+2,PL_HEIGHT-120, MainView.frame.size.width/3, 56)];
      [ButSure setTitle:@"确定" forState: UIControlStateNormal];
    [ButSure addTarget:self action:@selector(selectBut:) forControlEvents:UIControlEventTouchUpInside];
    ButSure.backgroundColor=[UIColor grayColor];
    ButSure.tag=202;
      [ButSure setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [MainView addSubview:ButSure];
    UIButton*ButCanle=[[UIButton alloc]initWithFrame:CGRectMake(ButSure.frame.size.width+AllSure.frame.size.width+4, PL_HEIGHT-120, MainView.frame.size.width/3, 56)];
      [ButCanle setTitle:@"取消" forState: UIControlStateNormal];
      [ButCanle addTarget:self action:@selector(selectBut:) forControlEvents:UIControlEventTouchUpInside];
    ButCanle.backgroundColor=[UIColor grayColor];
    ButCanle.tag=203;
      [ButCanle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [MainView addSubview:ButCanle];

    
    
    
    

}
-(void)initdestroyholiDayTabelView
{

    
    
    
    
    
    
    
    
    
    
}
-(void)selectBut:(UIButton*)send
{
    if (send.tag==201) {
           NSLog(@"全选");
    }else if (send.tag==202)
    {
        NSLog(@"确定");

        [MainView removeFromSuperview];
        
        
    }else if(send.tag==203)
    {
        NSLog(@"取消");
        [MainView removeFromSuperview];

    }
    
    
    
}
-(void)INITpoPvIEW2
{
    MainView=[[UIView alloc]initWithFrame:CGRectMake(0, PL_HEIGHT+10, PL_WIDTH, PL_HEIGHT/2)];
    MainView.backgroundColor=[UIColor whiteColor];
    datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0 ,PL_HEIGHT-216-120, MainView.frame.size.width, 216)];
    datePicker.backgroundColor=[UIColor whiteColor];
    [datePicker addTarget:self  action:@selector(datePickerTimer:) forControlEvents:UIControlEventValueChanged];
    [MainView  addSubview:datePicker];
    StarTextFiled=[[UITextField alloc]initWithFrame:CGRectMake(MainView.frame.size.width-280-60, 50, MainView.frame.size.width-80, 40)];
    StarTextFiled.delegate=self;
    NSDateFormatter*datef=[[NSDateFormatter alloc ]init];
    datef.dateFormat=@"yyyy 年 MM 月 dd HH 时 mm";
   
    StarTextFiled.text=[NSString stringWithFormat:@"假期开始  %@",[datef stringFromDate:datePicker.date]];

    StarTextFiled.borderStyle=UITextBorderStyleRoundedRect;
        [MainView addSubview:StarTextFiled];
    EndTextFiled=[[UITextField alloc]initWithFrame:CGRectMake(MainView.frame.size.width-280-60,150, MainView.frame.size.width-80, 40)];
    EndTextFiled.delegate=self;
    EndTextFiled.text=[NSString stringWithFormat:@"假期结束  %@",[datef stringFromDate:datePicker.date]];

    EndTextFiled.borderStyle=UITextBorderStyleRoundedRect;
    [MainView addSubview:EndTextFiled];
    UIButton*ButSure=[[UIButton alloc]initWithFrame:CGRectMake(0, PL_HEIGHT-120, MainView.frame.size.width/3, 56)];
    [ButSure setTitle:@"确定" forState: UIControlStateNormal];
    [ButSure addTarget:self action:@selector(selectBut2:) forControlEvents:UIControlEventTouchUpInside];
    ButSure.backgroundColor=[UIColor grayColor];
    ButSure.tag=208;
    [ButSure setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [MainView addSubview:ButSure];
    UIButton*ButCanle=[[UIButton alloc]initWithFrame:CGRectMake(ButSure.frame.size.width*2, PL_HEIGHT-120, MainView.frame.size.width/3, 56)];
    [ButCanle setTitle:@"取消" forState: UIControlStateNormal];
    [ButCanle addTarget:self action:@selector(selectBut2:) forControlEvents:UIControlEventTouchUpInside];
    ButCanle.backgroundColor=[UIColor grayColor];
    ButCanle.tag=209;
    [ButCanle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [MainView addSubview:ButCanle];
         [self.view addSubview:MainView];
    
    
}
-(void)selectBut2:(UIButton*)send
{
    if (send.tag==208) {
        NSLog(@"JI确定");
        [MainView removeFromSuperview];
    }else if(send.tag==209)
    {
        
        NSLog(@"ji取消");
        [MainView removeFromSuperview];

    }
    
    
}

-(void)datePickerTimer:(UIDatePicker*)datep
{
    NSDate*date2=datep.date;
    NSDateFormatter*datef=[[NSDateFormatter alloc ]init];
    datef.dateFormat=@"yyyy 年 MM 月 dd HH 时 mm";
    
   
    if ([StarTextFiled endEditing:NO]) {
      StarTextFiled.text=[NSString stringWithFormat:@"假期开始  %@",[datef stringFromDate:date2]];
    }
    if([EndTextFiled endEditing:NO])
    {
        EndTextFiled.text=[NSString stringWithFormat:@"假期结束  %@",[datef stringFromDate:date2]];
        NSLog(@"dhhd");
        
    }
    
    
    
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*CELL=[tableView cellForRowAtIndexPath:indexPath];
    if (tableView==self.tableView) {
        if (indexPath.section==1) {
            if (indexPath.row==0) {
                [self InitPopView];
                [UIView animateWithDuration:0.6 animations:^{
                    
                    MainView.frame=CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
                }];
                
            }
        }else if (indexPath.section==0)
        {
            if (indexPath.row==0) {
                
                [self INITpoPvIEW2];
                
                [UIView animateWithDuration:0.6 animations:^{
                    
                    MainView.frame=CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
                    
                }];
            }
        }

    }
    
    NSLog(@"点击到cell");
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
 
    [textField resignFirstResponder];
    NSLog(@"键盘操作");
    
}
@end
