//
//  SJViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/3/29.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "SJViewController.h"
#import "NOVBookShelf.h"

#define tabBarHeight self.navigationController.tabBarController.tabBar.frame.size.height //控制器高度

@interface SJViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,NOVViewDelegate,NOVNetworkAnomalyViewDelegate>

@property(nonatomic,strong) SJView *sjview;
@property(nonatomic,strong) NOVNetworkAnomalyView *networkAnomalyView;
@property(nonatomic,strong) NSMutableArray *followModelArray;
@property(nonatomic,strong) NSMutableArray *collectionModelArray;
@property(nonatomic,strong) NSMutableArray *joinModelArray;
@end

@implementation SJViewController{
    BOOL touchTopButton;
    NSInteger currentPage;
    NSMutableArray *isLoadArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    
    _sjview = [[SJView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - tabBarHeight)];
    [self.view addSubview:_sjview];
    _sjview.scrollView.delegate = self;
    [_sjview.startButton addTarget:self action:@selector(fqStart) forControlEvents:UIControlEventTouchUpInside];
    _sjview.headView.delegate = self;
    
    _sjview.followView.tableView.delegate = self;
    _sjview.followView.tableView.dataSource = self;
    _sjview.followView.tableView.tag = 1001;
    [_sjview.followView.tableView registerClass:[NOVBookTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _sjview.collectionView.tableView.delegate = self;
    _sjview.collectionView.tableView.dataSource = self;
    _sjview.collectionView.tableView.tag = 1002;
    [_sjview.collectionView.tableView registerClass:[NOVMyCollecitonTableViewCell class] forCellReuseIdentifier:@"collectionCell"];
 
    _sjview.joinView.tableView.delegate = self;
    _sjview.joinView.tableView.dataSource = self;
    _sjview.joinView.tableView.tag = 1003;
    [_sjview.joinView.tableView registerClass:[NOVMyRenewTableViewCell class] forCellReuseIdentifier:@"renewCell"];
    
    //分别标记三个页面是否加载过
    isLoadArray = [NSMutableArray arrayWithArray:@[@NO,@NO,@NO]];
    currentPage = 0;
    [self obtainBookListWithCurrentPage:currentPage];
}

-(void)obtainBookListWithCurrentPage:(NSInteger)page{
    NOVObtainBookShelfManager *model = [[NOVObtainBookShelfManager alloc] init];
    if (page == 0) {    //获取关注列表
        [self.followModelArray removeAllObjects];
        [model obtainFollowBookListSucceed:^(id  _Nullable responseObject) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:responseObject[@"data"]];
            for (int i = 0; i < array.count; i++) {
                NOVbookMessage *model = [[NOVbookMessage alloc] initWithDictionary:array[i] error:nil];
                [self.followModelArray addObject:model];
//                NSLog(@"关注name:%@ bookID:%ld",model.bookName,(long)model.bookId);
            }
            [_sjview.followView.tableView reloadData];
            isLoadArray[page] = @YES;//标记页面已经加载
        } failure:^(NSError * _Nonnull error) {
            //显示网络故障
            self.networkAnomalyView.hidden = NO;
        }];
    }else if (page == 1){   //获取我的收藏列表
        [self.collectionModelArray removeAllObjects];
        [model obtainMyCollectionSucceed:^(id  _Nullable responseObject) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:responseObject[@"data"]];
            for (int i = 0; i < array.count; i++) {
                NOVMyCollectionModel *model = [[NOVMyCollectionModel alloc] initWithDictionary:array[i] error:nil];
                model.author = [[NOVMyCollectionAuthor alloc] initWithDictionary:array[i][@"author"] error:nil];
                [self.collectionModelArray addObject:model];
            }
            [_sjview.collectionView.tableView reloadData];
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }else{  //获取我的参与列表
        [self.joinModelArray removeAllObjects];
        [model obtainMyRenewSucceed:^(id  _Nullable responseObject) {
            NSMutableArray *modelArray = responseObject[@"data"];
            for (int i = 0; i < modelArray.count; i++) {
                NOVGetMyRenewModel *model = [[NOVGetMyRenewModel alloc] initWithDictionary:modelArray[i] error:nil];
                NSMutableArray *array = modelArray[i][@"myWriteBranchDTOS"];
                NSLog(@"%@",array);
                NSMutableArray *myBranchModelArray = [NSMutableArray array];
                for (int j = 0; j < array.count; j++) {
                    NOVMyBranchModel *myModel = [[NOVMyBranchModel alloc] initWithDictionary:array[j] error:nil];
                    [myBranchModelArray addObject:myModel];
                }
                model.myWriteBranchDTOS = [myBranchModelArray copy];
                NSLog(@"%lu",(unsigned long)model.myWriteBranchDTOS.count);
                model.simpleBookDTO = [[NOVSimpleBookModel alloc] initWithDictionary:modelArray[i][@"simpleBookDTO"] error:nil];
                model.simpleBookDTO.author = [[NOVAuthorModel alloc] initWithDictionary:modelArray[i][@"simpleBookDTO"][@"author"] error:nil];
                [self.joinModelArray addObject:model];
            }
            [_sjview.joinView.tableView reloadData];
            isLoadArray[page] = @YES;
        } failure:^(NSError * _Nonnull error) {
            self.networkAnomalyView.hidden = YES;
        }];
    }
}

-(NOVNetworkAnomalyView *)networkAnomalyView{
    if (_networkAnomalyView) {
        _networkAnomalyView = [[NOVNetworkAnomalyView alloc] init];
        [self.view addSubview:_networkAnomalyView];
        [_networkAnomalyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.and.width.mas_equalTo(150);
            make.center.equalTo(self.view);
        }];
        _networkAnomalyView.delegate = self;
        _networkAnomalyView.hidden = YES;
    }
    return _networkAnomalyView;
}

-(void)touchRespone:(UIButton *)touchButton{
    touchTopButton = YES;
    [_sjview viewResponseWhenTouchButton:touchButton];
    currentPage = touchButton.tag;
    if([isLoadArray[touchButton.tag] isEqual:@YES]){  //该页面已经加载过
        return;
    }
    [self obtainBookListWithCurrentPage:currentPage];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    touchTopButton = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //如果是点击button导致的scrollView移动则不触发该方法
    if (touchTopButton || scrollView != _sjview.scrollView) {
        return;
    }
    [_sjview.headView setButtonPostion:scrollView.contentOffset width:scrollView.contentSize.width];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
    NSLog(@"%ld",(long)currentPage);
    if ([isLoadArray[currentPage] isEqual:@YES]) {  //该页面已经加载过
        return;
    }
    [self obtainBookListWithCurrentPage:currentPage];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1001) {
        static NSString *identifier = @"cell";
        NOVBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        [cell updateCellModel:self.followModelArray[indexPath.section]];
        return cell;
    }else if (tableView.tag == 1002){
        static NSString *idetifier = @"collectionCell";
        NOVMyCollecitonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idetifier forIndexPath:indexPath];
        NOVMyCollectionModel *model = self.collectionModelArray[indexPath.section];
        [cell updateCellWithModel:model];
        return cell;
    }else{
        static NSString *identifier = @"renewCell";
        NOVGetMyRenewModel *model = _joinModelArray[indexPath.section];
        NOVMyRenewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        [cell updateCellModel:model.myWriteBranchDTOS[indexPath.row]];
        return cell;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 1003) {
        NOVGetMyRenewModel *model = _joinModelArray[section];
        return model.myWriteBranchDTOS.count;
    }
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag == 1001) {
        return self.followModelArray.count;
    }else if (tableView.tag == 1002){
        return self.collectionModelArray.count;
    }else{
        return self.joinModelArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1003) {
        NOVGetMyRenewModel *model = _joinModelArray[indexPath.section];
        return [NOVMyRenewCellHeightModel getRenewCellHeightWithModel:model.myWriteBranchDTOS[indexPath.row]];
    }else if (tableView.tag == 1002){
        NOVMyCollectionModel *model = _collectionModelArray[indexPath.section];
        return [NOVMyRenewCellHeightModel getCollectionCellHeightWithModel:model];
    }
    return self.view.frame.size.height*0.18;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 1003) {
        return tableView.frame.size.width*(0.17 + 0.05) + 15;
    }
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 1003) {
        static NSString *identifier = @"headView";
        NOVGetMyRenewModel *model = _joinModelArray[section];
        NOVRenewHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        if (!headView) {
            headView = [[NOVRenewHeadView alloc] initWithReuseIdentifier:identifier];
            [headView.goNovelButton addTarget:self action:@selector(goNovelButton:) forControlEvents:UIControlEventTouchUpInside];
        }
        headView.goNovelButton.tag = section;
        [headView updateCellModel:model.simpleBookDTO];
        [headView setBackgroundColor:[UIColor whiteColor]];
        return headView;
    }
    return [[UIView alloc] init];
}

-(void)goNovelButton:(UIButton *)button{
    NOVGetMyRenewModel *model = _joinModelArray[button.tag];
    NOVReadNovelViewController *readNovelViewController = [[NOVReadNovelViewController alloc] init];
    readNovelViewController.hidesBottomBarWhenPushed = YES;
    readNovelViewController.bookMessage = [[NOVbookMessage alloc] init];
    readNovelViewController.bookMessage.author.username = model.simpleBookDTO.author.username;
    readNovelViewController.bookMessage.author.account = model.simpleBookDTO.author.account;
    readNovelViewController.bookMessage.bookId = model.simpleBookDTO.bookId;
    readNovelViewController.bookMessage.bookName = model.simpleBookDTO.bookName;
    [self.navigationController pushViewController:readNovelViewController animated:NO];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1001) {
        NOVReadNovelViewController *readNovelViewController = [[NOVReadNovelViewController alloc] init];
        readNovelViewController.hidesBottomBarWhenPushed = YES;
        readNovelViewController.bookMessage = self.followModelArray[indexPath.section];
        [self.navigationController pushViewController:readNovelViewController animated:NO];
    }else if (tableView.tag == 1002){
        
    }else if (tableView.tag == 1003){
        
    }
}

- (void)fqStart{
    NOVMystartViewController *mystartViewcontroller = [[NOVMystartViewController alloc] init];
    mystartViewcontroller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mystartViewcontroller animated:NO];
}

-(NSMutableArray *)followModelArray{
    if (!_followModelArray) {
        _followModelArray = [NSMutableArray array];
    }
    return _followModelArray;
}

-(NSMutableArray *)collectionModelArray{
    if (!_collectionModelArray) {
        _collectionModelArray = [NSMutableArray array];
    }
    return _collectionModelArray;
}

-(NSMutableArray *)joinModelArray{
    if (!_joinModelArray) {
        _joinModelArray = [NSMutableArray array];
    }
    return _joinModelArray;
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
