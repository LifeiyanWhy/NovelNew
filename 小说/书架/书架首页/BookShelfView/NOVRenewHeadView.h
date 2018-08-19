//
//  NOVRenewHeadView.h
//  小说
//
//  Created by 李飞艳 on 2018/8/17.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NOVSimpleBookModel;
@interface NOVRenewHeadView : UITableViewHeaderFooterView
@property(nonatomic,strong) UIImageView *bookImage;
@property(nonatomic,strong) UIButton *goNovelButton;
@property(nonatomic,strong) UILabel *bookNameLabel;
@property(nonatomic,strong) UILabel *authorLabel;
@property(nonatomic,strong) UILabel *joinNumLabel;
@property(nonatomic,strong) UILabel *bookCreateTime;
@property(nonatomic,strong) UILabel *myRenewLabel;
-(void)updateCellModel:(NOVSimpleBookModel *)model;
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end
