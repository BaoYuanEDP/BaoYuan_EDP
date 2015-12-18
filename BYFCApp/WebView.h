//
//  WebView.h
//  BYFCApp
//
//  Created by PengLee on 15/3/6.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebView : UIView
@property (nonatomic,strong)UIWebView * conmonWebView;
- (id)initWithPoint:(float)frame  loadURL:(NSString *)URL;


@end
