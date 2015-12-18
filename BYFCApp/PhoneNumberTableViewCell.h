//
//  PhoneNumberTableViewCell.h
//  BYFCApp
//
//  Created by PengLee on 15/5/14.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PhoneNumberTableViewCellDelegate<NSObject>
/**
 *  @brief
 *
 *  @param point 点击事件在其父视图上的所在位置
 */
-(void)editPhoneNumber:(CGPoint)point;
-(void)deletePhoneNumber:(CGPoint)point;
@end
@interface PhoneNumberTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextfield;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIImageView *PhoneTypeImageView;
@property (weak, nonatomic) id<PhoneNumberTableViewCellDelegate>phoneNumberDelegate;

@end
