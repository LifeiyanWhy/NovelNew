//
//  NOVReadNovelViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/4/20.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVReadNovelViewController.h"
#import "NOVReadNovelViewController+catalog.h"
#import "NOVReadPageViewController.h"
#import "NOVObatinBookContent.h"
#import "NOVReadEditVIew.h"
#import "NOVDataModel.h"
#import "NOVChapterModel.h"
#import "NOVbookMessage.h"
#import "NOVRecordModel.h"
#import "NOVReadEndView.h"
#import "NOVWriteViewController.h"
#import "NOVRenewModel.h"
#import "NOVStartManager.h"
#import "NOVNextChapterViewController.h"
#import "NOVCatalogView.h"

@interface NOVReadNovelViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,strong) UIPageViewController *pageViewController;
@property(nonatomic,strong) NOVReadPageViewController *readViewController;//当前阅读视图
@property(nonatomic,strong) NOVReadEditVIew *readEditView;
@property(nonatomic,strong) NOVReadEndView *readEndView;//当前所在章节阅读结束时显示
@property(nonatomic,assign) NOVPageChangeType pageChangeType;
@property(nonatomic,strong) UITapGestureRecognizer *tap;
@end

@implementation NOVReadNovelViewController{
    NOVObatinBookContent *obatinBookContent; //用于获取作品信息的类
    NSInteger currentPage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bookBackground.png"]];
    [self addChildViewController:self.pageViewController];
    [self.view addGestureRecognizer:({
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setMenu:)];
        _tap.cancelsTouchesInView = NO;
        _tap.delegate = self;
        _tap;
    })];
    [self.view addSubview:self.readEndView];
    [self.view addSubview:self.readEditView];
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.catalogView];
    currentPage = -1;
    obatinBookContent = [[NOVObatinBookContent alloc] init];
    
    if (_bookMessage) {
        _readFromCatalog = NO;
        //根据bookId在本地查找是否已有阅读数据
        _recordModel = [NOVRecordModel getRecordModelFromLocalWithBookId:_bookMessage.bookId];
        if (!_recordModel) {
            self.recordModel.chapter = 1;
            //获取首段ID
            [obatinBookContent getBookFirstChapterIdWithBookID:_bookMessage.bookId succeed:^(id responseObject) {
                NSNumber *number = responseObject[@"data"][0][@"branchId"];
                [self obtainChapterContentWithBranchId:[number integerValue]];
            } fail:^(NSError *error) {
            }];
        }else{
            currentPage = _recordModel.page;
            //将获取到的文本self示到当前controller上
            [_pageViewController setViewControllers:@[[self readViewControllerWithChapter:_recordModel.chapterModel position:currentPage]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
            if (currentPage == _recordModel.pageCount -1) {
                _readEndView.hidden = NO;
            }
        }
    }else{
        NSLog(@"未获取到作品信息");
    }
}

//获取章节内容
-(void)obtainChapterContentWithBranchId:(NSInteger)branchId{
    [obatinBookContent getChapterModelWithBranchId:branchId succeed:^(id responseObject) {
        NSLog(@"%@",responseObject);
        //当前阅读章节，对获取到的章节内容进行分页
        [self.recordModel updateChapterModel:[[NOVChapterModel alloc] initWithDictionary:responseObject[@"data"] error:nil]];
        currentPage = 0;
        //将获取到的文本self示到当前controller上
        if (_readFromCatalog) {
            [_pageViewController setViewControllers:@[[self readViewControllerWithChapter:_recordModel.chapterModel position:currentPage]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        }else{
            [_pageViewController setViewControllers:@[[self readViewControllerWithChapter:_recordModel.chapterModel position:currentPage]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        }
        if (currentPage == _recordModel.pageCount -1) {
            _readEndView.hidden = NO;
        }else{
            _readEndView.hidden = YES;
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//翻页后加载页面
-(NOVReadPageViewController *)readViewControllerWithChapter:(NOVChapterModel *)chapter position:(NSInteger)position{
    _readViewController = [[NOVReadPageViewController alloc] init];
    _readViewController.content = [_recordModel stringWithPage:position];
    return _readViewController;
}

//设置翻页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    if (currentPage == -1) {
        NSLog(@"未获取到作品信息");
        return nil;
    }
    if (currentPage == 0) {
        return nil;
    }
    _readEndView.hidden = YES;
    _pageChangeType = NOVPageChangeTypeBefore;
    return [self readViewControllerWithChapter:_recordModel.chapterModel position:currentPage - 1];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    if (_catalogView.hidden == NO) {
        return nil;
    }
    if (currentPage == -1) {
        NSLog(@"未获取到作品信息");
        return nil;
    }
    if (currentPage == _recordModel.pageCount - 1) {//已经到最后一页,不再翻页
        return nil;
    }
    _pageChangeType = NOVPageChangeTypeAfter;
    return [self readViewControllerWithChapter:_recordModel.chapterModel position:currentPage + 1];
}
//翻页后执行
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed) {
        if (_pageChangeType == NOVPageChangeTypeAfter && currentPage != _recordModel.pageCount - 1) {//向后翻页
            currentPage++;
            _recordModel.page = currentPage;
        }else if(_pageChangeType == NOVPageChangeTypeBefore && currentPage != 0){  //向前翻页
            currentPage--;
            _recordModel.page = currentPage;
        }
    }
    if (currentPage == _recordModel.pageCount - 1) {//最后一页
        _readEndView.hidden = NO;
    }
}

-(UIPageViewController *)pageViewController
{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        _pageViewController.doubleSided = NO;
        _pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.view addSubview:_pageViewController.view];
    }
    return _pageViewController;
}

- (NOVRecordModel *)recordModel{
    if (!_recordModel) {
        _recordModel = [[NOVRecordModel alloc] init];
        _recordModel.bookId = _bookMessage.bookId;
    }
    return _recordModel;
}

-(void)setMenu:(UITapGestureRecognizer *)gester{
    CGPoint gesterPoint = [gester locationInView:gester.view];
    NSLog(@"%@ %f %f",gester.view,gesterPoint.x,gesterPoint.y);
    if (!_readEndView.hidden){
        if (gesterPoint.x > ScreenWidth - 25 && gesterPoint.y < 64 && gesterPoint.y > 64 - 25) {
            return;
        }
    }
    if (!_catalogView.hidden && gesterPoint.x < ScreenWidth*0.8) {  //目录是显示状态，并点击了目录的位置
        return;
    }else if (!_catalogView.hidden && gesterPoint.x >= ScreenWidth*0.75){   //目录是显示状态，并点击了空白处，回收菜单
        _catalogView.hidden = YES;
        _backgroundView.hidden = YES;
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            _catalogView.frame = CGRectMake(-1*ScreenWidth*0.8, 0, ScreenWidth*0.8, ScreenHeight);
        } completion:nil];
        return;
    }
    if (_readEditView.hidden) {
        [_readEditView displayMenu:self.view];
    }else{
        [_readEditView hiddenMenu];
    }
}

-(NOVReadEditVIew *)readEditView
{
    if (!_readEditView) {
        _readEditView = [[NOVReadEditVIew alloc] initWithFrame:self.view.frame];
        [_readEditView.backButton addTarget:self action:@selector(touchBackButton) forControlEvents:UIControlEventTouchUpInside];
        [_readEditView.rightButton addTarget:self action:@selector(touchRightButton) forControlEvents:UIControlEventTouchUpInside];
        [_readEditView.collectionButton addTarget:self action:@selector(touchCollectionButton:) forControlEvents:UIControlEventTouchUpInside];
        [_readEditView.followButton addTarget:self action:@selector(touchFollowButton:) forControlEvents:UIControlEventTouchUpInside];
        [_readEditView.nextChapterButton addTarget:self action:@selector(nextChapter) forControlEvents:UIControlEventTouchUpInside];
        [_readEditView.catalogButton addTarget:self action:@selector(showCatalogView) forControlEvents:UIControlEventTouchUpInside];
        _readEditView.hidden = YES;
    }
    return _readEditView;
}

-(void)touchRightButton{
    BOOL collection = NO,follow = NO;
    NOVDataModel *datamodel = [NOVDataModel shareInstance];
    //是否关注
    NSArray *array = [datamodel getFollowBookList];
    for (NSNumber *bookId in array) {
        if(self.bookMessage.bookId == [bookId integerValue]){
            follow = YES;
            break;
        }
    }
    //是否收藏
    NSArray *collectionArray = [NOVDataModel getCollectionList];
    for (NSNumber *chapterId in collectionArray) {
        NSLog(@"%@===branchID%ld",chapterId,(long)self.recordModel.chapterModel.branchId);
        if (self.recordModel.chapterModel.branchId == [chapterId integerValue]) {
            collection = YES;
            break;
        }
    }
    [_readEditView touchRightButtonCollection:collection follow:follow];
}

-(void)touchCollectionButton:(UIButton *)button{
    if (!button.selected) {//收藏
        [NOVObatinBookContent collectionChapterWithBranchId:self.recordModel.chapterModel.branchId succeed:^(id responseObject) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:responseObject[@"data"]];
            NSMutableArray *collectionArray = [NSMutableArray array];
            for (int i = 0; i < array.count; i++) {
                [collectionArray addObject:array[i][@"branchId"]];
            }
            [NOVDataModel updateCollectionListWithArray:collectionArray];
            [_readEditView collectionButtonChange:button];
        } fail:^(NSError *error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:&error];
            NSLog(@"collection：%@",dict[@"message"]);
        }];
    } else {
        [NOVObatinBookContent cancelCollectionChapterWithBranchId:self.recordModel.chapterModel.branchId succeed:^(id responseObject) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:responseObject[@"data"]];
            NSMutableArray *collectionArray = [NSMutableArray array];
            for (int i = 0; i < array.count; i++) {
                [collectionArray addObject:array[i][@"branchId"]];
            }
            [NOVDataModel updateCollectionListWithArray:collectionArray];
            [_readEditView collectionButtonChange:button];
        } fail:^(NSError *error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:&error];
            NSLog(@"collection：%@",dict);
        }];
    }
}

-(void)touchFollowButton:(UIButton *)button{
    NOVObatinBookContent *model = [[NOVObatinBookContent alloc] init];
    if (!button.selected) { //关注
        [model followBookWithBookId:self.bookMessage.bookId succeed:^(id responseObject) {
            NSLog(@"%@",responseObject[@"message"]);
            //更新本地存储的关注列表
            NOVDataModel *datamodel = [NOVDataModel shareInstance];
            NSArray *followArray = [datamodel getFollowBookList];
            NSMutableArray *array = [NSMutableArray arrayWithArray:followArray];
            [array addObject:[NSNumber numberWithInteger:self.bookMessage.bookId]];
            [datamodel updateFollowBookListWithArray:array];
            
            [_readEditView followButtonChange:button];
        } fail:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }else{  //取消关注
        [model cancelFollowBookId:self.bookMessage.bookId succeed:^(id responseObject) {
            NSLog(@"%@",responseObject[@"message"]);
            //更新本地存储的关注列表
            NOVDataModel *datamodel = [NOVDataModel shareInstance];
            NSArray *followArray = [datamodel getFollowBookList];
            NSMutableArray *array = [NSMutableArray arrayWithArray:followArray];
            [array removeObject:[NSNumber numberWithInteger:self.bookMessage.bookId]];
            [datamodel updateFollowBookListWithArray:array];
            [_readEditView followButtonChange:button];
        } fail:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}

-(NOVReadEndView *)readEndView{
    if (!_readEndView) {
        _readEndView = [[NOVReadEndView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 60)];
        _readEndView.hidden = YES;
        [_readEndView.renewButton addTarget:self action:@selector(renew) forControlEvents:UIControlEventTouchUpInside];
        [_readEndView.likeButton addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
        [_readEndView.disLikeButton addTarget:self action:@selector(disLike) forControlEvents:UIControlEventTouchUpInside];
    }
    return _readEndView;
}

//续写
-(void)renew{
    NOVWriteViewController *writeViewController = [[NOVWriteViewController alloc] init];
    writeViewController.hidesBottomBarWhenPushed = YES;
    writeViewController.publishNovelBlock = ^(NSString *title, NSString *content) {
        NOVRenewModel *renewModel = [[NOVRenewModel alloc] init];
        renewModel.bookId = _bookMessage.bookId;
        renewModel.parentId = _recordModel.chapterModel.branchId;
        renewModel.title = title;
        renewModel.content = content;
        NOVStartManager *startManager = [[NOVStartManager alloc] init];
        [startManager publishRenewWithRenewModel:renewModel success:^(id  _Nonnull responseObject) {
            NSLog(@"%@",responseObject);
        } fail:^(NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    };
    [self.navigationController pushViewController:writeViewController animated:NO];
}

-(void)like{
}

-(void)disLike{
}

-(void)nextChapter{
    NOVObatinBookContent *obtainBookContent = [[NOVObatinBookContent alloc] init];
    //获取下一章列表
    [obtainBookContent getRenewListWithBookId:_bookMessage.bookId ParentId:_recordModel.chapterModel.branchId succeed:^(id responseObject) {
        //获取成功
        [_pageViewController setViewControllers:@[[[NOVReadPageViewController alloc] init]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        NOVNextChapterViewController *nextChapterViewControler = [[NOVNextChapterViewController alloc] init];
        nextChapterViewControler.parentId = _recordModel.chapterModel.branchId;
        nextChapterViewControler.bookMessage = _bookMessage;
        __block NOVReadNovelViewController *weakSelf = self;
        nextChapterViewControler.chapterIdBlock = ^(NSInteger chapter) {
            weakSelf.readEndView.hidden = YES;
            weakSelf.readEditView.hidden = YES;
            _readFromCatalog = YES;
            obatinBookContent = [[NOVObatinBookContent alloc] init];
            [weakSelf obtainChapterContentWithBranchId:chapter];
        };
        [self.navigationController pushViewController:nextChapterViewControler animated:NO];
    } fail:^(NSError *error) {
        NSLog(@"未获取到作品信息");
        [self showAlertActionWithTitle:@"本章暂无续写内容"];
    }];
}

-(void)touchBackButton{
    if (_recordModel) {
        NSLog(@"保存！");
        [NOVRecordModel updateLocalRecordModel:_recordModel];//退出前存储本次阅读记录
    }
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)showCatalogView{
    self.catalogView.hidden = NO;
    self.backgroundView.hidden = NO;
    //目录出现时设为NO，使tableview可以响应
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        _catalogView.frame = CGRectMake(0, 0, ScreenWidth*0.8, ScreenHeight);
    } completion:nil];
    [self updateCatalog];
    
}

-(NOVCatalogView *)catalogView{
    if (!_catalogView) {
        _catalogView = [[NOVCatalogView alloc] init];
        _catalogView.frame = CGRectMake(-1*ScreenWidth*0.75, 0, ScreenWidth*0.75, ScreenHeight);
        _catalogView.hidden = YES;
    }
    return _catalogView;
}

-(UIImageView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIImageView alloc] initWithFrame:self.view.frame];
        _backgroundView.backgroundColor = [UIColor colorWithRed:0.25f green:0.25f blue:0.25f alpha:0.6f];
        _backgroundView.hidden = YES;
    }
    return _backgroundView;
}

- (void)viewWillAppear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden = YES;
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
