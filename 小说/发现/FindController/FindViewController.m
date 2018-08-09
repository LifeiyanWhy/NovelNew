//
//  FindViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/3/29.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "FindViewController.h"
#import "NOVFindView.h"
#import "NOVFindTableViewCell.h"
#import "NOVObtainBookList.h"
#import "NOVbookMessage.h"
#import "NOVReadNovelViewController.h"

#define tabBarHeight self.navigationController.tabBarController.tabBar.frame.size.height //控制器高度

@interface FindViewController ()<UIScrollViewDelegate,NOVViewDelegate,UITableViewDelegate,UITableViewDataSource,NOVNetworkAnomalyViewDelegate>
@property(nonatomic,strong) NOVFindView *findView;
@property(nonatomic,strong) NSMutableArray *bookArray;
@property(nonatomic,strong) NOVNetworkAnomalyView *networkAnoamlyView;
@end

@implementation FindViewController{
    NSIndexPath *selectIndex;
    NSMutableArray *judge ;
    BOOL touchTopButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    
    _findView = [[NOVFindView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - tabBarHeight)];
    [self.view addSubview:_findView];
    _findView.scrollView.delegate = self;
    _findView.headView.delegate = self;

    _findView.todayPromotionView.tableView.delegate = self;
    _findView.todayPromotionView.tableView.dataSource = self;
    [_findView.todayPromotionView.tableView registerClass:[NOVFindTableViewCell class] forCellReuseIdentifier:@"findCell"];
    
    _findView.rankingListView.tableView.delegate = self;
    _findView.rankingListView.tableView.dataSource = self;
    [_findView.rankingListView.tableView registerClass:[NOVFindTableViewCell class] forCellReuseIdentifier:@"findCell"];
    
    _findView.allWorksView.tableView.delegate = self;
    _findView.allWorksView.tableView.dataSource = self;
    [_findView.allWorksView.tableView registerClass:[NOVFindTableViewCell class] forCellReuseIdentifier:@"findCell"];
    
    _bookArray = [NSMutableArray array];
    judge = [NSMutableArray array];
    
    //获取今日推介列表
    [self obtainBookListWithType:NOVObtainBookListRecommend];
}

-(void)obtainBookListWithType:(NOVObtainListType)listType{  //根据类型获取图书列表
    NSLog(@"obtainBookList");
    NOVObtainBookList *obtainBookList = [[NOVObtainBookList alloc] init];
    [obtainBookList obtainBookListWithType:listType succeed:^(id responseObject) {
        NOVAllBookMesssage *allFindModel = [[NOVAllBookMesssage alloc] initWithDictionary:responseObject error:nil];
        NSMutableArray *array = [NSMutableArray arrayWithArray:allFindModel.data];
        NSLog(@"%lu",(unsigned long)array.count);
        for (int i = 0; i < array.count; i++) {
            [judge addObject:@NO];
            NOVbookMessage *model = [[NOVbookMessage alloc] initWithDictionary:array[i] error:nil];
            model.createUser = [[NOVBookStartUser alloc] initWithDictionary:array[i][@"createUser"] error:nil];
            [_bookArray addObject:model];
            NSLog(@"name:%@ bookID:%ld",model.bookName,(long)model.bookId);
        }
        [_findView.todayPromotionView.tableView reloadData];
    } fail:^(NSError *error) {
        //显示网络故障
        self.networkAnoamlyView.hidden = NO;
    }];
}

-(NOVNetworkAnomalyView *)networkAnoamlyView{
    if (!_networkAnoamlyView) {
        _networkAnoamlyView = [[NOVNetworkAnomalyView alloc] init];
        [self.view addSubview:_networkAnoamlyView];
        [_networkAnoamlyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.and.width.mas_equalTo(150);
            make.center.equalTo(self.view);
        }];
        _networkAnoamlyView.delegate = self;
        _networkAnoamlyView.hidden = YES;
    }
    return _networkAnoamlyView;
}
//NOVNetworkAnomalyView的代理方法，点击网络故障时执行
-(void)touchAnomalyImage{
    self.networkAnoamlyView.hidden = YES;
    //重新获取数据
    [self obtainBookListWithType:NOVObtainBookListRecommend];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"findCell";
    NOVFindTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    [cell updateCellWithModel:_bookArray[indexPath.section]];
    cell.readButton.tag = indexPath.section;
    [cell.readButton addTarget:self action:@selector(readNovel:) forControlEvents:UIControlEventTouchUpInside];
    if ([judge[indexPath.section] isEqual:@YES]) {
        cell.isOpen = YES;
        [cell cellOpen];
    }else {
        cell.isOpen = NO;
        [cell cellClose];
    }
    return cell;
}
-(void)readNovel:(UIButton *)button{
    NOVReadNovelViewController *readNovelViewController = [[NOVReadNovelViewController alloc] init];
    //把点击作品的作品信息传给即将要进入的界面（小说阅读）
    readNovelViewController.bookMessage = _bookArray[button.tag];
    readNovelViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:readNovelViewController animated:NO];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _bookArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([judge[indexPath.section] isEqual:@YES]) {
        return 250;
    }
    return 110;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[judge objectAtIndex:indexPath.section] isEqual:@YES]) {
        judge[indexPath.section]=@NO;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }else {
        judge[indexPath.section]=@YES;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}

-(void)touchRespone:(UIButton *)touchButton{
    touchTopButton = YES;
    [_findView viewResponseWhenTouchButton:touchButton];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    touchTopButton = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //如果是点击button导致的scrollView移动则不触发该方法
    if (touchTopButton || scrollView != _findView.scrollView) {
        return;
    }
    [_findView.headView setButtonPostion:scrollView.contentOffset width:scrollView.contentSize.width];
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
