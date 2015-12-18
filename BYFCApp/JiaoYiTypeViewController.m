//
//  JiaoYiTypeViewController.m
//  BYFCApp
//
//  Created by PengLee on 15/10/8.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "JiaoYiTypeViewController.h"
#import "PL_Header.h"

@interface JiaoYiTypeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *typeArray;
    NSMutableArray *selectArr;
}
@end

@implementation JiaoYiTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易状态";
    typeArray = @[@"未知",@"无效",@"已购",@"已租",@"有效",@"预定",@"暂缓"];
    selectArr = [NSMutableArray array];
    _jiaoyiString = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    //自定义返回按钮
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    //自定义右边确定按钮
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(viewSureClick:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
    
    UITableView *typeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-60, self.view.frame.size.height)];
    NSLog(@"222222----%f",self.view.frame.size.width);
//    UITableView *typeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 100, self.view.frame.size.height)];

//    typeTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:typeTableView];
    typeTableView.delegate = self;
    typeTableView.dataSource = self;
    typeTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (void)viewSureClick:(UIBarButtonItem *)bar
{
    if(isSelected == YES)
    {
    [selectArr addObject:typeArray[0]];
    }
    if(isSelected1 == YES)
    {
        [selectArr addObject:typeArray[1]];
    }
    if(isSelected2 == YES)
    {
        [selectArr addObject:typeArray[2]];
    }
    if(isSelected3 == YES)
    {
        [selectArr addObject:typeArray[3]];
    }
    if(isSelected4 == YES)
    {
        [selectArr addObject:typeArray[4]];
    }if(isSelected5 == YES)
    {
        [selectArr addObject:typeArray[5]];
    }if(isSelected6 == YES)
    {
        [selectArr addObject:typeArray[6]];
    }
    _jiaoyiString = [selectArr componentsJoinedByString:@","];
    
    _moreVC.jiaoyiStr = _jiaoyiString;
    [self.navigationController popViewControllerAnimated:YES];
    //    UIView * view =self.navigationController.view.superview;
    //    if (view &&  [view isKindOfClass:[MoreMenuVC class]])
    //    {
    //        MoreMenuVC * more = (MoreMenuVC *)view;
    //        [more dismissView ];
    //
    //    }
    //     [[NSNotificationCenter defaultCenter]postNotificationName:@"type" object:nil userInfo:@{@"type":typeString}];
    
}

-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return typeArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setEditing:NO];
    static NSString *reuseId = @"reuseId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    cell.textLabel.text = typeArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];

        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        NSLog(@"%@",indexPath);
        if(indexPath.row == 0)
        {
            if (isSelected) {
                isSelected = NO;
                cell.accessoryType = UITableViewCellAccessoryNone;
                
            }
            else
            {
                isSelected = YES;
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            
        }
        if(indexPath.row == 1)
        {
            if (isSelected1) {
                
                isSelected1 = NO;
                cell.accessoryType = UITableViewCellAccessoryNone;
                
            }
            else
            {
                isSelected1 = YES;
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            
        }
        
        if(indexPath.row == 2)
        {
            if (isSelected2) {
                
                isSelected2 = NO;
                cell.accessoryType = UITableViewCellAccessoryNone;
                
            }
            else
            {
                isSelected2 = YES;
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            
        }
        
        if(indexPath.row == 3)
        {
            if (isSelected3) {
                
                isSelected3 = NO;
                cell.accessoryType = UITableViewCellAccessoryNone;
                
            }
            else
            {
                isSelected3 = YES;
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            
        }
    if(indexPath.row == 4)
    {
        if (isSelected4) {
            
            isSelected4 = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
        else
        {
            isSelected4 = YES;
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
    }

    if(indexPath.row == 5)
    {
        if (isSelected5) {
            
            isSelected5 = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
        else
        {
            isSelected5 = YES;
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
    }

    if(indexPath.row ==6)
    {
        if (isSelected6) {
            
            isSelected6 = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
        else
        {
            isSelected6 = YES;
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
    }

    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    
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
