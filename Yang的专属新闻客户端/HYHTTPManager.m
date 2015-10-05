//
//  HYHTTPManager.m
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/8/26.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import "HYHTTPManager.h"

@implementation HYHTTPManager

+ (instancetype)manager
{
    HYHTTPManager *mgr = [super manager];
    NSMutableSet *mgrSet = [NSMutableSet set];
    mgrSet.set = mgr.responseSerializer.acceptableContentTypes;
    
    [mgrSet addObject:@"text/html"];
    
    mgr.responseSerializer.acceptableContentTypes = mgrSet;
    
    return mgr;
}

@end
