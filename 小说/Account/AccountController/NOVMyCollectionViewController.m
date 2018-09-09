//
//  NOVMyCollectionViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/9/3.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVMyCollectionViewController.h"
#import "NOVMyCollecitonTableViewCell.h"
#import "NOVMyCollectionModel.h"
#import "NOVObtainBookShelfManager.h"
#import "NOVMyRenewCellHeightModel.h"

@interface NOVMyCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *modelArray;
@end

@implementation NOVMyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的收藏";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = SystemColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回white.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    [self.view addSubview:self.tableView];
    
    if (self.showChapterType == NOVShowChapterTypeCollection) {
        [self getMyCollection];
    }else{
        
    }
}

-(void)getMyCollection{
    [self.modelArray removeAllObjects];
    NOVObtainBookShelfManager *manager = [[NOVObtainBookShelfManager alloc] init];
    [manager obtainMyCollectionSucceed:^(id  _Nullable responseObject) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:responseObject[@"data"]];
        for (int i = 0; i < array.count; i++) {
            NOVMyCollectionModel *model = [[NOVMyCollectionModel alloc] initWithDictionary:array[i] error:nil];
            model.author = [[NOVMyCollectionAuthor alloc] initWithDictionary:array[i][@"author"] error:nil];
            [_modelArray addObject:model];
        }
        [_tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"collectionCell";
    NOVMyCollecitonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell updateCellWithModel:_modelArray[indexPath.section]];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _modelArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [NOVMyRenewCellHeightModel getCollectionCellHeightWithModel:_modelArray[indexPath.section]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth - 20, ScreenHeight)];
        _tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[NOVMyCollecitonTableViewCell class] forCellReuseIdentifier:@"collectionCell"];
    }
    return _tableView;
}

-(NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
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
