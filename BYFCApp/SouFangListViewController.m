//
//  SouFangListViewController.m
//  BYFCApp
//
//  Created by zzs on 15/4/2.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "SouFangListViewController.h"
#import "PL_Header.h"
#import "SinaVC.h"
static UIButton *selectBtn4;
@interface SouFangListViewController ()

@end

@implementation SouFangListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"端口申请";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBarHidden=NO;
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    _button=[[UIButton alloc]initWithFrame:CGRectMake(100, 70, PL_WIDTH-200, 30)];
    [_button setImage:[UIImage imageNamed:@"搜房网logo33.png"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(webClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_button.frame)+5, PL_WIDTH, 1)];
    image.image=[UIImage imageNamed:@"heng_hui_duan.png"];
    [self.view addSubview:image];
    
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, PL_HEIGHT-50, PL_WIDTH, 50)];
    view.backgroundColor=[UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1];
    [self.view addSubview:view];
    
    UIButton *sure=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH*2/3, 50)];
    sure.backgroundColor=[UIColor colorWithRed:77.0/255.0 green:170.0/255.0 blue:37.0/255.0 alpha:1];
    [sure setTitle:@"确定" forState:UIControlStateNormal];
    [sure addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:sure];
    UIButton *cancle=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH*2/3, 0, PL_WIDTH/3, 50)];
    cancle.backgroundColor=[UIColor colorWithRed:233.0/255.0 green:110.0/255.0 blue:10.0/255.0 alpha:1];
    [cancle setTitle:@"重选" forState:UIControlStateNormal];
    [cancle addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancle];
    table=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame), PL_WIDTH, PL_HEIGHT-114-50+5) style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    //table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, table.bounds.size.width, 0.01f)];
    [self.view addSubview:table];
    if ([table respondsToSelector:@selector(setSeparatorInset:)]) {
        [table setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([table respondsToSelector:@selector(setLayoutMargins:)]) {
        [table setLayoutMargins:UIEdgeInsetsZero];
    }
    
    bgView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_button.frame), PL_WIDTH, PL_HEIGHT)];
    bgView.backgroundColor=[UIColor colorWithRed:109.0/255.0 green:109.0/255.0 blue:109.0/255.0 alpha:0.9];
    bgView.hidden=YES;
    [self.view addSubview:bgView];
    
    //table2=[[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_button.frame)-5, 0, _button.frame.size.width+10, _button.frame.size.height*9-5)];
    table2=[[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_button.frame)-5, 0, _button.frame.size.width+10, _button.frame.size.height*9-5) style:UITableViewStylePlain];
    table2.delegate=self;
    table2.dataSource=self;
    [bgView addSubview:table2];
    
    if ([table2 respondsToSelector:@selector(setSeparatorInset:)]) {
        [table2 setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([table2 respondsToSelector:@selector(setLayoutMargins:)]) {
        [table2 setLayoutMargins:UIEdgeInsetsZero];
    }
    [self request];
}
-(void)request
{
    PL_PROGRESS_SHOW;
    [[MyRequest defaultsRequest]GetWebSiteList:^(NSMutableString *string) {
        NSLog(@"string=====%@",string);
        requeStr=string;
        if ([string isEqualToString:@"[]"]) {
            PL_ALERT_SHOW(@"暂无数据");
        }
        else if ([string isEqualToString:@"exception"]) {
            PL_ALERT_SHOW(@"服务器异常");
        }
        else  if ([string isEqualToString:@"NOLOGIN"]) {
            ViewController *login=[[ViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
        else
        {
            SBJSON *json=[[SBJSON alloc]init];
            array=[json objectWithString:string error:nil];
            NSLog(@"%luqqqqqqqqq",(unsigned long)array.count);
        }
        PL_PROGRESS_DISMISS;
        [table reloadData];
    } WebSiteMode:_string userid:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME] token:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN]];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==table2) {
        return 6;
    }
    else
    {
        return array.count;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==table2) {
        return 44;
    }
    else
    {
        return 100;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==table2) {
        static NSString *str2=@"cell2";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str2];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str2];
        }
        NSArray *imageArr=[NSArray arrayWithObjects:[UIImage imageNamed:@"搜房网logo33.png"],[UIImage imageNamed:@"sinaLOGO33.png"],[UIImage imageNamed:@"anjuke_SH33.png"],[UIImage imageNamed:@"anjuke_ks33.png"],[UIImage imageNamed:@"58LOGO33.png"],[UIImage imageNamed:@"GanJilogo33.png"], nil];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, _button.frame.size.width, _button.frame.size.height)];
        imageView.image=imageArr[indexPath.row];
        [cell addSubview:imageView];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        NSString *str = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
        WebCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell=[[WebCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            
        }
        [cell.button setBackgroundImage:[UIImage imageNamed:@"no_checked33.png"] forState:UIControlStateNormal];
        [cell.button setBackgroundImage:[UIImage imageNamed:@"checked33.png"] forState:UIControlStateSelected];
        cell.lab1.text=@"";
        cell.lab2.text=@"";
        cell.lab3.text=@"";
        cell.lab33.text=@"";
        cell.lab4.text=@"";
        cell.lab5.text=@"";
        cell.lab6.text=@"";
        cell.lab7.text=@"";
        cell.lab1.hidden=NO;
        cell.lab2.hidden=NO;
        cell.lab3.hidden=NO;
        cell.lab33.hidden=NO;
        cell.lab4.hidden=NO;
        cell.lab5.hidden=NO;
        cell.lab6.hidden=NO;
        cell.lab7.hidden=NO;
        cell.button.hidden=NO;
        dic=[array objectAtIndex:indexPath.row];
        cell.lab1.text=[NSString stringWithFormat:@"编号：%@",[dic objectForKey:@"PackageID"]];
        cell.lab2.text=[NSString stringWithFormat:@"急售房：%@",[dic objectForKey:@"HRJiShouIcon"]];
        cell.lab3.text=[NSString stringWithFormat:@"放心房：%@",[dic objectForKey:@"HRFangXinIcon"]];
        cell.lab4.text=[NSString stringWithFormat:@"店铺房源：%@",[dic objectForKey:@"HRCount"]];
        cell.lab5.text=[NSString stringWithFormat:@"新推房：%@",[dic objectForKey:@"HRXinTuiIcon"]];
        cell.lab6.text=[NSString stringWithFormat:@"新房免佣：%@",[dic objectForKey:@"HRXinFangMY"]];
        cell.lab33.text=[NSString stringWithFormat:@"套餐价格(元/月)：%@",[dic objectForKey:@"PackagePrice"]];
        cell.lab7.text=[NSString stringWithFormat:@"刷新次数(次/天)：%@",[dic objectForKey:@"HRRefreshCount"]];
        
        [cell.button addTarget:self action:@selector(selectClick4:) forControlEvents:UIControlEventTouchUpInside];
        cell.button.tag=indexPath.row;
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==table2) {
        bgView.hidden=YES;
        selectBtn4.selected=NO;
        if (indexPath.row==0) {
            _string=@"搜房网";
            
            [_button setImage:[UIImage imageNamed:@"搜房网logo33.png"] forState:UIControlStateNormal];
            SouFangListViewController *sf=[[SouFangListViewController alloc]init];
            sf.string=@"搜房网";
            [self.navigationController pushViewController:sf animated:NO];
        }
        else if (indexPath.row==1)
        {
            //PL_ALERT_SHOW(@"数据异常");
            _string=@"新浪网";
            
            [_button setImage:[UIImage imageNamed:@"sinaLOGO33.png"] forState:UIControlStateNormal];
            SinaListViewController *sinaL=[[SinaListViewController alloc]init];
            sinaL.string=@"新浪网";
            [self.navigationController pushViewController:sinaL animated:NO];
            // [self request];
        }
        else if (indexPath.row==2)
        {
            _string=@"上海安居客";
            
            [_button setImage:[UIImage imageNamed:@"anjuke_SH33.png"] forState:UIControlStateNormal];
            SHViewController *sh=[[SHViewController alloc]init];
            sh.string=@"上海安居客";
            [self.navigationController pushViewController:sh animated:NO];
        }
        else if (indexPath.row==3)
        {
            _string=@"昆山安居客";
            
            [_button setImage:[UIImage imageNamed:@"anjuke_ks33.png"] forState:UIControlStateNormal];
            KSListViewController *ks=[[KSListViewController alloc]init];
            ks.string=@"昆山安居客";
            [self.navigationController pushViewController:ks animated:NO];
        }
        else if (indexPath.row==4)
        {
            _string=@"58同城网";
            
            [_button setImage:[UIImage imageNamed:@"58LOGO33.png"] forState:UIControlStateNormal];
            TCListViewController *tc=[[TCListViewController alloc]init];
            tc.string=@"58同城网";
            [self.navigationController pushViewController:tc animated:NO];
        }
        else if (indexPath.row==5)
        {
            _string=@"赶集网";
            
            [_button setImage:[UIImage imageNamed:@"GanJilogo33.png"] forState:UIControlStateNormal];
            GJListViewController *gj=[[GJListViewController alloc]init];
            gj.string=@"赶集网";
            [self.navigationController pushViewController:gj animated:NO];
        }
    }
}

-(void)selectClick4:(UIButton *)sender
{
    if (sender!=selectBtn4) {
        selectBtn4.selected=NO;
        selectBtn4=sender;
    }
    selectBtn4.selected=YES;
    NSLog(@"%ld",(long)selectBtn4.tag);
}

-(void)sureClick
{
    if (selectBtn4.selected)
    {
        SinaVC *sou=[[SinaVC alloc]init];
        sou.dict=[array objectAtIndex:selectBtn4.tag];
        [self.navigationController pushViewController:sou animated:YES];
    }
    else
    {
        PL_ALERT_SHOW(@"请选择一种套餐");
    }
    
}

-(void)cancleClick
{
    selectBtn4.selected=NO;
}

-(void)webClick:(UIButton *)sender
{
    
    bgView.hidden=NO;
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    bgView.hidden=YES;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)returnClick
{
    
    NSArray *temArray = self.navigationController.viewControllers;
    for(UIViewController *temVC in temArray)
    {
        if ([temVC isKindOfClass:[PortViewController class]])
        {
            [self.navigationController popToViewController:temVC animated:YES];
        }
    }
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
