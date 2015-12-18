//
//  NewReviseFYViewController.h
//  BYFCApp
//
//  Created by PengLee on 15/8/20.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PL_Header.h"

@interface NewReviseFYViewController : UIViewController
{
    //定义字符串判断领导与业务员
    NSString * flagSubs;
}
@property(nonatomic,strong)NSString *followListdutyCode;
@property(nonatomic,strong)NSString *roomdutycode;
@property(nonatomic,strong)NSString *dutyCode;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
- (IBAction)sureBut:(id)sender;
- (IBAction)cancelBut:(id)sender;
@property(nonatomic,strong) RoomData * reviseRoomData;
@property(nonatomic,strong) NSDictionary *housDic;
@property(nonatomic)BOOL isEq;
@property(nonatomic,strong)NSArray * titleArray;
@property(nonatomic,strong)NSMutableArray * jiaoYiArray;
@property (nonatomic, strong) NSDictionary *arrayData;//售价租价等数据
@property (nonatomic,strong)UITextField *rentPriceTextField;
@property (nonatomic,strong)UITextField *salePriceTextField;
@property(nonatomic,strong)NSString     *statusString;
@property(nonatomic,strong)NSString     *jiShouString;
@property(nonatomic,strong)NSString     *jingLiTuiJianString;
@property (nonatomic,strong) NSString *propertyIDString;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)RoomRevisInfo *neRoomRevisInfo;


@end
