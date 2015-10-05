//
//  HYDetailImgModal.m
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/9/26.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import "HYDetailImgModal.h"

@implementation HYDetailImgModal


/** 便利构造器方法 */
+ (instancetype)detailImgWithDict:(NSDictionary *)dict
{
    HYDetailImgModal *imgModel = [[self alloc]init];
    imgModel.ref = dict[@"ref"];
    imgModel.pixel = dict[@"pixel"];
    imgModel.src = dict[@"src"];
    
    return imgModel;
}



@end
