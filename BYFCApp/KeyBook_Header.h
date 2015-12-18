//
//  KeyBook_Header.h
//  BYFCApp
//
//  Created by Wangpu_IOS on 15/12/17.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyBook_Header : UIView
@property (weak, nonatomic) IBOutlet UIButton *KeyStorageBook;
+(KeyBook_Header*)AddSubHeaderView_KeyBook;
@end
