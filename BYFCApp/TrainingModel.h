//
//  TrainingModel.h
//  BYFCApp
//
//  Created by 王鹏 on 15/12/1.
//  Copyright © 2015年 PengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrainingModel : NSObject
//培训时间
@property(nonatomic,strong)NSString*LessonDate;
//培训名称
@property(nonatomic,strong)NSString*LessonName;
//培训类型名称
@property(nonatomic,strong)NSString*LessonTypeName;
@property(nonatomic,strong)NSString*LessonType;
@property(nonatomic,strong)NSString*LessonNo;
@end
