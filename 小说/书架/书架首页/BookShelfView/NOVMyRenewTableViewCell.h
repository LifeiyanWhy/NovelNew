//
//  NOVMyRenewTableViewCell.h
//  小说
//
//  Created by 李飞艳 on 2018/8/16.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NOVGetMyRenewModel;
@interface NOVMyRenewTableViewCell : UITableViewCell
@property(nonatomic,strong) UIButton *goNovelButton;
@property(nonatomic,strong) UILabel *bookNameLabel;
@property(nonatomic,strong) UILabel *authorLabel;
@property(nonatomic,strong) UILabel *joinNumLabel;
@property(nonatomic,strong) UILabel *myRenewTitle;
@property(nonatomic,strong) UILabel *summaryLabel;
@property(nonatomic,strong) UILabel *likeNum;
@property(nonatomic,strong) UILabel *createTimeLabel;
-(void)updateCellModel:(NOVGetMyRenewModel *)model;
@end
