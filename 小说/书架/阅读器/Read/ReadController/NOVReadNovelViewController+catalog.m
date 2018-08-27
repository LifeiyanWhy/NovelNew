//
//  NOVReadNovelViewController+catalog.m
//  小说
//
//  Created by 李飞艳 on 2018/8/18.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVReadNovelViewController+catalog.h"
#import "NOVCatalogView.h"
#import "NOVRecordModel.h"
#import "NOVChapterModel.h"
#import "NOVbookMessage.h"
#import "NOVCatalogTableViewCell.h"
@implementation NOVReadNovelViewController (catalog)
-(void)updateCatalog{
    
    self.catalogView.titleLabel.text = [NSString stringWithFormat:@"  %@",self.bookMessage.bookName];
    self.catalogView.tableView.delegate = self;
    self.catalogView.tableView.dataSource = self;
    [self.catalogView.tableView registerClass:[NOVCatalogTableViewCell class] forCellReuseIdentifier:@"catalogCell"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"catalogCell";
    NOVCatalogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell updateCellWithModel:self.recordModel.chapterArray[indexPath.section][indexPath.row]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.recordModel.chapterArray[section].count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"%lu",(unsigned long)self.recordModel.chapterArray.count);
    return self.recordModel.chapterArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenHeight * 0.1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [NSString stringWithFormat:@"第%ld章",section+1];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NOVChapterReadModel *model = self.recordModel.chapterArray[indexPath.section][indexPath.row];
    self.readFromCatalog = YES;
    [self obtainChapterContentWithBranchId:model.chapterId];
    self.catalogView.hidden = YES;
    self.backgroundView.hidden = YES;
}

- (void)showAlertActionWithTitle:(NSString *)title{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alert = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
    [alertControl addAction:alert];
    [self presentViewController:alertControl animated:YES completion:nil];
}

@end
