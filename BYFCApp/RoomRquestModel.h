//
//  RoomRquestModel.h
//  BYFCApp
//
//  Created by Wangpu_IOS on 15/12/5.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^allTypeBlock)(id object,NSString*Result);
typedef void(^NotTypeBlock)(NSMutableArray* object);
@interface RoomRquestModel : NSObject
/**
 *  声明一个单例的类方法
 *
 *  @return 一个单例
 */
+(RoomRquestModel*)defalutRquestModel;
/**
 *  回调的Block
 *
 *  @return 返回的block带的值
 */
@property(nonatomic,copy)allTypeBlock CustomBlockAllType;
@property(nonatomic,copy)NotTypeBlock CustomBlockNotType;
/**
 *  setValueWithForKeys方法对应的Key独家与签赔的传值key
 */
@property(nonatomic,strong)NSString*PropertyID;
@property(nonatomic,strong)NSString*PropertyType;
@property(nonatomic,strong)NSString*PropertyTrust;
@property(nonatomic,strong)NSString*Price;
@property(nonatomic,strong)NSString*Date;
@property(nonatomic,strong)NSString*jsonData;
@property(nonatomic,strong)NSString*userid;
@property(nonatomic,strong)NSString*token;
/**
 *  钥匙保管的传值key
 重复jsonData userid token
 */
@property(nonatomic,strong)NSString*HouseKey;
@property(nonatomic,strong)NSString*WhereKey;
@property(nonatomic,strong)NSString*PasswordKey;
@property(nonatomic,strong)NSString*ContactMess;
@property(nonatomic,strong)NSString*CheckInUserId;
@property(nonatomic,strong)NSString*Remark;
@property(nonatomic,copy) void (^allTypeBlock)(id obj);
/**
 *  钥匙管理查询的传值key
 重复，PropertyID userid token
 */
/**
 *  查询B层经理下的所有分行|分行E层业务员
 *
 * 重复，WhereKey userid token
 */
/**
 *  签赔与独家的请求
 *
 *  @param model 传入的字典整合数据
 *  @param block block回调的值
 */
-(void)signatureRquestModel:(NSDictionary*)model BackValue:(void(^)(id obj,NSString*Result))block;
/**
 *  钥匙添加的请求
 *
 *  @param model 传入的字典整合数据
 *  @param block block回调的值
 */
-(void)AddProKeyRquestModel:(NSDictionary*)model BackValue:(void(^)(id obj,NSString*Result))block;
/**
 *  钥匙管理查询
 *
 *  @param model 传入的字典整合数据
 *  @param block block回调的值
 */
-(void)GetHouseKeyListRquestModel:(NSDictionary*)model BackValue:(void(^)(id obj,NSString*Result))block;
/**
 *  查询B层经理下的所有分行|分行E层业务员
 *
 *  @param model 传入的字典整合数据
 *  @param block block回调的值
 */
-(void)GetSelectYB_BranchRquestModel:(NSDictionary*)model BackValue:(void(^)(NSMutableArray* obj))block;

@end
