//
//  LookSeeView.h
//  BYFCApp
//
//  Created by PengLee on 15/5/28.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookSeeView : UIView<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong) NSString *propertyIDString;
-(void)addSelfInAView:(UIView *)sup;
@property(nonatomic,copy)NSString*EstStr;
@property(nonatomic,copy)NSString*FloorStr;
@end
