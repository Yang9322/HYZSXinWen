//
//  HYReplyCell.h
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/9/25.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYReplyModals.h"

@interface HYReplyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sayLabel;
@property(nonatomic,strong) HYReplyModals *replyModel;


@end
