//
//  HYTableViewCell.h
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/8/29.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModal;

@interface HYTableViewCell : UITableViewCell

@property(nonatomic,strong) NewsModal *NewsModel;


/**
 *  类方法返回可重用的id
 */
+ (NSString *)idForRow:(NewsModal *)NewsModel;

/**
 *  类方法返回行高
 */
+ (CGFloat)heightForRow:(NewsModal *)NewsModel;


@end
