//
//  HYWeatherView.h
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/9/1.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeatherModal;

@interface HYWeatherView : UIView

@property(nonatomic,strong)WeatherModal *weatherModel;


+ (instancetype)view;
- (void)addAnimate;


@end
