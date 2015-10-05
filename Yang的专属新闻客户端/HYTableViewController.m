//
//  HYTableViewController.m
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/8/28.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import "HYTableViewController.h"
#import "MJRefresh.h"
#import "HYTableViewCell.h"
#import "HttpTool.h"
#import "NewsModal.h"
#import "MJExtension.h"
#import "HYPhotoSetViewController.h"
#import "HYDetailNewsViewController.h"

@interface HYTableViewController ()

@property(nonatomic,assign)BOOL update;
@property(nonatomic,strong) NSMutableArray *arrayList;



@end

@implementation HYTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView addHeaderWithTarget:self action:@selector(loadData)];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
    self.update = YES;
    
    
   // self.view.backgroundColor = [UIColor yellowColor];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    if (self.update == YES) {
        [self.tableView headerBeginRefreshing];
        self.update = NO;
    }
}

-(void)setUrlString:(NSString *)urlString{
    _urlString = urlString;
}

-(void)loadData{
    NSString *urlString = [NSString stringWithFormat:@"/nc/article/%@/0-20.html",self.urlString];
    [self loadDataForType:1 withURL:urlString];
}


-(void)loadMoreData{
    
     NSString *urlstring = [NSString stringWithFormat:@"/nc/article/%@/%ld-20.html",self.urlString,(self.arrayList.count - self.arrayList.count%10)];
    [self loadDataForType:2 withURL:urlstring];
    
}

-(void)loadDataForType:(int)type  withURL:(NSString *)urlString{
    [[[HttpTool sharedHttpTools] GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary * responseObject) {
        NSString *key = [responseObject.keyEnumerator nextObject];
        NSArray *tmpAry = responseObject[key];
        NSMutableArray *modalAry = [NewsModal objectArrayWithKeyValuesArray:tmpAry];
        if (type == 1) {
            self.arrayList = modalAry;
            [self.tableView headerEndRefreshing];
            [self.tableView reloadData];
        }else if (type == 2)
        {
            [self.arrayList addObjectsFromArray:modalAry];
            [self.tableView footerEndRefreshing];
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }] resume];

}


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
      return self.arrayList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsModal *newsModal = self.arrayList[indexPath.row];
    NSString *ID = [HYTableViewCell idForRow:newsModal];
    HYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HYTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.NewsModel = newsModal;
    return cell;
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModal *newModal = self.arrayList[indexPath.row];
    CGFloat rowHeight = [HYTableViewCell heightForRow:newModal];
    if( (indexPath.row % 20 == 0) &&(indexPath.row != 0)){
        rowHeight = 80;
    }
    return rowHeight;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[HYDetailNewsViewController class]]) {
        NSInteger x = self.tableView.indexPathForSelectedRow.row;
        HYDetailNewsViewController *detailVC = segue.destinationViewController;
        detailVC.newsModel = self.arrayList[x];
#warning self.index
      //  detailVC.index = self.index;
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
    }
    else {
        NSInteger x = self.tableView.indexPathForSelectedRow.row;
        HYPhotoSetViewController *vc = segue.destinationViewController;
        vc.newsModel = self.arrayList[x];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 刚选中又马上取消选中，格子不变色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    UIViewController *vc = [[UIViewController alloc]init];
//    vc.view.backgroundColor = [UIColor yellowColor];
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//) {
//        <#statements#>
//    }
//}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
