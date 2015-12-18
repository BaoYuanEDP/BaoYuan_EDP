//
//  SinaVC.m
//  BYFCApp
//
//  Created by PengLee on 15/4/2.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "SinaVC.h"
#import "PL_Header.h"
#import "SFTableViewCell.h"
#define image_inset 45
@interface SinaVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSInteger _currentSelectStatus;
}
@property (nonatomic,strong)UITableView * detailTable;
@property (nonatomic,strong)UIImageView * selImage;
@property (nonatomic,strong)UILabel     * taocanNumLable;

@end

@implementation SinaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"端口申请";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _currentSelectStatus = 1;
    
    self.navigationController.navigationBar.backItem.hidesBackButton = YES;
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(5, 5, 12, 20);
    
   [ leftButton setBackgroundImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(callBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    
    self.navigationItem.leftBarButtonItem = left;
    [self initContentView];
    
}
- (void)callBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (void)initContentView
{
    _detailTable = [[UITableView alloc]init];
    _detailTable.delegate = self;
    _detailTable.dataSource = self;
    _detailTable.tableFooterView = [[UIView alloc]init];
    _detailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _detailTable.scrollEnabled = NO;
    [self.view addSubview:_detailTable];
    [_detailTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    
}
#pragma mark --tableviewDelegate
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    return 0;
    
    
}
 - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 75;
    }
    return 0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, 75)];
    headerView.backgroundColor = [UIColor clearColor];
    UILabel * selectLable = [[UILabel alloc]init];
    selectLable.text = @"您选择的是";
    selectLable.backgroundColor = [UIColor clearColor];
    selectLable.font = [UIFont boldSystemFontOfSize:PL_SF_FONT_DETAIL];
    selectLable.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:selectLable];
    [selectLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.width.equalTo(@(PL_WIDTH/3));
        make.height.equalTo(@45);
        
        
    }];
    UILabel * taocanLable = [[UILabel alloc]init];
    taocanLable.text = @"套餐编号";
    taocanLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
    taocanLable.backgroundColor = [UIColor clearColor];
    taocanLable.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:taocanLable];
    [taocanLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.centerX.equalTo(selectLable.mas_centerX);
        make.width.equalTo(@(PL_WIDTH/3));
        make.bottom.equalTo(headerView.mas_bottom);
        make.top.equalTo(selectLable.mas_bottom);
        
        
    }];
    UILabel * bottonLableline = [[UILabel alloc]init];
    bottonLableline.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:pl_alpha];
    [headerView addSubview:bottonLableline];
    [bottonLableline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headerView).with.insets(UIEdgeInsetsMake(45, 0, 29, 0));
        
    }];
    UILabel * shuxianLbale = [[UILabel alloc]init];
    shuxianLbale.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:pl_alpha];
    [headerView addSubview:shuxianLbale];
    [shuxianLbale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selectLable.mas_right);
        make.top.equalTo(headerView.mas_top);
        make.bottom.equalTo(headerView.mas_bottom);
        make.width.equalTo(@1);
        
        
    }];
    _selImage = [[UIImageView alloc]init];
    [headerView addSubview:_selImage];
    _selImage.image = [UIImage imageNamed:@"搜房网logo33.png"];
   // _selImage.contentMode = UIViewContentModeCenter;
    _selImage.backgroundColor = [UIColor clearColor];
    [_selImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shuxianLbale.mas_right).with.offset(image_inset);
        make.top.equalTo(headerView.mas_top);
        make.bottom.equalTo(selectLable.mas_bottom);
        make.width.equalTo(@(PL_WIDTH*2/3-image_inset*2));
        
        
    }];
    _taocanNumLable = [[UILabel alloc]init];
        if (self.dict.count>0)
    {
         _taocanNumLable.text =_dict[@"PackageID"];
    }
    else
    {
        _taocanNumLable.text = @"";

    }
   
    _taocanNumLable.textAlignment = NSTextAlignmentCenter;
    _taocanNumLable.font = [UIFont systemFontOfSize:PL_DETAIL_BIG_FONT_SIZ];
    
    [headerView addSubview:_taocanNumLable];
    [_taocanNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(taocanLable.mas_centerY);
        make.centerX.equalTo(_selImage.mas_centerX);
        make.width.greaterThanOrEqualTo(_taocanNumLable.mas_width);
        make.height.equalTo(_taocanNumLable.mas_height);
        
    }];
    UILabel * xiaLbaleline = [[UILabel alloc]init];
    xiaLbaleline.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:pl_alpha];
    [headerView addSubview:xiaLbaleline];
    [xiaLbaleline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(headerView.mas_right);
        make.height.equalTo(@1);
        make.bottom.equalTo(headerView.mas_bottom);
        
        
    }];

    
    
    return headerView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 300;
    }
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifer = @"cellidertifer";
    SFTableViewCell * cell = [_detailTable dequeueReusableCellWithIdentifier:cellIdentifer ];
    if (!cell)
    {
        cell = [[SFTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   //cell.textLabel.text = @"123";
    cell.backgroundColor = [UIColor clearColor];
    if (_dict.count>0)
    {
        //[_dict objectForKey:@"HRCount"]
        cell.dianpuLable.text =[NSString stringWithFormat:@"%@",[_dict objectForKey:@"HRCount"]] ;
        
        
        cell.jishoufangLable.text = [NSString stringWithFormat:@"%@",_dict[@"HRJiShouIcon"]];
        cell.xintuiFLable.text = [NSString stringWithFormat:@"%@",_dict[@"HRXinTuiIcon"]];
        cell.fangxinfangLable.text =[NSString stringWithFormat:@"%@",_dict[@"HRFangXinIcon"]] ;
        
        cell.temp1.text =[NSString stringWithFormat:@"%@", _dict[@"HRXinFangMY"]];
        cell.temp2.text = [NSString stringWithFormat:@"%@", _dict[@"HRRefreshCount"]];
        cell.temp3.text = [NSString stringWithFormat:@"%@",  _dict[@"PackagePrice"]];
    }
    
   
     [cell.redioButton1 setBackgroundImage:[UIImage imageNamed:@"radio-button_off33.png"] forState:UIControlStateNormal];
    [cell.redioButton1 setBackgroundImage:[UIImage imageNamed:@"radio-button_on33.png"] forState:UIControlStateSelected];
    [cell.rediaoButton2 setBackgroundImage:[UIImage imageNamed:@"radio-button_off33.png"] forState:UIControlStateNormal];
    [cell.rediaoButton2 setBackgroundImage:[UIImage imageNamed:@"radio-button_on33.png"] forState:UIControlStateSelected];
    cell.rediaoButton2.selected = YES;
    [cell.rediaoButton2 addTarget:self action:@selector(redioClick2:) forControlEvents:UIControlEventTouchUpInside];
     [cell.redioButton1 addTarget:self action:@selector(redioClick1:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.applyButton addTarget:self action:@selector(appClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)redioClick1:(UIButton *)button
{
    SFTableViewCell * cell = (SFTableViewCell *)[[[button superview] superview] superview];
    cell.redioButton1.selected =! cell.redioButton1.selected;
     cell.rediaoButton2.selected = !cell.redioButton1.selected;
    _currentSelectStatus = 0;
    
   
    
}
- (void)redioClick2:(UIButton *)button
{
    SFTableViewCell * cell = (SFTableViewCell *)[[[button superview] superview] superview];
    cell.rediaoButton2.selected = !cell.rediaoButton2.selected;
    cell.redioButton1.selected =! cell.rediaoButton2.selected;
    _currentSelectStatus = 1;
    
  
}
-(void)appClick:(UIButton *)button
{
    NSLog(@"123");
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要申请该套餐吗？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.delegate=self;
    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex==1) {
        WebData *web=[[WebData alloc]init];
        web.WebName=@"搜房网";
        if (_currentSelectStatus==0)
        {
            web.RegisterType = @"0";
        }
        else
        {
            web.RegisterType = @"1";
            
        }
        web.PackageID=[_dict objectForKey:@"PackageID"];
        web.PackagePrice=[_dict objectForKey:@"PackagePrice"];
        web.PackageType=[_dict objectForKey:@"PackageType"];
        //web.MonthType=@"";
        web.userid=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
        web.token=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN];
        NSLog(@"%@  %@  %@  %@  %@  %@",web.WebName,web.RegisterType,web.PackageID,web.PackagePrice,web.userid,web.token);
        PL_PROGRESS_SHOW;
        [[MyRequest defaultsRequest]setApplication:web backInfoMessage:^(NSMutableString *string) {
            NSLog(@"%@",string);
            if ([string isEqualToString:@"1"]) {
                PL_ALERT_SHOW(@"参数有空值");
            }
            else if([string isEqualToString:@"2"])
            {
                PL_ALERT_SHOW(@"未绑定网站账号");
            }
            else if ([string isEqualToString:@"3"])
            {
                PL_ALERT_SHOW(@"安币充值申请公费不能大于500");
            }
            else if ([string isEqualToString:@"4"])
            {
                PL_ALERT_SHOW(@"本月已申请该网站套餐,不能重复申请");
            }
            else if ([string isEqualToString:@"5"])
            {
                PL_ALERT_SHOW(@"未申请过套餐(体验版/标准版)，不允许安申请币充值");
            }
            else if ([string isEqualToString:@"6"])
            {
                PL_ALERT_SHOW(@"安币充值只能输入数字");
            }
            else if ([string isEqualToString:@"7"])
            {
                PL_ALERT_SHOW(@"安币充值申请金额为0");
            }
            else if ([string isEqualToString:@"8"])
            {
                PL_ALERT_SHOW(@"安币充值申请金额必须为100的倍数");
            }
            else if ([string isEqualToString:@"9"])
            {
                PL_ALERT_SHOW(@"本月安币充值累计申请大于500");
            }
            else if ([string isEqualToString:@"10"])
            {
                PL_ALERT_SHOW(@"本月已申请该网站套餐,不能重复申请");
            }
            else if ([string isEqualToString:@"11"])
            {
                PL_ALERT_SHOW(@"同一种套餐类型只能申请一个套餐");
            }
            else if ([string isEqualToString:@"12"])
            {
                PL_ALERT_SHOW(@"没有申请商铺类套餐的权限");
            }
            else if ([string isEqualToString:@"13"])
            {
                PL_ALERT_SHOW(@"只有营业部才允许申请");
            }
            else if ([string isEqualToString:@"14"])
            {
                PL_ALERT_SHOW(@"本月申请额超出片区限额");
            }
            else if ([string isEqualToString:@"15"])
            {
                PL_ALERT_SHOW(@"上月业绩未导入，不能申请");
            }
            else if ([string isEqualToString:@"exception"])
            {
                PL_ALERT_SHOW(@"服务器异常");
            }
            else if ([string isEqualToString:@"OK"])
            {
                PL_ALERT_SHOW(@"申请成功");
            }
            else
            {
                PL_ALERT_SHOW(@"申请失败");
            }
            PL_PROGRESS_DISMISS;
        }];
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
