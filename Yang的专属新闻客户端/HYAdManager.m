//
//  HYAdManager.m
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/10/5.
//  Copyright © 2015年 He yang. All rights reserved.
//
#import "HttpTool.h"
#import "HYAdManager.h"

#define kCachedCurrentImage ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingString:@"/adcurrent.png"])
#define kCachedNewImage     ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingString:@"/adnew.png"])


@interface HYAdManager ()

+ (void)downloadImage:(NSString *)imageUrl;

@end

@implementation HYAdManager


+(BOOL)isShouldDisplayAd{
//    NSLog(@"   %@",([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingString:@"/adcurrent.png"]) );
//
//   NSLog(@"%d",
//          [[NSFileManager defaultManager]fileExistsAtPath:kCachedCurrentImage isDirectory:NO]);
////          [[NSFileManager defaultManager]fileExistsAtPath:kCachedNewImage isDirectory:NO]);
    return ([[NSFileManager defaultManager]fileExistsAtPath:kCachedCurrentImage isDirectory:NO] || [[NSFileManager defaultManager]fileExistsAtPath:kCachedNewImage isDirectory:NO]);
}

+(UIImage *)getAdImage{
    if ([[NSFileManager defaultManager] fileExistsAtPath:kCachedNewImage isDirectory:NO]) {
        [[NSFileManager defaultManager] removeItemAtPath:kCachedCurrentImage error:nil];
        [[NSFileManager defaultManager] moveItemAtPath:kCachedNewImage toPath:kCachedCurrentImage error:nil];
    }
    return [UIImage imageWithData:[NSData dataWithContentsOfFile:kCachedCurrentImage]];
}

+(void)downloadImage:(NSString *)imageUrl{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:imageUrl]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            [data writeToFile:kCachedNewImage atomically:YES];
        }
    }];
    [task resume];
}   

+(void)loadLatestAdImage{
    NSInteger now = [[[NSDate alloc] init] timeIntervalSince1970];
    NSString *path = [NSString stringWithFormat:@"http://g1.163.com/madr?app=7A16FBB6&platform=ios&category=startup&location=1&timestamp=%ld",(long)now];
    [[[HttpTool sharedNetworkToolsWithoutBaseUrl]GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *adArray = [responseObject valueForKey:@"ads"];
        NSString *imgUrl = adArray[0][@"res_url"][0];
        NSString *imgUrl2 = nil;
        if (adArray.count > 1) {
            imgUrl2 = adArray[1][@"res_url"][0];
        }
        BOOL one = [[NSUserDefaults standardUserDefaults] boolForKey:@"one"];
        if (imgUrl2.length > 0) {
            if (one) {
                [self downloadImage:imgUrl];
                [[NSUserDefaults standardUserDefaults]setBool:!one forKey:@"one"];
            }else{
                [self downloadImage:imgUrl2];
                [[NSUserDefaults standardUserDefaults] setBool:!one forKey:@"one"];
            }
        }else {
            [self downloadImage:imgUrl];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }] resume];
}



@end
