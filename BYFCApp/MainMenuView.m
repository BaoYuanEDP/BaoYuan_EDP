//
//  MainMenuView.m
//  BYFCApp
//
//  Created by PengLee on 15/3/9.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "MainMenuView.h"
#import "PL_Header.h"
#import "MenuTableViewCell.h"
#define PL_SCREEN_INSETS 0
#define RADIUS 5
@interface MainMenuView()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _menuTableView;
    TableAnimation _showDeriction;
    
}
- (void)fadeIn;
- (void)fadeOut;


@end
@implementation MainMenuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithTile:(NSString *)string loadWithArray:(NSArray *)array isOpenWithDirection:(TableAnimation)showDirection
{
    CGRect rect =[UIScreen mainScreen].applicationFrame;
    
    UITouch * touch = [[UITouch alloc]init];
    [touch locationInView:self.window];
    CGFloat tableX;
    
    
    
    if (self = [super initWithFrame:rect])
    {
        
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = RADIUS;
        self.layer.masksToBounds = YES;
        _showDeriction = showDirection;
        self.opertions = [NSArray arrayWithArray:array];
        
        
        if (showDirection==tableAnimationLeft)
        {
             tableX =PL_SCREEN_INSETS;
        
        }
        else
        {
            tableX = PL_WIDTH-120;
            
            
        }
        //CGRectMake(tableX, PL_SYSTEM_VERSION_ISIOS7?0.0f:20.0f,PL_WIDTH/3, PL_HEIGHT/3)
        _menuTableView = [[UITableView alloc]init];
        
        
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        _menuTableView.backgroundColor = [UIColor redColor];
        
        _menuTableView.scrollEnabled = NO;
        _menuTableView.rowHeight = 44;
        
//       _menuTableView = [_menuTableView initWithFrame:CGRectMake(tableX, PL_SYSTEM_VERSION_ISIOS7?0.0f:20.0f, PL_WIDTH/3,self.opertions.count*_menuTableView.rowHeight) style:UITableViewStyleGrouped];
        
        _menuTableView.frame = CGRectMake(tableX, PL_SYSTEM_VERSION_ISIOS7?40.0f:60.0f, 120,self.opertions.count*_menuTableView.rowHeight);
        
        [self addSubview:_menuTableView];
        
        if ([_menuTableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_menuTableView setLayoutMargins:UIEdgeInsetsZero];
        }
        if (([_menuTableView respondsToSelector:@selector(setSeparatorInset:)])) {
            [_menuTableView setSeparatorInset:UIEdgeInsetsZero];
            
            
        }
        
    }
    return self;
    
}
 -(NSArray *)loadWithArray:(NSArray *)array
{
     self.opertions = [NSArray arrayWithArray:array];
    
    return self.opertions;
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins :UIEdgeInsetsZero];
    }
    if (([cell respondsToSelector:@selector(setSeparatorInset:)])) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_showDeriction==tableAnimationLeft |_showDeriction== tableAnimationRight)
    {
        return _opertions.count;
        
    }
    
    return 0;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * popoverCell = @"popCell";
    MenuTableViewCell * cell = [_menuTableView dequeueReusableCellWithIdentifier:popoverCell];
    if (!cell)
    {
        cell = [[MenuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:popoverCell];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_showDeriction ==tableAnimationLeft)
    {
        cell.textLabel.text =_opertions[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    else
    {
        cell.textLabel.text = _opertions[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
        
    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_menuTableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger  row = indexPath.row;
    MenuTableViewCell * cell =(MenuTableViewCell *) [_menuTableView cellForRowAtIndexPath:indexPath];
    
    
    if (_showDeriction ==tableAnimationLeft)
    {
        [self fadeOut];
        if ([self.delegate respondsToSelector:@selector(didselectRow:cellTile: tableShowDeriction:)])
        {
            [self.delegate didselectRow:row cellTile:cell.textLabel.text tableShowDeriction:_showDeriction] ;
            
        }
    }
    else
    {
        [self fadeOut];
        [self.delegate didselectRow:row cellTile:cell.textLabel.text tableShowDeriction:_showDeriction];
        
    }
}
 -(void)fadeIn
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
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // tell the delegate the cancellation
    
    // dismiss self
    [self fadeOut];
}

- (void)showAnimation:(BOOL)animation
{
    AppDelegate     * del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [del.window addSubview:self];
    if (animation)
    {
        [self fadeIn];
    }
    
}
@end
