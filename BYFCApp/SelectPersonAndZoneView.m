//
//  SelectPersonAndZoneView.m
//  BYFCApp
//
//  Created by 向远波 on 15/5/20.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "SelectPersonAndZoneView.h"
#import "PL_Header.h"
#define TABLEWIDTH  ([UIScreen mainScreen].bounds.size.width - 20)/3
#define TABLEHIGHT  120

@interface SelectPersonAndZoneView ()
{
    NSArray *_acceptDataArray ;
    NSInteger spaceLevel;
    NSString *_unitfullcodeString;
    NSArray * _secondFilterTableViewDataArray;
    NSArray * _thirdFilterTableViewDataArray;
    NSArray * _fourthFilterTableViewDataArray;
    NSArray * _fifthFilterTableViewDataArray;
    NSArray * _sixthFilterTableViewDataArray;
    
    NSInteger viewsTableView;
    
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *disPlayLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectPartButton;

@property (nonatomic,strong)     UITableView * firstFilterTableView;

@property (nonatomic,strong)     UITableView * secondFilterTableView;

@property (nonatomic,strong)     UITableView * thirdFilterTableView;

@property (nonatomic,strong)     UITableView * fourthFilterTableView;

@property (nonatomic,strong)     UITableView * fifthFilterTableView;

@property (nonatomic,strong)     UITableView * sixFilterTableView;

@end

@implementation SelectPersonAndZoneView
-(UITableView *)firstFilterTableView
{
    if (!_firstFilterTableView) {
        _firstFilterTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.selectPartButton.frame.origin.x, self.selectPartButton.frame.origin.y + self.selectPartButton.frame.size.height, TABLEWIDTH, TABLEHIGHT)];
        _firstFilterTableView.delegate = self;
        _firstFilterTableView.dataSource = self;
        _firstFilterTableView.rowHeight = 20;
    }
    return _firstFilterTableView;
}
-(UITableView *)secondFilterTableView
{
    if (!_secondFilterTableView) {
        _secondFilterTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.firstFilterTableView.frame.origin.x + TABLEWIDTH, self.firstFilterTableView.frame.origin.y, TABLEWIDTH, TABLEHIGHT)];
        _secondFilterTableView.delegate = self;
        _secondFilterTableView.dataSource = self;
        _secondFilterTableView.rowHeight = 20;
    }
    return _secondFilterTableView;
}
-(UITableView *)thirdFilterTableView
{
    if (!_thirdFilterTableView) {
        _thirdFilterTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.secondFilterTableView.frame.origin.x + TABLEWIDTH, self.secondFilterTableView.frame.origin.y, TABLEWIDTH, TABLEHIGHT)];
        _thirdFilterTableView.delegate = self;
        _thirdFilterTableView.dataSource = self;
        _thirdFilterTableView.rowHeight = 20;
        
    }
    return _thirdFilterTableView;
}
-(UITableView *)fourthFilterTableView
{
    if (!_fourthFilterTableView) {
        _fourthFilterTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.firstFilterTableView.frame.origin.x, self.firstFilterTableView.frame.origin.y + TABLEHIGHT, TABLEWIDTH, TABLEHIGHT)];
        _fourthFilterTableView.delegate = self;
        _fourthFilterTableView.dataSource = self;
        _fourthFilterTableView.rowHeight = 20;
        
    }
    return _fourthFilterTableView;
}
-(UITableView *)fifthFilterTableView
{
    if (!_fifthFilterTableView) {
        _fifthFilterTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.fourthFilterTableView.frame.origin.x + TABLEWIDTH, self.fourthFilterTableView.frame.origin.y, TABLEWIDTH, TABLEHIGHT)];
        _fifthFilterTableView.delegate = self;
        _fifthFilterTableView.dataSource = self;
        _fifthFilterTableView.rowHeight = 20;
        
    }

    return _fifthFilterTableView;
}
-(UITableView *)sixFilterTableView
{
    if (!_sixFilterTableView) {
        _sixFilterTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.fifthFilterTableView.frame.origin.x + TABLEWIDTH, self.fifthFilterTableView.frame.origin.y, TABLEWIDTH, TABLEHIGHT)];
        _sixFilterTableView.delegate = self;
        _sixFilterTableView.dataSource = self;
        _sixFilterTableView.rowHeight = 20;
        
    }

    return _sixFilterTableView;
}
-(instancetype)initWithFrame:(CGRect)frame andData:(NSArray *)dataArray
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self = [[NSBundle mainBundle]loadNibNamed:@"SelectPersonAndZoneView" owner:self options:nil].lastObject;
        self.frame = [UIScreen mainScreen].bounds ;
//        self.frame = CGRectMake(0, 100, PL_WIDTH, 200);
//        self.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.6];
        _acceptDataArray = dataArray;
       
    }
    return self;
}

- (IBAction)didClickSelectButton:(UIButton *)sender
{
    if (!sender.selected) {
        
         viewsTableView   = 0;
        [self addSubTableView];
        
        sender.selected = NO;
    }
    else
    {
        sender.selected = YES;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.firstFilterTableView)
    {
        [self addSecondFilterTableView];
         NSDictionary *dic = _acceptDataArray[indexPath.row];
        viewsTableView = 1;
        spaceLevel = 0;
        _unitfullcodeString = dic[@"UnitFullCode"];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(doPostDepetInfo) name:@"observerResult" object:nil];
        [self postDeptInfo];
     }
    if (tableView == self.secondFilterTableView) {
        viewsTableView = 2;
        [self addSubTableView];
        
    }
    if (tableView == self.thirdFilterTableView) {
        viewsTableView = 3;
        [self addSubTableView];

    }
    if (tableView == self.fourthFilterTableView) {
        viewsTableView = 4;
        [self addSubTableView];

    }
    if (tableView == self.fifthFilterTableView) {
        viewsTableView = 5;
        [self addSubTableView];

    }
    if (tableView == self.sixFilterTableView) {
        viewsTableView = 6;
        [self addSubTableView];

    }
}
-(void)doPostDepetInfo
{
    spaceLevel++;
    [self postDeptInfo];
}

-(void)postDeptInfo
{
   
    NSLog(@"[[[[[[[[[[[%@",[NSString stringWithFormat:@"%ld",(long)spaceLevel]);
    
    [[MyRequest defaultsRequest]afGetDeptFromSnapshotWithUnitCode:_unitfullcodeString SpaceLevel:[NSString stringWithFormat:@"%ld",(long)spaceLevel] DutyCode:[PL_USER_STORAGE objectForKey:PL_USER_DUTYCODE] completeBack:^(NSString *str)
     {
         NSLog(@"++++++++++++++++%@",str);
         if ([str isEqualToString:@"1"]) {
             PL_ALERT_SHOW(@"没有下级部门可选了");
             return ;
         }
         
         if ([str isEqualToString:@"[]"]) {
             NSLog(@">>>>>>%@",str);
             [[NSNotificationCenter defaultCenter]postNotificationName:@"observerResult" object:nil];
            [[NSNotificationCenter defaultCenter]removeObserver:self name:@"observerResult" object:nil];
             return;
         }
         SBJSON *json = [[SBJSON alloc]init];
         
         
         switch (viewsTableView) {
              case 1:
                 _firstFilterTableView = [json objectWithString:str error:nil];
                 break;
            case 2:
                  _secondFilterTableView = [json objectWithString:str error:nil];
                 break;
             case 3:
                 _thirdFilterTableView = [json objectWithString:str error:nil];
                 break;
             case 4:
                 _fourthFilterTableView = [json objectWithString:str error:nil];
                 break;
             case 5:
                 _fifthFilterTableViewDataArray = [json objectWithString:str error:nil];
                 break;
             default:
                 _sixthFilterTableViewDataArray = [json objectWithString:str error:nil];

                 break;
         }
         
         [self addSubTableView];
    }];

}
-(void)addSubTableView
{
    switch (viewsTableView) {
        case 0:
            [self addSubview:self.firstFilterTableView];
            break;
        case 1:
            [self addSubview:self.secondFilterTableView];
            break;
        case 2:
            [self addSubview:self.thirdFilterTableView];
            break;
        case 3:
            [self addSubview:self.fourthFilterTableView];
            break;
        case 4:
            [self addSubview:self.fifthFilterTableView];
            break;
        default:
            [self addSubview:self.firstFilterTableView];
            break;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  tableView == self.firstFilterTableView ? _acceptDataArray.count : 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusedid = @"cellReuse";
    UITableViewCell *datacell = [tableView dequeueReusableCellWithIdentifier:reusedid];
    if (!datacell) {
        datacell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedid];
    }
    if (tableView == self.firstFilterTableView) {
        NSDictionary *dic = _acceptDataArray[indexPath.row];
        datacell.textLabel.text = dic[@"Department"];
        
    }
    
    return datacell;
}

-(void)addSecondFilterTableView
{
    
    [self addSubview:_secondFilterTableView];
}

- (IBAction)didClickSenderButton:(UIButton *)sender {
}

-(void)addSelfInAView:(UIView *)superView
{
    
    [superView.window addSubview:self];
    [self bringSubviewToFront:superView.superview.window];
    
    
    [self fadeIn];
}
- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.4, 1.4);
    self.alpha = 1;
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
    [self clearTel:nil];
}
- (void)clearTel:(UIGestureRecognizer *)tap
{
    [self fadeOut];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
