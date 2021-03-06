//
//  NOVWriteViewController.m
//  小说
//
//  Created by 李飞艳 on 2018/4/22.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVWriteViewController.h"
#import "NOVWriteView.h"
#import "NOVSetUpView.h"
#import "NOVKeyboardView.h"
#import "NOVSummaryViewController.h"
#import "NOVStartBookModel.h"

@interface NOVWriteViewController ()<NOVWriteViewDelegate,UIScrollViewDelegate,NOVSetUpViewDelegate>
@property(nonatomic,strong) NOVWriteView *writeView;
@property(nonatomic,copy) NSString *summaryString;
@end

@implementation NOVWriteViewController{
    UIButton *leftButton;
    UILabel *label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 90, 30)];
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 30, 30);
    [leftButton setImage:[UIImage imageNamed:@"返回read.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:leftButton];
    label = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 100, 30)];
    label.text = @"0字";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:15];
    [leftView addSubview:label];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    UIBarButtonItem *tempBar = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    tempBar.width = -10;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:tempBar,leftBar,nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor blackColor]];
    self.navigationController.navigationBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.navigationController.navigationBar.layer.shadowOpacity = 0.8f;
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(-2, 2);
    self.navigationController.navigationBar.layer.masksToBounds = NO;

    [self.view addSubview:self.writeView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
}

-(NOVWriteView *)writeView{
    if (!_writeView) {
        _writeView = [[NOVWriteView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.bounds.size.height)];
        [_writeView.setupButton addTarget:self action:@selector(setupView) forControlEvents:UIControlEventTouchUpInside];
        _writeView.scrollView.delegate = self;
        _writeView.delagate = self;
        _writeView.setUpView.delegate = self;
        [_writeView.keyboardView.hiddenKeyboard addTarget:self action:@selector(cancelKeyboard) forControlEvents:UIControlEventTouchUpInside];
        [_writeView.summaryButton addTarget:self action:@selector(editSummary) forControlEvents:UIControlEventTouchUpInside];
        if (self.bookModel.bookId != -1) {
            NSLog(@"%@",_bookModel.firstTitle);
            _writeView.titleTextView.text = _bookModel.firstTitle;
            _writeView.titleTextView.textColor = [UIColor blackColor];
            _writeView.contentTextView.text = _bookModel.firstContent;
            _writeView.contentTextView.textColor = [UIColor blackColor];
            [_writeView.summaryButton setTitle:@"章节简介" forState:UIControlStateNormal];
            label.text = [NSString stringWithFormat:@"%lu字",(unsigned long)_writeView.contentTextView.text.length];
        }
    }
    return _writeView;
}

-(NOVStartBookModel *)bookModel{
    if (!_bookModel) {
        _bookModel = [[NOVStartBookModel alloc] init];
    }
    return _bookModel;
}

- (void)keyboardShow:(NSNotification *)notification{
    [_writeView keyboardShowWithFrame:[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue]];
}

- (void)keyboardHidden:(NSNotification *)notification{
    [_writeView keyBoardHidden];
}

-(void)cancelKeyboard{
    [_writeView.titleTextView resignFirstResponder];
    [_writeView.contentTextView resignFirstResponder];
}

//点击setupButton时执行
- (void)setupView{
    //显示设置背景颜色及亮度的view
    [_writeView setupView];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_writeView responseWhenTouchView];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

//输入正文时执行
- (void)contentTextViewChange:(NSUInteger)numberOfWords withContent:(NSString *)content{
    NSString *number = [NSString stringWithFormat:@"%lu字",(unsigned long)numberOfWords];
    label.text = number;
}


//点击rightBarButtonItem（发布）button执行
- (void)save{
    NSLog(@"%@",_summaryString);
    if ([_writeView.contentTextView.text isEqualToString:@""] || [_writeView.contentTextView.text isEqualToString:@"请输入正文"]) {
        [self showAlertActionWithTitle:@"内容不能为空!"];
        return;
    }else if ([_writeView.titleTextView.text  isEqualToString:@""] || [_writeView.titleTextView.text isEqualToString:@"请输入章节名称"]){
        [self showAlertActionWithTitle:@"章节名称不能为空!"];
        return;
    }
    if (_summaryString == NULL) {
        [self showAlertActionWithTitle:@"请添加章节简介!"];
        return;
    }
    [self showAlertPublishOrSave];
}

-(void)showAlertPublishOrSave{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"是否直接发布" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertSave = [UIAlertAction actionWithTitle:@"存为草稿" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.publishNovelBlock(_writeView.titleTextView.text, _summaryString, _writeView.contentTextView.text, NO);
        [self.navigationController popViewControllerAnimated:NO];
    }];
    [alertControl addAction:alertSave];
    UIAlertAction *alertPublish = [UIAlertAction actionWithTitle:@"直接发布" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.publishNovelBlock(_writeView.titleTextView.text, _summaryString,_writeView.contentTextView.text,YES);
        [self.navigationController popViewControllerAnimated:NO];
    }];
    [alertControl addAction:alertPublish];
    [self presentViewController:alertControl animated:YES completion:nil];
}

-(void)editSummary{
    NOVSummaryViewController *summaryController = [[NOVSummaryViewController alloc] init];
    __block NOVWriteViewController *weakSelf = self;
    summaryController.summaryEdit = NOVSummaryEditSummary;
    if (_bookModel.bookId != -1) {
        NSLog(@"===%@",_bookModel.firstSummary);
        summaryController.summary = _bookModel.firstSummary;
    }
    summaryController.summaryblock = ^(NSString *summaryString) {
        NSLog(@"%@",summaryString);
        weakSelf.summaryString = summaryString;
        [weakSelf.writeView.summaryButton setTitle:@"章节简介" forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:summaryController animated:NO];
}

//点击颜色button（setupview的代理方法）
-(void)touchColorButton:(UIButton *)button color:(UIColor *)color{
    [_writeView setViewColorWithColor:color];
}

- (void)showAlertActionWithTitle:(NSString *)title{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
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
