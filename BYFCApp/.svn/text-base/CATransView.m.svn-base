//
//  CATransView.m
//  BYFCApp
//
//  Created by PengLee on 15/3/4.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "CATransView.h"
#import "PL_Header.h"
@implementation CATransView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame setBackGroundImage:(UIImage *)image loadWithButtonImage:(UIImage *)buttonImage completeBack:(void (^)(id))block

{
    if (self = [super initWithFrame:frame])
    {
        
        self.backgroundColor = [UIColor clearColor];
        self.isChangeColor = YES;
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        self.idBlock = block;
        //添加背景图片
        UIImageView * bgImageView = [[UIImageView alloc]init];
        bgImageView.image = image;
        self.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:bgImageView];
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.center.equalTo(self);
            make.size.equalTo(self);
            
        }];
        UIButton * drowDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
        drowDownButton.frame = CGRectMake(self.center.x-30, 0, 60, 15);
        [drowDownButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [drowDownButton addTarget:self action:@selector(trandsAnimation:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:drowDownButton];
        self.catableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, self.frame.size.width, self.frame.size.height-15) style:UITableViewStylePlain];
        _catableView.delegate = self;
        _catableView.dataSource = self;
        _catableView.rowHeight = 44;
        _catableView.tableFooterView = [[UIView alloc]init];
        _catableView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.catableView];
        self.colloletionArray = [NSMutableArray array];
        //将表格线填充到真个屏幕
        if ([_catableView respondsToSelector:@selector(setSeparatorInset:)])
        {
            [_catableView setSeparatorInset:UIEdgeInsetsZero];
            
        }
        if ([_catableView respondsToSelector:@selector(setLayoutMargins:)])
        {
            [_catableView setLayoutMargins:UIEdgeInsetsZero];
            
        }
        
        UISwipeGestureRecognizer * swipges = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipClick:)];
        [swipges setDirection:UISwipeGestureRecognizerDirectionDown];
        
        [self addGestureRecognizer:swipges];
    }
    return self;
    
}
- (void)swipClick:(UISwipeGestureRecognizer *)swip
{
   
     self.idBlock(swip);
    
}
- (void)trandsAnimation:(UIButton *)sender
{
   
    self.idBlock(sender);
    
    
    
}
#pragma mark --UITableViewDataSource
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.colloletionArray.count !=0)
    {
        return _colloletionArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellidenterfier = @"identifer";
    NoticeCell * cell = [self.catableView dequeueReusableCellWithIdentifier:cellidenterfier];
    if (!cell)
    {
        cell =  [[NoticeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidenterfier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
     NSDictionary * dict = _colloletionArray[indexPath.row];
    cell.activityLable.text = dict[@"PublishTitle"];
    cell.activityLable.numberOfLines = 0;
   // cell.activityLable.adjustsFontSizeToFitWidth = YES;
    cell.jishuLable.text = dict[@"PublishDep"];
    cell.timerLable.text = dict[@"PublishDate"];
    //cell.textLabel.text = @"123";
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }

}
@end
