//
//  HYWeatherDetailModal.h
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/9/4.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYWeatherDetailModal : NSObject

@property(nonatomic,copy)NSString *wind;
/** 农历*/
@property(nonatomic,copy)NSString *nongli;
/** 日期*/
@property(nonatomic,copy)NSString *date;
/** 天气*/
@property(nonatomic,copy)NSString *climate;
/** 温度*/
@property(nonatomic,copy)NSString *temperature;
/** 星期几*/
@property(nonatomic,copy)NSString *week;



@end
