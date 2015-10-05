//
//  HttpTool.h
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/8/29.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface HttpTool : AFHTTPSessionManager

+ (instancetype)sharedHttpTools;

+ (instancetype)sharedNetworkToolsWithoutBaseUrl;

@end
