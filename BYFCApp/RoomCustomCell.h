//
//  RoomCustomCell.h
//  BYFCApp
//
//  Created by PengLee on 15/2/5.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "SWTableViewCell.h"
#import "PL_Header.h"
@interface RoomCustomCell : SWTableViewCell
@property(nonatomic,strong)UIImageView        * shaleLable;
@property(nonatomic,strong)UIImageView        * zuLable;

@property (nonatomic,strong)UIImageView       * roomImageInfo;
@property (strong,nonatomic)UIButton          * districtNameLable;
@property (strong, nonatomic)UIButton         *estateNameLable;
@property (strong, nonatomic)UILabel          *countFLable;
@property (nonatomic,strong)UILabel           *roomNumLable;
@property (strong, nonatomic)UILabel          *squareLable;
@property (strong, nonatomic)UILabel          *tradeStateLable;

@property (strong, nonatomic)UILabel            *priceLable;
@property (strong ,nonatomic)UIButton          *areaLable;
@property (weak, nonatomic)  UIImageView        *roomImage;
@property (assign,nonatomic) float              cellHeight;

@property (strong,nonatomic)UIImageView             * jingliTuiJianLable;
@property (strong,nonatomic)UIImageView             * jishouLable;
@property (strong,nonatomic)UIImageView             * xuequfangLable;
@property (strong,nonatomic)UIButton            *leftBtn;
@property (strong,nonatomic)UIButton            *photoBtn;

//右边按钮

@property (strong,nonatomic)UIButton           *telBnt;
@property (strong,nonatomic)UIButton            * changeBtn;
- (void)initWithContent;

@end
