//
//  NOVMystartViewController+viewMove.m
//  小说
//
//  Created by 李飞艳 on 2018/9/19.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVMystartViewController+viewMove.h"
#import "NOVAllMyStartView.h"
#import "NOVMystartView.h"
#import "NOVView.h"
#import "NOVReadNovelViewController.h"
#import "NOVGetMyStartModel.h"
#import "NOVbookMessage.h"
#import "NOVWriteViewController.h"
#import "NOVBookSetView.h"
#import "NOVStartBookModel.h"
#import "NOVStartManager.h"

@implementation NOVMystartViewController (viewMove)

-(void)touchRespone:(UIButton *)touchButton{
    self.touchTopButton = YES;
    [self.allMyStartView.scrollView setContentOffset:CGPointMake(ScreenWidth*touchButton.tag + 1, 0) animated:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.touchTopButton = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //如果是点击button导致的scrollView移动则不触发该方法
    if (self.touchTopButton) {
        return;
    }
    CGPoint point = scrollView.contentOffset;
    if ([scrollView isEqual:self.allMyStartView.scrollView]) {
//        NSLog(@"%f",point.x);
    }else{
        return;
    }
    [self.allMyStartView.headView setButtonPostion:point width:ScreenWidth*2];
}

//进入阅读界面
-(void)readBookWithModel:(NOVGetMyStartModel *)myStartModel{
    NOVReadNovelViewController *readNovelViewController = [[NOVReadNovelViewController alloc] init];
    readNovelViewController.bookMessage.bookId = myStartModel.bookId;
    readNovelViewController.bookMessage.bookName = myStartModel.bookName;
    [self.navigationController pushViewController:readNovelViewController animated:NO];
}

//getMyStartModel编辑草稿   startBookModel重新发起一本书
-(void)editBookWithView:(NOVBookSetView *)setView getModel:(NOVGetMyStartModel *)draftBookModel model:(NOVStartBookModel *)startBookModel{
    NOVWriteViewController *writeViewController = [[NOVWriteViewController alloc] init];
    if (nil != draftBookModel) {   //getMyStartModel编辑草稿
        writeViewController.bookModel = [[NOVStartBookModel alloc] initWithDraft:draftBookModel];
        if (!startBookModel) {
            startBookModel = [[NOVStartBookModel alloc] init];
        }
        //根据草稿ID获取草稿
        [startBookModel obtainDraftContentWithBookId:writeViewController.bookModel.bookId succeed:^(id responseObject) {
            NSLog(@"%@",responseObject);
            NSDictionary *dict = responseObject[@"data"];
            writeViewController.bookModel.firstTitle = dict[@"firstTitle"];
            writeViewController.bookModel.firstSummary = dict[@"firstSummary"];
            writeViewController.bookModel.firstContent = dict[@"firstContent"];
            [self.navigationController pushViewController:writeViewController animated:NO];
        } fail:^(NSError *error) {
            NSLog(@"draftError===%@",error);
        }];
    } else {    //startBookModel重新发起一本书
        writeViewController.bookModel = startBookModel;
        [self.navigationController pushViewController:writeViewController animated:NO];
    }
    
    //保存修改结果（发布编辑后的内容）
    writeViewController.publishNovelBlock = ^(NSString *title, NSString *summary, NSString *content,Boolean isPublish) {
        //isPublish标记发布还是存为草稿
        startBookModel.firstTitle = title;   //更新model
        startBookModel.firstContent = content;
        startBookModel.firstSummary = summary;
        NOVStartManager *startManager = [[NOVStartManager alloc] init];
        [startManager startNovelWithModel:startBookModel isPublish:isPublish success:^(id  _Nonnull responseObject) {
            NSLog(@"%@",responseObject);
            //发布成功
            if (isPublish) {
                setView.novelState = NovelStatePublished;   //标记为已发布
            }
            startBookModel.bookId = [responseObject[@"data"][@"bookId"] integerValue];
            //发布后更新数据
            NOVGetMyStartModel *model = [[NOVGetMyStartModel alloc] initWithDictionary:responseObject[@"data"] error:nil];
            [self.draftsArray replaceObjectAtIndex:setView.tag withObject:model];
        } fail:^(NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    };
}

@end
