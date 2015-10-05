//
//  HYReadViewController.m
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/10/1.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import "HYReadViewController.h"

@interface HYReadViewController ()
@property (weak, nonatomic) IBOutlet UITabBarItem *readItem;

@end

@implementation HYReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.readItem  setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
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
