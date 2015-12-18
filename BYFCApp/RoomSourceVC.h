//
//  RoomSourceVC.h
//  BYFCApp
//
//  Created by PengLee on 14/12/3.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "SWTableViewCell.h"
#import "Comon.h"
@class RoomDetailVC;

@interface RoomSourceVC : UIViewController<UITextFieldDelegate>
{
    UIButton            * _currentBtn;
    UITableView         * _tableView1;
    UITableView         * _tableView2;
  long  int               imageCurrentID;
    NSMutableArray      * arrTitle;
  long  int                     currentTag;
    UIView              *  colView;
    UILabel             * style;
    UILabel             * fangshi;
    UIView              *smallView;
    UITableView         * tableVeiwList;
    NSArray             * styleArray;
    UIView              * sousuoViewstyle;
    UIWindow            * mainWindow;
    UITableView         * telTableView;
    NSArray             * telNumArray;
    UIView              * bgHuiView;
    RoomDetailVC        * detailVC;
    NSString            *districtStr;
    NSString            *areaStr;
    NSString            * tradeStringCache;
    UIView              *dropBgView;
    UILabel             *placeholder;
    UIButton            *fangshiBtn;
    UIButton            *styleBtn;
    NSMutableArray      * _downArrayImage;
    //更多筛选
    //房源类型
    NSArray             *moreArr;
    NSString            *propertyTypeAccept;
    //有图无图
    NSArray             *imageArr;
    NSString            *imageTypeAccept;
    //委托状态
    NSArray             *jiaoYiArray;
    NSString            *jiaoYiTypeAccept;
    //房源类型
    NSArray             *tradeArr;
    NSString            *tradeAccept;
    //房屋现状
    NSArray             *propertyOccupyArr;
    NSString            *propertyOccupyAccept;
    //物业归属
    NSArray             *propertyOwn1Arr;
    NSString            *propertyOwn1Accept;
    //房屋朝向
    NSArray             *propertyDirectionArr;
    NSString            *propertyDirectionAccept;
    //签赔
    NSArray             *propertyTrustArr;
    NSString            *propertyTrustAccept;
    
    
    
    //筛选签赔
    NSString            *propertyTrustStr;
    //筛选房屋现状
    NSString            *propertyOccupyStr;
    //筛选房屋朝向
    NSString            *propertyDirectionStr;
    //筛选物业归属
    NSString            *propertyOwn1Str;
    //筛选房屋建筑面积F
    NSString            *roomSquareFromStr;
    //筛选房屋建筑面积T
    NSString            *roomSquareToStr;
    //筛选房屋类型-室
    NSString            *roomCountFStr;
     //筛选房屋类型-厅
    NSString            *roomCountTStr;
    //筛选业主联系方式
    NSString            *custTelStr;
    //筛选员工编号
    NSString            *userCodeStr;
    //筛选委托状态有效
    NSString            *status1Str;
    //筛选委托状态有效时间
    NSString            *statusLimitStr;
    //筛选有效开始时间
    NSString            *effectiveDateFromStr;
    //筛选有效开始时间
    NSString            *effectiveDateToStr;
    //筛选房源类型出租出售租售
    NSString            *tradeStr;
    
    //临时存储筛选条件
    NSString            *priceFrom;
    NSString            *priceTo;
    NSString            *rentPriceFrom;
    NSString            *rentPriceTo;
    NSInteger           _currentNum;
    UIButton  * alertLable;
    NSString * _photoCacheType;
    
    NSString * _roomBuildingNum;
    NSString * _roomRoomNum;
 //底部视图所加按钮
    UIView *topView;
    
}


@property(nonatomic,strong)NSMutableArray * jingliArray;
@property(nonatomic,strong)NSMutableArray * sousuoArray;
@property(nonatomic,strong)NSMutableArray * cacheArray;
@property(nonatomic,strong)NSArray * genjinArray;
//图片缓存
@property(nonatomic,strong)NSMutableDictionary * chcheImageRoom;
@property(copy,nonatomic)NSString * govAreaString;
//接收行政区名字
@property(strong,nonatomic)NSString * xingzhengqu;
@property(copy,nonatomic)NSString * tradeString;
//小区
@property (strong,nonatomic)NSString * cacheDistrictString;
//行政区
@property(strong,nonatomic)NSString * cacheEstateName;
//片区
@property (strong,nonatomic)NSString   * cacheAreaName;

//综合
@property (strong,nonatomic)NSString * cacheString;

@property (strong,nonatomic)NSString * cacheStorage;
@property (strong,nonatomic)NSString * cellProperID;
//地址
@property(strong,nonatomic)NSString * cacheAddress;
//客源ID
@property(nonatomic,strong)NSString *RoonSourceCustID;

@end
