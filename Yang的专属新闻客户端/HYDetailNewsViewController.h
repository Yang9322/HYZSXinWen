//
//  HYDetailNewsViewController.h
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/9/19.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModal;

@interface HYDetailNewsViewController : UIViewController

@property(nonatomic,strong) NewsModal *newsModel;

@property (nonatomic,assign) NSInteger index;

@end
