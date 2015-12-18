//
//  PortViewController.m
//  BYFCApp
//
//  Created by zzs on 15/1/20.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "PortViewController.h"
#import "PL_Header.h"
#import "PortListViewController.h"
@interface PortViewController ()

@end

@implementation PortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor=[UIColor grayColor];
    self.title=@"端口申请";
    self.navigationController.navigationBarHidden=NO;
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    // backItemBnt.backgroundColor=[UIColor redColor];
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    // [navView addSubview:backItemBnt];
    
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    UIButton * lookItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lookItemBtn.frame = CGRectMake(PL_WIDTH-44, 10, 44, 44);
    [lookItemBtn setTitle:@"查看" forState:UIControlStateNormal];
    [lookItemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lookItemBtn addTarget:self action:@selector(lookClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]initWithCustomView:lookItemBtn];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(0, 70, PL_WIDTH, 50)];
    title.text=@"选择您喜爱的网站";
    title.textAlignment=NSTextAlignmentCenter;
    title.font=[UIFont systemFontOfSize:20];
    title.textColor=[UIColor colorWithRed:253.0/255.0 green:208.0/255.0 blue:89.0/255.0 alpha:1];
    [self.view addSubview:title];
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(title.frame), PL_WIDTH, 320-2)];
    view.backgroundColor=[UIColor lightGrayColor];
    view.alpha=0.9;
    [self.view addSubview:view];
    
    table1=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH/2, 320-2) style:UITableViewStylePlain];
    table1.delegate=self;
    table1.dataSource=self;
    table1.rowHeight=80;
    
    [view addSubview:table1];
    table2=[[UITableView alloc]initWithFrame:CGRectMake(PL_WIDTH/2+1, 0, PL_WIDTH/2, 320-2) style:UITableViewStylePlain];
    table2.delegate=self;
    table2.dataSource=self;
    table2.rowHeight=80;
   
    [view addSubview:table2];
    //array1=[NSArray arrayWithObjects:@"    搜房网",@"    安居客(上海)",@"    58同城",@"    搜狐焦点", nil];
    array2=[NSArray arrayWithObjects:[UIImage imageNamed:@"sinaLOGO33.png"], [UIImage imageNamed:@"anjuke_ks33.png"],[UIImage imageNamed:@"GanJilogo33.png"],nil];
    array1=[NSArray arrayWithObjects:[UIImage imageNamed:@"搜房网logo33.png"],[UIImage imageNamed:@"anjuke_SH33.png"],[UIImage imageNamed:@"58LOGO33.png"],[UIImage imageNamed:@"敬请期待33.png"], nil];
    
    if ([table1 respondsToSelector:@selector(setSeparatorInset:)]) {
        [table1 setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([table1 respondsToSelector:@selector(setLayoutMargins:)]) {
        [table1 setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([table2 respondsToSelector:@selector(setSeparatorInset:)]) {
        [table2 setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([table2 respondsToSelector:@selector(setLayoutMargins:)]) {
        [table2 setLayoutMargins:UIEdgeInsetsZero];
    }
    
   // table2.contentSize=table1.contentSize;
   // table1.contentSize=table2.contentSize;
    table2.scrollEnabled=NO;
    table1.scrollEnabled=NO;
}

-(void)lookClick
{
    PortListViewController *vc = [[PortListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==table1) {
        return 4;
    }
    else {
         return 3;
    }
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    if (tableView==table1) {
        //cell.textLabel.text=[array1 objectAtIndex:indexPath.row];
        //cell.imageView.image=[array1 objectAtIndex:indexPath.row];
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(30, 20, PL_WIDTH/2-60, 30)];
        image.image=[array1 objectAtIndex:indexPath.row];
        [cell addSubview:image];
    }
    else
    {
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(30, 20, PL_WIDTH/2-60, 30)];
        image.image=[array2 objectAtIndex:indexPath.row];
        [cell addSubview:image];
        //cell.textLabel.text=[array2 objectAtIndex:indexPath.row];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==table1) {
        if (indexPath.row==0) {
            SouFangListViewController *SF=[[SouFangListViewController alloc]init];
            SF.string=@"搜房网";
            [self.navigationController pushViewController:SF animated:YES];
        }
        else if (indexPath.row==1)
        {
            NSLog(@"shanghai");
            SHViewController *sh=[[SHViewController alloc]init];
            sh.string=@"上海安居客";
            [self.navigationController pushViewController:sh animated:YES];
            
           
        }
        else if (indexPath.row==2)
        {
            NSLog(@"58");
            TCListViewController *tc=[[TCListViewController alloc]init];
            tc.string=@"58同城网";
            [self.navigationController pushViewController:tc animated:YES];
            
            
        }
        else
        {
            
        }
       
    }
    else
    {
        if (indexPath.row==0) {
            SinaListViewController *sinaL=[[SinaListViewController alloc]init];
            sinaL.string=@"新浪网";
            [self.navigationController pushViewController:sinaL animated:YES];
        }
        else if (indexPath.row==1)
        {
            NSLog(@"xinlang");
            // PL_ALERT_SHOW(@"数据异常");
//            SHViewController *web=[[SHViewController alloc]init];
//            web.string=@"新浪网";
//            [self.navigationController pushViewController:web animated:YES];
            NSLog(@"kunshan");
            KSListViewController *ks=[[KSListViewController alloc]init];
            ks.string=@"昆山安居客";
            [self.navigationController pushViewController:ks animated:YES];
        }
        else
        {
            NSLog(@"ganji");
            GJListViewController *gan=[[GJListViewController alloc]init];
            gan.string=@"赶集网";
            [self.navigationController pushViewController:gan animated:YES];
        }
    }
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
