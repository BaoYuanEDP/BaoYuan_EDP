//
//  ApplyViewController.m
//  BYFCApp
//
//  Created by zzs on 15/1/19.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "ApplyViewController.h"
#import "PL_Header.h"
#import "HoliDayEdityViewController.h"
#import "GoOutApplyViewController2.h"
#import "XJViewController.h"
#import "ApplyTrainingViewController.h"
@interface ApplyViewController ()


@end

@implementation ApplyViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)])
//    {
//        [[UIDevice currentDevice] performSelector:@selector(setOrientation:) withObject:(__bridge id)((void *)UIInterfaceOrientationPortrait)];
//        
//    }
    
    
}
- (void)viewDidLayoutSubviews
{


}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"申请类别";
   
    self.navigationController.navigationBarHidden=NO;
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    // backItemBnt.backgroundColor=[UIColor redColor];
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    // [navView addSubview:backItemBnt];
                                                                                                                                                                                                                                                                                                                                                                                                                                             
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    UITableView *table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT) style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    table.scrollEnabled=NO;
    [self.view addSubview:table];
    
    //array=[NSArray arrayWithObjects:@"招聘及人事管理系统",@"网络端口申请",@"名片申请",@"休假申请", nil];
    //@"端口报名系统",
    array=[NSArray arrayWithObjects:@"名片申请",@"网络端口申请",@"请假申请", @"外出及特殊豁免申请",@"销假申请",@"请假修改",@"培训申请",nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"string";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(PL_WIDTH-30, 10, 15, 20)];
        image.image=[UIImage imageNamed:@"BYright.png"];
        [cell addSubview:image];
    }
    cell.textLabel.text=[array objectAtIndex:indexPath.row];
    //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
   cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"选择您的申请类别:";
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        CardViewController *cear = [[CardViewController alloc] initWithNibName:@"CardViewController" bundle:nil];
        [self.navigationController pushViewController:cear animated:YES];
    }
    if (indexPath.row==1) {
        //PL_ALERT_SHOW(@"功能未完善");
        [self.navigationController pushViewController:[PortViewController new] animated:YES];
    }
    else if (indexPath.row==2)
    {

//        [self.navigationController pushViewController:[NewHolidayViewController new] animated:YES];
//        [self.navigationController pushViewController:[NewHolidayViewController2 new ] animated:YES];
        [self.navigationController pushViewController:[HolidayViewController new ] animated:YES];

    }
    else if (indexPath.row == 3)
    {
        [self.navigationController pushViewController:[GoOutApplyViewController2 new ] animated:YES];
    }else if (indexPath.row==4)
    {
        [self.navigationController pushViewController:[HoliDayEdityViewController new]animated:YES];
    }else if (indexPath.row == 5)
    {
//        [self.navigationController pushViewController:[XJViewController new ] animated:YES];
        HolidayListViewController *vc =[[HolidayListViewController alloc] init];
        vc.modeStr = @"1";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==6)
    {
        [self.navigationController pushViewController:[ApplyTrainingViewController new] animated:YES];
    }
}
-(void)holidayRequest
{
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation== UIInterfaceOrientationPortrait;
    
}
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskPortrait;
//}
- (BOOL)shouldAutorotate
{
    return YES;
    
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
