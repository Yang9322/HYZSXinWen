//
//  MJExtensionConfig.m
//  81 - 网易新闻
//
//  Created by dongshangxian on 15/8/10.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//
//
//#import "MJExtensionConfig.h"
//#import "MJExtension.h"
//#import "WeatherModal.h"
//
//@implementation MJExtensionConfig
//+ (void)load
//{
//
//    [WeatherModal setupObjectClassInArray:^NSDictionary *{
//        return @{
//                 @"detailArray" : @"HYWeatherDetailModal"
//                 };
//    }];
//    // 相当于在StatusResult.m中实现了+objectClassInArray方法
//    
//    // Student中的ID属性对应着字典中的id
//    // ....
//    [HYWeatherModel setupReplacedKeyFromPropertyName:^NSDictionary *{
//        return @{
//                 @"detailArray" : @"北京|北京"
//                 };
//    }];
//    // 相当于在Student.m中实现了+replacedKeyFromPropertyName方法
//    
//    [HYPhotoSet setupObjectClassInArray:^NSDictionary *{
//        return @{
//                 @"photos":@"HYPhotosDetail"
//                 };
//    }];
//}
//@end
