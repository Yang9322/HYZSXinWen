//
//  NewsModal.m
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/9/1.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import "NewsModal.h"

@implementation NewsModal

+ (instancetype)newsModelWithDict:(NSDictionary *)dict
{
    NewsModal *model = [[self alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

@end


