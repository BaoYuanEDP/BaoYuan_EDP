//
//  SHViewController.m
//  BYFCApp
//
//  Created by zzs on 15/3/2.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "SHViewController.h"
#import "PL_Header.h"
static UIButton *selectBtn1;
static UIButton *selectBtn2;
static UIButton *selectBtn3;
static UIButton *selectBtn4;
@interface SHViewController ()

@end

@implementation SHViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    selectArr=[[NSMutableArray alloc]initWithCapacity:0];
    self.treeOpenArray = [NSMutableArray array];
    self.rowListTitle = [NSString stringWithFormat:@"country"];
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
    //_button.backgroundColor=[UIColor redColor];
    [_button setImage:[UIImage imageNamed:@"anjuke_SH33.png"] forState:UIControlStateNormal];
    /*
    if ([_string isEqualToString:@"上海安居客"]) {
        [_button setImage:[UIImage imageNamed:@"anjuke_SH33.png"] forState:UIControlStateNormal];
    }
    else if ([_string isEqualToString:@"昆山安居客"])
    {
        [_button setImage:[UIImage imageNamed:@"anjuke_ks33.png"] forState:UIControlStateNormal];
    }
    else if ([_string isEqualToString:@"新浪网"])
    {
        [_button setImage:[UIImage imageNamed:@"sinaLOGO33.png"] forState:UIControlStateNormal];
    }
    else if ([_string isEqualToString:@"搜房网"])
    {
        [_button setImage:[UIImage imageNamed:@"搜房网logo33.png"] forState:UIControlStateNormal];
        //[table removeFromSuperview];
        
    }
    else if ([_string isEqualToString:@"58同城网"])
    {
        [_button setImage:[UIImage imageNamed:@"58LOGO33.png"] forState:UIControlStateNormal];
    }
    else if ([_string isEqualToString:@"赶集网"])
    {
        [_button setImage:[UIImage imageNamed:@"GanJilogo33.png"] forState:UIControlStateNormal];
    }
     */
    //[_button setImage:[UIImage imageNamed:@"anjuke_SH33.png"] forState:UIControlStateNormal];
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
    //[self request];
    
   
    
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
    _typeArr1=[[NSMutableArray alloc]initWithCapacity:0];
    _typeArr2=[[NSMutableArray alloc]initWithCapacity:0];
    _typeArr3=[[NSMutableArray alloc]initWithCapacity:0];
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
            
            for (int i=0; i<array.count; i++) {
                NSDictionary *dict=[array objectAtIndex:i];
                if ([[dict objectForKey:@"Type"]isEqualToString:@"1"]) {
                    [_typeArr1 addObject:dict];
                    NSMutableDictionary *dicts = [NSMutableDictionary dictionaryWithObject:_typeArr1 forKey:self.rowListTitle];
                    NSLog(@"%@",dicts);
                }
                else if ([[dict objectForKey:@"Type"]isEqualToString:@"2"])
                {
                    [_typeArr2 addObject:dict];
                    NSMutableDictionary *dicts1 = [NSMutableDictionary dictionaryWithObject:_typeArr2 forKey:self.rowListTitle];
                    NSLog(@"%@",dicts1);
                }
                else
                {
                    [_typeArr3 addObject:dict];
                    NSMutableDictionary *dicts2 = [NSMutableDictionary dictionaryWithObject:_typeArr3 forKey:self.rowListTitle];
                    NSLog(@"%@",dicts2);
                }
            }
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
        if (section==2) {
            NSString *tempSectionString = [NSString stringWithFormat:@"%ld",(long)section];
            if ([self.treeOpenArray containsObject:tempSectionString]) {
                return _typeArr3.count;
            }
            return 0;
        }
        else if(section==0)
        {
            NSString *tempSectionString = [NSString stringWithFormat:@"%ld",(long)section];
            if ([self.treeOpenArray containsObject:tempSectionString]) {
               return _typeArr1.count;
            }
            return 0;
        }
        else
        {
            NSString *tempSectionString = [NSString stringWithFormat:@"%ld",(long)section];
            if ([self.treeOpenArray containsObject:tempSectionString]) {
                return _typeArr2.count;
            }
            return 0;
        }
        /*
        if ([_string isEqualToString:@"上海安居客"])
        {
            if (section==2) {
                return typeArr3.count;
            }
            else if(section==0)
            {
                return typeArr1.count;
            }
            else
            {
                return typeArr2.count;
            }
            
        }
        else
        {
            return array.count;
        }
       */
    }
   
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==table)
    {
        /*
        if ([_string isEqualToString:@"上海安居客"]) {

            return 80;
        }
        else if ([_string isEqualToString:@"昆山安居客"])
        {
            return 80;
        }
        else if ([_string isEqualToString:@"搜房"])
        {
            return 44;
        }
        else if ([_string isEqualToString:@"58同城"])
        {
            return 100;
        }
        else if ([_string isEqualToString:@"新浪"])
        {
            return 100;
        }
        else
        {
            return 100;
        }
         */
        return 80;
    }
    else
    {
        return 44;
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
        WebCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SubCell"];
        if (!cell) {
            cell=[[WebCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SubCell"];
            
        }
        [cell.button setBackgroundImage:[UIImage imageNamed:@"no_checked33.png"] forState:UIControlStateNormal];
        [cell.button setBackgroundImage:[UIImage imageNamed:@"checked33.png"] forState:UIControlStateSelected];
        //cell.selectionStyle=UITableViewCellSelectionStyleNone;
        /*
        if ([_string isEqualToString:@"上海安居客"]) {
             indexSection=indexPath.section;
            
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
            cell.lab33.hidden=YES;
            cell.lab4.hidden=NO;
            cell.lab5.hidden=NO;
            cell.lab6.hidden=NO;
            cell.lab7.hidden=YES;
            cell.button.hidden=NO;
            
            NSLog(@"%@",[dic objectForKey:@"PackageType"]);
           
            if (indexPath.section==0) {
                dic=[typeArr1 objectAtIndex:indexPath.row];
            }
            else
            {
                 dic=[typeArr3 objectAtIndex:indexPath.row];
            }
            
            cell.lab1.text=[dic objectForKey:@"PackageID"];
            cell.lab2.text=[NSString stringWithFormat:@"定价房源：%@",[dic objectForKey:@"HRDingJiaCount"]];
            cell.lab3.text=[NSString stringWithFormat:@"充值要求：%@",[dic objectForKey:@"PayDemand"]];
            cell.lab4.text=[NSString stringWithFormat:@"库存：%@",[dic objectForKey:@"HRCount"]];
            cell.lab5.text=[NSString stringWithFormat:@"竞价房源：%@",[dic objectForKey:@"HRJingJiaCount"]];
            cell.lab6.text=[NSString stringWithFormat:@"价格(元/月)：%@",[dic objectForKey:@"PackagePrice"]];
            
            
            if (indexPath.section==0) {
                [cell.button addTarget:self action:@selector(selectClick1:) forControlEvents:UIControlEventTouchUpInside];
                cell.button.tag=indexPath.row;
            }
            else if(indexPath.section==1)
            {
                [cell.button addTarget:self action:@selector(selectClick2:) forControlEvents:UIControlEventTouchUpInside];
                cell.button.tag=indexPath.row;
            }
            else
            {
                [cell.button addTarget:self action:@selector(selectClick3:) forControlEvents:UIControlEventTouchUpInside];
                cell.button.tag=indexPath.row;
            }
        }
        else if ([_string isEqualToString:@"昆山安居客"])
        {
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
            cell.lab33.hidden=YES;
            cell.lab4.hidden=NO;
            cell.lab5.hidden=NO;
            cell.lab6.hidden=YES;
            cell.lab7.hidden=YES;
            cell.button.hidden=NO;
            dic=[array objectAtIndex:indexPath.row];
            
            cell.lab1.text=[NSString stringWithFormat:@"编号：%@",[dic objectForKey:@"PackageID"]];
            cell.lab2.text=[NSString stringWithFormat:@"出租房源(套)：%@",[dic objectForKey:@"HRZuCount"]];
            cell.lab3.text=[NSString stringWithFormat:@"套餐描述：%@",[dic objectForKey:@"Remark"]];
            cell.lab4.text=[NSString stringWithFormat:@"出售房源(套)：%@",[dic objectForKey:@"HRShowCount"]];
            cell.lab5.text=[NSString stringWithFormat:@"套餐价格(元/月)：%@",[dic objectForKey:@"PackagePrice"]];
            
            if (indexPath.section==0) {
                [cell.button addTarget:self action:@selector(selectClick4:) forControlEvents:UIControlEventTouchUpInside];
                cell.button.tag=indexPath.row;
            }
        }
        else if([_string isEqualToString:@"搜房网"])
        {
           // PL_ALERT_SHOW(@"暂不可用");
            cell.lab1.text=@"";
            cell.lab2.text=@"";
            cell.lab3.text=@"";
            cell.lab33.text=@"";
            cell.lab4.text=@"";
            cell.lab5.text=@"";
            cell.lab6.text=@"";
            cell.lab7.text=@"";
            cell.button.hidden=YES;
            
         
             cell.lab1.text=@"111";
             cell.lab2.text=@"111";
             cell.lab3.text=@"111";
             cell.lab33.text=@"111";
             
             cell.lab4.text=@"111";
             cell.lab5.text=@"111";
             cell.lab6.text=@"111";
             cell.lab7.text=@"111";
             cell.lab33.hidden=NO;
             cell.lab7.hidden=NO;
         
            if (indexPath.section==0) {
                [cell.button addTarget:self action:@selector(selectClick4:) forControlEvents:UIControlEventTouchUpInside];
                cell.button.tag=indexPath.row;
            }
        }
        
        else if ([_string isEqualToString:@"58同城网"])
        {
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
            cell.lab4.hidden=YES;
            cell.lab5.hidden=NO;
            cell.lab6.hidden=NO;
            cell.lab7.hidden=YES;
            cell.button.hidden=NO;
            
            dic=[array objectAtIndex:indexPath.row];
            cell.lab1.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"PackageID"]];
            cell.lab2.text=[NSString stringWithFormat:@"刷新次数(次/天)：%@",[dic objectForKey:@"HRRefreshCount"]];
            cell.lab3.text=[NSString stringWithFormat:@"套餐价格(元/月)：%@",[dic objectForKey:@"PackagePrice"]];;
            cell.lab5.text=[NSString stringWithFormat:@"房源量：%@",[dic objectForKey:@"HRCount"]];
            cell.lab6.text=[NSString stringWithFormat:@"赠送推广价格(元)：%@",[dic objectForKey:@"PackagePresent"]];
            cell.lab33.text=[NSString stringWithFormat:@"服务内容描述：%@",[dic objectForKey:@"PackageRemark"]];
            
            if (indexPath.section==0) {
                [cell.button addTarget:self action:@selector(selectClick4:) forControlEvents:UIControlEventTouchUpInside];
                cell.button.tag=indexPath.row;
            }
            
        }
        
        else if ([_string isEqualToString:@"新浪网"])
        {
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
            cell.lab5.hidden=YES;
            cell.lab6.hidden=NO;
            cell.lab7.hidden=NO;
            cell.button.hidden=NO;
            dic=[array objectAtIndex:indexPath.row];
            cell.lab1.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"PackageID"]];
            cell.lab2.text=[NSString stringWithFormat:@"认证房：%@",[dic objectForKey:@"HRRenZhengCount"]];
            cell.lab3.text=[NSString stringWithFormat:@"急售标签：%@",[dic objectForKey:@"HRJiShouCount"]];
            cell.lab4.text=[NSString stringWithFormat:@"上架房源数：%@",[dic objectForKey:@"HRCount"]];
            
            cell.lab6.text=[NSString stringWithFormat:@"新推标签：%@",[dic objectForKey:@"HRXinTuiCount"]];
            cell.lab33.text=[NSString stringWithFormat:@"套餐价格(元/月)：%@",[dic objectForKey:@"PackagePrice"]];
            cell.lab7.text=[NSString stringWithFormat:@"刷新次数(次/天)：%@",[dic objectForKey:@"HRRefreshCount"]];
            if (indexPath.section==0) {
                [cell.button addTarget:self action:@selector(selectClick4:) forControlEvents:UIControlEventTouchUpInside];
                cell.button.tag=indexPath.row;
            }
        }
        
        else if ([_string isEqualToString:@"赶集网"])
        {
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
            cell.lab5.hidden=YES;
            cell.lab6.hidden=YES;
            cell.lab7.hidden=YES;
            cell.button.hidden=NO;
            dic=[array objectAtIndex:indexPath.row];
            cell.lab1.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"PackageID"]];
            cell.lab2.text=[NSString stringWithFormat:@"赠送竞价币：%@",[dic objectForKey:@"PackagePresent"]];
            cell.lab3.text=[NSString stringWithFormat:@"刷新次数(次/天)：%@",[dic objectForKey:@"HRRefreshCount"]];
            cell.lab4.text=[NSString stringWithFormat:@"房源量：%@",[dic objectForKey:@"HRCount"]];
            
            cell.lab5.text=[NSString stringWithFormat:@"套餐价格(元/月)：%@",[dic objectForKey:@"PackagePrice"]];
            
            cell.lab33.text=[NSString stringWithFormat:@"服务内容描述：%@",[dic objectForKey:@"PackageRemark"]];
            if (indexPath.section==0) {
                [cell.button addTarget:self action:@selector(selectClick4:) forControlEvents:UIControlEventTouchUpInside];
                cell.button.tag=indexPath.row;
            }
            
        }
        
      //  [selectArr addObject:cell.button];
       // NSLog(@"selectArr.count==%d",selectArr.count);
        */
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
        cell.lab33.hidden=YES;
        cell.lab4.hidden=NO;
        cell.lab5.hidden=NO;
        cell.lab6.hidden=NO;
        cell.lab7.hidden=YES;
        cell.button.hidden=NO;
        
        NSLog(@"%@",[dic objectForKey:@"PackageType"]);
        
        if (indexPath.section==0) {
            dic=[_typeArr1 objectAtIndex:indexPath.row];
        }
        else if(indexPath.section==1)
        {
            dic=[_typeArr2 objectAtIndex:indexPath.row];
        }
        else
        {
            dic=[_typeArr3 objectAtIndex:indexPath.row];
        }
        
        cell.lab1.text=[dic objectForKey:@"PackageID"];
        cell.lab2.text=[NSString stringWithFormat:@"定价房源：%@",[dic objectForKey:@"HRDingJiaCount"]];
        cell.lab3.text=[NSString stringWithFormat:@"充值要求：%@",[dic objectForKey:@"PayDemand"]];
        cell.lab4.text=[NSString stringWithFormat:@"库存：%@",[dic objectForKey:@"HRCount"]];
        cell.lab5.text=[NSString stringWithFormat:@"竞价房源：%@",[dic objectForKey:@"HRJingJiaCount"]];
        cell.lab6.text=[NSString stringWithFormat:@"价格(元/月)：%@",[dic objectForKey:@"PackagePrice"]];
        
        
        if (indexPath.section==0) {
            [cell.button addTarget:self action:@selector(selectClick1:) forControlEvents:UIControlEventTouchUpInside];
            cell.button.tag=indexPath.row;
        }
        else if(indexPath.section==1)
        {
            [cell.button addTarget:self action:@selector(selectClick2:) forControlEvents:UIControlEventTouchUpInside];
            cell.button.tag=indexPath.row;
        }
        else
        {
            [cell.button addTarget:self action:@selector(selectClick3:) forControlEvents:UIControlEventTouchUpInside];
            cell.button.tag=indexPath.row;
        }

       
        
        return cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==table) {
        if (_typeArr2.count==0)
        {
            if (section==1)
            {
                return 0.1;
            }
            else
            {
                return 44;
            }
        }
        else
        {
            return 44;
        }
        
    }
    else
    {
        return 0;
    }
        /*
        if ([_string isEqualToString:@"上海安居客"])
         {
            if (typeArr2.count==0) {
                if (section==1) {
                    return 0.1;
                }
                else
                {
                    return 44;
                }
            }
            else
            {
                 return 44;
            }
           
        }
        else
        {
            return 0.1;
        }
        
    }
    else
    {
        return 0;
    }
    */
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, 44)];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, 44)];
    label.textAlignment=NSTextAlignmentCenter;
    [view addSubview:label];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 0, PL_WIDTH, 44);
    [but addTarget:self action:@selector(but:) forControlEvents:UIControlEventTouchUpInside];
    but.titleLabel.textAlignment = NSTextAlignmentCenter;
    but.tag = section;
    [view addSubview:but];
    UIImageView *tempImageV = [[UIImageView alloc]initWithFrame:CGRectMake(286, 20, 20, 11)];
    NSString *tempSectionString = [NSString stringWithFormat:@"%ld",(long)section];
    if ([self.treeOpenArray containsObject:tempSectionString]) {
        tempImageV.image = [UIImage imageNamed:@"close"];
        
    }else{
        tempImageV.image = [UIImage imageNamed:@"open"];
    }
    [view addSubview:tempImageV];
    ///给section加一条线。
    CALayer *_separatorL = [CALayer layer];
    _separatorL.frame = CGRectMake(0.0f, 44.0f, [UIScreen mainScreen].bounds.size.width, 1.0f);
    _separatorL.backgroundColor = [UIColor lightGrayColor].CGColor;
    [view.layer addSublayer:_separatorL];
    if (section==0) {
        label.text=@"套餐类型：住宅";
    }
    else if (section==1)
    {
        if (_typeArr2.count==0) {
            label.text=@"";
        }
        else
        {
            label.text=@"套餐类型：商铺";
        }
        
    }
    else
    {
        label.text=@"安币充值";
    }
    
    return view;
    /*
    if ([_string isEqualToString:@"上海安居客"])
    {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, 44)];
        //view.backgroundColor=[UIColor redColor];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, 44)];
        label.textAlignment=NSTextAlignmentCenter;
        [view addSubview:label];
        if (section==0) {
            label.text=@"套餐类型：住宅";
        }
        else if (section==1)
        {
            if (typeArr2.count==0) {
                label.text=@"";
            }
            else
            {
                 label.text=@"套餐类型：商铺";
            }
           
        }
        else
        {
            label.text=@"安币充值";
        }
        
        return view;
    }
    else
    {
        return nil;
    }
    */
}
- (void)but:(UIButton *)sender
{
    self.treeOpenString = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    if ([self.treeOpenArray containsObject:self.treeOpenString]) {
        [self.treeOpenArray removeObject:self.treeOpenString];
    }else{
        [self.treeOpenArray addObject:self.treeOpenString];
    }
    [table reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationFade];
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    
//    if (section==0) {
//        return @"套餐类型：住宅";
//    }
//    else if (section==1)
//    {
//        return @"套餐类型：商铺";
//    }
//    else
//    {
//        return @"安币充值";
//    }
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==table)
    {
        if (hide3==YES)
        {
            return 2;
        }
        else
        {
            return 3;
        }
        
    }
    else
    {
        return 1;
    }
        /*
        if ([_string isEqualToString:@"上海安居客"])
        {
            NSLog(@"sh========%@",[dic objectForKey:@"PackageType"]);
             if (hide3==YES)
             {
                 return 2;
             }
            else
            {
                return 3;
            }
            
        }
        else
        {
            return 1;
        }
      
    }
    else
    {
        return 1;
    }
    */
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==table2) {
        bgView.hidden=YES;
//        [selectBtn1 removeFromSuperview];
//        [selectBtn2 removeFromSuperview];
//        [selectBtn3 removeFromSuperview];
        selectBtn1.selected=NO;
        selectBtn2.selected=NO;
        selectBtn3.selected=NO;
     
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
    else
    {
       
//        NSLog(@"indexPath.section=====%d",indexPath.section);
//        WebCustomCell *cell = (WebCustomCell *)[tableView cellForRowAtIndexPath:indexPath];
//        if (indexPath.section==0) {
//            if (cell.button!=selectBtn) {
//                selectBtn.selected=NO;
//                selectBtn=cell.button;
//            }
//            selectBtn.selected=YES;
//        }
//        else
//        {
//            selectBtn=cell.button;
//            selectBtn.selected=!selectBtn.selected;
//        }
//        WebCustomCell *cell = (WebCustomCell *)[tableView cellForRowAtIndexPath:indexPath];
//        cell.button.selected=YES;
        //for the selected row+1
//        NSUInteger indexes[2] = {indexPath.section, indexPath.row+1};
//        NSIndexPath *otherIndex = [NSIndexPath indexPathWithIndexes:indexes length:2];
//        WebCustomCell *nextRowCell = (WebCustomCell *)[tableView cellForRowAtIndexPath:otherIndex];
//        nextRowCell.button.selected=NO;
        
//        if ([_string isEqualToString:@"上海安居客"]) {
//            if (indexPath.section==0) {
//                selectBtn.selected=YES;
//            }
//            else if(indexPath.section==1)
//            {
//                [self selectClick:selectBtn];
//            }
//            else
//            {
//                [self selectClick:selectBtn];
//            }
//        }
       
    }
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    NSLog(@"Segue Identifier = %@", [segue identifier]);
//    NSDictionary *dic=[array objectAtIndex:selectBtn.tag];
//    id page=segue.destinationViewController;
//    [page setValue:dic forKey:@"dict"];
//}


-(void)selectClick1:(UIButton *)sender
{
    
        if (sender!=selectBtn1) {
            selectBtn1.selected=NO;
            selectBtn1=sender;
        }
        selectBtn1.selected=YES;
    
    
}
-(void)selectClick2:(UIButton *)sender
{
    
    if (sender!=selectBtn2) {
        selectBtn2.selected=NO;
        selectBtn2=sender;
    }
    selectBtn2.selected=YES;
    
    
}

-(void)selectClick3:(UIButton *)sender
{
    
    if (sender!=selectBtn3) {
        selectBtn3.selected=NO;
        selectBtn3=sender;
    }
    selectBtn3.selected=YES;
    
    
}




-(void)sureClick
{
    if (selectBtn1.selected)
    {
        SHAJKViewController *SH=[[SHAJKViewController alloc]init];
        SH.dict=[_typeArr1 objectAtIndex:selectBtn1.tag];
        if (selectBtn2.selected)
        {
            SH.dict2=[_typeArr2 objectAtIndex:selectBtn2.tag];
        }
        if (selectBtn3.selected)
        {
            SH.dict3=[_typeArr3 objectAtIndex:selectBtn3.tag];
        }
        [self.navigationController pushViewController:SH animated:YES];
    }
    else if (selectBtn2.selected)
    {
        SHAJKViewController *SH=[[SHAJKViewController alloc]init];
        SH.dict2=[_typeArr2 objectAtIndex:selectBtn2.tag];
        if (selectBtn3.selected)
        {
            SH.dict3=[_typeArr3 objectAtIndex:selectBtn3.tag];
        }
        [self.navigationController pushViewController:SH animated:YES];
    }
    else if (selectBtn3.selected)
    {
        SHAJKViewController *SH=[[SHAJKViewController alloc]init];
        SH.dict3=[_typeArr3 objectAtIndex:selectBtn3.tag];
        [self.navigationController pushViewController:SH animated:YES];
//        PL_ALERT_SHOW(@"请选择一种套餐");
    }else
    {
        
        PL_ALERT_SHOW(@"请选择一种套餐");
    }
    /*
    if (selectBtn1.selected)
    {
        
        NSLog(@"%@",_string);
        if ([_string isEqualToString:@"上海安居客"]) {
            
            SHAJKViewController *SH=[[SHAJKViewController alloc]init];
            SH.dict=[typeArr1 objectAtIndex:selectBtn1.tag];
            
            if (selectBtn3.selected)
            {
                SH.dict3=[typeArr3 objectAtIndex:selectBtn3.tag];
            }
            [self.navigationController pushViewController:SH animated:YES];
        }
        else if ([_string isEqualToString:@"昆山安居客"])
        {
            KunShanWebViewController *kun=[[KunShanWebViewController alloc]init];
            NSLog(@"array11111=====%d",array.count);
            kun.dict=[array objectAtIndex:selectBtn1.tag];
            [self.navigationController pushViewController:kun animated:YES];
            
        }
        else if ([_string isEqualToString:@"新浪网"])
        {
            sinaViewController *sina=[[sinaViewController alloc]init];
            sina.dict=[array objectAtIndex:selectBtn1.tag];
            [self.navigationController pushViewController:sina animated:YES];
            //[_button setImage:[UIImage imageNamed:@"sinaLOGO33.png"] forState:UIControlStateNormal];
        }
        else if ([_string isEqualToString:@"搜房网"])
        {
            [_button setImage:[UIImage imageNamed:@"搜房网logo33.png"] forState:UIControlStateNormal];
            //[table removeFromSuperview];
            
        }
        else if ([_string isEqualToString:@"58同城网"])
        {
            TongChengViewController *tongcheng=[[TongChengViewController alloc]init];
            tongcheng.dict=[array objectAtIndex:selectBtn1.tag];
            [self.navigationController pushViewController:tongcheng animated:YES];
            
        }
        else if ([_string isEqualToString:@"赶集网"])
        {
            GanJiViewController *ganji=[[GanJiViewController alloc]init];
            ganji.dict=[array objectAtIndex:selectBtn1.tag];
            [self.navigationController pushViewController:ganji animated:YES];
        }
    }
    else if (selectBtn2.selected)
    {
        SHAJKViewController *SH=[[SHAJKViewController alloc]init];
        SH.dict=[typeArr2 objectAtIndex:selectBtn2.tag];
        if (selectBtn3.selected)
        {
            SH.dict3=[typeArr3 objectAtIndex:selectBtn3.tag];
        }
        [self.navigationController pushViewController:SH animated:YES];
    }
    
    else if (selectBtn4.selected)
    {
        if ([_string isEqualToString:@"昆山安居客"])
        {
            KunShanWebViewController *kun=[[KunShanWebViewController alloc]init];
            NSLog(@"array11111=====%d",array.count);
            kun.dict=[array objectAtIndex:selectBtn4.tag];
            [self.navigationController pushViewController:kun animated:YES];
            
        }
        else if ([_string isEqualToString:@"新浪网"])
        {
            sinaViewController *sina=[[sinaViewController alloc]init];
            sina.dict=[array objectAtIndex:selectBtn4.tag];
            [self.navigationController pushViewController:sina animated:YES];
            //[_button setImage:[UIImage imageNamed:@"sinaLOGO33.png"] forState:UIControlStateNormal];
        }
        else if ([_string isEqualToString:@"搜房网"])
        {
            [_button setImage:[UIImage imageNamed:@"搜房网logo33.png"] forState:UIControlStateNormal];
            [table removeFromSuperview];
            
        }
        else if ([_string isEqualToString:@"58同城网"])
        {
            TongChengViewController *tongcheng=[[TongChengViewController alloc]init];
            tongcheng.dict=[array objectAtIndex:selectBtn4.tag];
            [self.navigationController pushViewController:tongcheng animated:YES];
            
        }
        else if ([_string isEqualToString:@"赶集网"])
        {
            GanJiViewController *ganji=[[GanJiViewController alloc]init];
            ganji.dict=[array objectAtIndex:selectBtn4.tag];
            [self.navigationController pushViewController:ganji animated:YES];
        }
    }
    
    else
    {
        PL_ALERT_SHOW(@"请选择一种套餐");
    }
*/
}

-(void)cancleClick
{
     selectBtn1.selected=NO;
    selectBtn2.selected=NO;
    selectBtn3.selected=NO;
  
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
