//
//  RoomStyleViewController.m
//  BYFCApp
//
//  Created by PengLee on 15/4/13.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "RoomStyleViewController.h"
#import "PL_Header.h"


@interface RoomStyleViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * moreArr;
    NSArray *isImageArr;
    NSArray *jiaoYiArr;
    NSMutableArray *selectArr;
    NSArray *tradeArrs;
    NSArray *propertyOccupyArrs;
    NSArray *propertyOwn1Arrs;
    NSArray *propertyDirectionArrs;
    NSArray *propertyTrustArrs;
    
    NSArray *timeArr;
    
//    交易状态
    BOOL isSelected;
    BOOL isSelected1;
    BOOL isSelected2;
    BOOL isSelected3;
    //房源类型
    BOOL isSelect;
    BOOL isSelect1;
    BOOL isSelect2;
    BOOL isSelect3;
    BOOL isSelect4;
    BOOL isSelect5;
    //是否有图
    BOOL select;
    BOOL select1;
    BOOL select2;
    //有效请选择按钮
    UIButton *selectButton;
    //员工编号
    UITextField *numTextfield;
    //选择有效时间列表
    UITableView *timeTableView;
    BOOL isOK;
    //有效时间开始时间
    UITextField *startTimeTextfield;
    UIButton * startTimeBut;
    //有效时间结束时间
    UITextField *endTimeTextfield;
    UIButton * endTimeBut;


    NSString *butStr;
}
@property (strong,nonatomic)UITableView * customTableView;

@property (assign, nonatomic) NSInteger rowNow;
@property (assign, nonatomic) NSInteger sectionNow;
@property (assign, nonatomic) NSInteger rowNow1;
@property (assign, nonatomic) NSInteger sectionNow1;
@property (assign, nonatomic) NSInteger rowNow2;
@property (assign, nonatomic) NSInteger sectionNow2;
@property (assign, nonatomic) NSInteger rowNow3;
@property (assign, nonatomic) NSInteger sectionNow3;
@property (assign, nonatomic) NSInteger rowNow4;
@property (assign, nonatomic) NSInteger sectionNow4;
@property (assign, nonatomic) NSInteger rowNow5;
@property (assign, nonatomic) NSInteger sectionNow5;
@property (assign, nonatomic) NSInteger rowNow6;
@property (assign, nonatomic) NSInteger sectionNow6;
@property (assign, nonatomic) NSInteger rowNow7;
@property (assign, nonatomic) NSInteger sectionNow7;
@end

@implementation RoomStyleViewController
@synthesize   roomdelegate;

- (void)viewWillAppear:(BOOL)animated
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [_customTableView reloadData];
    _propertyStyle=@"";
    _imageStyle = @"";
    _jiaoYiStyle = @"";
    _tradeArrStyle = @"";
    _propertyOccupyArrStyle = @"";
    _propertyOwn1ArrStyle = @"";
    _propertyDirectionArrStyle = @"";
    _propertyTrustArrStyle = @"";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"筛选";
    _customTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH-60, PL_HEIGHT) style:UITableViewStyleGrouped];
    _customTableView.backgroundColor = [UIColor clearColor];
    _customTableView.dataSource = self;
    _customTableView.delegate = self;
    _customTableView.scrollEnabled = NO;
    [self.view addSubview:_customTableView];
    [_customTableView reloadData];
    isOK = NO;
    butStr = @"请选择";
     moreArr=[NSArray arrayWithObjects:@"不限",@"多层",@"高层",@"别墅",@"多类层",@"小高层", nil];
    isImageArr = [NSArray arrayWithObjects:@"全部",@"无图",@"有图", nil];
    jiaoYiArr = [NSArray arrayWithObjects:@"有效",@"无效",@"已租",@"已售", nil];
    
    tradeArrs = [NSArray arrayWithObjects:@"出租",@"出售",@"租售", nil];
    propertyOccupyArrs = [NSArray arrayWithObjects:@"业主住",@"空置",@"租客住", nil];
    propertyOwn1Arrs = [NSArray arrayWithObjects:@"私人物业",@"公司物业",@"共有物业",@"使用权", nil];
    propertyDirectionArrs = [NSArray arrayWithObjects:@"东",@"西",@"南",@"北",@"东南",@"西南",@"正南", nil];
    propertyTrustArrs = [NSArray arrayWithObjects:@"独家",@"签赔", nil];
    timeArr = [NSArray arrayWithObjects:@"请选择",@"当天",@"3天",@"7天",@"10天",@"全部",@"自定义", nil];
    selectArr = [NSMutableArray array];
    self.navigationController.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(viewSureClick:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
    UIButton * backBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backBnt.frame = CGRectMake(0, 0, 40, 20);
    [backBnt addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
//    [backBnt setBackgroundImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
    [backBnt setTitle:@"取消" forState:UIControlStateNormal];
    backBnt.titleLabel.font=[UIFont systemFontOfSize:17.0f];
    [backBnt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
}
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewSureClick:(UIBarButtonItem *)bar
{
    selectArr = [NSMutableArray array];
    if(_isShowSection == 0)
    {
        if([textfield.text isEqualToString:@""]&&[textfield1.text isEqualToString:@""])
        {
            _gest.louDongNum = @"";
        }
        else if([textfield.text isEqualToString:@""]&&![textfield1.text isEqualToString:@""])
        {
            _gest.louDongNum = [NSString stringWithFormat:@"%@室",textfield1.text];
            
        }
        else if(![textfield.text isEqualToString:@""]&&[textfield1.text isEqualToString:@""])
        {
            _gest.louDongNum = [NSString stringWithFormat:@"%@号",textfield.text];
            
        }
        else
        {
            _gest.louDongNum = [NSString stringWithFormat:@"%@号%@室",textfield.text,textfield1.text];
            
        }
        _gest.num1 = textfield.text;
        _gest.num2 = textfield1.text;
        [self.navigationController popViewControllerAnimated:YES];
    }
    if(_isShowSection == 1)
    {
        _gest.roomSourceType = _propertyStyle;
        [self.navigationController popViewControllerAnimated:YES];
    }
    if(_isShowSection == 2)
    {
        _gest.isHaveImage = _imageStyle;
        [self.navigationController popViewControllerAnimated:YES];

    }
    if(_isShowSection == 3)
    {
        _gest.jiaoYiStyle = _jiaoYiStyle;
        _gest.userCodeAcceptStr = numTextfield.text;
        _gest.effectiveDateFromAcceptStr = startTimeTextfield.text;
        _gest.effectiveDateToAcceptStr = endTimeTextfield.text;
        _gest.statusLimitAcceptStr =butStr;
        [self.navigationController popViewControllerAnimated:YES];

    }
    if(_isShowSection == 4)
    {
        _gest.tradeAcceptStr = _tradeArrStyle;
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    if(_isShowSection == 5)
    {
        _gest.propertyOccupyAcceptStr = _propertyOccupyArrStyle;
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    if(_isShowSection == 6)
    {
        _gest.propertyOwn1AcceptStr = _propertyOwn1ArrStyle;
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    if(_isShowSection == 7)
    {
        if([textfield2.text isEqualToString:@""]&&[textfield3.text isEqualToString:@""])
        {
            _gest.countFTAcceptStr = @"";
        }
        else if([textfield2.text isEqualToString:@""]&&![textfield3.text isEqualToString:@""])
        {
            _gest.countFTAcceptStr = [NSString stringWithFormat:@"%@厅",textfield3.text];

        }
        else if(![textfield2.text isEqualToString:@""]&&[textfield3.text isEqualToString:@""])
        {
            _gest.countFTAcceptStr = [NSString stringWithFormat:@"%@室",textfield2.text];
            
        }
        else
        {
            _gest.countFTAcceptStr = [NSString stringWithFormat:@"%@房%@厅",textfield2.text,textfield3.text];

        }
        _gest.countFAcceptStr = textfield2.text;
        _gest.countTAcceptStr = textfield3.text;
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    if(_isShowSection == 8)
    {
        
        
        if([textfield4.text isEqualToString:@""]&&[textfield5.text isEqualToString:@""])
        {
            _gest.squareFromToAcceptStr = @"";
        }
        else
        {
            _gest.squareFromToAcceptStr = [NSString stringWithFormat:@"%@-%@平米",textfield4.text,textfield5.text];
        }
        _gest.squareFromAcceptStr = textfield4.text;
        _gest.squareToAcceptStr = textfield5.text;
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    if(_isShowSection == 9)
    {
        _gest.propertyDirectionAcceptStr = _propertyDirectionArrStyle;
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    if(_isShowSection == 10)
    {
        _gest.propertyTrustAcceptStr = _propertyTrustArrStyle;
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    if(_isShowSection == 11)
    {
        _gest.custTelAcceptStr = textfield6.text;
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    NSLog(@"你好");
    [_customTableView reloadData];
//    NSLog(@"%@ %@  %@  %@ %@",textfield.text,textfield1.text,_propertyStyle,_imageStyle,_jiaoYiStyle);
//    _text1String= textfield.text;
//    _text2String = textfield1.text;
//    if ([self.roomdelegate respondsToSelector:@selector(sendSelfText1:selfText2:styleString:)])
//    {
//        [self.roomdelegate sendSelfText1:_text1String selfText2:_text2String styleString:_propertyStyle];
//        
//    }

   }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _customTableView) {
        if (indexPath.row == 0) {
            if (isOK) {
                return 70;
            }
            else
            {
                return 40;
            }
        }
        else
        {
            return 40;
        }


    }
    else if(tableView == timeTableView)
    {
        return 30;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{ if(tableView == _customTableView)
    {
        return 35;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == _customTableView) {
        if (_isShowSection == 0)
        {
            return @"输入栋号和室号";
        }
        else if(_isShowSection==1)
        {
            return @"楼栋类型";
        }
        else if(_isShowSection == 2)
        {
            return @"是否有图";
        }
        else if(_isShowSection == 3)
        {
            return @"委托状态";
        }
        else if(_isShowSection == 4)
        {
            return @"房源类型";
        }
        else if(_isShowSection == 5)
        {
            return @"房屋现状";
        }
        else if(_isShowSection == 6)
        {
            return @"物业归属";
        }
        else if(_isShowSection == 7)
        {
            return @"请输入房号厅号";
        }
        else if(_isShowSection == 8)
        {
            return @"请输入建筑面积";
        }
        else if(_isShowSection == 9)
        {
            return @"房屋朝向";
        }
        else if(_isShowSection == 10)
        {
            return @"房源特点";
        }
        else if(_isShowSection == 11)
        {
            return @"业主联系方式";
        }

    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _customTableView) {
        if (_isShowSection == 0)
        {
            return 1;
        }
        else if (_isShowSection== 1)
        {
            
            return moreArr.count;
        }
        else if( _isShowSection == 2)
        {
            return isImageArr.count;
        }
        else if(_isShowSection == 3)
        {
            return jiaoYiArr.count;
        }
        else if(_isShowSection == 4)
        {
            return tradeArrs.count;
        }
        else if(_isShowSection == 5)
        {
            return propertyOccupyArrs.count;
        }
        else if(_isShowSection == 6)
        {
            return propertyOwn1Arrs.count;
        }
        else if(_isShowSection == 6)
        {
            return propertyOwn1Arrs.count;
        }
        else if(_isShowSection == 7)
        {
            return 1;
        }
        else if(_isShowSection == 8)
        {
            return 1;
        }
        else if(_isShowSection == 9)
        {
            return propertyDirectionArrs.count;
        }
        else if(_isShowSection == 10)
        {
            return propertyTrustArrs.count;
        }
        else if(_isShowSection == 11)
        {
            return 1;
        }

    }
    else if(tableView == timeTableView)
    {
        return timeArr.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _customTableView) {
        if (_isShowSection == 0)
        {
            [tableView setEditing:NO];
            static NSString * cellIdertifer = @"cell";
            UITableViewCell * cell = [_customTableView dequeueReusableCellWithIdentifier:cellIdertifer];
            if (!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdertifer];
                
                if (indexPath.section==0)
                {
                    UITextField * text1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, 75, 30)];
                    text1.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                    text1.borderStyle = UITextBorderStyleRoundedRect;
                    text1.tag = 1001;
                    [cell addSubview:text1];
                    UITextField * text2 = [[UITextField alloc]initWithFrame:CGRectMake(110, 5, 75, 30)];
                    text2.borderStyle = UITextBorderStyleRoundedRect;
                    text2.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                    text2.tag = 1002;
                    [cell addSubview:text2];
                }
                
            }
            if (indexPath.section==0)
            {
                textfield = (UITextField *)[cell viewWithTag:1001];
                textfield.placeholder = @"楼栋号:";
                textfield1 = (UITextField *)[cell viewWithTag:1002];
                textfield1.placeholder = @"室号:";
            }
            return cell;
        }
        else if (_isShowSection == 1)
        {
            [tableView setEditing:NO];
            static NSString * cellIdertifer = @"cell1";
            UITableViewCell * cell = [_customTableView dequeueReusableCellWithIdentifier:cellIdertifer];
            if (!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdertifer];
            }
            cell.textLabel.text = moreArr[indexPath.row];
            if (indexPath.row==_rowNow&&indexPath.section==_sectionNow) {
                cell.accessoryType=UITableViewCellAccessoryCheckmark;
            }
            cell.accessoryType=UITableViewCellAccessoryNone;
            
            return cell;
        }
        else if(_isShowSection == 2)
        {   [tableView setEditing:NO];
            static NSString * cellIdertifer = @"cell2";
            UITableViewCell *cell = [_customTableView dequeueReusableCellWithIdentifier:cellIdertifer];
            if(!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdertifer];
            }
            cell.textLabel.text = isImageArr[indexPath.row];
            if (indexPath.row==_rowNow1&&indexPath.section==_sectionNow1) {
                cell.accessoryType=UITableViewCellAccessoryCheckmark;
            }
            cell.accessoryType=UITableViewCellAccessoryNone;
            
            return cell;
        }
        else if(_isShowSection == 3)
        {
            [tableView setEditing:NO];
            static NSString * cellIdertifer = @"cell3";
            UITableViewCell * cell = [_customTableView dequeueReusableCellWithIdentifier:cellIdertifer];
            if (!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdertifer];
                if(indexPath.row == 0)
                {
                    
                    selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
                    selectButton.frame = CGRectMake(PL_WIDTH-60-80, 5, 70, 30);
                    [selectButton setTitle:butStr forState:UIControlStateNormal];
                    selectButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
                    selectButton.layer.borderColor = PL_CUSTOM_COLOR(229, 229, 229, 1).CGColor;
                    selectButton.layer.masksToBounds = YES;
                    selectButton.layer.borderWidth = 1;
                    selectButton.layer.cornerRadius = 5;
                    [selectButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                    [selectButton addTarget:self action:@selector(selectButClick) forControlEvents:UIControlEventTouchUpInside];
                    selectButton.hidden = YES;
                    [cell addSubview:selectButton];
                    numTextfield = [[UITextField alloc] initWithFrame:CGRectMake(60, 8, 100, 30)];
                    numTextfield.placeholder = @"请输入员工编号";
                    numTextfield.font = [UIFont systemFontOfSize:12.0f];
                    numTextfield.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                    numTextfield.borderStyle = UITextBorderStyleRoundedRect;
                    numTextfield.hidden = YES;
                    [cell addSubview:numTextfield];
                    timeTableView = [[UITableView alloc] initWithFrame:CGRectMake(PL_WIDTH-60-80, 80, 70, 180)];
                    timeTableView.delegate = self;
                    timeTableView.dataSource = self;
                    timeTableView.hidden = YES;
                    [_customTableView addSubview:timeTableView];
                    startTimeTextfield = [[UITextField alloc] initWithFrame:CGRectMake(60, 40, 90, 30)];
                    startTimeTextfield.placeholder = @"选择开始时间";
                    startTimeTextfield.font = [UIFont systemFontOfSize:12.0f];
                    startTimeTextfield.keyboardType = UIKeyboardTypeNumberPad;
                    startTimeTextfield.borderStyle = UITextBorderStyleRoundedRect;
                    startTimeTextfield.hidden = YES;
                    startTimeTextfield.userInteractionEnabled = NO;
                    [cell addSubview:startTimeTextfield];
                    startTimeBut = [UIButton buttonWithType:UIButtonTypeCustom];
                    startTimeBut.frame = CGRectMake(60, 40, 90, 30);
                    [startTimeBut addTarget:self action:@selector(startTimeButClick) forControlEvents:UIControlEventTouchUpInside];
                    [cell addSubview:startTimeBut];
                    
                    
                    endTimeTextfield = [[UITextField alloc] initWithFrame:CGRectMake(160, 40, 90, 30)];
                    endTimeTextfield.placeholder = @"选择结束时间";
                    endTimeTextfield.font = [UIFont systemFontOfSize:12.0f];
                    endTimeTextfield.keyboardType = UIKeyboardTypeNumberPad;
                    endTimeTextfield.borderStyle = UITextBorderStyleRoundedRect;
                    endTimeTextfield.hidden = YES;
                    endTimeTextfield.userInteractionEnabled = NO;

                    [cell addSubview:endTimeTextfield];
                    endTimeBut = [UIButton buttonWithType:UIButtonTypeCustom];
                    endTimeBut.frame = CGRectMake(160, 40, 90, 30);
                    [endTimeBut addTarget:self action:@selector(endTimeButClick) forControlEvents:UIControlEventTouchUpInside];
                    [cell addSubview:endTimeBut];

                }
                else
                {
                    
                }

            }
            
            cell.textLabel.text = jiaoYiArr[indexPath.row];
            if (indexPath.row == 0) {
                
            }
            else{
                if (indexPath.row==_rowNow7&&indexPath.section==_sectionNow7) {
                    cell.accessoryType=UITableViewCellAccessoryCheckmark;
                    return cell;
                }
                else
                {
                    cell.accessoryType=UITableViewCellAccessoryNone;
                    return cell;
                }
            }
           
            return cell;
            
        }
        else if(_isShowSection == 4)
        {
            [tableView setEditing:NO];
            static NSString *cellIdertifer = @"cell4";
            UITableViewCell *cell = [_customTableView dequeueReusableCellWithIdentifier:cellIdertifer];
            if(!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdertifer];
            }
            cell.textLabel.text = tradeArrs[indexPath.row];
            if (indexPath.row==_rowNow2&&indexPath.section==_sectionNow2) {
                cell.accessoryType=UITableViewCellAccessoryCheckmark;
            }
            cell.accessoryType=UITableViewCellAccessoryNone;
            return cell;
        }
        
        else if(_isShowSection == 5)
        {
            [tableView setEditing:NO];
            static NSString *cellIdertifer = @"cell5";
            UITableViewCell *cell = [_customTableView dequeueReusableCellWithIdentifier:cellIdertifer];
            if(!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdertifer];
            }
            cell.textLabel.text = propertyOccupyArrs[indexPath.row];
            if (indexPath.row==_rowNow3&&indexPath.section==_sectionNow3) {
                cell.accessoryType=UITableViewCellAccessoryCheckmark;
            }
            cell.accessoryType=UITableViewCellAccessoryNone;
            return cell;
        }
        
        else if(_isShowSection == 6)
        {
            [tableView setEditing:NO];
            static NSString *cellIdertifer = @"cell6";
            UITableViewCell *cell = [_customTableView dequeueReusableCellWithIdentifier:cellIdertifer];
            if(!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdertifer];
            }
            cell.textLabel.text = propertyOwn1Arrs[indexPath.row];
            if (indexPath.row==_rowNow4&&indexPath.section==_sectionNow4) {
                cell.accessoryType=UITableViewCellAccessoryCheckmark;
            }
            cell.accessoryType=UITableViewCellAccessoryNone;
            return cell;
        }
        
        else if(_isShowSection == 7)
        {
            [tableView setEditing:NO];
            static NSString * cellIdertifer = @"cell7";
            UITableViewCell * cell = [_customTableView dequeueReusableCellWithIdentifier:cellIdertifer];
            if (!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdertifer];
                
                if (indexPath.section==0)
                {
                    UITextField * text1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, 75, 30)];
                    text1.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                    text1.borderStyle = UITextBorderStyleRoundedRect;
                    text1.tag = 1003;
                    [cell addSubview:text1];
                    UITextField * text2 = [[UITextField alloc]initWithFrame:CGRectMake(110, 5, 75, 30)];
                    text2.borderStyle = UITextBorderStyleRoundedRect;
                    text2.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                    text2.tag = 1004;
                    [cell addSubview:text2];
                }
                
            }
            if (indexPath.section==0)
            {
                textfield2 = (UITextField *)[cell viewWithTag:1003];
                textfield2.placeholder = @"房号:";
                textfield3 = (UITextField *)[cell viewWithTag:1004];
                textfield3.placeholder = @"厅号:";
            }
            return cell;
            
        }
        
        else if(_isShowSection == 8)
        {
            [tableView setEditing:NO];
            static NSString * cellIdertifer = @"cell8";
            UITableViewCell * cell = [_customTableView dequeueReusableCellWithIdentifier:cellIdertifer];
            if (!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdertifer];
                
                if (indexPath.section==0)
                {
                    UITextField * text1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, 75, 30)];
                    text1.keyboardType = UIKeyboardTypeNumberPad;
                    text1.borderStyle = UITextBorderStyleRoundedRect;
                    text1.tag = 1005;
                    [cell addSubview:text1];
                    UITextField * text2 = [[UITextField alloc]initWithFrame:CGRectMake(110, 5, 75, 30)];
                    text2.borderStyle = UITextBorderStyleRoundedRect;
                    text2.keyboardType = UIKeyboardTypeNumberPad;
                    text2.tag = 1006;
                    [cell addSubview:text2];
                }
                
            }
            if (indexPath.section==0)
            {
                textfield4 = (UITextField *)[cell viewWithTag:1005];
                textfield4.placeholder = @"最小面积:";
                textfield4.font = [UIFont systemFontOfSize:12.0f];
                textfield5 = (UITextField *)[cell viewWithTag:1006];
                textfield5.placeholder = @"最大面积:";
                textfield5.font = [UIFont systemFontOfSize:12.0f];
            }
            return cell;
            
        }
        
        else if(_isShowSection == 9)
        {
            [tableView setEditing:NO];
            static NSString *cellIdertifer = @"cell9";
            UITableViewCell *cell = [_customTableView dequeueReusableCellWithIdentifier:cellIdertifer];
            if(!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdertifer];
            }
            cell.textLabel.text = propertyDirectionArrs[indexPath.row];
            if (indexPath.row==_rowNow5&&indexPath.section==_sectionNow5) {
                cell.accessoryType=UITableViewCellAccessoryCheckmark;
            }
            cell.accessoryType=UITableViewCellAccessoryNone;
            return cell;
        }
        
        else if(_isShowSection == 10)
        {
            [tableView setEditing:NO];
            static NSString *cellIdertifer = @"cell10";
            UITableViewCell *cell = [_customTableView dequeueReusableCellWithIdentifier:cellIdertifer];
            if(!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdertifer];
            }
            cell.textLabel.text = propertyTrustArrs[indexPath.row];
            if (indexPath.row==_rowNow6&&indexPath.section==_sectionNow6) {
                cell.accessoryType=UITableViewCellAccessoryCheckmark;
            }
            cell.accessoryType=UITableViewCellAccessoryNone;
            return cell;
        }
        else if(_isShowSection == 11)
        {
            [tableView setEditing:NO];
            static NSString * cellIdertifer = @"cell11";
            UITableViewCell * cell = [_customTableView dequeueReusableCellWithIdentifier:cellIdertifer];
            if (!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdertifer];
                
                if (indexPath.section==0)
                {
                    UITextField * text1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, 150, 30)];
                    text1.keyboardType = UIKeyboardTypeNumberPad;
                    text1.borderStyle = UITextBorderStyleRoundedRect;
                    text1.tag = 1007;
                    [cell addSubview:text1];
                }
                
            }
            if (indexPath.section==0)
            {
                textfield6 = (UITextField *)[cell viewWithTag:1007];
                textfield6.placeholder = @"请输入电话号码";
            }
            return cell;
            
        }
    }
    else if(tableView == timeTableView)
    {
        static NSString * cellIdertifer = @"cellID";
        UITableViewCell * cell = [timeTableView dequeueReusableCellWithIdentifier:cellIdertifer];
        if(!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdertifer];
        }
        cell.textLabel.text = timeArr[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
        return cell;
    }
    return nil;

   }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _customTableView) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.view endEditing:YES];
        if (_isShowSection == 0)
        {
        }
        else if (_isShowSection == 1)
        {
            NSIndexPath *lastIndexPath=[NSIndexPath indexPathForRow:_rowNow inSection:_sectionNow];
            UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:lastIndexPath];
            lastCell.accessoryType=UITableViewCellAccessoryNone;
            // 设置当前选中的row 的checkMark
            UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
            _propertyStyle = cell.textLabel.text;
            // 重置 _rowNow _secitonNow  为当前选中改行的section 和 row
            _rowNow=indexPath.row;
            _sectionNow=indexPath.section;
            
        }
        else if(_isShowSection == 2)
        {
            
            NSIndexPath *lastIndexPath=[NSIndexPath indexPathForRow:_rowNow1 inSection:_sectionNow1];
            UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:lastIndexPath];
            lastCell.accessoryType=UITableViewCellAccessoryNone;
            // 设置当前选中的row 的checkMark
            UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
            _imageStyle = cell.textLabel.text;
            // 重置 _rowNow _secitonNow  为当前选中改行的section 和 row
            _rowNow1=indexPath.row;
            _sectionNow1=indexPath.section;
        }
        else if(_isShowSection == 3)
        {
            
            NSIndexPath *lastIndexPath=[NSIndexPath indexPathForRow:_rowNow7 inSection:_sectionNow7];
            UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:lastIndexPath];
            lastCell.accessoryType=UITableViewCellAccessoryNone;
            // 设置当前选中的row 的checkMark
            UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
            if(indexPath.row == 0)
            {
                _jiaoYiStyle = cell.textLabel.text;
                selectButton.hidden = NO;
                numTextfield.hidden = NO;
                timeTableView.hidden = YES;
                if ([butStr isEqualToString:@"自定义"]) {
                    startTimeTextfield.hidden = NO;
                    endTimeTextfield.hidden = NO;
                    isOK = YES;
                }
                else
                {
                    startTimeTextfield.hidden = YES;
                    endTimeTextfield.hidden = YES;
                    isOK = NO;
                }
            }
            else
            {
                butStr = @"请选择";
                [selectButton setTitle:butStr forState:UIControlStateNormal];

                selectButton.hidden = YES;
                numTextfield.hidden = YES;
                timeTableView.hidden = YES;
                startTimeTextfield.hidden = YES;
                endTimeTextfield.hidden = YES;
                numTextfield.text = @"";
                startTimeTextfield.text = @"";
                endTimeTextfield.text = @"";
                isOK = NO;
                cell.accessoryType=UITableViewCellAccessoryCheckmark;
                _jiaoYiStyle = cell.textLabel.text;

            }
            // 重置 _rowNow _secitonNow  为当前选中改行的section 和 row
            _rowNow7=indexPath.row;
            _sectionNow7=indexPath.section;
            [_customTableView reloadData];
        }
        else if(_isShowSection == 4)
        {
            
            NSIndexPath *lastIndexPath=[NSIndexPath indexPathForRow:_rowNow2 inSection:_sectionNow2];
            UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:lastIndexPath];
            lastCell.accessoryType=UITableViewCellAccessoryNone;
            // 设置当前选中的row 的checkMark
            UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
            _tradeArrStyle = cell.textLabel.text;
            // 重置 _rowNow _secitonNow  为当前选中改行的section 和 row
            _rowNow2=indexPath.row;
            _sectionNow2=indexPath.section;
        }
        
        else if(_isShowSection == 5)
        {
            
            NSIndexPath *lastIndexPath=[NSIndexPath indexPathForRow:_rowNow3 inSection:_sectionNow3];
            UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:lastIndexPath];
            lastCell.accessoryType=UITableViewCellAccessoryNone;
            // 设置当前选中的row 的checkMark
            UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
            _propertyOccupyArrStyle = cell.textLabel.text;
            // 重置 _rowNow _secitonNow  为当前选中改行的section 和 row
            _rowNow3=indexPath.row;
            _sectionNow3=indexPath.section;
        }
        
        else if(_isShowSection == 6)
        {
            
            NSIndexPath *lastIndexPath=[NSIndexPath indexPathForRow:_rowNow4 inSection:_sectionNow4];
            UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:lastIndexPath];
            lastCell.accessoryType=UITableViewCellAccessoryNone;
            // 设置当前选中的row 的checkMark
            UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
            _propertyOwn1ArrStyle = cell.textLabel.text;
            // 重置 _rowNow _secitonNow  为当前选中改行的section 和 row
            _rowNow4=indexPath.row;
            _sectionNow4=indexPath.section;
        }
        
        else if(_isShowSection == 7)
        {
            
            
        }
        
        else if(_isShowSection == 8)
        {
            
        }
        else if(_isShowSection == 9)
        {
            
            NSIndexPath *lastIndexPath=[NSIndexPath indexPathForRow:_rowNow5 inSection:_sectionNow5];
            UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:lastIndexPath];
            lastCell.accessoryType=UITableViewCellAccessoryNone;
            // 设置当前选中的row 的checkMark
            UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
            _propertyDirectionArrStyle = cell.textLabel.text;
            // 重置 _rowNow _secitonNow  为当前选中改行的section 和 row
            _rowNow5=indexPath.row;
            _sectionNow5=indexPath.section;
        }
        
        else if(_isShowSection == 10)
        {
            
            NSIndexPath *lastIndexPath=[NSIndexPath indexPathForRow:_rowNow6 inSection:_sectionNow6];
            UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:lastIndexPath];
            lastCell.accessoryType=UITableViewCellAccessoryNone;
            // 设置当前选中的row 的checkMark
            UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
            _propertyTrustArrStyle = cell.textLabel.text;
            // 重置 _rowNow _secitonNow  为当前选中改行的section 和 row
            _rowNow6=indexPath.row;
            _sectionNow6=indexPath.section;
        }
        else if(_isShowSection == 11)
        {
            
        }

    }
    else if(tableView == timeTableView)
    {
        butStr = timeArr[indexPath.row];
        [selectButton setTitle:butStr forState:UIControlStateNormal];

        timeTableView.hidden = YES;
        if ([timeArr[indexPath.row] isEqualToString:@"自定义"]) {
            isOK = YES;
            startTimeTextfield.hidden = NO;
            endTimeTextfield.hidden = NO;
            
        }
        else
        {
            isOK = NO;
            startTimeTextfield.hidden = YES;
            endTimeTextfield.hidden = YES;

        }
        [_customTableView reloadData];

    }
   

}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _customTableView) {
        if(_isShowSection == 3)
        {
            return YES;
        }
        return NO;
    }
    else if(tableView == timeTableView)
    {
        return  NO;
    }
    return NO;
   
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    
}
-(void)startTimeButClick
{
    NSLog(@"开始时间");
    
    UIViewController*BackgroundViewCintroller=[[UIViewController alloc]init];
    
    BackgroundViewCintroller.view.frame=CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
    BackgroundViewCintroller.view .backgroundColor=[UIColor clearColor];
    [self.view addSubview:BackgroundViewCintroller.view];
    
    
     CalendarHomeViewController *cal = [[CalendarHomeViewController alloc] init];
    [cal setAirPlaneToDay:365 ToDateforString:nil];
    [BackgroundViewCintroller presentViewController:cal animated:YES completion:^{
       
//        __block CalendarHomeViewController*calBlock;
        cal.calendarblock=^(CalendarDayModel*model)
        {
          
            startTimeTextfield.text=model.toString;
            [BackgroundViewCintroller.view removeFromSuperview];

        };
        
    }];

    
 }
-(void)endTimeButClick
{
    NSLog(@"结束时间");
    UIViewController*BackgroundViewCintroller=[[UIViewController alloc]init];
    
    BackgroundViewCintroller.view.frame=CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT);
    BackgroundViewCintroller.view .backgroundColor=[UIColor clearColor];
    [self.view addSubview:BackgroundViewCintroller.view];
    CalendarHomeViewController *cal = [[CalendarHomeViewController alloc] init];
    [cal setAirPlaneToDay:365 ToDateforString:nil];
    [BackgroundViewCintroller presentViewController:cal animated:YES completion:^{
        
        cal.calendarblock=^(CalendarDayModel*model)
        {
            
            endTimeTextfield.text=model.toString;
            [BackgroundViewCintroller.view removeFromSuperview];
        };
        
    }];

}
-(void)selectButClick
{
    timeTableView.hidden = NO;
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
