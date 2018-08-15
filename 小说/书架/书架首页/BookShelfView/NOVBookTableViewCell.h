//
//  NOVBookTableViewCell.h
//  小说
//
//  Created by 李飞艳 on 2018/4/10.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NOVbookMessage;

@interface NOVBookTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView *leftImageView;
@property(nonatomic,strong) UILabel *bookName;
@property(nonatomic,strong) UILabel *authorName;
@property(nonatomic,strong) UILabel *createTimeLabel;
@property(nonatomic,strong) UILabel *joinNumberLabel;
@property(nonatomic,strong) UILabel *contentLabel;
-(void)updateCellModel:(NOVbookMessage *)model;
@end
