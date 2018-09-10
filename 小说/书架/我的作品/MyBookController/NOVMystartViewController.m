//
//  NOVMystartViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/5/22.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVMystartViewController.h"
#import "NOVMystartView.h"
#import "NOVBookSetView.h"
#import "NOVEditViewController.h"
#import "NOVStartManager.h"
#import "NOVGetMyStartModel.h"
#import "NOVStartBookModel.h"
#import "NOVWriteViewController.h"

@interface NOVMystartViewController ()<NOVMystartViewDategate>
@property(nonatomic,strong) NOVMystartView *mystartView;
@end

@implementation NOVMystartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithDisplayP3Red:0.15 green:0.65 blue:0.6 alpha:1.00];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 130, 30)];
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftButton setImage:[UIImage imageNamed:@"返回white.png"] forState:UIControlStateNormal];
    [leftview addSubview:leftButton];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 100, 30)];
    label.text = @"我的发起";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    [leftview addSubview:label];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftview];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(creatStart)];
    
    _novelArray = [NSMutableArray array];
    //获取当前用户的所有作品
    NOVStartManager *startManager = [[NOVStartManager alloc] init];
    [startManager getMyStartSuccess:^(id  _Nonnull responseObject) {
        NSArray *array = responseObject[@"data"];
        for (int i = 0 ; i < array.count; i++) {
            [_novelArray addObject:[[NOVGetMyStartModel alloc] initWithDictionary:array[i] error:nil]];
        }
        _mystartView = [[NOVMystartView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) withViewNumber:_novelArray.count];
        _mystartView.delegate = self;
        [self.view addSubview:_mystartView];
        _mystartView.delegate = self;
    } fail:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

-(NOVBookSetView *)viewForPape:(NSInteger)page WithWidth:(CGFloat)width Height:(CGFloat)height{
    NOVBookSetView *bookSetView = [[NOVBookSetView alloc] initWithFrame:CGRectMake(width*(0.15+page), height*0.07, width*0.7, height*0.83)];
    [bookSetView updateWithModel:_novelArray[page]];
    return bookSetView;
}

-(void)touchEditButtonInSetView:(NOVBookSetView *)setView{
    NOVStartBookModel *model = self.novelArray[setView.tag-1];
    NOVWriteViewController *writeViewController = [[NOVWriteViewController alloc] init];
    writeViewController.publishNovelBlock = ^(NSString *title, NSString *summary, NSString *content) {
        model.firstTitle = title;
        model.firstContent = content;
        model.firstSummary = summary;
        NOVStartManager *startManager = [[NOVStartManager alloc] init];
        [startManager startNovelWithModel:model success:^(id  _Nonnull responseObject) {
            //发布成功
            //改变编辑button状态
            [setView.editButton setTitle:@"查看作品(已发布)" forState:UIControlStateNormal];
            setView.editButton.userInteractionEnabled = NO;
            //标记为已发布
            setView.novelState = NovelStatePublished;
            NSLog(@"发布成功%@",responseObject);
            if (model.bookImage) {
                //根据bookId上传图片
                model.bookId = (NSInteger)responseObject[@"data"][@"bookId"];
                [startManager uploadBookImage:model.bookImage bookId:model.bookId success:^(id  _Nonnull responseObject) {
                } fail:^(NSError * _Nonnull error) {
                }];
            }
        } fail:^(NSError * _Nonnull error) {
            NSLog(@"发布失败%@",error);
        }];
    };
    [self.navigationController pushViewController:writeViewController animated:NO];
}

-(void)changeBookImageWithView:(UIImageView *)imageView{
}

-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)creatStart{
    if (!_mystartView) {
        _mystartView = [[NOVMystartView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _mystartView.delegate = self;
        [self.view addSubview:_mystartView];
    }
    __block NOVMystartViewController *weakSelf = self;
    NOVEditViewController *editViewController = [[NOVEditViewController alloc] init];
    editViewController.novelTitleBlock = ^(NOVStartBookModel *model) {
        NSLog(@"%@",model.introduction);
        //在我的发起界面根据回调的数据添加作品（未发布）
        [weakSelf.mystartView addViewWithModel:model];
        //更新数据源
        [weakSelf.novelArray addObject:model];
    };
    [self.navigationController pushViewController:editViewController animated:NO];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithDisplayP3Red:0.15 green:0.65 blue:0.6 alpha:1.00];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

-(void)viewWillDisappear:(BOOL)animated{
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
