//
//  NOVSetbackView.m
//  小说
//
//  Created by 李飞艳 on 2018/5/24.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVSetbackView.h"
#import <UIImageView+WebCache.h>
#import "NOVStartBookModel.h"
#import "NOVGetMyStartModel.h"

@implementation NOVSetbackView{
    NSArray *contentArray;
    NSArray *modelArray;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
        
        _close = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_close];
        
        _coverImage = [[UIImageView alloc] init];
        [self addSubview:_coverImage];
        
        _tableview = [[UITableView alloc] init];
        [self addSubview:_tableview];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        
//        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self addSubview:_deteleButton];
        
        contentArray = @[@[@"作品名称",@"作品简介",@"作品类型",@"发布时间"],@[@"已参与人数",@"续写数量",@"浏览次数",@"获得赞"]];
    }
    return self;
}

-(void)layoutSubviews{
    [_close mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.width.equalTo(self).multipliedBy(0.13);
        make.top.equalTo(self).offset(15);
        make.height.equalTo(self).multipliedBy(0.04);
    }];
    [_close setTitle:@"关闭" forState:UIControlStateNormal];
    [_close setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _close.titleLabel.font = [UIFont systemFontOfSize:13];
    
//    [_deleteButton mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self).offset(-15);
//        make.width.equalTo(self).multipliedBy(0.13);
//        make.top.equalTo(self).offset(15);
//        make.height.equalTo(self).multipliedBy(0.04);
//    }];
//    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
//    [_deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    _deleteButton.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [_tableview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self).offset(self.frame.size.height*0.1);
        make.bottom.equalTo(self).offset(self.frame.size.height*-0.05);
    }];
    _tableview.backgroundColor = [UIColor colorWithRed:0.9 green:0.93 blue:0.92 alpha:1.00];
    _tableview.showsVerticalScrollIndicator = NO;
    _tableview.showsHorizontalScrollIndicator = NO;
    _tableview.bounces = NO;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, self.frame.size.height*0.1, self.frame.size.width, self.frame.size.height*0.35);
    [view addSubview:_coverImage];
    [_coverImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(view).multipliedBy(0.6);
        make.centerY.equalTo(view);
        make.width.equalTo(view).multipliedBy(0.3);
        make.centerX.equalTo(view);
    }];
    _coverImage.backgroundColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1.00];
    _tableview.tableHeaderView = view;
}

-(void)updateWithModel:(NOVGetMyStartModel *)model{
    modelArray = @[@[model.bookName,@"简介简介!!!",model.bookType,[model.createTime substringToIndex:10]],@[[NSNumber numberWithInteger:model.branchNum],[NSNumber numberWithInteger:model.branchNum],[NSNumber numberWithInteger:model.readNum],@"100"]];
    [self.coverImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BookImageUrl,model.bookImage]]];
}

-(void)setBookWithModel:(NOVStartBookModel *)model{
    self.coverImage.image = model.bookImage;
    NSString *bookType;
    switch (model.bookType) {
        case 0:
            bookType = @"玄幻言情";
            break;
        case 1:
            bookType = @"仙侠奇缘";
            break;
        case 2:
            bookType = @"古代言情";
            break;
        case 3:
            bookType = @"现代言情";
            break;
        case 4:
            bookType = @"浪漫青春";
            break;
        case 5:
            bookType = @"悬疑灵异";
            break;
        case 6:
            bookType = @"科技空间";
            break;
        case 7:
            bookType = @"游戏竞技";
            break;
        case 8:
            bookType = @"耽美小说";
            break;
        default:
            break;
    }
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *createTime = [formatter stringFromDate:date];
    modelArray = @[@[model.name,model.introduction,bookType,[createTime substringToIndex:10]],@[@"暂无",@"暂无",@"暂无",@"暂无"]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor colorWithRed:0.15 green:0.17 blue:0.19 alpha:1.00];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = contentArray[indexPath.section][indexPath.row];
    if (modelArray) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",modelArray[indexPath.section][indexPath.row]];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

-(void)drawRect:(CGRect)rect{
    UIColor *color = [UIColor colorWithRed:0.96 green:0.97 blue:0.98 alpha:1.00];
    [color set];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) cornerRadius:20];
    [path fill];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
