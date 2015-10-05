//
//  WeatherModal.h
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/9/4.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYWeatherDetailModal.h"
#import "WeatherBg.h"
@interface WeatherModal : NSObject

@property(nonatomic,strong)NSArray *detailArray;
@property(nonatomic,strong)WeatherBg *pm2d5;
@property(nonatomic,copy)NSString *dt;
@property(nonatomic,assign)int rt_temperature;





@end
