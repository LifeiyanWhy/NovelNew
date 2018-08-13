//
//  NOVNextChapterViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/8/8.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVNextChapterViewController.h"
#import "NOVNextChapterView.h"
#import "NOVObatinBookContent.h"
#import "NOVNextChapterTableViewCell.h"
#import "NOVChapterListModel.h"
#import "NOVNextChapterCellHeightModel.h"
#import "NOVReadNovelViewController.h"
#import "NOVbookMessage.h"
@interface NOVNextChapterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NOVNextChapterView *nextChapterView;
@property(nonatomic,strong) NSMutableArray *modelArray;
@end

@implementation NOVNextChapterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bookBackground.png"]];
    [self.view addSubview:self.nextChapterView];
    
    NOVObatinBookContent *obtainBookContent = [[NOVObatinBookContent alloc] init];
    [obtainBookContent getRenewListWithBookId:_bookMessage.bookId ParentId:_parentId succeed:^(id responseObject) {
        NOVAllChapterListModel *allModel = [[NOVAllChapterListModel alloc] initWithDictionary:responseObject error:nil];
        NSMutableArray *array = [NSMutableArray arrayWithArray:allModel.data];
        for (int i = 0; i < array.count; i++) {
            NOVChapterListModel *model = [[NOVChapterListModel alloc] initWithDictionary:array[i] error:nil];
            model.author = [[NOVChapterAuthorModel alloc] initWithDictionary:array[i][@"author"] error:nil];
            [self.modelArray addObject:model];
        }
        [_nextChapterView.tableView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"%@",error.userInfo[@"com.alamofire.serialization.response.error.response"]);
    }];
 }

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"chapterCell";
    NOVNextChapterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell updateCellModelWithChapterListModel:_modelArray[indexPath.section]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NOVChapterListModel *model = _modelArray[indexPath.section];
    NOVReadNovelViewController *readViewController = [[NOVReadNovelViewController alloc] init];
    readViewController.bookMessage = _bookMessage;
    readViewController.readType = NOVReadTypeReadFromSelectRenewChapter;
    readViewController.selectChapterId = model.branchId;
    [self.navigationController pushViewController:readViewController animated:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [NOVNextChapterCellHeightModel getCellHeightWithModel:_modelArray[indexPath.section]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _modelArray.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

-(NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

-(NOVNextChapterView *)nextChapterView{
    if (!_nextChapterView) {
        _nextChapterView = [[NOVNextChapterView alloc] initWithFrame:self.view.frame];
        _nextChapterView.tableView.delegate = self;
        _nextChapterView.tableView.dataSource = self;
        [_nextChapterView.tableView registerClass:[NOVNextChapterTableViewCell class] forCellReuseIdentifier:@"chapterCell"];
    }
    return _nextChapterView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
