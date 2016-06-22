//
//  ReadViewController.m
//  LeiSure
//
//  Created by lanou on 16/6/13.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "ReadViewController.h"
#import "ReadListModel.h"
#import "CycleScrollView.h"
#import "CollectionViewCellFactory.h"
#import "ReadListTableViewController.h"
#import "Carousel.h"
@interface ReadViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *readTypeCollection;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, weak) CycleScrollView *cycleScrollView;

@property (nonatomic, strong) NSMutableArray *urlArray;

@end

@implementation ReadViewController


- (IBAction)openDrawer:(id)sender {
    //获取控制器
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    //打开
    [delegate openDrawer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self getData];
    [self createSubViews];
    
    
    //如果控制器存在导航栏 系统会将第一个被添加上的子视图往下偏移64
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [@[] mutableCopy];
    }
    return _dataArray;
}

//请求数据
- (void)getData {
    [ASRequestTool requestWithType:GET URLString:kReadListURL Parameter:nil callBack:^(NSData *data, NSError *error) {
        //JSon解析
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        NSDictionary *dictionary = jsonDic[@"data"];
        
        for (NSDictionary *dic in dictionary[@"list"]) {
            ReadListModel *readList = [[ReadListModel alloc] init];
            [readList setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:readList];
        }
        self.urlArray = @[].mutableCopy;
        for (NSDictionary *dic in dictionary[@"carousel"]) {
            [self.urlArray addObject:dic[@"img"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.readTypeCollection reloadData];
//            [self createScrollView];
            [self createCarouselView:self.urlArray];
        });
    }];
}

- (void)createCarouselView:(NSArray *)imageURLS {
    
    Carousel *carouselView = [[Carousel alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - kScreenWidth - 64) ImageURLS:self.urlArray];
    carouselView.imageClickBlock = ^(NSInteger index) {
        NSLog(@"%ld", index);
    };
    
    [self.view addSubview:carouselView];
}

//创建子视图
- (void)createSubViews {
    //创建集合视图
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //最小行间距
    layout.minimumLineSpacing = 5;
    //item大小
    layout.itemSize = CGSizeMake((kScreenWidth - 10) / 3, (kScreenWidth - 10) / 3);
    //最小item间距
    layout.minimumInteritemSpacing = 5;
    
    self.readTypeCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0,kScreenHeight -  kScreenWidth, kScreenWidth, kScreenWidth) collectionViewLayout:layout];
    
    [self.view addSubview:self.readTypeCollection];
    self.readTypeCollection.delegate = self;
    self.readTypeCollection.dataSource = self;
    
    //从xib注册cell
    [self.readTypeCollection registerNib:[UINib nibWithNibName:@"ReadTypeCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"readType"];
    
   
}

- (void)createScrollView{
    //创建轮播图
    CycleScrollView *cycleScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - kScreenWidth - 64) animationDuration:2.0];
    self.cycleScrollView = cycleScrollView;
    [self.view addSubview:self.cycleScrollView];
    
    NSMutableArray *views = @[].mutableCopy;
    for (int i = 0; i < self.urlArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.cycleScrollView.bounds];
        imageView.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:arc4random() % 256 / 255.0];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.urlArray[i]]];
        [views addObject:imageView];
    }
    self.cycleScrollView.totalPagesCount = views.count;
    self.cycleScrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex) {
        return views[pageIndex];
    };
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //从工厂中获取cell
    BaseCollectionViewCell *cell = [CollectionViewCellFactory CellWithCollectionView:collectionView Identifier:@"readType" IndexPath:indexPath];
    
    //调用赋值方法
    [cell setContentWithModel:self.dataArray[indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //取出对应model
    ReadListModel *model = self.dataArray[indexPath.row];
    
    //从storyboard中取出控制器
    ReadListTableViewController *readlistTableVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"readList"];
    //push到listVC
    readlistTableVC.TypeId = model.type;
    
    [self.navigationController pushViewController:readlistTableVC animated:YES];
    
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
