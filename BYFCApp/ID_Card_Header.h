//
//  ID_Card_Header.h
//  BYFCApp
//
//  Created by Wangpu_IOS on 15/12/17.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ID_Card_Header : UIView
@property (weak, nonatomic) IBOutlet UIButton *ID_Card;
+(ID_Card_Header*)AddSubHeaderView_ID_Card;
@end
