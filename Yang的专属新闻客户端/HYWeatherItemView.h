//
//  HYWeatherItemView.h
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/9/4.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYWeatherItemView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *tLbl;
@property (weak, nonatomic) IBOutlet UILabel *weatherLbl;
@property (weak, nonatomic) IBOutlet UILabel *windLbl;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImg;
@property(nonatomic,copy)NSString *weather;
+ (instancetype)view;


@end
