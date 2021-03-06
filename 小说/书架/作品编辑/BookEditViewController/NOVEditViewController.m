//
//  NOVEditViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/5/10.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVEditViewController.h"
#import "NOVEditView.h"
#import "NOVEditViewTableViewCell.h"
#import "NOVDetailViewController.h"
#import "NOVStartBookModel.h"
#import "NOVSelectPhotoManager.h"
#import "NOVSummaryViewController.h"

@interface NOVEditViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,NOVSelectPhotoManagerDeleagte>
@property(nonatomic,strong) NOVEditView *editView;
@property(nonatomic,strong) NOVSelectPhotoManager *photoManager;
@end

@implementation NOVEditViewController{
    NSArray *cellTitleArray;
    
    UIAlertController *actionController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithDisplayP3Red:0.15 green:0.65 blue:0.6 alpha:1.00];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 130, 30)];
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftButton setImage:[UIImage imageNamed:@"返回white.png"] forState:UIControlStateNormal];
    [leftview addSubview:leftButton];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 100, 30)];
    label.text = @"填写作品信息";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    [leftview addSubview:label];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftview];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishEdit)];
    
    _editView = [[NOVEditView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_editView];
    _editView.tableView.delegate = self;
    _editView.tableView.dataSource = self;
    _editView.novelNameTextfeild.delegate = self;
    _startModel = [[NOVStartBookModel alloc] init];
    
    [_editView.tableView registerClass:[NOVEditViewTableViewCell class] forCellReuseIdentifier:@"cell"];
    cellTitleArray = @[@"作品简介",@"发起形式",@"作品类型",@"指定续写人员",@"指定观看人群"];
    [_editView.changeImageTap addTarget:self action:@selector(changeImage)];
    
    
    actionController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
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
    [actionController addAction:photographAction];
    [actionController addAction:albumAction];
    [actionController addAction:cancelAction];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

-(void)changeImage{
    NSLog(@"changeImage");
    [self presentViewController:actionController animated:YES completion:nil];
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
    [_editView.novelImage setImage:image];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)finishEdit{
    if ([_editView.novelNameTextfeild.text  isEqual: @""]) {
        [self addAlertActionWithTitle:@"作品名称不能为空"];
        return;
    }
    _startModel.name = _editView.novelNameTextfeild.text;//作品名称
    _startModel.bookImage = _editView.novelImage.image;
    for (int i = 1; i <= 4; i++) {
        NOVEditViewTableViewCell *cell = [_editView.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        //cell.enumNumber == -1 表示该条信息未编辑
        if (cell.enumNumber == -1) {
            [self addAlertActionWithTitle:@"请完善作品信息"];
            return;
        }
        switch (i) {
            case 1:
                _startModel.startType = cell.enumNumber;
                break;
            case 2:
                _startModel.bookType = cell.enumNumber;
                break;
            case 3:
                _startModel.renewPeople = cell.enumNumber;
                break;
            case 4:
                _startModel.viewerType = cell.enumNumber;
                break;
            default:
                break;
        }
    }
    self.novelTitleBlock(_startModel);
    [self.navigationController popViewControllerAnimated:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    NOVEditViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.textLabel.text = cellTitleArray[indexPath.row];
    if (indexPath.row == 0) {
        cell.leftLabel.text = @"请填写";
    } else {
        cell.leftLabel.text = @"请选择 >";
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _editView.frame.size.height*0.06;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_editView.novelNameTextfeild resignFirstResponder];
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NOVDetailViewController *detailViewcontroller = [[NOVDetailViewController alloc] init];
    NOVEditViewTableViewCell *cell = (NOVEditViewTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    detailViewcontroller.viewtitle = cell.textLabel.text;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        //编辑简介
        NOVSummaryViewController *summaryController = [[NOVSummaryViewController alloc] init];
        __block NOVEditViewController *weakSelf = self;
        summaryController.summaryblock = ^(NSString *summaryString) {
            NSLog(@"%@",summaryString); //书的简介
            if (summaryString != NULL) {
                weakSelf.startModel.introduction = summaryString;
                cell.leftLabel.text = @"已填写";
                cell.enumNumber = 1;
            }
        };
        [self.navigationController pushViewController:summaryController animated:NO];
        return;
    }else if (indexPath.row == 1) {
        detailViewcontroller.viewtype = startType;  //编辑发起类型
    }else if (indexPath.row == 2) {
        detailViewcontroller.viewtype = viewNovelType;  //编辑作品类型
    }else if (indexPath.row == 3){
        detailViewcontroller.viewtype = renewPeople; //续写权限
    }else if(indexPath.row == 4){
        detailViewcontroller.viewtype = viewerType; //观看权限
    }
    detailViewcontroller.viewtitleBlock = ^(NSString *viewtitle,NSInteger enumNumber) {
        NSLog(@"%@",viewtitle);
        if (viewtitle) {
            cell.leftLabel.text = [NSString stringWithFormat:@"%@",viewtitle];
            cell.enumNumber = enumNumber;
        }
    };
    [self.navigationController pushViewController:detailViewcontroller animated:NO];
}

- (void)addAlertActionWithTitle:(NSString *)title{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *messageAlert = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:nil];
    [alertControl addAction:messageAlert];
    UIAlertAction *alert = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
    [alertControl addAction:alert];
    [self presentViewController:alertControl animated:YES completion:nil];
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
