//
//  WeatherBg.h
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/9/1.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherBg : NSObject

@property(nonatomic,copy)NSString *nbg1;

/** 这个是真正的背景图*/
@property(nonatomic,copy)NSString *nbg2;

@property(nonatomic,copy)NSString *aqi;

@property(nonatomic,copy)NSString *pm2_5;

@end
