//
//  HomeViewController.m
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/8/26.
//  Copyright © 2015年 He yang. All rights reserved.
//
#include "HYTableViewController.h"
#import "HomeViewController.h"
#import "HYTitleLabel.h"
#import "UIView+Frame.h"
#import "AFNetworking.h"
#import "WeatherModal.h"
#import "HYWeatherView.h"
#import "HYDetailWeatherView.h"
#import "MJExtension.h"
#import "HYAdManager.h"


@interface HomeViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *smallScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;
@property(nonatomic,strong)NSArray *newsLists;
@property(nonatomic,weak)HYTitleLabel *selectedLabel;
@property(nonatomic,weak)UIButton *rightBtn;
@property(nonatomic,assign)BOOL weatherShow;
@property(nonatomic,weak)HYWeatherView *weatherView;
@property(nonatomic,strong)UIImageView *tran;
@property(nonatomic,strong)WeatherModal *weatherModal;


@end

@implementation HomeViewController


-(NSArray *)newsLists{
    if (!_newsLists) {
        _newsLists = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"NewsURLs.plist" ofType:nil]];;
    }
    return _newsLists;
}

- (void)viewDidLoad {
    [super viewDidLoad];
       
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.smallScrollView.showsHorizontalScrollIndicator = NO;
    self.smallScrollView.showsVerticalScrollIndicator = NO;
    self.bigScrollView.delegate = self;
    [self addControllers];
    [self addTitleLabels];
//    self.smallScrollView.backgroundColor = [UIColor grayColor];
    CGFloat contenx = self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
    self.bigScrollView.contentSize = CGSizeMake(contenx, 0);
    self.bigScrollView.pagingEnabled = YES;
    UIViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.bigScrollView.bounds;
    [self.bigScrollView addSubview:vc.view];
    HYTitleLabel *label = [self.smallScrollView.subviews firstObject];
    label.scale = 1.0;
 //   self.bigScrollView.showsHorizontalScrollIndicator = NO;
    UIButton *rightBtn = [[UIButton alloc] init];
    self.rightBtn = rightBtn;
    UIWindow *win = [[UIApplication sharedApplication].windows firstObject];
    [win addSubview:rightBtn];
    rightBtn.y = 20;
    rightBtn.width = 40;
    rightBtn.height = 40;
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.x = [UIScreen mainScreen].bounds.size.width -  rightBtn.width;
    [rightBtn setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];
    
    [self sendWeatherRequest];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushWeatherDetail) name:@"pushWeatherDetail" object:nil];
    
//  UIViewController *vc = self.childViewControllers[1];
//    vc.view.backgroundColor = [UIColor yellowColor];
    
    
  
    // Do any additional setup after loading the view.
}

-(void)pushWeatherDetail{
    self.weatherShow = NO;
    HYDetailWeatherView *detailVc = [[HYDetailWeatherView alloc] init];
    [self.navigationController pushViewController:detailVc animated:YES];
    [UIView animateWithDuration:0.1 animations:^{
        self.weatherView.alpha = 0;
    } completion:^(BOOL finished) {
        self.weatherView.alpha = 0.9;
        self.weatherView.hidden = YES;
        self.tran.hidden = YES;
    }];
    detailVc.weatherModal =self.weatherModal;

    
}

-(void)rightBtnClick{
    if (self.weatherShow) {
        self.weatherView.hidden = YES;
        self.tran.hidden = YES;
        [UIView animateWithDuration:0.1 animations:^{
            self.rightBtn.transform = CGAffineTransformRotate(self.rightBtn.transform,M_1_PI * 5);
        } completion:^(BOOL finished) {
            [self.rightBtn setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];
        }];
//

    }else{
        [self.rightBtn setImage:[UIImage imageNamed:@"223"] forState:UIControlStateNormal];
        [self.weatherView addAnimate];
        self.weatherView.hidden = NO;
        self.tran.hidden = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.rightBtn.transform = CGAffineTransformRotate(self.rightBtn.transform, -M_1_PI * 6);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 animations:^{
                self.rightBtn.transform = CGAffineTransformRotate(self.rightBtn.transform, M_1_PI );
            }];
        }];

    }
    
    self.weatherShow = !self.weatherShow;
    
}

-(void)sendWeatherRequest{
    NSString *url = @"http://c.3g.163.com/nc/weather/5YyX5LqsfOWMl%2BS6rA%3D%3D.html";
    [[AFHTTPRequestOperationManager manager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
       // NSLog(@"   %@",responseObject);
       
        
        WeatherModal *weatherModal =  [WeatherModal objectWithKeyValues:responseObject];
        
        
        self.weatherModal = weatherModal;
        [self addWeatherView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

-(void)addWeatherView{
    HYWeatherView *weatherView = [HYWeatherView view];
    self.weatherView = weatherView;
    weatherView.weatherModel = self.weatherModal;
    weatherView.alpha = 0.9;
    [[[UIApplication sharedApplication].windows firstObject] addSubview:weatherView];
    
    weatherView.frame = [UIScreen mainScreen].bounds;
    weatherView.y = 64;
    weatherView.height -=64;
    self.weatherView.hidden = YES;
    
    
    
    UIImageView *tran = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"224"]];
    self.tran = tran;
    tran.width = 7;
    tran.height = 7;
    tran.y = 57;
    tran.x = [UIScreen mainScreen].bounds.size.width - 33;
    [[[UIApplication sharedApplication].windows firstObject] addSubview:tran];
    self.tran.hidden = YES;
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.rightBtn.hidden = NO;
    self.rightBtn.alpha = 0;
    [UIView animateWithDuration:0.4 animations:^{
        self.rightBtn.alpha = 1;
    }];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.rightBtn.hidden = YES;
    self.rightBtn.transform = CGAffineTransformIdentity;
    [self.rightBtn setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];
}


-(void)addControllers{
    for (int i = 0; i < self.newsLists.count; i++) {
        HYTableViewController *vc = [[UIStoryboard storyboardWithName:@"News" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        vc.title = self.newsLists[i][@"title"];
//        NSDictionary *dic = [NSDictionary dictionary];
//        [dic setValue:[UIColor redColor] forKey:@"tintColor"];
        //[vc.title setValue:[UIColor redColor] forKey:@"tintColor"];
//        
     //   self.tabBarItem.title = @"123";
        vc.urlString = self.newsLists[i][@"urlString"];
        [self addChildViewController:vc];
       // [self.bigScrollView addSubview:vc.view];
    }
    
}


-(void)addTitleLabels{
   

    for (int i = 0; i < self.newsLists.count; i ++) {
        CGFloat labelW = 70;
        CGFloat labelH = 30;
        CGFloat labelY = 0;
        CGFloat labelX = i * labelW;
        HYTitleLabel *label = [[HYTitleLabel alloc] init];
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        HYTableViewController *vc = self.childViewControllers[i];
        label.text = vc.title;
      //  label.backgroundColor = [UIColor redColor];
       // label.font = [UIFont systemFontOfSize:19];
        label.userInteractionEnabled = YES;
        [self.smallScrollView addSubview:label];
      //  NSLog(@"11--%@",NSStringFromCGRect(label.frame));
        label.tag = i;
         [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lblClick:)]];

        
    }
    self.smallScrollView.contentSize = CGSizeMake(70 * self.newsLists.count, 0);

}

//-(void)lblClick:(UIGestureRecognizer *)recognizer{
//    
//    HYTitleLabel *label = (HYTitleLabel *)recognizer.view;
//    
//   // NSLog(@"%ld",(long)label.tag);
//    CGFloat offsetX = label.tag * self.bigScrollView.frame.size.width;
//    CGFloat offsetY = self.bigScrollView.contentOffset.y;
//
//    CGPoint offsetPoint =CGPointMake(offsetX, offsetY);
//   // CGFloat bigW =
//    [self.bigScrollView setContentOffset:offsetPoint];
//    
//}

- (void)lblClick:(UITapGestureRecognizer *)recognizer
{
    HYTitleLabel *titlelable = (HYTitleLabel *)recognizer.view;
    
    CGFloat offsetX = titlelable.tag * self.bigScrollView.frame.size.width;
    
    CGFloat offsetY = self.bigScrollView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    [self.bigScrollView setContentOffset:offset animated:YES];
    
    
}



/*!
 滚动结束后调用
 
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSUInteger index = scrollView.contentOffset.x / self.bigScrollView.frame.size.width;
    HYTitleLabel *label =(HYTitleLabel*) self.smallScrollView.subviews[index];
    CGFloat offsetX = label.center.x - self.smallScrollView.frame.size.width * 0.5;
    CGFloat offsetMax = self.smallScrollView.contentSize.width - self.smallScrollView.frame.size.width;
    if (offsetX < 0) {
        offsetX = 0;
    }else if(offsetX > offsetMax){
        offsetX = offsetMax;}
    CGPoint  offsetPoint = CGPointMake(offsetX, 0);
    
    [self.smallScrollView setContentOffset:offsetPoint animated:YES];
    HYTableViewController *newsVc = self.childViewControllers[index];
    newsVc.index = index;
    [self.smallScrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != index) {
            HYTitleLabel *label = self.smallScrollView.subviews[idx];
            label.scale = 0.0;
        }
    }];
    if (newsVc.view.superview)return;
    newsVc.view.frame = scrollView.bounds;
    [self.bigScrollView addSubview:newsVc.view];
    
}

/*!
 
 
 */


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
        // 取出绝对值 避免最左边往右拉时形变超过1
        CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
        NSUInteger leftIndex = (int)value;
        NSUInteger rightIndex = leftIndex + 1;
        CGFloat scaleRight = value - leftIndex;
        CGFloat scaleLeft = 1 - scaleRight;
        HYTitleLabel *labelLeft = self.smallScrollView.subviews[leftIndex];
        labelLeft.scale = scaleLeft;
        // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
        if (rightIndex < self.smallScrollView.subviews.count) {
            HYTitleLabel *labelRight = self.smallScrollView.subviews[rightIndex];
            labelRight.scale = scaleRight;
        }
        
  //  NSLog(@"%f",scrollView.contentOffset.x);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 刚选中又马上取消选中，格子不变色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    UIViewController *vc = [[UIViewController alloc]init];
//    vc.view.backgroundColor = [UIColor yellowColor];
}
@end
