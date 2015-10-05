//
//  HYDetailNewsViewController.m
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/9/19.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import "HYDetailNewsViewController.h"
#import "HYDetailNewModal.h"
#import "NewsModal.h"
#import "HYHTTPManager.h"
#import "HYDetailImgModal.h"
#import "HYReplyViewController.h"
#import "HYReplyModals.h"

@interface HYDetailNewsViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,strong) HYDetailNewModal *detailModel;
@property (weak, nonatomic) IBOutlet UIButton *replyCountBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property(nonatomic,strong) NSMutableArray *replyModels;


@end

@implementation HYDetailNewsViewController

- (NSMutableArray *)replyModels
{
    if (_replyModels == nil) {
        _replyModels = [NSMutableArray array];
    }
    return _replyModels;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.newsModel.docid];
    [[HYHTTPManager manager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.detailModel = [HYDetailNewModal detailWithDict:responseObject[self.newsModel.docid]];
        [self showInWebView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    NSString *docID = self.newsModel.docid;
    CGFloat count = [self.newsModel.replyCount intValue];
    NSString *displayCount;
    if (count > 10000) {
        displayCount = [NSString stringWithFormat:@"%.1f万跟帖",count / 10000];
    }else{
        displayCount = [NSString stringWithFormat:@"%.0f跟帖",count];
    }
    [self.replyCountBtn setTitle:displayCount forState:UIControlStateNormal];
        NSString *url2 = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/10/10/2/2",self.newsModel.boardid,docID];
    [self sendRequestWithUrl2:url2];
    
}

-(void)showInWebView{
    
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"HYDetails.css" withExtension:nil]];
    [html appendString:@"</head>"];
   
    [html appendString:@"<body>"];
    [html appendString:[self touchBody]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    [self.webView loadHTMLString:html baseURL:nil];
    
    


    
}

-(NSString *)touchBody{
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\">%@</div>",self.detailModel.title];
    [body appendFormat:@"<div class=\"time\">%@</div>",self.detailModel.ptime];
    if (self.detailModel.body != nil) {
        [body appendString:self.detailModel.body];
    }
    for (HYDetailImgModal *detailImgModal in self.detailModel.img) {
        NSMutableString *imgHtml = [NSMutableString string];
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        // 数组存放被切割的像素
        NSArray *pixel = [detailImgModal.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [[pixel firstObject]floatValue];
        CGFloat height = [[pixel lastObject]floatValue];
        // 判断是否超过最大宽度
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width * 0.96;
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        
        NSString *onload = @"this.onclick = function() {"
        "  window.location.href = 'sx:src=' +this.src;"
        "};";
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,detailImgModal.src];
        // 结束标记
        [imgHtml appendString:@"</div>"];
        // 替换标记
        [body replaceOccurrencesOfString:detailImgModal.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    

    return body;
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"sx:src="];
    if (range.location != NSNotFound) {
        NSInteger begin = range.location + range.length;
        NSString *src = [url substringFromIndex:begin];
        [self savePictureToAlbum:src];
        return NO;
    }

    
    
    return YES;
}


- (void)savePictureToAlbum:(NSString *)src{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要保存到相册吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        NSURLCache *cache =[NSURLCache sharedURLCache];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:src]];
        NSData *imgData = [cache cachedResponseForRequest:request].data;
        UIImage *image = [UIImage imageWithData:imgData];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
    }]];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)sendRequestWithUrl2:(NSString *)url2{
    
    [[HYHTTPManager manager] GET:url2 parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        if (responseObject[@"hotPosts"] != [NSNull null]) {
            NSArray *dictArray = responseObject[@"hotPosts"];
            for (int i = 0; i < dictArray.count; i++) {
                NSDictionary *dict = dictArray[i][@"1"];
                HYReplyModals *replyModal = [[HYReplyModals alloc] init];
                replyModal.name = dict[@"n"];
                if (replyModal.name == nil) {
                    replyModal.name = @"火星网友";
                }
                replyModal.address = dict[@"f"];
                replyModal.say = dict[@"b"];
                replyModal.suppose = dict[@"v"];
                [self.replyModels addObject:replyModal];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    HYReplyViewController *VC = segue.destinationViewController;
    VC.replys = self.replyModels;
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//    }

}

@end
