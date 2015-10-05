//
//  HYReplyViewController.m
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/9/24.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import "HYReplyViewController.h"
#import "HYReplyCell.h"
#import "HYReplyHeader.h"

@interface HYReplyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HYReplyViewController
static NSString *ID = @"replyCell";


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
   // self.tableView.showsVerticalScrollIndicator = YES;
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
 
     

if (self.replys.count == 0) {
 return 1;
 }
 
 if (section == 0) {
 // NSLog(@"111---   %lu",(unsigned long)self.replys.count );
 
 return self.replys.count;
 
 }else{
 // NSLog(@"222---   %lu",(unsigned long)self.replys.count );
 
 return self.replys.count;
 
 }}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HYReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell ==nil) {
        cell = [[HYReplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    if (self.replys.count == 0) {
        UITableViewCell *cell2 = [[UITableViewCell alloc] init];
        cell.textLabel.text = @"暂无跟帖数据";
        return cell2;
    }else{
        HYReplyModals *modal = self.replys[indexPath.row];
        cell.replyModel = modal;
    }
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [HYReplyHeader replyViewFirst];
    }else{
        return [HYReplyHeader replyViewLast];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.replys.count == 0) {
        return 40;
    }else{
        HYReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        HYReplyModals *modal = self.replys[indexPath.row];
        cell.replyModel = modal;
        //[cell layoutIfNeeded];
        CGSize size = [cell.sayLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return cell.sayLabel.frame.origin.y + size.height + 10;
    }
}
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
@end
