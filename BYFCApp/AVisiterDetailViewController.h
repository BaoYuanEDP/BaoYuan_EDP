//
//  AVisiterDetailViewController.h
//  BYFCApp
//
//  Created by zzs on 14/12/4.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"
#import "PL_Header.h"
#import "AppointVisiterData.h"

@interface AVisiterDetailViewController : UIViewController<UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,CWStarRateViewDelegate,UIAlertViewDelegate>
{
    NSInteger starCount;
    NSDictionary * dic;
    NSInteger score;
    UITextView *textView;
    UILabel *count;
    UIView *view;
    UIView *popView;
    UILabel *fangshi;
    UITableView *styleTable;
    UIView * popViewstyle;
    NSArray *styleArray;
    UILabel *style;
    UILabel *_name;
    UILabel *_sex;
    UILabel *_area;
    UILabel *_request;
    UILabel *_room;
    UILabel *_beizhu;
    UILabel *_price;
    UILabel *yixiang;
    UIButton *phoneButton;
    UITextField *_firstGJ;
    UITextField *_secondGJ;
    UITextField *_thirdGJ;
    UITextField *_fourGJ;
    UITextField *_fiveGJ;
    int height;
    NSArray *phoneArr;
    UITableView *phoneTable;
    UIView *phoneBG;
    NSArray *phoneArr2;
    UIScrollView *_scroll1;
    UILabel *placeholder;
    UIButton *fangshiBtn;
    UIButton *styleBtn;
    NSArray *followArray;
    UITableView *followTable;
    NSInteger followHeight;
    UIImageView *genjinBG;
    UILabel *genjinLab;
    UILabel *genR;
    CGFloat score2;
    BOOL isCommit;
    UITapGestureRecognizer*TAP;
    
}
//@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
/*
- (IBAction)btnClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *area;
@property (weak, nonatomic) IBOutlet UILabel *request;
@property (weak, nonatomic) IBOutlet UILabel *room;
@property (weak, nonatomic) IBOutlet UILabel *beizhu;
@property (weak, nonatomic) IBOutlet UILabel *price;
*/
//@property (weak, nonatomic) IBOutlet UITextField *firstGJ;
//@property (weak, nonatomic) IBOutlet UITextField *secondGJ;
//@property (weak, nonatomic) IBOutlet UITextField *thirdGJ;
//@property (weak, nonatomic) IBOutlet UITextField *fourGJ;
//@property (weak, nonatomic) IBOutlet UITextField *fiveGJ;
//@property (weak, nonatomic) IBOutlet UIButton *phone;
//
//@property (weak, nonatomic) IBOutlet UITextView *textView;
//@property (weak, nonatomic) IBOutlet UILabel *genjinren;
@property(strong,nonatomic)NSDictionary *dict;
@property(strong,nonatomic)NSString *detailString;
@property (strong, nonatomic) CWStarRateView *starRateView;
@property(strong,nonatomic)NSArray *listArr;
@property(strong,nonatomic)NSMutableArray *arr;
@property(assign,nonatomic)BOOL isHiden;
@property(strong,nonatomic)NSString *custId;
@property(strong,nonatomic) AppointVisiterData  *customDetail;
//上级编号
@property(strong,nonatomic)NSString *supcode;
@property(nonatomic,strong)NSString *AVisiterDetailPropertyID;

@property (nonatomic,strong)NSString *strP;
@property (nonatomic, strong) NSString *isOK;
@end
