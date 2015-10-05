//
//  HYTabBarController.m
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/8/27.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import "HYTabBarController.h"
#import "HYAdManager.h"
#import "UIView+Frame.h"

@interface HYTabBarController ()

@end

@implementation HYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [HYAdManager loadLatestAdImage];
 //   NSLog(@" 111---  %d",[HYAdManager isShouldDisplayAd] );

    if ([HYAdManager isShouldDisplayAd]) {
        // ------这里主要是容错一个bug。
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"top20"];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"rightItem"];
        
        
        // ------本想吧广告设置成广告显示完毕之后再加载rootViewController的，但是由于前期已经使用storyboard搭建了，写在AppDelete里会冲突，只好就随便整个view广告
        UIView *adView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        UIImageView *adImg = [[UIImageView alloc]initWithImage:[HYAdManager getAdImage]];
        UIImageView *adBottomImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"adBottom.png"]];
        [adView addSubview:adBottomImg];
        [adView addSubview:adImg];
        adBottomImg.frame = CGRectMake(0, self.view.height - 135, self.view.width, 135);
        adImg.frame = CGRectMake(0, 0, self.view.width, self.view.height - 135);
        
        //        adImg.frame = [UIScreen mainScreen].bounds;
        adView.alpha = 0.99f;
        [self.view addSubview:adView];
        [[UIApplication sharedApplication]setStatusBarHidden:YES];
        
        [UIView animateWithDuration:3 animations:^{
            adView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            [[UIApplication sharedApplication]setStatusBarHidden:NO];
            [UIView animateWithDuration:0.5 animations:^{
                adView.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [adView removeFromSuperview];
            }];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"HYAdvertisementKey" object:nil];
        }];
    }else{
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"update"];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
