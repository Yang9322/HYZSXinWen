//
//  HYTitleLabel.m
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/8/29.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import "HYTitleLabel.h"

@implementation HYTitleLabel

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:14];
        self.scale = 0.0;
    }
    return self;
}


-(void)setScale:(CGFloat)scale{
    _scale = scale;
    self.textColor = [UIColor colorWithRed:scale green:0.0 blue:0.0 alpha:1];
    CGFloat minScale = 0.7;
    CGFloat trueScale = minScale + (1-minScale)*scale;
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);

}

@end
