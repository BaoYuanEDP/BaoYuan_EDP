//  VisiterDetailSetViewController.m
//  BYFCApp
//
//  Created by zzs on 15/5/19.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "VisiterDetailSetViewController.h"
#import "PL_Header.h"
@interface VisiterDetailSetViewController ()<UITableViewDataSource,UITableViewDelegate,CustomDelegate,UITextFieldDelegate>

{

//    UITableView  *dropDownTableView;
    
    int a;
    
    __weak IBOutlet UIButton *yiXiangButton;
    __weak IBOutlet UIButton *gouJiaButton;
    
    __weak IBOutlet UIButton *zuJiaButton;
    
}




@property (nonatomic,strong) UITableView  *dropDownTableView;
//@property(nonatomic,strong) PriceRangeData *price;

@end

@implementation VisiterDetailSetViewController
-(UITableView *)dropDownTableView
{
    if (!_dropDownTableView) {
        _dropDownTableView = [[UITableView alloc]init];
        _dropDownTableView.delegate = self;
        _dropDownTableView.dataSource = self;
        
    }
    return _dropDownTableView;
}
//-(PriceRangeData *)price{
//
//    if (!_price) {
//        _price = [[PriceRangeData alloc]init];
//    }
//    return _price;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"修改客户需求";
    
    
    //面积
    hallStrText = @"";
    bigStrText = @"";
    
    _hallStr =  [_smallStr  componentsSeparatedByString:@"-"].firstObject;
    bigStr = [_smallStr componentsSeparatedByString:@"-"].lastObject;
 
//    _houseTextField.text =  hallStr;
//    _houseBigTextField.text = bigStr;
    _houseTextField.text =  @"";
    _houseBigTextField.text = @"";


    //房厅
    roomText = @"";
    hallText = @"";
    room = [_roomStr componentsSeparatedByString:@"房"].firstObject;
    hall = [_hallStr componentsSeparatedByString:@"厅"].firstObject;
//    _roomTextField.text = room;
//    //NSLog(@"roomstr %@",_roomStr);
//    _hallTextField.text = hall;
    _roomTextField.text = @"";
    //NSLog(@"roomstr %@",_roomStr);
    _hallTextField.text = @"";
    
    NSLog(@"_DistricName  %@",_DistricName);
    //意向区域
    districNameSend = @"";
    districName = _DistricName;
    areaID1 = _AreaID;
//    if ([districName isKindOfClass:[NSNull class]]||[districName isEqualToString:@"<null>"]||districName==nil||[_AreaName isEqualToString:@"<null>"]||_AreaName==nil) {
////        NSLog(@"bbbbbbbb");
//        [yiXiangButton setTitle:@"点击选择意向区域" forState:UIControlStateNormal];
//        
//    }else{
//          [yiXiangButton setTitle:[NSString stringWithFormat:@"%@%@",_DistricName,_AreaName] forState:UIControlStateNormal];
//    }
    [yiXiangButton setTitle:@"点击选择意向区域" forState:UIControlStateNormal];

    //购价初始值
    hallPriceSend = @"";
    bigPriceSend = @"";
    priceName = _Price;
    NSLog(@"price:%@",priceName);
    if ([priceName isKindOfClass:[NSNull class]]||[priceName isEqualToString:@""]||priceName==nil ) {
        
        [gouJiaButton setTitle:@"选择购价" forState:UIControlStateNormal];
        
    }else{
        [gouJiaButton setTitle:_Price forState:UIControlStateNormal];
    }
    NSLog(@"_Rental  %@",_Rental);
    //租价初始值
    hallRentSend = @"";
    bigPriceSend = @"";
    RentName = _Rental;
    if (RentName== nil||[RentName isKindOfClass:[NSNull class]]||[RentName isEqualToString:@""]) {
        
        [zuJiaButton setTitle:@"选择租价" forState:UIControlStateNormal];
        [gouJiaButton setTitle:@"选择购价" forState:UIControlStateNormal];
    }else{
        [zuJiaButton setTitle:_Rental forState:UIControlStateNormal];
    }
    //自定义返回按钮
    UIButton * backItemBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    backItemBnt.frame = CGRectMake(20, 10, 10, 20);
    [backItemBnt setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [backItemBnt addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:backItemBnt];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
}

#pragma mark -- 自定义返回按钮
-(void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//选择意向区域
- (IBAction)yiXiangButton:(UIButton*)sender1 {
    a=1;
    NSLog(@"%d",a);
    [self post];
   
   // NSLog(@"USER_ID%@",[PL_USER_STORAGE objectForKey:PL_USER_NAME]);
    
    
}

#pragma mark//选择购房价
- (IBAction)gouJiaButton:(UIButton*)sender {
    a=2;
    NSLog(@"%d",a);
    yiXiangButton.selected = NO;
    zuJiaButton.selected = NO;
   
    
    [self post];
    
    if (!sender.selected)
    {
        
        self.dropDownTableView.frame = CGRectMake(sender.frame.origin.x-30, sender.frame.origin.y+sender.frame.size.height+5, 150, 160) ;
        
        [sender.superview addSubview:self.dropDownTableView];
        self.dropDownTableView.backgroundColor = [UIColor whiteColor];
        sender.selected = YES;
        [self.dropDownTableView reloadData];
    }
    else
    {
        
        [self.dropDownTableView removeFromSuperview];
        sender.selected = NO;
    }
    
}
#pragma mark  选择租房价
- (IBAction)zuJiaButton:(UIButton*)sender {
    a=3;
    NSLog(@"%d",a);
    yiXiangButton.selected = NO;
    gouJiaButton.selected = NO;
        [self post];
    if (!sender.selected)
    {
    
        self.dropDownTableView .frame= CGRectMake(sender.frame.origin.x-40, sender.frame.origin.y+sender.frame.size.height+5, 150, 120) ;
        [sender.superview addSubview:self.dropDownTableView];
        self.dropDownTableView.backgroundColor = [UIColor whiteColor];
        sender.selected = YES;
        [self.dropDownTableView reloadData];
        
    }
    else
    {
        
        [self.dropDownTableView removeFromSuperview];
        sender.selected = NO;
        
    }

    
}
#pragma mark  传过去的数据处理
-(VisiterUpdate*)judgeData{

    VisiterUpdate *visterUpdate = [[VisiterUpdate alloc]init];
  
    visterUpdate.CustID = _CustID;
    visterUpdate.CountF = roomText;
    visterUpdate.CountT = hallText;
    NSLog(@"visterUpdate.CountF:%@",visterUpdate.CountF);
    NSLog(@"visterUpdate.CountT:%@",visterUpdate.CountT);
    visterUpdate.SquareMin = hallStrText;
    visterUpdate.SquareMax = bigStrText;

    if (_string1 ==nil) {
        visterUpdate.DistrictName=_DistricName;
    }else{
        visterUpdate.DistrictName =_string1;
    }
    if (_string2 == nil){
        visterUpdate.AreaName = _AreaName;
        
    }else {
        visterUpdate.AreaName = _string2;
    }
    if (areaId ==nil) {
        visterUpdate.AreaID = areaID1;
    }else{
    visterUpdate.AreaID = areaId;
    }
    if (hallPrice==nil) {
        hallPriceSend = @"";
        bigPrice = @"";
    }else{
        hallPriceSend = hallPrice;
        if ([bigPrice isEqualToString:@"以上"]) {
            bigPrice = @"";
        }else
        {
            bigPriceSend = bigPrice;
        }
    }
    visterUpdate.PriceMin = hallPriceSend;
    visterUpdate.PriceMax = bigPrice;
    if (hallRent==nil) {
         hallRentSend = @"";
         bigRentSend = @"";
    }else{
        hallRentSend = hallRent;
        if ([bigRent isEqualToString:@"以上"]) {
            bigRent = @"";
        }
        bigRentSend = bigRent;
    }
    visterUpdate.RentalMin = hallRentSend;
    visterUpdate.RentalMax = bigRentSend;
    visterUpdate.userid =[PL_USER_STORAGE objectForKey:PL_USER_USERID];
    visterUpdate.token = [PL_USER_STORAGE objectForKey:PL_USER_TOKEN];
    visterUpdate.FromPort = @"ios";
    
    return visterUpdate;
}


#pragma mark   提交按钮
- (IBAction)sendButton:(UIButton*)sender {
    [_roomTextField resignFirstResponder];
    [_houseTextField resignFirstResponder];
    [_houseBigTextField resignFirstResponder];
    [_hallTextField resignFirstResponder];
    
    NSLog(@"客源ID:%@",[self judgeData].CustID);
    NSLog(@"城区名称:%@",[self judgeData].DistrictName );
    NSLog(@"片区ID：%@",[self judgeData].AreaID);
    NSLog(@"房：%@",[self judgeData].CountF);
    NSLog(@"厅：%@",[self judgeData].CountT);
    NSLog(@"最小面积：%@",[self judgeData].SquareMin);
    NSLog(@"最大面积：%@",[self judgeData].SquareMax);
    NSLog(@"最小购价：%@",[self judgeData].PriceMin);
    NSLog(@"最大购价：%@",[self judgeData].PriceMax);
    NSLog(@"最小租价：%@",[self judgeData].RentalMin);
    NSLog(@"最大租价：%@",[self judgeData].RentalMax);
    NSLog(@"操作来源：%@",[self judgeData].FromPort);
    NSLog(@"账号：%@",[PL_USER_STORAGE objectForKey:PL_USER_USERID]);
    NSLog(@"token:%@",[PL_USER_STORAGE objectForKey:PL_USER_TOKEN]);
    
    int min = [self judgeData].SquareMin.intValue;
    int max = [self judgeData].SquareMax.intValue;
    if(min > max)
    {
        PL_ALERT_SHOW(@"最大意向面积必须大于最小意向面积");
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定要修改需求吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" ,nil];
        NSLog(@"<<<<<<<<<<<<<>>>>>>>>>>%@",alert);
        [alert show];
    }
    
    
   

//    [[MyRequest defaultsRequest] afSetCustUpdate:[self judgeData] completeBack:^(NSString *str) {
//        NSLog(@"str:%@",str);
//        NSString *string = [[NSString alloc]init];
//        string = str;
//        if ([string isEqualToString:@"OK"]) {
//            PL_ALERT_SHOW(@"修改成功");
//               [self.navigationController popViewControllerAnimated:YES];
//        }else if ([string isEqualToString:@"ERR"]){
//        
//            PL_ALERT_SHOW(@"修改失败");
//        }else if ([string isEqualToString:@"1"]){
//             PL_ALERT_SHOW(@"无修改");
//        }else{
//        
//             PL_ALERT_SHOW(@"缺少客源ID");
//        }
//    }];
    
//[[MyRequest defaultsRequest]afSetCustUpdate:[self judgeData]completeBack:^(NSString *str) {
//    NSLog(@"&&&&&&&&&&&&&&&%@",str);
//}];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSLog(@"点击了确定按钮");
        [[MyRequest defaultsRequest] afSetCustUpdate:[self judgeData] completeBack:^(NSString *str) {
            NSLog(@"str:%@",str);
            NSString *string = [[NSString alloc]init];
            string = str;
            if ([string isEqualToString:@"OK"]) {
                PL_ALERT_SHOW(@"修改成功");
                [self.navigationController popViewControllerAnimated:YES];
            }else if ([string isEqualToString:@"ERR"]){
                
                PL_ALERT_SHOW(@"修改失败");
            }else if ([string isEqualToString:@"1"]){
                PL_ALERT_SHOW(@"无修改");
            }else{
                
                PL_ALERT_SHOW(@"缺少客源ID");
            }
        }];
    }
    else {
        NSLog(@"点击了取消按钮");
    }
}

//清空按钮
- (IBAction)emptyButton:(UIButton*)sender {
    NSLog(@"aaaaaaaaa");
    _houseTextField.text = @"";
    _houseBigTextField.text = @"";
    _roomTextField.text = @"";
    _hallTextField.text = @"";
    
    [yiXiangButton setTitle:@"点击选择意向城区" forState:UIControlStateNormal];
    [gouJiaButton setTitle:@"选择购价" forState:UIControlStateNormal];
    [zuJiaButton setTitle:@"选择租价" forState:UIControlStateNormal];
    
    
}


#pragma mark  //请求数据
-(void)post{
    
    
    if (a==1) {
        [[VisitersRequest defaultsRequest]requestAreaInfoMessage:@"2" roomDistrictId:@"" roomDisName:@"" userName:[PL_USER_STORAGE objectForKey:PL_USER_USERID] userTokne:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] backInfoMessage:^(NSMutableArray *array) {
            
            if (array.count>0)
            {
                //            NSLog(@"=========%s",__FUNCTION__);
                NSMutableArray * tempArray = [NSMutableArray array];
                
                for (NSDictionary * dict in array)
                {
                    roomAreaPlace * roomArea = [[roomAreaPlace alloc]init];
                    
                    roomArea.areaDistrictId = dict[@"DistrictId"];
                    roomArea.areaDistrictName =dict[@"DistrictName"];
                    NSLog(@"++++++%@,%@",roomArea.areaDistrictId,roomArea.areaDistrictName);
                    [tempArray addObject:roomArea];
                }
                roomAreaPlace * virtuRoom = [[roomAreaPlace alloc]init];
                virtuRoom.areaDistrictName = @"不限";
                virtuRoom.areaDistrictId   = @"";
                [tempArray insertObject:virtuRoom atIndex:0];
                CustomAddView * addView = [[CustomAddView alloc]initWithArray:tempArray];
                addView.delegate = nil;
                addView.delegate = self;
                [addView showInView:self.view animation:YES];
            }
            else
            {
                PL_ALERT_SHOWNOT_OKAND_YES(@"暂无区域数据");
                
            }
            
        } string:^(NSString *string) {
            
        }];
        
    }else if (a==2){
        
        PriceRangeData *price = [[PriceRangeData alloc]init];
        price.userid=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
        price.token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        price.PriceType =@"售价";
        
        [[MyRequest defaultsRequest]getPriceRange:price backInfoMessage:^(NSMutableString *string) {
            
            NSLog(@"********************%@",string);
            
            if ([string isEqualToString:@"NOLOGIN"]) {
                ViewController *login=[[ViewController alloc]init];
                [self.navigationController pushViewController:login animated:YES];
            }
            else if ([string isEqualToString:@"exception"])
            {
                PL_ALERT_SHOW(@"服务器异常");
                priceArray=nil;
            }
            else if ([string isEqualToString:@"[]"]) {
                PL_ALERT_SHOW(@"暂无数据");
                priceArray=nil;
            }
            else
            {
                SBJSON *json=[[SBJSON alloc]init];
                priceArray=[json objectWithString:string error:nil];
                NSLog(@"%@",priceArray);
                NSLog(@"%lu",(unsigned long)priceArray.count);
            }
            
            [_dropDownTableView reloadData];
            //  [_tableView2 reloadData];
            PL_PROGRESS_DISMISS;
            
            
        }];
        
    }else if(a==3){
        PriceRangeData *price = [[PriceRangeData alloc]init];
        price.userid=[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME];
        price.token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
        price.PriceType =@"租价";
    
        [[MyRequest defaultsRequest]getPriceRange:price backInfoMessage:^(NSMutableString *string) {
            
            NSLog(@"********************%@",string);
            
            if ([string isEqualToString:@"NOLOGIN"]) {
                ViewController *login=[[ViewController alloc]init];
                [self.navigationController pushViewController:login animated:YES];
            }
            else if ([string isEqualToString:@"exception"])
            {
                PL_ALERT_SHOW(@"服务器异常");
                priceArray=nil;
            }
            else if ([string isEqualToString:@"[]"]) {
                PL_ALERT_SHOW(@"暂无数据");
                priceArray=nil;
            }
            else
            {
                SBJSON *json=[[SBJSON alloc]init];
                priceArray=[json objectWithString:string error:nil];
                NSLog(@"%@",priceArray);
                NSLog(@"%lu",(unsigned long)priceArray.count);
            }
            
            [_dropDownTableView reloadData];
            //  [_tableView2 reloadData];
            PL_PROGRESS_DISMISS;
            
            
        }];
    }
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return priceArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor clearColor];
    NSDictionary *dic=[priceArray objectAtIndex:indexPath.row];
    if (a==1) {
        cell.textLabel.text = @(indexPath.row).description;
    }
    if (a==2) {
        
       NSString *priceStr=[NSString stringWithFormat:@"%@-%@万元",[dic  objectForKey:@"PRICEUP"],[dic objectForKey:@"PRICEDOWN"]];
        //gouJiaButton.titleLabel.text=priceStr;
        cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
       cell.textLabel.text = priceStr;
    }
    if (a==3) {
        NSString *priceStr=[NSString stringWithFormat:@"%@-%@元/月",[dic  objectForKey:@"PRICEUP"],[dic objectForKey:@"PRICEDOWN"]];
        cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
        cell.textLabel.text = priceStr;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *dict = [priceArray objectAtIndex:indexPath.row];
    if (a==2) {
        
        NSString *price=[NSString stringWithFormat:@"%@-%@万元",[dict  objectForKey:@"PRICEUP"],[dict objectForKey:@"PRICEDOWN"]];
        
        NSLog(@"+++%@",price);
    
        hallPrice = [dict objectForKey:@"PRICEUP"];
        bigPrice = [dict objectForKey:@"PRICEDOWN"];
        NSLog(@"---%@",hallPrice);
        NSLog(@"---%@",bigPrice);
        [gouJiaButton setTitle:price forState:UIControlStateNormal];
        
        [_dropDownTableView removeFromSuperview];
      //  NSLog(@"--------------------------%@",gouJiaButton.titleLabel.text);
        
    }else if(a==3){
    
           NSString *zujiaStr=[NSString stringWithFormat:@"%@-%@元/月",[dict  objectForKey:@"PRICEUP"],[dict objectForKey:@"PRICEDOWN"]];
        
        hallRent = [dict objectForKey:@"PRICEUP"];
        bigRent =[dict objectForKey:@"PRICEDOWN"];
        NSLog(@"---%@",hallRent);
        NSLog(@"---%@",bigRent);
        [zuJiaButton setTitle:zujiaStr forState:UIControlStateNormal];
        [_dropDownTableView removeFromSuperview];
    }
    
    
}



-(void)didSelectRowIndexPath:(NSIndexPath *)indexPath administrativeArea:(NSString *)adminnistat
{
    [yiXiangButton setTitle:adminnistat forState:UIControlStateNormal];
    if ([adminnistat isEqualToString:@"不限"]) {
        _string1 = adminnistat;
        _string2 = @"";
    }
    else
    {
        _string1 = adminnistat;
        _string2 = @"";
    }
}
#pragma mark  传区域
-(void)didSelectRowIndexPath:(NSIndexPath *)indexPath sadministativeArea:(NSString *)adminnistat
{
    
    if ([adminnistat isEqualToString:@"全部片区"])
    {
        _string2 = @"";
        [yiXiangButton setTitle:[yiXiangButton.titleLabel.text stringByAppendingFormat:@" %@",_string2] forState:UIControlStateNormal];
    }
    else
    {
        [yiXiangButton setTitle:[yiXiangButton.titleLabel.text stringByAppendingFormat:@" %@",adminnistat] forState:UIControlStateNormal];
        _string2 = adminnistat;
    }
}
#pragma mark 传areaID
-(void)didSelectRowIndexPath:(NSIndexPath *)indexPath AreaID:(NSString *)areaID{

    if ([areaId isEqualToString:@"全部片区"])
    {
        areaId = @"";
    }
    else
    {
        areaId = areaID;
    }
    
    
}

//- (void)didSelRowIndexPath:(NSIndexPath *)indexPath titleName:(NSString *)string xingzhengqu:(NSString *)string1
//{
//    NSLog(@"%@  -%ld++ %@",string,(long)indexPath.row,string1);
//    NSLog(@">>>>>>%@",areaBtn.titleLabel.text);
//    self.titleArea = [NSString stringWithFormat:@"%@ %@",string1,string];
//    [areaBtn setTitle:_titleArea forState:UIControlStateNormal];
//
//    _string1 = string1;
//    _string2 = string;
//     NSLog(@"<<<<<<<<<<%@",areaBtn.titleLabel.text);
//
//
//
//}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    hallText = _hallTextField.text;
    
    hallStrText = _houseTextField.text;
    bigStrText = _houseBigTextField.text;
    roomText = _roomTextField.text;
    

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
