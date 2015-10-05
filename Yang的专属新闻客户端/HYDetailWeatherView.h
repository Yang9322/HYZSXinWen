//
//  HYDetailWeatherView.h
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/9/1.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeatherModal;

@interface HYDetailWeatherView : UIViewController


@property(nonatomic,strong)WeatherModal *weatherModal;
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;


@end
