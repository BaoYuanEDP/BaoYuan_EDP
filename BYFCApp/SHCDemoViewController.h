//
//  SHCDemoViewController.h
//  BYFCApp
//
//  Created by PengLee on 15/8/21.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PL_Header.h"
enum
{
    TopSet_None = 0,
    TopSet_Forever,
    TopSet_Three,
    TopSet_Seven,
    TopSet_Fifteen,
    TopSet_Thirty,
    
};
typedef NSInteger TopSet;
@interface SHCDemoViewController : UIViewController
{
    //定义字符串判断领导与业务员
    NSString * flagSubs;
}
@property(nonatomic,strong)NSString *followListdutyCode;
@property(nonatomic,strong)NSString *roomdutycode;
@property(nonatomic,strong)NSString *dutyCode;
@property(nonatomic,strong) RoomData * reviseRoomData;
@property(nonatomic,strong) NSDictionary *housDic;
@property(nonatomic)BOOL isEq;
@property(nonatomic,strong)NSArray * titleArray;
@property(nonatomic,strong)NSMutableArray * jiaoYiArray;
@property (nonatomic, strong) NSDictionary *arrayData;//售价租价等数据
@property (nonatomic,assign)TopSet  topset;

@property(nonatomic,strong)NSString     *statusString;
@property(nonatomic,strong)NSString     *jiShouString;
@property(nonatomic,strong)NSString     *zhuangXiuString;
@property(nonatomic,strong)NSString     *jingLiTuiJianString;
//置顶
@property(nonatomic,strong)NSString     *topSetString;
//交易类型
@property(nonatomic,strong)NSString     *topSetSenderString;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//@property(nonatomic,strong)UILabel *label;
@property (nonatomic,strong) NSString *propertyIDString;
@property(nonatomic,strong)RoomRevisInfo *neRoomRevisInfo;



@property (weak, nonatomic) IBOutlet UITextField *saleTextField;
@property (weak, nonatomic) IBOutlet UITextField *rentTextField;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (weak, nonatomic) IBOutlet UILabel *label4;

@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;

@property (weak, nonatomic) IBOutlet UILabel *label7;
@property (weak, nonatomic) IBOutlet UILabel *label8;
- (IBAction)sureAction:(id)sender;

- (IBAction)cancelAction:(id)sender;











@end
