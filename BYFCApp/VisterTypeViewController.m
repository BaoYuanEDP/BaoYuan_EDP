//
//  VisterTypeViewController.m
//  BYFCApp
//
//  Created by PengLee on 15/5/6.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "VisterTypeViewController.h"
#import "PL_Header.h"
@interface VisterTypeViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation VisterTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"类型";
    _typeString = @"";
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

    UITableView *typeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:typeTableView];
    typeTableView.delegate = self;
    typeTableView.dataSource = self;
    typeTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}

- (void)viewSureClick:(UIBarButtonItem *)bar
{
    
    _moreVC.typeStr = _typeString;
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

    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *typeArray = @[@"不限",@"经理推荐",@"急需",@"学区房"];
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
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _typeString = cell.textLabel.text;
   
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