//
//  CycleScrollView.h
//  CycleScrollDemo
//
//  Created by Weever Lu on 12-6-14.
//  Copyright (c) 2012年 linkcity. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CycleDirectionPortait,          // 垂直滚动
    CycleDirectionLandscape         // 水平滚动
}CycleDirection;

@protocol CycleScrollViewDelegate;

@interface CycleScrollView : UIView <UIScrollViewDelegate> {
    
    UIScrollView *scrollView;
   
    
    NSInteger  totalPage;
   NSInteger  curPage;
    CGRect scrollFrame;
    
    CycleDirection scrollDirection;     // scrollView滚动的方向
    NSArray *imagesArray;               // 存放所有需要滚动的图片 UIImage
    NSMutableArray *curImages;          // 存放当前滚动的三张图片
    
    id delegate;
}

@property (nonatomic, assign) id delegate;
@property(nonatomic,strong) UIImageView *curImageView;
- (NSInteger)validPageValue:(NSInteger)value;
- (id)initWithFrame:(CGRect)frame ;

- (void)cycleDirection:(CycleDirection)direction pictures:(NSArray *)pictureArray;

- (NSArray *)getDisplayImagesWithCurpage:(NSInteger)page;
- (void)refreshScrollView;

@end

@protocol CycleScrollViewDelegate <NSObject>
@optional
- (void)cycleScrollViewDelegate:(CycleScrollView *)cycleScrollView didSelectImageView:(NSInteger)index;
- (void)cycleScrollViewDelegate:(CycleScrollView *)cycleScrollView didScrollImageView:(NSInteger)index;

@end