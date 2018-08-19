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
@property(nonatomic,strong) NSMutableArray *todayPromotionModelArray;
@property(nonatomic,strong) NSMutableArray *rankingListModelArray;
@property(nonatomic,strong) NSMutableArray *allWorksModelArray;
@property(nonatomic,strong) NOVNetworkAnomalyView *networkAnoamlyView;
@end

@implementation FindViewController{
    NSIndexPath *selectIndex;
    NSMutableArray *judge ;
    BOOL touchTopButton;
    NSInteger currentPage;//当前页
    NSMutableArray *isLoadArray;//标记tableView是否加载过
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    judge = [NSMutableArray array];
    _findView = [[NOVFindView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - tabBarHeight)];
    [self.view addSubview:_findView];
    _findView.scrollView.delegate = self;
    _findView.headView.delegate = self;

    _findView.todayPromotionView.tableView.delegate = self;
    _findView.todayPromotionView.tableView.dataSource = self;
    [_findView.todayPromotionView.tableView registerClass:[NOVFindTableViewCell class] forCellReuseIdentifier:@"findCell"];
    _todayPromotionModelArray = [NSMutableArray array];
    _findView.todayPromotionView.tableView.tag = 1000;
    
    _findView.rankingListView.tableView.delegate = self;
    _findView.rankingListView.tableView.dataSource = self;
    [_findView.rankingListView.tableView registerClass:[NOVFindTableViewCell class] forCellReuseIdentifier:@"findCell"];
    _rankingListModelArray = [NSMutableArray array];
    _findView.rankingListView.tableView.tag = 1001;
    
    _findView.allWorksView.tableView.delegate = self;
    _findView.allWorksView.tableView.dataSource = self;
    [_findView.allWorksView.tableView registerClass:[NOVFindTableViewCell class] forCellReuseIdentifier:@"findCell"];
    _allWorksModelArray = [NSMutableArray array];
    _findView.allWorksView.tableView.tag = 1002;
    
    isLoadArray = [NSMutableArray arrayWithArray:@[@NO,@NO,@NO]];
    currentPage = 0;
    //获取今日推介列表
    [self obtainBookListWithType:NOVObtainBookListBRANCH_NUM tableView:_findView.todayPromotionView.tableView modelArray:_todayPromotionModelArray];
}

-(void)obtainBookListWithType:(NOVObtainListType)listType tableView:(UITableView *)tableView modelArray:(NSMutableArray *)modelArray{  //根据类型获取图书列表
    NSLog(@"obtainBookList");
    [modelArray removeAllObjects];
    NOVObtainBookList *obtainBookList = [[NOVObtainBookList alloc] init];
    [obtainBookList obtainBookListWithType:listType succeed:^(id responseObject) {
        NOVAllBookMesssage *allFindModel = [[NOVAllBookMesssage alloc] initWithDictionary:responseObject[@"data"] error:nil];
        NSMutableArray *array = [NSMutableArray arrayWithArray:allFindModel.list];
        for (int i = 0; i < array.count; i++) {
            [judge addObject:@NO];
            NOVbookMessage *model = [[NOVbookMessage alloc] initWithDictionary:array[i] error:nil];
            model.author = [[NOVBookStartUser alloc] initWithDictionary:array[i][@"author"] error:nil];
            NSLog(@"name:%@ bookID:%ld username:%@",model.bookName,(long)model.bookId,model.author.username);
            [modelArray addObject:model];
        }
        isLoadArray[currentPage] = @YES;
        [tableView reloadData];
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
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"findCell";
    NOVFindTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    [cell updateCellWithModel:[self getCurrentPageWithPage:tableView.tag][indexPath.section]];
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
    readNovelViewController.bookMessage = [self getCurrentPageWithPage:currentPage][button.tag];
    readNovelViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:readNovelViewController animated:NO];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self getCurrentPageWithPage:tableView.tag].count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([judge[indexPath.section] isEqual:@YES]) {
        return self.view.frame.size.height*0.33;
    }
    return self.view.frame.size.height*0.18;
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
    currentPage = touchButton.tag;
    if([isLoadArray[touchButton.tag] isEqual:@YES]){  //该页面已经加载过
        return;
    }
    [self updateCurrentPage];
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

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
    if ([isLoadArray[currentPage] isEqual:@YES]) {  //该页面已经加载过
        return;
    }
    [self updateCurrentPage];
}

- (void)updateCurrentPage{
    switch (currentPage) {
        case 0:
            [self obtainBookListWithType:NOVObtainBookListBRANCH_NUM tableView:_findView.todayPromotionView.tableView modelArray:_todayPromotionModelArray];
            break;
        case 1:
            [self obtainBookListWithType:NOVObtainBookListREAD_NUM tableView:_findView.rankingListView.tableView modelArray:_rankingListModelArray];
            break;
        case 2:
            [self obtainBookListWithType:NOVObtainBookListJOIN_USERS tableView:_findView.allWorksView.tableView modelArray:_allWorksModelArray];
            break;
        default:
            break;
    }
}

-(NSMutableArray *)getCurrentPageWithPage:(NSInteger)currentPage{
    switch (currentPage % 1000) {
        case 0:
            return _todayPromotionModelArray;
        case 1:
            return _rankingListModelArray;
        case 2:
            return _allWorksModelArray;
        default:
            return nil;
    }
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
