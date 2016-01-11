//
//  CustomAddView.m
//  BYFCApp
//
//  Created by PengLee on 15/3/17.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "CustomAddView.h"
#define tableView_left 40
#define tableView_top 80
#define headerView_height 60
#define lable_inset 10
#define lable_width 100
#define lable_height 30
#define ALERT_FONT 18
#define alert_font 10
#define font_name @"TimesNewRomanPS-BoldMT"
@implementation CustomAddView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithArray:(NSArray *)array{
    CGRect rect = [[UIScreen mainScreen]applicationFrame];
    
    if (self = [super initWithFrame:rect])
    {
        self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
        self.layer.cornerRadius = 3.0f;
        self.layer.masksToBounds = YES;
        self.arrayR = array;
        
        [self reloadData:array];
    }
    return self;
    
}
- (void)reloadData:(NSArray *)array
{
    _bagroundView  = [[UIView alloc]initWithFrame:CGRectMake(tableView_left, tableView_top, PL_WIDTH-2*tableView_left, PL_HEIGHT-2*tableView_top)];
    _bagroundView.backgroundColor = [UIColor whiteColor];
    _bagroundView.layer.cornerRadius = 5.0f;
    _bagroundView.layer.masksToBounds = YES;
    [self addSubview:_bagroundView];
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_bagroundView.frame), headerView_height)];
    headerView.backgroundColor = [UIColor grayColor];
    [_bagroundView addSubview:headerView];
    UILabel * areaLable = [[UILabel alloc]initWithFrame:CGRectMake(tableView_left/2, lable_inset, lable_width*2, lable_height)];
    areaLable.text = @"意向区域选择:";
    areaLable.font = [UIFont fontWithName:font_name size:ALERT_FONT];
    areaLable.textColor = [UIColor whiteColor];
    [headerView addSubview:areaLable];
    //CGFloat tableH ;
    
       //表
    _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerView.frame), CGRectGetWidth(_bagroundView.frame)/2, CGRectGetHeight(_bagroundView.frame)-CGRectGetHeight(headerView.frame)) style:UITableViewStylePlain];
    _tableView1.rowHeight = 44;
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    _tableView1.tableFooterView = [[UIView alloc]init];
    if ([_tableView1 respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView1 setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_tableView1 respondsToSelector:@selector(setLayoutMargins:)])
    {
        [_tableView1 setLayoutMargins:UIEdgeInsetsZero];
        
    }
//    if (array.count>0)
//    {
//        tableH =array.count*_tableView1.rowHeight;
//        
//        
//    }
//    else
//    {
//        tableH =0;
//    }
    //_tableView1.frame = CGRectMake(0, CGRectGetMaxY(headerView.frame), CGRectGetWidth(_bagroundView.frame)/2, tableH);
    
    [_bagroundView addSubview:_tableView1];
   
    
    _tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_bagroundView.frame)/2, CGRectGetMaxY(headerView.frame), CGRectGetWidth(_bagroundView.frame)/2, CGRectGetHeight(_bagroundView.frame)-CGRectGetHeight(headerView.frame)) style:UITableViewStylePlain];
    _tableView2.rowHeight = 44;
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    _tableView2.tableFooterView = [[UIView alloc]init];
    if ([_tableView2 respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView2 setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_tableView2 respondsToSelector:@selector(setLayoutMargins:)])
    {
        [_tableView2 setLayoutMargins:UIEdgeInsetsZero];
        
    }
//    CGFloat tableHeight;
//    
//    if (self.table2Array.count>0)
//    {
//        tableHeight =self.table2Array.count*_tableView2.rowHeight;
//        
//        
//    }
//    else
//    {
//        tableHeight =0;
//    }
//    _tableView2.frame = CGRectMake(CGRectGetWidth(_bagroundView.frame)/2, CGRectGetMaxY(headerView.frame), CGRectGetWidth(_bagroundView.frame)/2, tableH);
    
   
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView ==_tableView1)
    {
        return self.arrayR.count;
    }
    else
    {
        
        return self.table2Array.count;
    }
    return 0;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==_tableView1)
    {
        static NSString * cellIdentifer = @"cellider";
        UITableViewCell * cell = [_tableView1 dequeueReusableCellWithIdentifier:cellIdentifer];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
            cell.textLabel.frame = CGRectOffset(cell.textLabel.frame, cell.center.x/2, cell.center.y);
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            
        }
        roomAreaPlace * place = self.arrayR[indexPath.row];
        
//        if ([place.areaDistrictName isKindOfClass:[NSNull class]]) {
//            NSLog(@"null");
//        }
//        else
//        {
      cell.textLabel.text = place.areaDistrictName;
//        }
        return cell;
    }
    else{
        static NSString * cellIdentifer = @"celliderfer";
        UITableViewCell * cell = [_tableView2 dequeueReusableCellWithIdentifier:cellIdentifer];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
            cell.textLabel.frame = CGRectOffset(cell.textLabel.frame, cell.center.x/3, cell.center.y);
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            
        }
        if (self.table2Array.count>0)
        {
            
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@",self.table2Array[indexPath.row]];
        }
       
        return cell;
    }
    
    return nil;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView ==_tableView1)
    {
        roomAreaPlace * area = self.arrayR[indexPath.row];
        _cacheEstateString = area.areaDistrictName;
        
        
        [[VisitersRequest defaultsRequest]requestAreaInfoMessage:@"1" roomDistrictId:area.areaDistrictId roomDisName:area.areaDistrictName userName:[PL_USER_STORAGE objectForKey:PL_USER_NAME] userTokne:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] backInfoMessage:^(NSMutableArray *array) {
            //   NSLog(@"arr == %d",array.count);
            if (array.count>0 && indexPath.row > 0)
            {
              
                
                self.table2Array = [NSMutableArray array];
              
//                NSLog(@" ======= %@",self.table2Array);
                for (NSDictionary * name in array)
                {
                    NSString * nameID = [NSString stringWithFormat:@"%@",[name objectForKey:@"AreaName"]];
                    NSLog(@"%@",nameID);
                    [self.table2Array addObject:nameID];
                    
                    
                }
                NSString * virtuNameId = @"全部片区";
                [self.table2Array insertObject:virtuNameId atIndex:0];
                 NSLog(@"++++++%@",self.table2Array);
               
                  [_tableView2 reloadData];
                 [_bagroundView addSubview:_tableView2];
                
                UITableViewCell * cell  = [_tableView1 cellForRowAtIndexPath:indexPath];
                if ([self.delegate respondsToSelector:@selector(didSelectRowIndexPath:administrativeArea:)])
                {
                    [self.delegate didSelectRowIndexPath:indexPath administrativeArea:cell.textLabel.text];
                }
                

            }
            else if (indexPath.row == 0)
            {
             
                UITableViewCell * cell = [_tableView1 cellForRowAtIndexPath:indexPath];
                NSLog(@"----------- %@",cell.textLabel.text);
                if ([self.delegate respondsToSelector:@selector(didSelectRowIndexPath:administrativeArea:)])
                {
                    [self.delegate didSelectRowIndexPath:indexPath administrativeArea:cell.textLabel.text];
                }

                [self fadeOut];
            }
            else
            {
                PL_ALERT_SHOWNOT_OKAND_YES(@"暂无区域数据,请检查网络");
                
            }

            
            
        } string:^(NSString *string) {
            NSLog(@"————————————%@",string);
            SBJSON *json = [[SBJSON alloc]init];
            arrayStr = [json objectWithString:string error:nil];
                        
        }];

//        [[MyRequest defaultsRequest]requestAreaInfoMessage:@"2" roomDistrictId:area.areaDistrictId  roomDisName:area.areaDistrictName userName:[PL_USER_STORAGE objectForKey:PL_USER_NAME] userTokne:[PL_USER_STORAGE objectForKey:PL_USER_TOKEN] backInfoMessage:^(NSMutableArray *array1) {
//                       //        self.quyuShuzu = [NSArray arrayWithArray:array];
//            //        [_tableView1 reloadData];
//            
//            
//        }];

        
    }
    else
    {
        NSLog(@"45656");
        UITableViewCell * cell = [_tableView2 cellForRowAtIndexPath:indexPath];
        NSLog(@"%ld",(long)indexPath.row);
//        [arrayStr insertObject:{@"AreaID":@"BS000",@"AreaName":@"全部片区"}atIndex:0];
        NSDictionary *dict;
        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"全部片区";
            if ([self.delegate respondsToSelector:@selector(didSelectRowIndexPath:sadministativeArea:)])
            {
                NSLog(@"%@",[dict objectForKey:@"AreaID"]);
                [self.delegate didSelectRowIndexPath:indexPath sadministativeArea:cell.textLabel.text];
                
                [self fadeOut];
            }
            if ([self.delegate respondsToSelector:@selector(didSelectRowIndexPath:AreaID:)])
            {
                [self.delegate   didSelectRowIndexPath:indexPath AreaID:[dict objectForKey:@"AreaID"]];
                
            }

        }
        else
        {
            dict = [arrayStr objectAtIndex:indexPath.row-1];
            
            if ([self.delegate respondsToSelector:@selector(didSelectRowIndexPath:sadministativeArea:)])
            {
                NSLog(@"%@",[dict objectForKey:@"AreaID"]);
                [self.delegate didSelectRowIndexPath:indexPath sadministativeArea:cell.textLabel.text];
                
                [self fadeOut];
            }
            if ([self.delegate respondsToSelector:@selector(didSelectRowIndexPath:AreaID:)])
            {
                [self.delegate   didSelectRowIndexPath:indexPath AreaID:[dict objectForKey:@"AreaID"]];
                
            }

        }
        
        
        
    }
    
}
- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.4, 1.4);
    self.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}
- (void)fadeOut
{
    [UIView animateWithDuration:.25 animations:^{
        self.transform = CGAffineTransformMakeScale(1.4, 1.4);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}
- (void)showInView:(UIView *)myView animation:(BOOL)animation
{
    //AppDelegate * del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [myView addSubview:self];
    if (animation)
    {
        [self fadeIn];
        
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self fadeOut];
    
}

@end
