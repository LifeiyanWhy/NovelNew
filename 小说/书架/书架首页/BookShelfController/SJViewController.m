//
//  SJViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/3/29.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "SJViewController.h"
#import "SJView.h"
#import "NOVView.h"
#import "SJBottomView.h"
#import "NOVBookTableViewCell.h"
#import "NOVReadNovelViewController.h"
#import "NOVMystartViewController.h"
#import "NOVObtainBookshelfModel.h"
#import "NOVbookMessage.h"

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
    
    _sjview.collectionView.tableView.delegate = self;
    _sjview.collectionView.tableView.dataSource = self;
    [_sjview.collectionView.tableView registerClass:[NOVBookTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _sjview.followView.tableView.delegate = self;
    _sjview.followView.tableView.dataSource = self;
    [_sjview.followView.tableView registerClass:[NOVBookTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _sjview.joinView.tableView.delegate = self;
    _sjview.joinView.tableView.dataSource = self;
    [_sjview.joinView.tableView registerClass:[NOVBookTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    //分别标记三个页面是否加载过
    isLoadArray = [NSMutableArray arrayWithArray:@[@NO,@NO,@NO]];
    currentPage = 0;
    [self obtainBookListWithCurrentPage:currentPage];
}

-(void)obtainBookListWithCurrentPage:(NSInteger)page{
    NOVObtainBookshelfModel *model = [[NOVObtainBookshelfModel alloc] init];
    if (page == 0) {    //获取关注列表
        [model obtainFollowBookListSucceed:^(id  _Nullable responseObject) {
            NOVAllBookMesssage *allFindModel = [[NOVAllBookMesssage alloc] initWithDictionary:responseObject error:nil];
            NSMutableArray *array = [NSMutableArray arrayWithArray:allFindModel.data];
            for (int i = 0; i < array.count; i++) {
                NOVbookMessage *model = [[NOVbookMessage alloc] initWithDictionary:array[i] error:nil];
                [self.followModelArray addObject:model];
                NSLog(@"name:%@ bookID:%ld",model.bookName,(long)model.bookId);
            }
            [_sjview.followView.tableView reloadData];
            isLoadArray[page] = @YES;
        } failure:^(NSError * _Nonnull error) {
            //显示网络故障
            self.networkAnomalyView.hidden = NO;
        }];
    }else if (page == 1){   //获取我的收藏列表
        
    }else{  //获取我的参与列表
        
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
    if(isLoadArray[touchButton.tag]){  //该页面已经加载过
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
    if (isLoadArray[currentPage]) {  //该页面已经加载过
        return;
    }
    [self obtainBookListWithCurrentPage:currentPage];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    NOVBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell updateCellModel:self.followModelArray[indexPath.section]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.followModelArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.frame.size.height*0.2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NOVReadNovelViewController *readNovelViewController = [[NOVReadNovelViewController alloc] init];
    readNovelViewController.hidesBottomBarWhenPushed = YES;
    readNovelViewController.bookMessage = self.followModelArray[indexPath.section];
    [self.navigationController pushViewController:readNovelViewController animated:NO];
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
