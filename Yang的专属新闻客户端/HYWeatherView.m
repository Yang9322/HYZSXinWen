
//
//  HYWeatherView.m
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/9/1.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import "HYWeatherView.h"
#import "UIView+Frame.h"
#import "WeatherModal.h"
#import "HYDetailWeatherView.h"
#import "HYWeatherDetailModal.h"
#import "WeatherBg.h"

@interface HYWeatherView ()
@property (weak, nonatomic) IBOutlet UILabel *tempLbl;
@property (weak, nonatomic) IBOutlet UILabel *nowTempLbl;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImg;
@property (weak, nonatomic) IBOutlet UILabel *dateWeekLbl;
@property (weak, nonatomic) IBOutlet UILabel *airPMLbl;
@property (weak, nonatomic) IBOutlet UILabel *climateLbl;
@property (weak, nonatomic) IBOutlet UILabel *localLbl;
@property(nonatomic,weak)UIView *bottomView;
@property(nonatomic,strong)UIButton *btn1;
@property(nonatomic,strong)UIButton *btn2;
@property(nonatomic,strong)UIButton *btn3;
@property(nonatomic,strong)UIButton *btn4;
@property(nonatomic,strong)UIButton *btn5;
@property(nonatomic,strong)UIButton *btn6;

@property(nonatomic,strong)UIImageView *img1;
@property(nonatomic,strong)UIImageView *img2;
@property(nonatomic,strong)UIImageView *img3;
@property(nonatomic,strong)UIImageView *img4;
@property(nonatomic,strong)UIImageView *img5;
@property(nonatomic,strong)UIImageView *img6;

@end

@implementation HYWeatherView

+ (instancetype)view{
    return [[NSBundle mainBundle]loadNibNamed:@"HYWeatherView" owner:nil options:nil].firstObject;
}




- (void)layoutSubviews{
    [super layoutSubviews];
    self.bottomView.y = 255;
    self.bottomView.height = self.height-self.bottomView.y;
    self.bottomView.width = self.width;
    self.bottomView.x = 0;
    [self addBtnWithTitle:@"搜索" icon:@"204" color:[UIColor orangeColor] index:0];
    [self addBtnWithTitle:@"上头条" icon:@"202" color:[UIColor redColor] index:1];
    [self addBtnWithTitle:@"离线" icon:@"203" color:[UIColor colorWithRed:213/255.0 green:22/255.0 blue:71/255.0 alpha:1] index:2];
    [self addBtnWithTitle:@"夜间" icon:@"205" color:[UIColor colorWithRed:58/255.0 green:153/255.0 blue:208/255.0 alpha:1] index:3];
    [self addBtnWithTitle:@"扫一扫" icon:@"204" color:[UIColor colorWithRed:70/255.0 green:95/255.0 blue:176/255.0 alpha:1] index:4];
    [self addBtnWithTitle:@"邀请好友" icon:@"201" color:[UIColor colorWithRed:80/255.0 green:192/255.0 blue:70/255.0 alpha:1] index:5];
    
  
    
}


-(void)setWeatherModel:(WeatherModal *)weatherModel{
    _weatherModel = weatherModel;
    self.nowTempLbl.text = [NSString stringWithFormat:@"%d",weatherModel.rt_temperature];
    HYWeatherDetailModal *detailModal = weatherModel.detailArray[0];
    NSMutableString *temp = [detailModal.temperature mutableCopy];
    [temp replaceOccurrencesOfString:@"C" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, temp.length)];

    self.tempLbl.text =temp;
    self.dateWeekLbl.text = [NSString stringWithFormat:@"%@ %@",weatherModel.dt,detailModal.week];
    NSString *desc;
    int pm = weatherModel.pm2d5.pm2_5.intValue;
    if (pm < 50) {
        desc = @"优";
        
    }else if (pm < 100){
        desc = @"良";
    }else{
        desc = @"差";
    }
    self.airPMLbl.text =    [NSString stringWithFormat:@"PM2.5 %d %@",pm,desc];
    self.localLbl.text = @"北京";
    self.climateLbl.text = [NSString stringWithFormat:@"%@ %@",detailModal.climate,detailModal.wind];
    if ([detailModal.climate isEqualToString:@"雷阵雨"]) {
        self.weatherImg.image = [UIImage imageNamed:@"thunder_mini"];
    }else if ([detailModal.climate isEqualToString:@"晴"]){
        self.weatherImg.image = [UIImage imageNamed:@"sun_mini"];
    }else if ([detailModal.climate isEqualToString:@"多云"]){
        self.weatherImg.image = [UIImage imageNamed:@"sun_and_cloud_mini"];
    }else if ([detailModal.climate isEqualToString:@"阴"]){
        self.weatherImg.image = [UIImage imageNamed:@"nosun_mini"];
    }else if ([detailModal.climate hasSuffix:@"雨"]){
        self.weatherImg.image = [UIImage imageNamed:@"rain_mini"];
    }else if ([detailModal.climate hasSuffix:@"雪"]){
        self.weatherImg.image = [UIImage imageNamed:@"snow_heavyx_mini"];
    }else{
        self.weatherImg.image = [UIImage imageNamed:@"sand_float_mini"];
    }

    
}



-(void)awakeFromNib{
    UIView *bottomView = [[UIView alloc] init];
    self.bottomView = bottomView;
    [self addSubview:bottomView];
 
    
}

-(void)addBtnWithTitle:(NSString *)title icon:(NSString *)icon color:(UIColor *)color index:(int)index{


    
    int cols = index % 3;
    int rows = index / 3;
    CGFloat w =self.width / 3;
    CGFloat h = self.bottomView.height / 2;
    UIView *itemView = [[UIView alloc] init];
    [self.bottomView addSubview:itemView];
    itemView.x = cols * w;
    itemView.y = rows * h;
    itemView.height = h;
    itemView.width = w;
    
    UIButton *btn = [[UIButton alloc] init];
    btn.width = w - 40;
    btn.height = btn.width;
    btn.y = 40;
    if (index > 2) {
        btn.y = 10;
    }
    btn.x = 20;
    btn.layer.cornerRadius = btn.width / 2;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = color;
    btn.tag = index;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:icon];
    imgView.width = btn.width;
    imgView.height = imgView.width;
    imgView.center = btn.center;
    
    [itemView addSubview:btn];
    [itemView addSubview:imgView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.height = 40;
    titleLabel.width = itemView.width;
    titleLabel.x = 0;
    titleLabel.y = btn.y + btn.height;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [itemView addSubview:titleLabel];
    
    
    switch (index) {
        case 0:
            self.btn1 = btn;
            self.img1 = imgView;
            break;
        case 1:
            self.btn2 = btn;
            self.img2 = imgView;
            break;
        case 2:
            self.btn3 = btn;
            self.img3 = imgView;
            break;
        case 3:
            self.btn4 = btn;
            self.img4 = imgView;
            break;
        case 4:
            self.btn5 = btn;
            self.img5 = imgView;
            break;
        case 5:
            self.btn6 = btn;
            self.img6 = imgView;
            break;
            
        default:
            break;
    }
    

}

- (void)addAnimate{
   
    self.btn1.transform = CGAffineTransformMakeScale(0.2, 0.2);
    self.btn2.transform = CGAffineTransformMakeScale(0.2, 0.2);
    self.btn3.transform = CGAffineTransformMakeScale(0.2, 0.2);
    self.btn4.transform = CGAffineTransformMakeScale(0.2, 0.2);
    self.btn5.transform = CGAffineTransformMakeScale(0.2, 0.2);
    self.btn6.transform = CGAffineTransformMakeScale(0.2, 0.2);
    
    self.img1.transform = CGAffineTransformMakeScale(1.4, 1.4);
    self.img2.transform = CGAffineTransformMakeScale(1.4, 1.4);
    self.img3.transform = CGAffineTransformMakeScale(1.4, 1.4);
    self.img4.transform = CGAffineTransformMakeScale(1.4, 1.4);
    self.img5.transform = CGAffineTransformMakeScale(1.4, 1.4);
    self.img6.transform = CGAffineTransformMakeScale(1.4, 1.4);
    [UIView animateWithDuration:0.2 animations:^{
        self.btn1.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.btn2.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.btn3.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.btn4.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.btn5.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.btn6.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
        self.img1.transform = CGAffineTransformMakeScale(0.7, 0.7);
        self.img2.transform = CGAffineTransformMakeScale(0.7, 0.7);
        self.img3.transform = CGAffineTransformMakeScale(0.7, 0.7);
        self.img4.transform = CGAffineTransformMakeScale(0.7, 0.7);
        self.img5.transform = CGAffineTransformMakeScale(0.7, 0.7);
        self.img6.transform = CGAffineTransformMakeScale(0.7, 0.7);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.btn1.transform = CGAffineTransformIdentity;
            self.btn2.transform = CGAffineTransformIdentity;
            self.btn3.transform = CGAffineTransformIdentity;
            self.btn4.transform = CGAffineTransformIdentity;
            self.btn5.transform = CGAffineTransformIdentity;
            self.btn6.transform = CGAffineTransformIdentity;
            
            self.img1.transform = CGAffineTransformIdentity;
            self.img2.transform = CGAffineTransformIdentity;
            self.img3.transform = CGAffineTransformIdentity;
            self.img4.transform = CGAffineTransformIdentity;
            self.img5.transform = CGAffineTransformIdentity;
            self.img6.transform = CGAffineTransformIdentity;
        }];
        
    }];
    
}


-(void)btnClick:(UIButton *)btn{
    NSLog(@"%ld",(long)btn.tag);
}

- (IBAction)pushDetail {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushWeatherDetail" object:nil];
}

@end
