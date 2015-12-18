//
//  VisiterViewController.h
//  BYFCApp
//
//  Created by zzs on 14/12/3.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PL_Header.h"
#import "CWStarRateView.h"
@interface VisiterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,CWStarRateViewDelegate,UIAlertViewDelegate>
{
     NSInteger score;
    NSInteger starCount;
    UIView *dropBgView;
    NSArray * priceArray;
    UIImageView *image0;
    UIButton *_currentButton;
    NSMutableArray *chooseArray ;
    UISearchBar *_search;
    NSMutableString *_resultString;
    NSMutableArray *_array;
    UIButton *gouBtn;
    UIButton *zuBtn;
    UITableView *table;
    //MyVisiterCell *cell;
    MyVisiterCustomCell *cell;
    NSDictionary *dictionary;
   
    UIView *bgView;
    UITextView *textView1;
    UILabel *count;
    UILabel *fangshi;
    UIView *sousuoView;
    UIView *view;
    NSArray *styleArray;
    UIView *sousuoViewstyle;
    UITableView *styleTable;
    UILabel *style;
    UITableView *_tableView1;
    UITableView *_tableView2;
    UIButton *_areaButton;
    UIButton *topButton;
    NSArray *phoneArr;
    UITableView *phoneTable;
    UIView *phoneBG;
    NSInteger xxNum;
    NSArray *phoneArr2;
    NSString *currentStr;
    NSString *currentTradeStr;
    NSString *currentPriceMin;
    NSString *currentPriceMax;
    //UIImageView *buttonImg;
    UILabel *placeholder;
    UIButton *fangshiBtn;
    UIButton *styleBtn;
    UIButton *buttonImg;
    UIButton *_currentBtn2;
    NSMutableArray *buttonArr;
    UIButton *_currentBtn3;
    UIButton *_currentBtn4;
    NSArray *MoreArr1;
    NSString *topStr1;
    NSString *topStr2;
    NSString *topStr3;
    NSString *XQStr;
    NSString *PQStr;
    BOOL rightIsClick;
    UILabel * sikeLable;
    UIButton * rightBtn;
    NSInteger indexTag;
    UIButton *addBtn;
    NSString * privateCount;
    NSString * telePhoneNumberString;
    NSString *pubTypeString;
    NSString *jiaoYiTypeString;
}
@property(nonatomic,strong)NSString *priceString;
@property(nonatomic,strong)NSString *xiaoquString;
@property(nonatomic,strong)NSString *pianquString;
@property (strong, nonatomic) CWStarRateView *starRateView;
//房源ID
@property(nonatomic,strong)NSString *VisiterPropertyID;

@property(nonatomic,strong) NSString *strP;

@end
