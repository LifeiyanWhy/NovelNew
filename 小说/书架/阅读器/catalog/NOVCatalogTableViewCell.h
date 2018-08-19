//
//  NOVCatalogTableViewCell.h
//  小说
//
//  Created by 李飞艳 on 2018/8/18.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NOVChapterReadModel;
@interface NOVCatalogTableViewCell : UITableViewCell
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong) UILabel *authorLabel;
-(void)updateCellWithModel:(NOVChapterReadModel *)model;
@end
