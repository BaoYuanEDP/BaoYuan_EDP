//
//  GosenResultView.h
//  BYFCApp
//
//  Created by PengLee on 15/5/22.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GosenResultView : UIView<UITableViewDataSource,UITableViewDelegate>{

    
    __weak IBOutlet UIButton *dateTimeButton;
    
    
}
@property (weak, nonatomic) IBOutlet UITableView *dataSourcesTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTopLayout;
- (IBAction)rightCloseButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *lableJL;

@property (weak, nonatomic) IBOutlet UIView *viewS;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lableHeightLayout;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellHeightLayout;
@property(nonatomic,strong) NSMutableArray *dataSourceArray;
-(void)addSelfInAView:(UIView *)sup andGoseeID:(NSString *)goseeID;
//约看结果
@property (weak, nonatomic) IBOutlet UILabel *lableJieGu;
//类型
@property (weak, nonatomic) IBOutlet UIButton *lableLX;
//图片
@property (weak, nonatomic) IBOutlet UIImageView *lmg;
//键盘消失
- (IBAction)textFiledReturnEditing:(id)sender;
-(instancetype)initWithFrame:(CGRect)frame isBool:(BOOL)isbool;
@end
