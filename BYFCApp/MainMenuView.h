//
//  MainMenuView.h
//  BYFCApp
//
//  Created by PengLee on 15/3/9.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PL_Header.h"
typedef NS_ENUM(NSInteger, TableAnimation) {
    tableAnimationLeft=0,
    tableAnimationRight,
};
@protocol MenuDelegate <NSObject>

@required
- (void)didselectRow:(NSInteger)row cellTile:(NSString *)title tableShowDeriction:(TableAnimation )showderiction;


@end
@interface MainMenuView : UIView
@property (strong,nonatomic)NSArray * opertions;
@property (weak ,nonatomic)id <MenuDelegate>delegate;

- (id)initWithTile:(NSString *)string loadWithArray:(NSArray *)array isOpenWithDirection:(TableAnimation)showDirection;
- (void)showAnimation:(BOOL)animation;
- (NSArray *)loadWithArray:(NSArray *)array;


@end
