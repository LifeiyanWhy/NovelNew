# Novel
## 阅读器
### 内容分页
首先获取本章节的数据，对获取到的内容进行分页<br>
具体的分页方法：
```
 content: 要进行分页的文字
 bound: 文字要布局的区域
-(void)pagingWithContent:(NSString *)content bounds:(CGRect)bounds{
    if (!content) {
        return;
    }
    [_pageArray removeAllObjects];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString  alloc] initWithString:content];
    //获取字体设置
    NSDictionary *attribute = [NOVReadParser parserAttribute:[NOVReadConfig shareInstance]];
    //设置文本属性
    [attrString setAttributes:attribute range:NSMakeRange(0, attrString.length)];
    //根据文本属性配置CTFramesetterRef
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) attrString);
    //设置坐标位置
    CGPathRef path = CGPathCreateWithRect(bounds, NULL);
    int currentOffset = 0;
    int currentInnerOffset = 0;
    BOOL hasMorePages = YES;
    // 防止死循环，如果在同一个位置获取CTFrame超过2次，则跳出循环
    int preventDeadLoopSign = currentOffset;
    int samePlaceRepeatCount = 0;
    while (hasMorePages) {
        if (preventDeadLoopSign == currentOffset) {
            ++samePlaceRepeatCount;
        } else {
            samePlaceRepeatCount = 0;
        }
        if (samePlaceRepeatCount > 1) {
            // 退出循环前检查一下最后一页是否已经加上
            if (_pageArray.count == 0) {//如果是第一页
                [_pageArray addObject:@(currentOffset)];
            }
            else {
                NSUInteger lastOffset = [[_pageArray lastObject] integerValue];
                if (lastOffset != currentOffset) {    //没有显示到文本尾，当前位置是最后一页
                    [_pageArray addObject:@(currentOffset)];    //添加最后一页
                }
            }
            break;
        }
        [_pageArray addObject:@(currentOffset)];
        //
        CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(currentInnerOffset, 0), path, NULL);
        //返回实际适合于CTFrameRef字符长度
        CFRange range = CTFrameGetVisibleStringRange(frame);
        if ((range.location + range.length) != attrString.length) {
            currentOffset += range.length;
            currentInnerOffset += range.length;
            
        } else {
            // 已经分完，提示跳出循环
            hasMorePages = NO;
        }
        if (frame) CFRelease(frame);
    }
    
    CGPathRelease(path);
    CFRelease(frameSetter);
    _pageCount = _pageArray.count;
}

```
注：使用CoreText进行分页，用一个数组存储分页情况，数组下标对应相应的页码，元素存放把该页要显示到的位置（那么第五页要显示的数据就是从array[4] - array[5] 的文字）

```
//从 currentInnerOffset 位置开始，在path区域上布局文字
CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(currentInnerOffset, 0), path, NULL);
//返回实际适合于CTFrameRef字符长度
CFRange range = CTFrameGetVisibleStringRange(frame);
```

### UIPageViewController
UIPageViewController 支持翻页效果<br>
UIPageViewController 的两个代理：
```
@property (nullable, nonatomic, weak) id <UIPageViewControllerDelegate> delegate;
@property (nullable, nonatomic, weak) id <UIPageViewControllerDataSource> dataSource; 
```
实现 UIPageViewController 的delegate, dataSource
##### 向前翻页时执行
```
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    if (currentPage == -1) {
        NSLog(@"未获取到作品信息");
        return nil;
    }
    if (currentPage == 0) {//最前面一页
        return nil;
    }
    self.readEndView.hidden = YES;
    _pageChangeType = NOVPageChangeTypeBefore;
    //根据该章节的数据、当前的页码获取翻页后要显示的controller
    return [self readViewControllerWithChapter:_recordModel.chapterModel position:currentPage - 1];
}
```
##### 向后翻页时执行
```
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
    //根据该章节的数据、当前的页码获取翻页后要显示的controller
    return [self readViewControllerWithChapter:_recordModel.chapterModel position:currentPage + 1];
}
```
##### 翻页后获取controller的方法

```
-(NOVReadPageViewController *)readViewControllerWithChapter:(NOVChapterModel *)chapter position:(NSInteger)position{
    _readViewController = [[NOVReadPageViewController alloc] init];
    _readViewController.content = [_recordModel stringWithPage:position];//根据页码取出翻页后显示的片段（已经分好页）
    _readViewController.chapterModel = _recordModel.chapterModel;
    return _readViewController;
}
```

##### 具体的显示

```
-(NOVReadNovelView *)readNovelView{
    if (!_readNovelView) {
        _readNovelView = [[NOVReadNovelView alloc] initWithFrame:CGRectMake(20, 60, self.view.frame.size.width-40, self.view.frame.size.height - 120)];
        _readNovelView.backgroundColor = [UIColor clearColor];
        NOVReadConfig *config = [NOVReadConfig shareInstance];
        //根据文字，文字配置生成一个 CTFrameRef 对象
        _readNovelView.frameRef = [NOVReadParser loadParserWithContent:_content config:config bounds:CGRectMake(0,0, _readNovelView.frame.size.width, _readNovelView.frame.size.height)];
        _readNovelView.content = _content;
    }
    return _readNovelView;
}
```
#####  CTFrameRef的生成

```
+(CTFrameRef)loadParserWithContent:(NSString *)content config:(NOVReadConfig *)config bounds:(CGRect)bounds{
    if (!content) {
        return NULL;
    }
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:content];
    //设置文本内容，属性
    [attString addAttributes:[self parserAttribute:config] range:NSMakeRange(0, content.length)];
    //根据文本以及文本属性配置CTFramesetterRef
    CTFramesetterRef setterRef = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attString);
    //绘制区域
    CGPathRef pathRef = CGPathCreateWithRect(bounds, NULL);
    //
    CTFrameRef frameRef = CTFramesetterCreateFrame(setterRef, CFRangeMake(0, 0), pathRef, NULL);
    CFRelease(setterRef);
    CFRelease(pathRef);//ARC环境下编译器不会自动管理CF对象的内存，需要手动释放
    return frameRef;
}
```

##### 在drawRect方法中将 CTFrameRef 通过 CTFrameDraw  绘制到 view 上

```
- (void)drawRect:(CGRect)rect{
    if (!_frameRef) {
        return;
    }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
    CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    CTFrameDraw(_frameRef, ctx);
}
```


##### 翻页动画执行完后执行

```
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
        [self setEndView];  //显示 获取下一章、续写等 入口的view
    }
}
```
