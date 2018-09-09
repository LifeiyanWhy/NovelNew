//
//  MYViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/3/29.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "MYViewController.h"
#import "NOVAccountHeadFile.h"

@interface MYViewController ()<NOVSelectPhotoManagerDeleagte,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NOVSelectPhotoManager *photoManager;
@property(nonatomic,strong) NOVMyView *myView;
@property(nonatomic,strong) NOVUserMessage *userMessage;
@end

@implementation MYViewController{
    NSArray *imageArray1;
    NSArray *imageArray2;
    NSArray *titleArray1;
    NSArray *titleArray2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _myView = [[NOVMyView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_myView];
    
    titleArray1 = @[@"我的收藏",@"我的足迹",@"我赞过的"];
    titleArray2 = @[@"清除缓存",@"设置"];
    
    imageArray1 = @[@"收藏.png",@"足迹.png",@"赞.png"];
    imageArray2 = @[@"清除缓存.png",@"设置.png"];

    [_myView.headview.myImageButton addTarget:self action:@selector(changeMyimage) forControlEvents:UIControlEventTouchUpInside];
    [_myView.headview.profileButton addTarget:self action:@selector(editUserMessage) forControlEvents:UIControlEventTouchUpInside];
    [_myView.headview.myworkButton addTarget:self action:@selector(myWork) forControlEvents:UIControlEventTouchUpInside];
    _myView.tableView.delegate = self;
    _myView.tableView.dataSource = self;
    [_myView.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _actionController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *photographAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //拍照
        [self photograph];
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //从相册中选取
        [self selectFromAlbum];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [_actionController addAction:photographAction];
    [_actionController addAction:albumAction];
    [_actionController addAction:cancelAction];
    
    
    //获取用户信息
    [NOVEditUserMessageManager getUserMessageSuccess:^(id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        _userMessage = [[NOVUserMessage alloc] initWithDictionary:responseObject[@"data"] error:nil];
        _userMessage.simpleUserMessage = [[NOVSimpleUseMessage alloc] initWithDictionary:responseObject[@"data"][@"simpleUserMessage"] error:nil];
        _userMessage.userMessage = [[NOVPersonalMessage alloc] initWithDictionary:responseObject[@"data"][@"userMessage"] error:nil];
        if (![_userMessage.userMessage.signText  isEqual: @""]) {
            [self.myView.headview.profileButton setTitle:[NSString stringWithFormat:@"简介:%@",_userMessage.userMessage.signText] forState:UIControlStateNormal];
        }
        self.myView.headview.nameLabel.text = _userMessage.simpleUserMessage.username;
        [self.myView.headview.myImageButton sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",UserImageUrl,_userMessage.userMessage.icon]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"添加账号.png"]];
        //存储个人信息
        [NOVDataModel updateUserMessage:_userMessage];
    } failure:^(NSError * _Nonnull error) {
    }];
}

-(void)changeMyimage{
    NSLog(@"changeMyImage");
    [self presentViewController:_actionController animated:YES completion:nil];
}

-(void)photograph{
    if (!_photoManager) {
        _photoManager = [[NOVSelectPhotoManager alloc] initWithViewController:self];
        _photoManager.deleagte = self;
    }
    [_photoManager selectImageWithCamera];
}

-(void)selectFromAlbum{
    if (!_photoManager) {
        _photoManager = [[NOVSelectPhotoManager alloc] initWithViewController:self];
        _photoManager.deleagte = self;
    }
    [_photoManager selectImageWithAlbum];
}

-(void)changeImageWithImage:(UIImage *)image{
    NSLog(@"=====%@",image);
    [_myView.headview.myImageButton setImage:image forState:UIControlStateNormal];
    [NOVEditUserMessageManager uploadMyImageWithImage:image success:^(id  _Nullable responseObject) {
        NSLog(@"%@",responseObject[@"message"]);
    } failure:^(NSError * _Nonnull error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"相册=%@",dict);
    }];
}

-(void)myWork{
    NOVMystartViewController *myStartViewController = [[NOVMystartViewController alloc] init];
    myStartViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myStartViewController animated:NO];
}

-(void)editUserMessage{
    NOVEditUserMessageViewController *editUserMessageViewController = [[NOVEditUserMessageViewController alloc] init];
    editUserMessageViewController.selfTitle = @"编辑资料";
    editUserMessageViewController.hidesBottomBarWhenPushed = YES;
    editUserMessageViewController.userMessage = _userMessage;
    __block MYViewController *weakSelf = self;
    editUserMessageViewController.userMessageBlock = ^(NOVUserMessage *userMessage) {
        [weakSelf.myView.headview.profileButton setTitle:[NSString stringWithFormat:@"简介:%@",userMessage.userMessage.signText] forState:UIControlStateNormal];
        weakSelf.myView.headview.nameLabel.text = userMessage.simpleUserMessage.username;
    };
    [self.navigationController pushViewController:editUserMessageViewController animated:NO];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    } else if (section == 1){
        return 2;
    }else{
        return 1;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    switch (indexPath.section) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:imageArray1[indexPath.row]];
            cell.textLabel.text = titleArray1[indexPath.row];
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:imageArray2[indexPath.row]];
            cell.textLabel.text = titleArray2[indexPath.row];
            break;
        case 2:
            cell.textLabel.text = @"关于";
            cell.imageView.image = [UIImage imageNamed:@"关于.png"];
            break;
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 1) {
        NOVUserSetViewController *setViewController = [[NOVUserSetViewController alloc] init];
        setViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setViewController animated:NO];
        _userMessage = [NOVDataModel getUserMessage];
        [_myView.headview.profileButton setTitle:[NSString stringWithFormat:@"简介:%@",_userMessage.userMessage.signText] forState:UIControlStateNormal];
    }else if (indexPath.section == 1 && indexPath.row == 0){
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"确认清除缓存" message:@"清除缓存将删除所有阅读记录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertControl addAction:cancelAlert];
        UIAlertAction *sureAlert = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        [alertControl addAction:sureAlert];
        [self presentViewController:alertControl animated:YES completion:nil];
    }else if (indexPath.section == 0 && indexPath.row == 0){//我的收藏
        NOVMyCollectionViewController *myCollectionViewController = [[NOVMyCollectionViewController alloc] init];
        myCollectionViewController.showChapterType = NOVShowChapterTypeCollection;
        myCollectionViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myCollectionViewController animated:NO];
    }else if (indexPath.section == 0 && indexPath.row == 2){
        NOVMyCollectionViewController *myCollectionViewController = [[NOVMyCollectionViewController alloc] init];
        myCollectionViewController.showChapterType = NOVShowChapterTypeLike;
        myCollectionViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myCollectionViewController animated:NO];
    }
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
