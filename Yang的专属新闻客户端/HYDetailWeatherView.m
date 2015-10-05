//
//  HYDetailWeatherView.m
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/9/1.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import "HYDetailWeatherView.h"
#import "UIView+Frame.h"
#import "HYWeatherDetailModal.h"
#import "WeatherModal.h"
#import "UIImageView+WebCache.h"
#import "HYWeatherItemView.h"

@interface HYDetailWeatherView ()



@property(nonatomic,strong)UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *tempLbl;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImg;
@property (weak, nonatomic) IBOutlet UILabel *dateWeekLbl;
@property (weak, nonatomic) IBOutlet UILabel *airPMLbl;
@property (weak, nonatomic) IBOutlet UILabel *climateLbl;
@property (weak, nonatomic) IBOutlet UILabel *windLbl;

@end

@implementation HYDetailWeatherView

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
         self.hidesBottomBarWhenPushed=YES;
       // self.view.backgroundColor = [UIColor blueColor];
    }
    return self;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    UIView *bottomView = [[UIView alloc] init];
    self.bottomView = bottomView;
    [self.view addSubview:bottomView];
    bottomView.height = 250;
    bottomView.width = [UIScreen mainScreen].bounds.size.width;
    bottomView.x = 0;
    bottomView.y = [UIScreen mainScreen].bounds.size.height - bottomView.height;
    bottomView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [self addWeatherView];
    for (int i = 1; i < 4; i ++) {
        HYWeatherDetailModal *detailModal = self.weatherModal.detailArray[i];
        [self addItemWithTitle:detailModal.week weather:detailModal.climate wind:detailModal.wind temperature:detailModal.temperature index:i - 1];
    }
}


-(void)addItemWithTitle:(NSString *)title weather:(NSString *)weather wind:(NSString *)wind temperature:(NSString *)temper index:(int)index{
    HYWeatherItemView *itemView = [HYWeatherItemView view];
    itemView.width = [UIScreen mainScreen].bounds.size.width / 3;
    itemView.y = 0;
    itemView.height = 200;
    itemView.x =index * itemView.width;
    itemView.weather = weather;
    itemView.titleLbl.text = title;
    NSMutableString *temperature = [temper mutableCopy];
    [temperature replaceOccurrencesOfString:@"C" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, temperature.length)];
    itemView.tLbl.text = temperature;
//    NSMutableString *temp = [T mutableCopy];
//    [temp replaceOccurrencesOfString:@"C" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, temp.length)];
    itemView.windLbl.text = wind;
    [self.bottomView addSubview:itemView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (IBAction)back {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)addWeatherView{
        HYWeatherDetailModal *detailModal = self.weatherModal.detailArray[0];
    
    NSMutableString *temp = [detailModal.temperature mutableCopy];
    [temp replaceOccurrencesOfString:@"C" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, temp.length)];
    
    self.tempLbl.text = temp;
    
    self.dateWeekLbl.text = [NSString stringWithFormat:@"%@  %@",self.weatherModal.dt,detailModal.week];
    
    NSString *desc;
    int pm = self.weatherModal.pm2d5.pm2_5.intValue;
    if (pm < 50) {
        desc = @"优";
    }else if (pm < 100){
        desc = @"良";
    }else{
        desc = @"差";
    }
    
    self.airPMLbl.text = [NSString stringWithFormat:@"PM2.5 %d %@",pm,desc];
    //    self.localLbl.text = @"北京";
    self.climateLbl.text = detailModal.climate;
    self.windLbl.text = detailModal.wind;
    
    if ([detailModal.climate isEqualToString:@"雷阵雨"]) {
        self.weatherImg.image = [UIImage imageNamed:@"thunder"];
    }else if ([detailModal.climate isEqualToString:@"晴"]){
        self.weatherImg.image = [UIImage imageNamed:@"sun"];
    }else if ([detailModal.climate isEqualToString:@"多云"]){
        self.weatherImg.image = [UIImage imageNamed:@"sunandcloud"];
    }else if ([detailModal.climate isEqualToString:@"阴"]){
        self.weatherImg.image = [UIImage imageNamed:@"cloud"];
    }else if ([detailModal.climate hasSuffix:@"雨"]){
        self.weatherImg.image = [UIImage imageNamed:@"rain"];
    }else if ([detailModal.climate hasSuffix:@"雪"]){
        self.weatherImg.image = [UIImage imageNamed:@"snow"];
    }else{
        self.weatherImg.image = [UIImage imageNamed:@"sandfloat"];
    }
    [self.bgImg sd_setImageWithURL:[NSURL URLWithString:self.weatherModal.pm2d5.nbg2] placeholderImage:[UIImage imageNamed:@"QingTian"]];
}




@end
