//
//  HYDetailNewModal.h
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/9/6.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYDetailNewModal : NSObject

/** 新闻标题 */
@property (nonatomic, copy) NSString *title;
/** 新闻发布时间 */
@property (nonatomic, copy) NSString *ptime;
/** 新闻内容 */
@property (nonatomic, copy) NSString *body;
/** 新闻配图(希望这个数组中以后放HMNewsDetailImg模型) */
@property (nonatomic, strong) NSArray *img;

+ (instancetype)detailWithDict:(NSDictionary *)dict;


@end
