//
//  RoomDetailVC.h
//  BYFCApp
//
//  Created by PengLee on 14/12/16.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PL_Header.h"
#import "Comon.h"
#import "BMKMapView.h"
#import "CycleScrollView.h"



@interface RoomDetailVC : UIViewController<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,BMKMapViewDelegate,UITextFieldDelegate>
{
   
    CGFloat _keyboardHeight;
    CGFloat heightForRow;
    
    
//    UILabel * titleLable;
//    UILabel * titleLable1;
    UITableView * _tableView;
    NSDictionary *loupanDic;
    UIView *phonebg;
    UITableView *phoneTable;
    NSArray *phoneArr;
    UIButton * rightBtn;
    UILabel *placeholder;
    
    NSArray *imageArray;
    UIButton *fangshiBtn;
    UIButton *styleBtn;
    NSMutableArray * imageArrayContent;
    
    NSDictionary *detailDic;
    UIButton * button11;
    UIButton * button22;
    
    UIButton * button2;
    UIView *view2;
    
    
    
    NSString * filePathImage;
     long  int               imageCurrentID;
    NSInteger           _currentNum;
    
    NSString * _photoCacheType;
    CycleScrollView * cycle;
   
    
}
/**
 *  重新懒加载MapView因为有几个地方都调用了相机，在相机Dismiss方法返回的时候重新调用了ViewWillAppear方法，地图视图在一开始进入界面的时候已经被加载过一次了，然后又创建，形成了冲突所以改成懒加载，在判断MapView为nil的时候再去创建
 *
 *
 */
@property(nonatomic,strong) BMKMapView * mapView;

//xiangqing
@property(nonatomic,strong)NSArray *detailArray;
@property(nonatomic,strong)NSDictionary * dictionary;
@property(nonatomic,strong)NSArray *genjinArray;
//楼盘数组
@property(nonatomic,strong)NSArray *loupanArray;
@property(nonatomic,strong)NSArray *countArray;
@property(strong,nonatomic)NSString *  roomProID;

@property(strong,nonatomic) NSString * propertyID;;

//方式
@property(strong,nonatomic)NSString *fangshiS;
@property(strong,nonatomic)NSString *styleS;

@property(strong,nonatomic)UIButton * button1;

@property(strong,nonatomic)UILabel * titleLable;
@property(strong,nonatomic)UILabel * titleLable1;

@property(strong,nonatomic)RoomData * aRoomData;

//客源ID
@property(nonatomic,strong)NSString *RoomDetailCustID;

@property(nonatomic,strong)UITableView * detailTableView;


@end
