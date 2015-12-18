//
//  SHCPublicRoom.m
//  Demo
//
//  Created by zzs on 15/6/30.
//  Copyright (c) 2015年 zzs. All rights reserved.
//

#import "SHCPublicRoom.h"
#import "PL_Header.h"
@implementation SHCPublicRoom

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self turnNextPage];
    }
    return self;
}
-(void)turnNextPage
{
    NSLog(@"写跟进");
    //背景
    bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT)];
    bgView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
    
    [self addSubview:bgView];
    //小背景
    smallView=[[UIView alloc]initWithFrame:CGRectMake(20, PL_HEIGHT/3, PL_WIDTH-40, 200)];
    smallView.alpha=1;
    smallView.backgroundColor=[UIColor whiteColor];
    [bgView addSubview:smallView];
    //标题
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(PL_WIDTH/2-80, 5, 200, 30)];
    title.text=@"录入跟进信息";
    [smallView  addSubview:title];
    //跟进方式、按钮
    UIButton *FSBtn=[[UIButton alloc]initWithFrame:CGRectMake(20+20, 30, 80, 30)];
    FSBtn.highlighted = YES;
    [FSBtn addTarget:self action:@selector(fangshiClick:) forControlEvents:UIControlEventTouchUpInside];
    //FSBtn.backgroundColor=[UIColor redColor];
    [smallView addSubview:FSBtn];
    fangshi=[[UILabel alloc]initWithFrame:CGRectMake(20+20, 35, 50, 20)];
    fangshi.text=@"跟进方式";
    fangshi.font=[UIFont systemFontOfSize:12];
    [smallView addSubview:fangshi];
    fangshiBtn=[[UIButton alloc]initWithFrame:CGRectMake(71+20, 40, 10, 10)];
    [fangshiBtn addTarget:self action:@selector(fangshiClick:) forControlEvents:UIControlEventTouchUpInside];
    [fangshiBtn setImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    [fangshiBtn setImage:[UIImage imageNamed:@"dropup.png"] forState:UIControlStateSelected];
    [smallView addSubview:fangshiBtn];
    //跟进类型、按钮
    UIButton *STBtn=[[UIButton alloc]initWithFrame:CGRectMake(120+40, 30, 80, 30)];
    STBtn.highlighted = YES;
    [STBtn addTarget:self action:@selector(styleClickList:) forControlEvents:UIControlEventTouchUpInside];
    //STBtn.backgroundColor=[UIColor redColor];
    [smallView addSubview:STBtn];
    style=[[UILabel alloc]initWithFrame:CGRectMake(120+40, 35, 50, 20)];
    style.text=@"跟进类型";
    style.font=[UIFont systemFontOfSize:12];
    [smallView addSubview:style];
    styleBtn=[[UIButton alloc]initWithFrame:CGRectMake(171+40, 40, 10, 10)];
    [styleBtn setImage:[UIImage imageNamed:@"dropdown.png"] forState:UIControlStateNormal];
    [styleBtn setImage:[UIImage imageNamed:@"dropup.png"] forState:UIControlStateSelected];
    [styleBtn addTarget:self action:@selector(styleClickList:) forControlEvents:UIControlEventTouchUpInside];
    [smallView addSubview:styleBtn];
    //跟进方式
    NSMutableArray * arrTitleRoom = [NSMutableArray arrayWithObjects:@"电话",@"手机",@"微信",@"QQ", @"其他",nil];
   colView = [[UIView alloc]initWithFrame:CGRectMake(fangshi.frame.origin.x-8, fangshiBtn.frame.origin.y+15, 80, 30*arrTitleRoom.count)];
    UIImageView * viewBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"black.png"]];
    viewBg.frame = CGRectMake(0, 0, CGRectGetWidth(colView.frame), CGRectGetHeight(colView.frame));
    [colView addSubview:viewBg];
    for (int i=0; i<3; i++)
    {
        UIImageView * sousuoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,i*28+36, 80, 0.5)];
        sousuoImage.image = [UIImage imageNamed:@"black_in_hengxian.png"];
        sousuoImage.backgroundColor = [UIColor clearColor];
        [colView addSubview:sousuoImage];
    }
    
    for (int j=0; j<arrTitleRoom.count; j++)
    {
        UIButton * buttonLable = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonLable.frame = CGRectMake(0, j*28+10, 80, 20);
        //buttonLable.backgroundColor = [UIColor clearColor];
        buttonLable.titleLabel.font=[UIFont systemFontOfSize:15];
        [buttonLable setTitle:[arrTitleRoom objectAtIndex:j] forState:UIControlStateNormal];
        [buttonLable setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        buttonLable.tag =2500+j;
        [buttonLable addTarget:self action:@selector(buttonClicklie:) forControlEvents:UIControlEventTouchUpInside];
        [colView addSubview:buttonLable];
    }
    sousuoViewstyle = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMidX(style.frame)-8, CGRectGetMaxY(styleBtn.frame)+5, 80, 80+40)];
    UIImageView * leixingIMge = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"black.png"]];
    leixingIMge.frame = CGRectMake(0, 0, CGRectGetWidth(sousuoViewstyle.frame), CGRectGetHeight(sousuoViewstyle.frame));
    [sousuoViewstyle addSubview:leixingIMge];
    tableVeiwList=[[UITableView alloc]initWithFrame:CGRectMake(0, 7, 80+20, 80+40-7) style:UITableViewStylePlain];
    tableVeiwList.delegate=self;
    tableVeiwList.dataSource=self;
    tableVeiwList.tag = 1991;
    tableVeiwList.rowHeight = 30;
    tableVeiwList.separatorColor = [UIColor grayColor];
    tableVeiwList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    tableVeiwList.separatorInset = UIEdgeInsetsZero;
    tableVeiwList.backgroundColor=[UIColor clearColor];
    [sousuoViewstyle addSubview:tableVeiwList];
    if ([tableVeiwList respondsToSelector:@selector(setSeparatorInset:)])
    {
        tableVeiwList.separatorInset = UIEdgeInsetsZero;
        
    }
    if ([tableVeiwList respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableVeiwList setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    //输入框
    _text=[[UITextView alloc]initWithFrame:CGRectMake(20, 55, PL_WIDTH-40-40, 100)];
    _text.layer.borderWidth=1.5;
    _text.layer.borderColor = [UIColor grayColor].CGColor;
    _text.delegate=self;
    [smallView addSubview:_text];
    
    placeholder=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, PL_WIDTH-40, 30)];
    placeholder.text=@"请输入跟进内容";
    placeholder.font=[UIFont systemFontOfSize:13];
    //placeholder.hidden=YES;
    [_text addSubview:placeholder];
    
    //统计
    count=[[UILabel alloc]initWithFrame:CGRectMake(25, 157, 100, 20)];
    count.text=[NSString stringWithFormat:@"0/100"];
    [smallView addSubview:count];
    //确认按钮
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(PL_WIDTH-135, 150+10, 77, 30)];
    //button.backgroundColor=[UIColor redColor];
    [button setImage:[UIImage imageNamed:@"提交按钮.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [smallView addSubview:button];
    
    
}
#pragma mark - _textViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text1
{
    if (![[NSString stringWithFormat:@"%@",textView.text] isEqualToString:@""])
        
    {
        
        placeholder.hidden = YES;
        
    }
    
    if ([textView.text isEqualToString:@""] && range.location == 0 && range.length == 1)
        
    {
        
        placeholder.hidden = NO;
        
    }
    NSString * str = [NSString stringWithFormat:@"%@%@",textView.text,text1];
    if (str.length >BOOKMARK_WORD_LIMIT)
    {
        textView.text = [textView.text substringToIndex:BOOKMARK_WORD_LIMIT];
        return NO;
    }
    else
    {
        count.text=[NSString stringWithFormat:@"%ld/100",(unsigned long)str.length];
    }
    if ([text1 isEqualToString:@"\n"]) {
        [_text resignFirstResponder];
        return YES;
    }
    return YES;
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    
    if (textView.text.length >BOOKMARK_WORD_LIMIT)
    {
        textView.text = [textView.text substringToIndex:BOOKMARK_WORD_LIMIT];
        
    }
    else
    {
        count.text=[NSString stringWithFormat:@"%ld/100",(unsigned long)textView.text.length];
    }
}
-(void)buttonClicklie:(UIButton *)sender
{
    fangshiBtn.selected=NO;
    switch (sender.tag) {
        case 2500:
        {
            fangshi.text=@"电话";
            [colView removeFromSuperview];
        }
            break;
        case 2501:
        {
            fangshi.text=@"手机";
            [colView removeFromSuperview];
        }
            break;
        case 2502:
        {
            fangshi.text=@"微信";
            [colView removeFromSuperview];
        }
            break;
        case 2503:
        {
            fangshi.text=@"QQ";
            [colView removeFromSuperview];
        }
            break;
        case 2504:
        {
            fangshi.text=@"其他";
            [colView removeFromSuperview];
        }
            break;
        default:
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==tableVeiwList)
    {
        static  NSString * identifer = @"cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        
        if (!cell)
        {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        NSDictionary *dic=[styleArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [dic objectForKey:@"FollowType"];
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.textLabel.textColor=[UIColor whiteColor];
        cell.backgroundColor=[UIColor clearColor];
        return cell;
    }else
    {
        static NSString *strID = @"ID";
        UITableViewCell *cell  = [tableVeiwList dequeueReusableCellWithIdentifier:strID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
        }
        return cell;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == tableVeiwList) {
        return styleArray.count;
    }else{
        return 0;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==tableVeiwList)
    {
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        style.text = cell.textLabel.text;
        //[tableVeiwList removeFromSuperview];
        styleBtn.selected=NO;
        [sousuoViewstyle removeFromSuperview];
        
    }else{
        
    }
}
#pragma mark---跟进类型---
-(void)styleClickList:(UIButton *)sender
{
    NSLog(@"******");
    styleArray = [NSArray array];
    sender.selected=!sender.selected;
    if (sender.selected) {
        styleBtn.selected=YES;
                [[MyRequest defaultsRequest]GetFollowTypeList:^(NSMutableString *string) {
                    NSLog(@"%@",string);
                    if ([string isEqualToString:@"NOLOGIN"]) {
//                        ViewController *login=[[ViewController alloc]init];
                        
                    }
                    if ([string isEqualToString:@"[]"]) {
                        PL_ALERT_SHOW(@"暂无数据");
                    }
                    else  if ([string isEqualToString:@"exception"]) {
                        PL_ALERT_SHOW(@"服务器异常");
                    }
                    else
                    {
                        SBJSON *json=[[SBJSON alloc]init];
                        styleArray=[json objectWithString:string error:nil];
                        [tableVeiwList reloadData];
                        
                        [smallView addSubview:sousuoViewstyle];
                    }
                   
        
        
        
        
                } userid:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_NAME] token:[[NSUserDefaults standardUserDefaults]objectForKey:PL_USER_TOKEN]];
        
    }else{
        styleBtn.selected=NO;
        [sousuoViewstyle removeFromSuperview];
    }
}

#pragma mark----跟进fs
-(void)fangshiClick:(UIButton *)sender
{
    sender.selected=!sender.selected;
    if (sender.selected) {
        fangshiBtn.selected=YES;
        [smallView addSubview:colView];
        
    }
    else
    {
        fangshiBtn.selected=NO;
        [colView removeFromSuperview];
        
    }
    
    
}
//genjinfangshi
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
}
-(void)sureClick
{
        NSLog(@"-------");
        if ([fangshi.text isEqualToString:@"跟进方式"]&&[style.text isEqualToString:@"跟进类型"]&&[_text.text isEqualToString:@""]) {
            PL_ALERT_SHOW(@"跟进方式、跟进类型、跟进内容不能为空");
        }else if([style.text isEqualToString:@"跟进类型"]&&[_text.text isEqualToString:@""]){
            PL_ALERT_SHOW(@"跟进类型、跟进内容不能为空");
        }
        else if([fangshi.text isEqualToString:@"跟进方式"]&&[_text.text isEqualToString:@""]){
            PL_ALERT_SHOW(@"跟进方式、跟进内容不能为空");
        }else if([fangshi.text isEqualToString:@"跟进方式"]&&[style.text isEqualToString:@"跟进类型"]){
            PL_ALERT_SHOW(@"跟进方式、跟进类型不能为空");
        }else if([fangshi.text isEqualToString:@"跟进方式"]){
            PL_ALERT_SHOW(@"跟进方式不能为空");
        }else if([style.text isEqualToString:@"跟进类型"]){
            PL_ALERT_SHOW(@"跟进类型不能为空");
        }else if([_text.text isEqualToString:@""]){
            PL_ALERT_SHOW(@"跟进内容不能为空");
        }else{
            ADDPropertyContactData *follow = [[ADDPropertyContactData alloc] init];
            follow.PropertyId = [[NSUserDefaults standardUserDefaults]objectForKey:@"PropertyId"];
            follow.FollowType = style.text;
            follow.Content = _text.text;
            follow.FollowWay = fangshi.text;
            follow.userid = [[NSUserDefaults standardUserDefaults] objectForKey:PL_USER_NAME];
            follow.token = [[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            NSLog(@"%@  %@  %@  %@  %@  %@",follow.PropertyId,follow.FollowType,follow.Content,follow.FollowWay,follow.userid,follow.token);
            [[MyRequest defaultsRequest] addPropertyContact:follow backInfoMessage:^(NSMutableString *string) {
                if ([string isEqualToString:@"NOLOGIN"]) {
//                    ViewController *login = [[ViewController alloc] init];
//                    [self.navigationController popToViewController:login animated:YES];
                }
                else if ([string isEqualToString:@"OK"])
                {
                    PL_ALERT_SHOWNOT_OKAND_YES(@"提交成功");
                }
                else if ([string isEqualToString:@"ERR"])
                {
                    PL_ALERT_SHOW(@"提交失败");
                }else
                {
                    PL_ALERT_SHOW(@"提交内容有敏感词汇!");
                }
            }];
            [bgView removeFromSuperview];
        }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // Drawing code
}
*/

@end
