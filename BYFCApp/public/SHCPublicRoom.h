//
//  SHCPublicRoom.h
//  Demo
//
//  Created by zzs on 15/6/30.
//  Copyright (c) 2015年 zzs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHCPublicRoom : UIView<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    UIView * bgView;
    UIView              *smallView;
    UILabel             * fangshi;
    UIButton            *fangshiBtn;
    UILabel             * style;
    UIButton            *styleBtn;
    UIView              *  colView;
    UIView              * sousuoViewstyle;
    UITableView         * tableVeiwList;
    
    UILabel             *placeholder;
    UILabel * count;
    NSArray             * styleArray;
}
@property(nonatomic,strong)UITextView  * text;
@end
