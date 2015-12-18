//
//  CustomCell.m
//  BYFCApp
//
//  Created by PengLee on 14/12/4.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import "CustomCell.h"
//宏定义

@implementation CustomCell
@synthesize roomImageInfo;
@synthesize districtNameLable;
@synthesize countFLable;
@synthesize estateNameLable;
@synthesize squareLable;
@synthesize priceLable;
@synthesize tradeStateLable;

@synthesize shaleLable;
@synthesize zuLable;
@synthesize roomNumLable;
@synthesize areaLable;
@synthesize jingliTuiJianLable;
@synthesize jishouLable;
@synthesize xuequfangLable;
@synthesize changeBtn;
@synthesize telBnt;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
//        for (UIView * vi in self.subviews)
//        {
//            //[vi removeFromSuperview];
//            
//            
//        }
        
    }
    return self;
    
}
-(void)initView
{
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(viewChange) name:@"change" object:nil];
    
//    UISwipeGestureRecognizer *recogizerRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeRight)];
//    recogizerRight.direction=UISwipeGestureRecognizerDirectionRight;
//    [self addGestureRecognizer:recogizerRight];
//    
//    UISwipeGestureRecognizer *recogizerLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeLeft)];
//    recogizerLeft.direction=UISwipeGestureRecognizerDirectionLeft;
//    [self addGestureRecognizer:recogizerLeft];
    
//    view=[[UIView alloc]initWithFrame:CGRectMake(-60, 0, PL_WIDTH+60+60, PL_HEIGHT/6)];
//    //view.backgroundColor=[UIColor redColor];
//    [self addSubview:view];
    
    //出售  出租 标签
    /*
    shaleLable = [[UIImageView alloc]initWithFrame:CGRectMake(PL_WIDTH/25, PL_HEIGHT/36,PL_WIDTH/20 , PL_WIDTH/20)];
       [self.contentView addSubview:shaleLable];
  
   
    
    zuLable = [[UIImageView alloc]initWithFrame:CGRectMake(PL_WIDTH/25, CGRectGetMaxY(shaleLable.frame)+kPLhorisionCelledgedSpace+5, PL_WIDTH/20, PL_WIDTH/20)];
   [self.contentView addSubview:zuLable];
        //宝源默认图片
    
    roomImageInfo = [[UIImageView alloc]init];
    roomImageInfo.frame = CGRectMake(CGRectGetMaxX(shaleLable.frame)+kPLhorisionCelledgedSpace, PL_HEIGHT/36,CGRectGetHeight(shaleLable.frame)*4.3 , CGRectGetHeight(shaleLable.frame)*4.0) ;
    
   [self addSubview:roomImageInfo];
    
    estateNameLable = [[UIButton alloc]init];
    [estateNameLable setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    estateNameLable.frame= CGRectMake(CGRectGetMaxX(roomImageInfo.frame)+kPLhorisionCelledgedSpace, CGRectGetMinY(roomImageInfo.frame)-12, CGRectGetWidth(shaleLable.frame)*7, CGRectGetHeight(shaleLable.frame)+15);
    //estateNameLable.backgroundColor = [UIColor redColor];
    estateNameLable.titleLabel.font = [UIFont boldSystemFontOfSize:kPLStatusSystemFontSize+2];
    estateNameLable.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft|UIControlContentVerticalAlignmentBottom;
//    [estateNameLable addTarget:self action:@selector(esateClick) forControlEvents:UIControlEventTouchUpInside];
    //estateNameLable.titleEdgeInsets = UIEdgeInsetsZero;
    estateNameLable.contentEdgeInsets = UIEdgeInsetsZero;
    estateNameLable.backgroundColor = [UIColor redColor];
    [self addSubview:estateNameLable];
    countFLable = [[UILabel alloc]init];
   
   
    countFLable.backgroundColor = [UIColor clearColor];
  
    
    countFLable.frame = CGRectMake(CGRectGetMinX(estateNameLable.frame), CGRectGetMaxY(estateNameLable.frame), CGRectGetWidth(shaleLable.frame)*2.1  , CGRectGetHeight(shaleLable.frame)*0.9);
   // countFLable.adjustsFontSizeToFitWidth = YES;
    [self addSubview:countFLable];
    roomNumLable = [[UILabel alloc]init];
   // roomNumLable.text = @"12幢103室";
    roomNumLable.backgroundColor = [UIColor clearColor];
   
    
    roomNumLable.frame = CGRectMake(CGRectGetMaxX(countFLable.frame)*1.12  , CGRectGetMaxY(estateNameLable.frame), CGRectGetWidth(shaleLable.frame)*3, CGRectGetHeight(shaleLable.frame)*0.9);
  
    [self addSubview:roomNumLable];
    squareLable = [[UILabel alloc]init];
   // squareLable.text = @"188 平米";
   // CGSize squreSize  = kPLautoLableSize(squareLable.text);
    squareLable.backgroundColor = [UIColor clearColor];
    squareLable.frame = CGRectMake(CGRectGetMinX(countFLable.frame), CGRectGetMaxY(countFLable.frame),CGRectGetHeight(shaleLable.frame)*3, CGRectGetHeight(countFLable.frame));
    squareLable.contentMode = UIViewContentModeScaleAspectFill;
   // squareLable.adjustsFontSizeToFitWidth = YES;
    [self addSubview:squareLable];
    districtNameLable = [[UIButton alloc]init];
    
    districtNameLable.frame = CGRectMake(CGRectGetMaxX(roomImageInfo.frame)+kPLhorisionCelledgedSpace, CGRectGetMaxY(squareLable.frame)+3, CGRectGetWidth(shaleLable.frame)*2.5, CGRectGetWidth(shaleLable.frame));
    districtNameLable.contentMode = UIViewContentModeScaleAspectFit;
    districtNameLable.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [districtNameLable addTarget:self action:@selector(districtClick) forControlEvents:UIControlEventTouchUpInside];
    
    [districtNameLable setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    districtNameLable.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:districtNameLable];
    priceLable = [[UILabel alloc]init];
  
    priceLable.frame = CGRectMake(CGRectGetMinX(roomNumLable.frame), CGRectGetMaxY(roomNumLable.frame), CGRectGetWidth(estateNameLable.frame),  CGRectGetHeight(shaleLable.frame)*0.9);
   
    [self addSubview:priceLable];
    areaLable = [[UIButton alloc]init];
 
    areaLable.backgroundColor = [UIColor clearColor];
    areaLable.frame = CGRectMake(CGRectGetMinX(priceLable.frame), CGRectGetMaxY(priceLable.frame)+3, CGRectGetWidth(shaleLable.frame)*2.5, CGRectGetHeight(shaleLable.frame)*0.9);
    //[areaLable addTarget:self action:@selector(areaClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:areaLable];
    self.cellHeight = CGRectGetMaxY(roomImageInfo.frame)+kPLhorisionCelledgedSpace;
    jingliTuiJianLable = [[UIImageView alloc]init];
    jingliTuiJianLable.backgroundColor = [UIColor clearColor];
    jingliTuiJianLable.frame = CGRectMake(PL_WIDTH/1.5, CGRectGetMinY(estateNameLable.frame), CGRectGetWidth(shaleLable.frame)*3, CGRectGetHeight(shaleLable.frame));
   // jingliTuiJianLable.image =[UIImage imageNamed:@"jinglituijian_lan.png"];
    
    [jingliTuiJianLable.image stretchableImageWithLeftCapWidth:20 topCapHeight:15];
    jingliTuiJianLable.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:jingliTuiJianLable];
    jishouLable = [[UIImageView alloc]init];
    jishouLable.backgroundColor = [UIColor clearColor];
    jishouLable.frame = CGRectMake(CGRectGetMinX(jingliTuiJianLable.frame), CGRectGetMaxY(jingliTuiJianLable.frame)+6, CGRectGetWidth(jingliTuiJianLable.frame), CGRectGetHeight(jingliTuiJianLable.frame));
   // jishouLable.image = [UIImage imageNamed:@"jishou_hong.png"];
    
    [jishouLable.image stretchableImageWithLeftCapWidth:20 topCapHeight:15];
    
    jishouLable.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:jishouLable];
    xuequfangLable = [[UIImageView alloc]init];
    xuequfangLable.backgroundColor = [UIColor clearColor];
    xuequfangLable.frame = CGRectMake(CGRectGetMinX(jishouLable.frame), CGRectGetMaxY(jishouLable.frame)+6, CGRectGetWidth(jishouLable.frame), CGRectGetHeight(jishouLable.frame));
   // xuequfangLable.image = [UIImage imageNamed:@"xuequfang_fen.png"];
    
    [xuequfangLable.image stretchableImageWithLeftCapWidth:20 topCapHeight:15];
    
    xuequfangLable.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:xuequfangLable];
    //写跟进
    changeBtn = [[UIButton alloc]init];
    changeBtn.backgroundColor = [UIColor redColor];
    changeBtn.frame = CGRectMake(CGRectGetMaxX(jingliTuiJianLable.frame)+15, CGRectGetMinY(jingliTuiJianLable.frame), CGRectGetWidth(shaleLable.frame)*1.7, CGRectGetWidth(shaleLable.frame)*1.7);
    
    
    [self addSubview:changeBtn];
    telBnt = [UIButton buttonWithType:UIButtonTypeCustom];
    telBnt.frame = CGRectMake(CGRectGetMinX(changeBtn.frame), CGRectGetMaxY(changeBtn.frame)+10, CGRectGetWidth(changeBtn.frame), CGRectGetHeight(changeBtn.frame));
     telBnt.backgroundColor = [UIColor redColor];
    [telBnt bringSubviewToFront:self];
    
    [self addSubview:telBnt];
    NSLog(@"%@-----%@",[changeBtn superclass],[telBnt superview]);
    */
    
//    leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, PL_HEIGHT/6)];
//    leftView.backgroundColor=[UIColor colorWithRed:242/255.0 green:47/255.0 blue:31/255.0 alpha:1];
//    UILabel *fenxiang=[[UILabel alloc]initWithFrame:CGRectMake(0, PL_HEIGHT/12-20, 60, 40)];
//    fenxiang.text=@"分享";
//    fenxiang.textAlignment=NSTextAlignmentCenter;
//    fenxiang.textColor=[UIColor whiteColor];
//    [leftView addSubview:fenxiang];
//    _leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, PL_HEIGHT/6)];
//    [_leftBtn addTarget:self action:@selector(fenxiangClick) forControlEvents:UIControlEventTouchUpInside];
//    [leftView addSubview:_leftBtn];
//     [view addSubview:leftView];
    
    
    //NSLog(@"%f",view.frame.origin.x);
//    UIView *rightView=[[UIView alloc]initWithFrame:CGRectMake(PL_WIDTH+60, 0, 60, PL_HEIGHT/6)];
//    rightView.backgroundColor=[UIColor colorWithRed:242/255.0 green:47/255.0 blue:31/255.0 alpha:1];
//    
//    UILabel *photo=[[UILabel alloc]initWithFrame:CGRectMake(0, PL_HEIGHT/12-20, 60, 40)];
//    photo.text=@"拍照";
//    photo.textAlignment=NSTextAlignmentCenter;
//    photo.textColor=[UIColor whiteColor];
//    [rightView addSubview:photo];
//    
//    _photoBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, PL_HEIGHT/6)];
//    [_photoBtn addTarget:self action:@selector(phoneClick) forControlEvents:UIControlEventTouchUpInside];
//    _photoBtn.backgroundColor=[UIColor clearColor];
//    [rightView addSubview:_photoBtn];
//    [view addSubview:rightView];
    
   
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    NSLog(@"");
    
}
- (void)awakeFromNib {
    // Initialization code
    [self initView];
    
    
    
  }

-(void)handleSwipeRight
{
    //view.frame=CGRectMake(0, 0,  PL_WIDTH, PL_HEIGHT/6);
//    if (view.frame.origin.x<-60) {
//        view.frame=CGRectMake(-60, 0, PL_WIDTH, PL_HEIGHT/6);
//    }else
//    {
//        view.frame=CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT/6);
//    }
    
    //leftView.hidden=NO;
   // leftView.frame=CGRectMake(-60, 0, 60, PL_HEIGHT/6);
    
    //UIButton *tapBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,self.frame.origin.y, 60, PL_WIDTH/6)];
    
}
-(void)handleSwipeLeft
{
    
    
//    if (view.frame.origin.x==0) {
//        view.frame=CGRectMake(-60, 0, PL_WIDTH, PL_HEIGHT/6);
//    }else
//    {
//        view.frame=CGRectMake(-120, 0, PL_WIDTH+120, PL_HEIGHT/6);
//    }
    
    /*
    leftView.hidden=YES;
    if (view.frame.origin.x==60) {
        self.frame=CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT/6);
         view.frame=CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT/6);
    }
    else if (view.frame.origin.x==0)
    {
        self.frame=CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT/6);
        view.frame=CGRectMake(0, 0, PL_WIDTH, PL_HEIGHT/6);
    }
   */
}

-(void)fenxiangClick
{
    NSLog(@"ggggg");
   // view.frame=CGRectMake(-60, 0, PL_WIDTH, PL_HEIGHT/6);
}
-(void)phoneClick
{
    NSLog(@"aaaaa");
   // view.frame=CGRectMake(-60, 0, PL_WIDTH, PL_HEIGHT/6);
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//    NSLog(@"++++++++++++");
//    
//    
//}



    // Configure the view for the selected state
   /*
    roomImageInfo = [[UIImageView alloc]initWithFrame:CGRectMake(PL_GET_WIDTH/20, PL_GET_WIDTH/20, PL_GET_WIDTH/4, PL_GET_WIDTH/5)];
    roomImageInfo.backgroundColor = [UIColor redColor];
    roomImageInfo.autoresizingMask =PL_LEFT_RIGHT_TOP;
    
    [self.contentView addSubview:roomImageInfo];
    districtNameLable = [[UILabel alloc]initWithFrame:CGRectMake(125, 20, 60, 20)];
    districtNameLable.backgroundColor = [UIColor redColor];
    districtNameLable.autoresizingMask =PL_LEFT_RIGHT_TOP;
    

//}

    [self.contentView addSubview:districtNameLable];
    estateNameLable = [[UILabel alloc]initWithFrame:CGRectMake(200, 20, 80, 20)];
    estateNameLable.backgroundColor = [UIColor redColor];
    estateNameLable.autoresizingMask = PL_LEFT_RIGHT_TOP;
    [self.contentView addSubview:estateNameLable];
    countFLable = [[UILabel alloc]initWithFrame:CGRectMake(125, 50, 70, 20)];
    countFLable.backgroundColor = [UIColor redColor];
    countFLable.autoresizingMask = PL_LEFT_RIGHT_TOP;
    [self.contentView addSubview:countFLable];
    squareLable = [[UILabel alloc]initWithFrame:CGRectMake(210, 50, 70, 20)];
    squareLable.backgroundColor = [UIColor redColor];
    squareLable.autoresizingMask = PL_LEFT_RIGHT_TOP;
    
    [self.contentView addSubview:squareLable];
    tradeStateLable = [[UILabel alloc]initWithFrame:CGRectMake(125, 80, 70, 20)];
    tradeStateLable.backgroundColor = [UIColor redColor];
    tradeStateLable.autoresizingMask = PL_LEFT_RIGHT_TOP;
    [self.contentView addSubview:tradeStateLable];
    */
    
    
//}


@end
