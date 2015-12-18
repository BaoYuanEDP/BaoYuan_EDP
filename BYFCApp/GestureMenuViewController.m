//
//  GestureMenuViewController.m
//  BYFCApp
//
//  Created by PengLee on 15/4/13.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "GestureMenuViewController.h"
#import "PL_Header.h"
#import "TimeFilterView.h"
#import "SHCCheckBox.h"
@interface GestureMenuViewController ()<MoreMenuVCDelegate,UITableViewDataSource,UITableViewDelegate,TimeFilterViewDelegate>
{
    MoreMenuVC * men;
    NSArray * moreArr;
    
}
- (void)showViewAnimation:(BOOL)animation;

@property (strong,nonatomic)TimeFilterView *teme;
@property (nonatomic, strong) NSString *strNum1;
@property (nonatomic, strong) NSString *strNum2;
@property (nonatomic, strong) NSString *strNum3;
@property (nonatomic, strong) NSString *strNum4;
@property (nonatomic, strong) NSString *strNum5;
@property (nonatomic, strong) NSString *strNum6;

@end

@implementation GestureMenuViewController
- (void)showViewAnimation:(BOOL)animation
{
    [self.view.window addSubview:self.view];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_customTableView reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showLabelText1:) name:@"labelTextNotification1" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showLabelText2:) name:@"labelTextNotification2" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showLabelText3:) name:@"labelTextNotification3" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showLabelText4:) name:@"labelTextNotification4" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showLabelText5:) name:@"labelTextNotification5" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showLabelText6:) name:@"labelTextNotification6" object:nil];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"筛选";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    moreArr=[NSArray arrayWithObjects:@"不限",@"多层",@"高层",@"别墅",@"多类层",@"小高层", nil];
    viewContrs = @[[RoomStyleViewController new]];
    _customTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH-60, 240) style:UITableViewStyleGrouped];
    _customTableView.backgroundColor = [UIColor clearColor];
    _customTableView.dataSource = self;
    _customTableView.delegate = self;
    _customTableView.scrollEnabled = YES;
    [self.view addSubview:_customTableView];
//    TimeFilterView *timeView = [[TimeFilterView alloc]initWithFrame:CGRectMake(0, 100, PL_WIDTH - 60, 40) andTitlleArray:@[@"学区房",@"经理推荐",@"急售"]];
    TimeFilterView *timeView = [[TimeFilterView alloc] initWithFrame:CGRectMake(0, 240, PL_WIDTH - 60, 40)];
        [self.view addSubview:timeView];
    timeView.delegate = self;
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(viewSureClicks:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
    _num1 = @"";
    _num2 = @"";
    _roomSourceType = @"";
    _isHaveImage = @"";
    _jiaoYiStyle = @"";
    _tradeAcceptStr = @"";
    _propertyOccupyAcceptStr = @"";
    _propertyDirectionAcceptStr = @"";
    _propertyOwn1AcceptStr =@"";
    _propertyTrustAcceptStr = @"";
    _countFTAcceptStr = @"";
    _countFAcceptStr = @"";
    _countTAcceptStr = @"";
    _squareFromToAcceptStr = @"";
    _squareToAcceptStr  = @"";
    _squareFromAcceptStr = @"";
    _custTelAcceptStr = @"";
    _userCodeAcceptStr = @"";
    _statusLimitAcceptStr = @"";
    _effectiveDateFromAcceptStr = @"";
    _effectiveDateToAcceptStr = @"";
}
- (void)showLabelText1:(NSNotification *)notification
{
    _strNum1 = notification.object;
    
}
- (void)showLabelText2:(NSNotification *)notification
{
    _strNum2 = notification.object;
}
- (void)showLabelText3:(NSNotification *)notification
{
    _strNum3 = notification.object;
}
- (void)showLabelText4:(NSNotification *)notification
{
    _strNum4=notification.object;
    
}
- (void)showLabelText5:(NSNotification *)notification
{
    _strNum5=notification.object;
    
}
- (void)showLabelText6:(NSNotification *)notification
{
    _strNum6=notification.object;
    
}

- (void)viewSureClicks:(UIButton *)sender
{
    
    if ([_strNum1 isEqualToString:@"0"]) {
        _strNum1 = [NSString stringWithFormat:@""];
    }
    if ([_strNum2  isEqualToString:@"0"]) {
        _strNum2 = [NSString stringWithFormat:@""];
    }
    if ([_strNum3  isEqualToString:@"0"]) {
        _strNum3 = [NSString stringWithFormat:@""];
    }
    if ([_strNum4 isEqualToString:@"0"]) {
        _strNum4 = [NSString stringWithFormat:@""];
        NSLog(@"strLog%@",_strNum1);
    }
    if ([_strNum5 isEqualToString:@"0"]) {
        _strNum5 = [NSString stringWithFormat:@""];
    }
    if ([_strNum6 isEqualToString:@"0"]) {
        _strNum6 = [NSString stringWithFormat:@""];
    }
    NSLog(@"str1 = %@\n str2 = %@\n str3 = %@\n str4=%@\n str5=%@\n str6=%@\n",_strNum1,_strNum2,_strNum3,_strNum4,_strNum5,_strNum6);
    
    NSDictionary *adic = @{@"学区房":_strNum1,@"经理推荐":_strNum2,@"急售":_strNum3,@"满二年":_strNum4,@"独家":_strNum5,@"钥匙":_strNum6};
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc]initWithDictionary:adic]copy];

            self.dicBlock(dic);
        if ([self.delegate respondsToSelector:@selector(dismiss)]) {
            [self.delegate dismiss];
        }
    
    UIView * view =self.navigationController.view.superview;
    if (view &&  [view isKindOfClass:[MoreMenuVC class]])
    {
        MoreMenuVC * more = (MoreMenuVC *)view
        ;
        [more dismissView ];
        NSArray * arra;

        if (_num1.length>0||_num2.length>0||_roomSourceType.length>0||_isHaveImage.length>0||_jiaoYiStyle>0||_tradeAcceptStr>0||_propertyOccupyAcceptStr>0||_propertyDirectionAcceptStr>0||_propertyOwn1AcceptStr>0||_propertyTrustAcceptStr>0||_countFAcceptStr>0||_countTAcceptStr>0||_squareFromAcceptStr>0||_squareToAcceptStr>0||_custTelAcceptStr>0||_userCodeAcceptStr>0||_statusLimitAcceptStr>0||_effectiveDateFromAcceptStr>0||_effectiveDateToAcceptStr>0) {
            arra = [NSArray arrayWithObjects:_num1,_num2,_roomSourceType,_isHaveImage, _jiaoYiStyle,_tradeAcceptStr,_propertyOccupyAcceptStr,_propertyDirectionAcceptStr,_propertyOwn1AcceptStr,_propertyTrustAcceptStr,_countFAcceptStr,_countTAcceptStr,_squareFromAcceptStr,_squareToAcceptStr,_custTelAcceptStr,_userCodeAcceptStr,_statusLimitAcceptStr,_effectiveDateFromAcceptStr,_effectiveDateToAcceptStr,nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"menuinfo" object:nil userInfo:@{@"string1":arra}];
            return;
        }
        else{
            arra = [NSArray arrayWithObjects:@"",nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"menuinfo" object:nil userInfo:@{@"string1":arra}];
            return;
        }
    }
}
-(void)getAStringByBlock:(void (^)(NSMutableDictionary *))block
{
    self.dicBlock = nil;
    self.dicBlock = block;
}
-(void)whichButtonClick:(UIButton *)sender
{
    
 // NSDictionary *adic = @{@"学区房":@"",@"经理推荐":@"",@"急售":@""};
//  NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:adic];
//  switch (sender.tag) {
//        case 0:
//            [dic setObject:@"1" forKey:@"学区房"];
//            NSLog(@"%ld",sender.tag);
//            break;
//        case 1:
//            [dic setObject:@"1" forKey:@"经理推荐"];
//            NSLog(@"%ld",sender.tag);
//            break;
//        default:
//             [dic setObject:@"1" forKey:@"急售"];
//            NSLog(@"%ld",sender.tag);
//            break;
//    }
//    self.dicBlock(dic);
//    if ([self.delegate respondsToSelector:@selector(dismiss)]) {
//        [self.delegate dismiss];
//    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 0.1;
    }
    else
    {
        return 0.1;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return @"";
        
    }
    else
    {
        return @"";
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 12;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdertifer = @"cell";
    UITableViewCell * cell = [_customTableView dequeueReusableCellWithIdentifier:cellIdertifer];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdertifer];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.section==0)
    {
        cell.textLabel.text = @"楼栋号";
        cell.detailTextLabel.text = _louDongNum;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];

    }
    else if(indexPath.section == 1)
    {
        cell.textLabel.text = @"楼栋类型";
        cell.detailTextLabel.text = _roomSourceType;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];

    }
    else if(indexPath.section == 2)
    {
        cell.textLabel.text = @"是否有图";
        cell.detailTextLabel.text = _isHaveImage;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];

    }
    else if (indexPath.section == 3)
    {
        cell.textLabel.text = @"委托状态";
        cell.detailTextLabel.text = _jiaoYiStyle;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    else if (indexPath.section ==4)
    {
        cell.textLabel.text = @"房源类型";
        cell.detailTextLabel.text = _tradeAcceptStr;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    else if (indexPath.section == 5)
    {
        cell.textLabel.text = @"房屋现状";
        cell.detailTextLabel.text = _propertyOccupyAcceptStr;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    else if (indexPath.section == 6)
    {
        cell.textLabel.text = @"物业归属";
        cell.detailTextLabel.text = _propertyOwn1AcceptStr;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    else if (indexPath.section == 7)
    {
        cell.textLabel.text = @"房屋类型";
        cell.detailTextLabel.text = _countFTAcceptStr;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    else if (indexPath.section == 8)
    {
        cell.textLabel.text = @"建筑面积";
        cell.detailTextLabel.text = _squareFromToAcceptStr;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];

    }
    else if (indexPath.section == 9)
    {
        cell.textLabel.text = @"房屋朝向";
        cell.detailTextLabel.text = _propertyDirectionAcceptStr;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
        
    }
    else if (indexPath.section == 10)
    {
        cell.textLabel.text = @"房源特点";
        cell.detailTextLabel.text = _propertyTrustAcceptStr;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    else if (indexPath.section == 11)
    {
        cell.textLabel.text = @"业主联系方式";
        cell.detailTextLabel.text = _custTelAcceptStr;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    RoomStyleViewController * roomstyle =viewContrs[0];
    roomstyle.gest = self;
    
    if (indexPath.section==0)
    {
        roomstyle.isShowSection = 0;
        [self.navigationController pushViewController:roomstyle animated:YES];
    }
    else if (indexPath.section==1)
    {
        roomstyle.isShowSection =1;
        [self.navigationController pushViewController:roomstyle animated:YES];
    }
    else if (indexPath.section==2)
    {
        roomstyle.isShowSection =2;
        [self.navigationController pushViewController:roomstyle animated:YES];
    }
    else if(indexPath.section == 3)
    {
        roomstyle.isShowSection = 3;
        [self.navigationController pushViewController:roomstyle animated:YES];
    }
    else if(indexPath.section == 6)
    {
        PL_ALERT_SHOW(@"此功能敬请期待");
//        roomstyle.isShowSection = 6;
//        [self.navigationController pushViewController:roomstyle animated:YES];
    }

    else
    {
        roomstyle.isShowSection = indexPath.section;
        [self.navigationController pushViewController:roomstyle animated:YES];
    }
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
