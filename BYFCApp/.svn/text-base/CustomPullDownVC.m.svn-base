//
//  CustomPullDownVC.m
//  BYFCApp
//
//  Created by zzs on 14/12/12.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import "CustomPullDownVC.h"
#import "PL_Header.h"
@interface CustomPullDownVC ()<UITableViewDataSource,UITableViewDelegate,PersonDelegate>

@property(nonatomic,strong)UITableView * tradeTableView;
@property(nonatomic,strong)UITableView * priceTableView;
@property(nonatomic,strong)NSArray *priceArray;
-(id)init;
-(void)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;

@end

@implementation CustomPullDownVC

-(id)init
{
    self = [super init];
    
    if (self)
    {
        
    }
    return self;
    
}
-(void)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tradeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.view.frame) ,CGRectGetHeight(self.view.frame)/3) style:UITableViewStylePlain];
    _tradeTableView.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:_tradeTableView];
    _tradeTableView.tag = 10001;
    _tradeTableView.delegate = self;
    _tradeTableView.dataSource = self;
    _tradeTableView.separatorInset = UIEdgeInsetsZero;
    _priceTableView = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/3, 0, CGRectGetWidth(_tradeTableView.frame)*2, CGRectGetHeight(_tradeTableView.frame)) style:UITableViewStylePlain];
    _priceTableView.tag = 10002;
    _priceTableView.rowHeight = 30;
    _priceTableView.delegate = self;
    _priceTableView.dataSource = self;
    
    _priceTableView.backgroundColor = [UIColor blueColor];
    _priceTableView.separatorInset= UIEdgeInsetsZero;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==10001) {
        return 6;
    }else if (tableView.tag==10002){
        return 6;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==10001)
    {
        return 40;
    }
    else
    {
        return 40;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==10001) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        return cell;
    }else if (tableView.tag==10002){
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        return cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==10001) {
        [self.view addSubview:_priceTableView];
    }else{
        [_priceTableView removeFromSuperview];
        [_tradeTableView removeFromSuperview];
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
