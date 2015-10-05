//
//  HYReplyCell.m
//  Yang的专属新闻客户端
//
//  Created by He yang on 15/9/25.
//  Copyright © 2015年 He yang. All rights reserved.
//

#import "HYReplyCell.h"

@interface HYReplyCell ()
/** 用户名称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 用户ip信息 */
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
/** 用户的点赞数 */
@property (weak, nonatomic) IBOutlet UILabel *supposeLabel;

@end

@implementation HYReplyCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setReplyModel:(HYReplyModals *)replyModel{
    _replyModel = replyModel;
    if (replyModel.name == nil) {
        replyModel.name = @"";
        
    }
    self.nameLabel.text = replyModel.name;
    self.addressLabel.text = replyModel.address;
    NSRange range = [replyModel.address rangeOfString:@"&nbsp"];
    if (range.location != NSNotFound) {
        self.addressLabel.text = [replyModel.address substringToIndex:range.location];
    }
    self.sayLabel.text = replyModel.say;
    NSRange rangeSay = [replyModel.say rangeOfString:@"<br>"];
    if (rangeSay.location != NSNotFound) {
        NSMutableString *tempSay = [replyModel.say  mutableCopy];
        [tempSay replaceOccurrencesOfString:@"<br>" withString:@"\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, tempSay.length)];
        self.sayLabel.text = tempSay;
    }
    self.supposeLabel.text = replyModel.suppose;
}



@end
