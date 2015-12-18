//
//  PSWResetViewController.h
//  BYFCApp
//
//  Created by zzs on 14/12/9.
//  Copyright (c) 2014年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSWResetViewController : UIViewController<UITextFieldDelegate>
{
    UITextField *oldPsw;
    UITextField *newPsw;
    UITextField *newPsw2;
}
@end
