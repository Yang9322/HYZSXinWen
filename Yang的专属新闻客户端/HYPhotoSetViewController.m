//
//  HYPhotoSetViewController.m
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/9/21.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import "HYPhotoSetViewController.h"
#import "NewsModal.h"
#import "HYHTTPManager.h"
#import "HYPhotoSet.h"
#import "MJExtension.h"
#import "HYPhotosDetail.h"
#import "UIView+Frame.h"
#import "UIImageView+WebCache.h"
#import "HYReplyModals.h"
#import "HYReplyViewController.h"



@interface HYPhotoSetViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *photoScrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentText;
@property (weak, nonatomic) IBOutlet UIButton *replayBtn;
@property(nonatomic,strong) HYPhotoSet *photoSet;
@property(nonatomic,strong) NSMutableArray *replyModels;


@end

@implementation HYPhotoSetViewController

-(NSMutableArray *)replyModels{
    if (!_replyModels) {
        _replyModels = [NSMutableArray array];
    }
    return _replyModels;
}

- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *one = self.newsModel.photosetID;
//    NSLog(@"   %@",one );

    NSString *two = [one substringFromIndex:4];
//    NSLog(@"   %@",two );
    NSArray *three = [two componentsSeparatedByString:@"|"];
    CGFloat count =  [self.newsModel.replyCount intValue];
    NSString *displayCount;
    if (count > 10000) {
        displayCount = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];
    }else{
        displayCount = [NSString stringWithFormat:@"%.0f跟帖",count];
    }
    [self.replayBtn setTitle:displayCount forState:UIControlStateNormal];
    NSString *url1 = [NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/%@/%@.json",[three firstObject],[three lastObject]];
    
    [self sendRequestWithUrl:url1];
    NSString *url2 = @"http://comment.api.163.com/api/json/post/list/new/hot/photoview_bbs/PHOT1ODB009654GK/0/10/10/2/2";
    [self sendRequestWithUrl2:url2];
    
    // Do any additional setup after loading the view.
}

-(void)sendRequestWithUrl:(NSString *)url{
    [[HYHTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        HYPhotoSet *photoSet = [HYPhotoSet objectWithKeyValues:responseObject];
        self.photoSet = photoSet;
        [self setLabelWithModel:photoSet];
        [self setImageViewWithModel:photoSet];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)sendRequestWithUrl2:(NSString *)url{
    [[HYHTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSArray *dictarray = responseObject[@"hotPosts"];
        //        NSLog(@"%ld",dictarray.count);
        for (int i = 0; i < dictarray.count; i++) {
            NSDictionary *dict = dictarray[i][@"1"];
            HYReplyModals *replyModel = [[HYReplyModals alloc]init];
            replyModel.name = dict[@"n"];
            if (replyModel.name == nil) {
                replyModel.name = @"火星网友";
            }
            replyModel.address = dict[@"f"];
            replyModel.say = dict[@"b"];
            replyModel.suppose = dict[@"v"];
            [self.replyModels addObject:replyModel];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure %@",error);
    }];
}

-(void)setLabelWithModel:(HYPhotoSet *)photoSet{
    self.titleLabel.text = photoSet.setname;
    NSString *countNum = [NSString stringWithFormat:@"1/%ld",photoSet.photos.count];
    self.countLabel.text = countNum;
    [self setContentWithIndex:0];
    
}

-(void)setContentWithIndex:(int)index{
    NSString *content = [self.photoSet.photos[index] note];
    NSString *contentTitle = [self.photoSet.photos[index] imgtitle];
    if (content.length) {
        self.contentText.text = content;
        
    }else {
        self.contentText.text = contentTitle;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = self.photoScrollView.contentOffset.x / self.photoScrollView.width;
    
    // 添加图片
   // [self setImgWithIndex:index];
    
    // 添加文字
    NSString *countNum = [NSString stringWithFormat:@"%d/%ld",index+1,self.photoSet.photos.count];
    self.countLabel.text = countNum;
    
    // 添加内容
    [self setContentWithIndex:index];
}

- (void)setImageViewWithModel:(HYPhotoSet *)photoSet{
    NSInteger count = self.photoSet.photos.count;
    self.photoScrollView.showsHorizontalScrollIndicator = NO;
    self.photoScrollView.showsVerticalScrollIndicator = NO;
    for (int i = 0; i < count; i++) {
        
        UIImageView *photoView = [[UIImageView alloc] init];
//        [photoView sd_setImageWithURL:[NSURL URLWithString:[self.photoSet.photos[i] imgurl]] placeholderImage:[UIImage imageNamed:@"photoview_image_default_white"]];
        [photoView sd_setImageWithURL:[NSURL URLWithString:[self.photoSet.photos[i] imgurl]]  placeholderImage:[UIImage imageNamed:@"photoview_image_default_white"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            //NSLog(@"111");
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         //   NSLog(@"%@",imageURL);
        }];
        photoView.height = self.photoScrollView.height;
        photoView.width = self.photoScrollView.width;
        photoView.x = i *photoView.width;
        photoView.y = -64;
        photoView.contentMode = UIViewContentModeCenter;
        photoView.contentMode = UIViewContentModeScaleAspectFit;
        [self.photoScrollView addSubview:photoView];
        
    }
    self.photoScrollView.contentSize = CGSizeMake(self.photoScrollView.width *count, 0);
    self.photoScrollView.contentOffset = CGPointZero;
 
    self.photoScrollView.pagingEnabled = YES;
    
}



-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    HYReplyViewController *replyvc = segue.destinationViewController;
    replyvc.replys = self.replyModels;
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
