//
//  HYNavViewController.m
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/8/27.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import "HYNavViewController.h"

@interface HYNavViewController ()
@property (weak, nonatomic) IBOutlet UITabBarItem *tabBarItem;

@end

@implementation HYNavViewController

+(void)initialize{
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTintColor:[UIColor redColor]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
 [self.tabBarItem  setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    //    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeBlack) name:@"ChangeBlack" object:nil];
    
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
