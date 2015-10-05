//
//  HYReplyModals.h
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/9/20.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYReplyModals : NSObject

/** 用户的姓名 */
@property(nonatomic,copy) NSString *name;
/** 用户的ip信息 */
@property(nonatomic,copy) NSString *address;
/** 用户的发言 */
@property(nonatomic,copy) NSString *say;
/** 用户的点赞 */
@property(nonatomic,copy) NSString *suppose;

@end
