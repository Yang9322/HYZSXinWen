//
//  HYDetailNewModal.m
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/9/6.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import "HYDetailNewModal.h"
#import "HYDetailImgModal.h"

@implementation HYDetailNewModal


/** 便利构造器 */
+ (instancetype)detailWithDict:(NSDictionary *)dict
{
    HYDetailNewModal *detail = [[self alloc]init];
    detail.title = dict[@"title"];
    detail.ptime = dict[@"ptime"];
    detail.body = dict[@"body"];
    
    NSArray *imgArray = dict[@"img"];
    NSMutableArray *temArray = [NSMutableArray arrayWithCapacity:imgArray.count];
    
    for (NSDictionary *dict in imgArray) {
        HYDetailImgModal *imgModel = [HYDetailImgModal detailImgWithDict:dict];
        [temArray addObject:imgModel];
    }
    detail.img = temArray;
    
    
    return detail;
}

@end
