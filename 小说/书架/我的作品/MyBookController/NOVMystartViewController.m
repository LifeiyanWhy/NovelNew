//
//  NOVMystartViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/5/22.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVMystartViewController.h"
#import "NOVMystartHeadFile.h"

@interface NOVMystartViewController ()<NOVMystartViewDategate,NOVViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong) NOVNoContentView *noContentView;
@end

@implementation NOVMystartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.allMyStartView];
    _touchTopButton = NO;
    
    _novelArray = [NSMutableArray array];
    _draftsArray = [NSMutableArray array];
    
    //获取当前用户的所有作品
    NOVStartManager *startManager = [[NOVStartManager alloc] init];
    [startManager getMyStartWithType:@"PUBLISH" Success:^(id  _Nonnull responseObject) {
        NSArray *array = responseObject[@"data"];
        if (array.count == 0) {
            [self.view addSubview:self.noContentView];
        } else {
            for (int i = 0 ; i < array.count; i++) {
                [_novelArray addObject:[[NOVGetMyStartModel alloc] initWithDictionary:array[i] error:nil]];
            }
            [_allMyStartView.publishedView setSubViewsWithViewNumber:_novelArray.count isPublish:YES];
        }
    } fail:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    [startManager getMyStartWithType:@"UNPUBLISHED" Success:^(id  _Nonnull responseObject) {
        NSArray *array = responseObject[@"data"];
        if (array.count == 0) {
            [self.view addSubview:self.noContentView];
        } else {
            for (int i = 0 ; i < array.count; i++) {
                [_draftsArray addObject:[[NOVGetMyStartModel alloc] initWithDictionary:array[i] error:nil]];
            }
            [_allMyStartView.draftsView setSubViewsWithViewNumber:_draftsArray.count isPublish:NO];
        }
    } fail:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

-(NOVBookSetView *)mystartView:(NOVMystartView *)myStartView viewForPape:(NSInteger)page WithWidth:(CGFloat)width Height:(CGFloat)height{
    NOVBookSetView *bookSetView = [[NOVBookSetView alloc] initWithFrame:CGRectMake(width*(0.15+page), height*0.07, width*0.7, height*0.83)];
    if ([myStartView isEqual:_allMyStartView.publishedView]) {//已发布
        [bookSetView updateWithModel:_novelArray[page]];
    } else {//未发布
        [bookSetView updateWithModel:_draftsArray[page]];
    }
    return bookSetView;
}

-(NOVAllMyStartView *)allMyStartView{
    if (!_allMyStartView) {
        _allMyStartView = [[NOVAllMyStartView alloc] initWithFrame:self.view.frame];
        [_allMyStartView.leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [_allMyStartView.rightButton addTarget:self action:@selector(creatStart) forControlEvents:UIControlEventTouchUpInside];
        _allMyStartView.scrollView.delegate = self;
        _allMyStartView.headView.delegate = self;
        _allMyStartView.publishedView.delegate = self;
        _allMyStartView.publishedView.scrollView.delegate = self;
        _allMyStartView.draftsView.delegate = self;
        _allMyStartView.draftsView.scrollView.delegate = self;
    }
    return _allMyStartView;
}

-(void)changeBookImageWithView:(UIImageView *)imageView{
}

-(void)touchEditButtonInSetView:(NOVBookSetView *)setView{
    if (setView.novelState) {
        NSLog(@"publish");
        [self readBookWithModel:_novelArray[setView.editButton.tag]];
    }else{
        NSLog(@"unpublish");
        NSLog(@"%@ %@",[_draftsArray[setView.editButton.tag] class],[NOVGetMyStartModel class]);
        if ([_draftsArray[setView.editButton.tag] isMemberOfClass:[NOVGetMyStartModel class]]) {
            [self editBookWithView:setView getModel:_draftsArray[setView.editButton.tag] model:nil];
        } else {
            [self editBookWithView:setView getModel:nil model:_draftsArray[setView.editButton.tag]];
        }
    }
}

-(void)creatStart{
    __block NOVMystartViewController *weakSelf = self;
    NOVEditViewController *editViewController = [[NOVEditViewController alloc] init];
    editViewController.novelTitleBlock = ^(NOVStartBookModel *model) {
        NSLog(@"%@",model.introduction);
        model.bookId = -1;
        //在我的发起界面根据回调的数据添加作品（未发布）
        [_allMyStartView.draftsView addViewWithModel:model];
        //更新数据源
        [weakSelf.draftsArray addObject:model];
    };
    [self.navigationController pushViewController:editViewController animated:NO];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

-(NOVNoContentView *)noContentView{
    if (!_noContentView) {
        _noContentView = [[NOVNoContentView alloc] initWithFrame:CGRectMake(0, self.view.frame.origin.y - 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    }
    return _noContentView;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
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
