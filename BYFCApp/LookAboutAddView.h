//
//  LookAboutAddView.h
//  BYFCApp
//
//  Created by zzs on 15/5/28.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookAboutAddView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet UITableView *LookRoomListTableView;

    __weak IBOutlet UITextField *EstateNameTextField;

    __weak IBOutlet UITextField *BuildingNameTextField;
    
    __weak IBOutlet UITextField *RoomNoTextField;
}
@property(nonatomic,strong)NSString *CustID;
-(void)addSelfInAView:(UIView *)sup;
@end
