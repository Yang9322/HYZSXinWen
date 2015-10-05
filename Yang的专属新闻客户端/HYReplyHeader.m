//
//  HYReplyHeader.m
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/9/25.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import "HYReplyHeader.h"

@implementation HYReplyHeader

/** 类方法快速返回热门跟帖的view */
+ (instancetype)replyViewFirst
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"HYReplyHeader" owner:nil options:nil];
    return [array firstObject];
}

/** 类方法快速返回最新跟帖的view */
+ (instancetype)replyViewLast
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"HYReplyHeader" owner:nil options:nil];
    return [array lastObject];
}

@end
