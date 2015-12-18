//
//  Custom_Popover7.h
//  BYFCApp
//
//  Created by 王鹏 on 15/12/15.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisitingCard_Header.h"
#import "ID_Card_Header.h"
#import "KeyBook_Header.h"
#import "UpCommit_Footer.h"
@protocol Custom_Popover7Dalegate <NSObject>

@optional
-(UITableViewCell*)TableView:(UITableView*)tableview CellForRowAtIndexPath:(NSIndexPath*)indexPath;

//@optional
//-(CGFloat)SetRowHeight:(UITableView*)tableView IndexPath:(NSIndexPath*)indexPath;
@end
@interface Custom_Popover7 : UIView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
   
        int Sel;
    CGFloat   Height1;
    CGFloat   Height2;
    CGFloat   Height3;
    
}
-(void)RowHeight:(CGFloat)height;
-(void)RowHeight1:(CGFloat)height;
-(void)RowHeight2:(CGFloat)height;

-(void)RowHeight3:(CGFloat)height;


+(Custom_Popover7*)InitWithCutom_Popover7;
//@property (strong, nonatomic) IBOutlet UIButton *XXButoon;
//@property (weak, nonatomic) IBOutlet UIView *BackgrounView;
@property(nonatomic,strong)VisitingCard_Header*VisitingCard;
@property(nonatomic,strong)ID_Card_Header*ID_Card;
//@property (weak, nonatomic) IBOutlet UITableView *MainTableView;
@property(nonatomic,strong)UIView *BackgrounView;
@property (strong, nonatomic) IBOutlet UIButton *XXButoon;
@property (strong, nonatomic)  UITableView *MainTableView;

@property(nonatomic,strong)KeyBook_Header*KeyBook;

@property(nonatomic,strong)UpCommit_Footer*UpCommit;
@property(nonatomic,weak) id <Custom_Popover7Dalegate>Delegate;



@end
