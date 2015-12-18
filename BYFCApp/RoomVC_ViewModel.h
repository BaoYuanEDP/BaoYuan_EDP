//
//  RoomVC_ViewModel.h
//  BYFCApp
//
//  Created by Wangpu_IOS on 15/12/7.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Custom_Popover.h"
#import "Custom_Popover2.h"
#import "Custom_Popover3.h"
#import "Custom_Popover4.h"
#import "Custom_Popover5.h"
#import "Custom_Popover6.h"
#import "Custom_Popover7.h"
#import "LookKeyManagerController.h"
@interface RoomVC_ViewModel : NSObject <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate,Custom_Popover7Dalegate>
//选择签赔或者独家
@property(nonatomic,strong)Custom_Popover*Custom_Room_PopoverView;

//独家签赔
@property(nonatomic,strong)Custom_Popover2*Custom_Room_PopoverView2;
//签赔
@property(nonatomic,strong)Custom_Popover3*Custom_Room_PopoverView3;
//钥匙
@property(nonatomic,strong)Custom_Popover4*Custom_Room_PopoverView4;
//
@property(nonatomic,strong)Custom_Popover5*Custom_Room_PopoverView5;
//分行和业务员的列表
@property(nonatomic,strong)Custom_Popover6*Custom_Room_PopoverView6;
//选择行家之后上传附件
@property(nonatomic,strong)Custom_Popover7*Custom_Room_PopoverView7;

@property(nonatomic,strong)NSMutableArray*BranchArray;
@property(nonatomic,strong)NSMutableArray*SalesmanArray;
@property(nonatomic,strong)NSMutableArray* Model_ImageArray2;
@property(nonatomic,strong)NSMutableArray*Model_ImageArray4;
@property(nonatomic,strong)NSMutableArray*Model_ImageArray5;
@property(nonatomic,strong)NSMutableArray*Model_ImageArray8;
@property(nonatomic,strong)NSMutableArray*DujiaImageArray;
@property(nonatomic,strong)NSMutableArray*QianPeiImageArray;
@property(nonatomic,strong)NSMutableArray*KeyImageArray;
@property(nonatomic,strong)NSMutableArray*LookKeyArray;
@property(nonatomic,strong)NSMutableArray*DowdloadImageArray;



//查看钥匙的界面
@property(nonatomic,strong)LookKeyManagerController*LookKeyView;

/**
 *  首先创建一个工厂方法单例用来调用各种的方法
 */
+(RoomVC_ViewModel*)DefalutRoomVC;
/**
 *  控制View隐藏显示的方法
 */
-(void)Custom_Room_PopoverView6_ListPickerViewHidden1:(BOOL)hidden Hidden2:(BOOL)hidden2;
/**
 *  View6的PickerView的遵守代理方法
 */
-(void)Custom_Room_PopoverView6_ListPickerView1Delegate:(id)delegate DataSource:(id )DataSource;
-(void)Custom_Room_PopoverView6_ListPickerView2Delegate:(id)delegate DataSource:(id )DataSource;
/**
 *  加载独家按钮的方法配制
 */
-(void)ConfigurationPopoverView2AllButtonMethod;
-(void)ConfigurationPopoverView4AllButtonMethod;
/**
 *  获取预先加载的滚动视图的array
 *
 */
-(NSMutableArray*)Acquire_ImageArr3:(NSMutableArray*)imageArr3;
-(NSMutableArray*)Acquire_ImageArr1:(NSMutableArray*)imageArr1;
/**
 *  获取房源的钥匙数量来判断有没有钥匙要不要上传附件
 */
-(NSString*)Acquire_RoomHouseKey:(NSString*)houseKey;
/**
 *  获取self的当前VC
 *
 *  @param roomVC 
 *
 *  @return self
 */
-(RoomDetailVC*)Acquire_RoomDatailVC:(RoomDetailVC*)roomVC;
/**
 *  调用TouchBeegn控制键盘的输入
 */
-(void)CalltouchesBegan;
@end
