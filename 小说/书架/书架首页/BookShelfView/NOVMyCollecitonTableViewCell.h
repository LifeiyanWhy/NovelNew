//
//  NOVMyCollecitonTableViewCell.h
//  小说
//
//  Created by 李飞艳 on 2018/8/19.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NOVMyCollectionModel;
@interface NOVMyCollecitonTableViewCell : UITableViewCell
@property(nonatomic,strong) UIButton *authorImageButton;
@property(nonatomic,strong) UILabel *authorLabel;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *summaryLabel;
@property(nonatomic,strong) UIButton *likeNumButton;
@property(nonatomic,strong) UIButton *commentButton;
@property(nonatomic,strong) UILabel *createTimeLabel;
-(void)updateCellWithModel:(NOVMyCollectionModel *)model;
@end
