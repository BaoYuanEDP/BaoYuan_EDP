//
//  LookKeySubCell.h
//  单个demo
//
//  Created by 王鹏 on 15/12/8.
//  Copyright © 2015年 王鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookKeySubCell : UITableViewCell
//主视图
@property (weak, nonatomic) IBOutlet UIView *SubCellView;
//姓名
@property (weak, nonatomic) IBOutlet UILabel *NameLanel;
//电话号码
@property (weak, nonatomic) IBOutlet UILabel *PhoneNumber;
//宝原或者行家
@property (weak, nonatomic) IBOutlet UILabel *TypeLabel;
//日期
@property (weak, nonatomic) IBOutlet UILabel *DateLabel;
//密码
@property (weak, nonatomic) IBOutlet UILabel *PassWordLabel;
//钥匙数量
@property (weak, nonatomic) IBOutlet UIButton *KeyNumber;
//备注
@property (weak, nonatomic) IBOutlet UILabel *RemarksLabel;
/**
 *  赋值cell的方法
 *
 *  @param Dic 字典的对应值
 */
-(void)AddObjectsKeySubCellArray:(NSDictionary*)Dic;
@end
