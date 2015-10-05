//
//  WeatherModal.m
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/9/4.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import "WeatherModal.h"
#import "MJExtension.h"

@implementation WeatherModal



+(NSDictionary *)objectClassInArray{
    return @{
             @"detailArray" : @"HYWeatherDetailModal",
             
     
             };
}

+ (NSDictionary *)replacedKeyFromPropertyName{
      return @{  @"detailArray" : @"北京|北京"};
}




@end
