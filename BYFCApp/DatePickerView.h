//
//  DatePickerView.h
//  BYFCApp
//
//  Created by PengLee on 15/5/21.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DatePickerViewDelegate <NSObject>

-(void)transformAdateString:(NSString *)date;

@end
@interface DatePickerView : UIView
@property(nonatomic,copy)void (^blockString)(NSString  * string);
@property(weak,nonatomic)id<DatePickerViewDelegate>dateDelegate;
-(void)addSelfInAView:(UIView *)sup comPleteBlock:(void (^)(NSString *str))block;

@end
