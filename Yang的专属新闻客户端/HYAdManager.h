//
//  HYAdManager.h
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/10/5.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYAdManager : NSObject


+ (BOOL)isShouldDisplayAd;
+ (UIImage *)getAdImage;
+ (void)loadLatestAdImage;

@end
