//
//  HYPhotosDetail.h
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/9/27.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYPhotosDetail : NSObject


// 图片URL
@property (nonatomic, copy) NSString *timgurl;
// 图片对应的URL网址
@property (nonatomic, copy) NSString *photohtml;
// 默认新建网页首页 ＃
@property (nonatomic, copy) NSString *newsurl;
// 方形图片URL
@property (nonatomic, copy) NSString *squareimgurl;
// cimg图片URL
@property (nonatomic, copy) NSString *cimgurl;
// 图片标题
@property (nonatomic, copy) NSString *imgtitle;
@property (nonatomic, copy) NSString *simgurl;
// 标签
@property (nonatomic, copy) NSString *note;
// 图片ID
@property (nonatomic, copy) NSString *photoid;
// 图片下载地址
@property (nonatomic, copy) NSString *imgurl;

@end
