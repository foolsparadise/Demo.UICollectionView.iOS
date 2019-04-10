//
//  DemoViewController
//  
//
//  Created by foolsparadise on 22/3/2019.
//  Copyright © 2019 github.com/foolsparadise All rights reserved.
//

#import "DemoViewController.h"
#import "DemoCollectionView.h"
#import "XLPlainFlowLayout.h"

@interface DemoViewController ()<DemoCollectionViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *collectionArray;
@property (nonatomic, strong) NSArray *textItems;
@property (nonatomic, strong) NSArray *iconItems;
@end

@implementation DemoViewController
- (void)dealloc
{
    if(_collectionView) {
        [_collectionView removeFromSuperview];
        _collectionView = nil;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];

    __weak typeof(self) weakSelf = self;
    [self.headView setTitle:@"VC Title"];
    self.headView.isShowBottomLine = YES;
    self.headView.delegate = self;
    

    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.contentView addSubview:weakSelf.collectionView];
        weakSelf.collectionArray = [weakSelf.iconItems copy];
        weakSelf.collectionView.hidden = NO;
        UIEdgeInsets padding = UIEdgeInsetsMake(1, 1, 1, 1);
        [weakSelf.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.contentView).with.insets(padding);
        }];
    });


}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        CGFloat allFlowWidth = ([UIScreen mainScreen].bounds.size.width -3)/4;
        CGFloat itemSpacing = 1;
        CGFloat lineSpacing = 1;
        XLPlainFlowLayout *allFlowLayout = [XLPlainFlowLayout new];
        allFlowLayout.itemSize = CGSizeMake(allFlowWidth, allFlowWidth);
        allFlowLayout.minimumInteritemSpacing = itemSpacing;
        allFlowLayout.minimumLineSpacing = lineSpacing;
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH) collectionViewLayout:allFlowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;

        [self.collectionView registerClass:[DemoCollectionViewCell class] forCellWithReuseIdentifier:@"DemoCollectionViewCell"];
        [self.collectionView registerClass:[DemoCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
        
#if iOS10_OR_LATER //iOS 10 禁用这个属性,否则会崩溃
        NSLog(@"%d %f", __IPHONE_OS_VERSION_MAX_ALLOWED, IOS_VERSION);
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
            _collectionView.prefetchingEnabled = NO;
#endif

        
    }
    return _collectionView;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DemoCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"DemoCollectionViewCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.iconItems[indexPath.row]];
    cell.descLabel.text = self.textItems[indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusable = nil;
    return reusable;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    [self DemoCollectionViewDelegate:(long)indexPath.section withCell:(long)indexPath.row];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //    return CGSizeMake((SCREEN_WIDTH - 80) / 3, (SCREEN_WIDTH - 80) / 3 + 20);
    if((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad))
        return CGSizeMake((SCREEN_WIDTH - 80) / 3, (SCREEN_WIDTH - 80) / 3);
    else
        return CGSizeMake(200, 200);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //    return UIEdgeInsetsMake(20, 20, 10, 20);
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    //    //return CGSizeMake(300, 20);
    //    if (section == 0 || section == 2) {
    //        return CGSizeMake(self.frame.size.width, 50);
    //    }
    //    else
    {
        return CGSizeMake(0, 0);
    }
}

- (NSArray *)textItems
{
    if (!_textItems) {
        _textItems = @[@"我的名字1",@"我的名字2",@"我的名字3"
                       ];
    }
    return _textItems;
}
- (NSArray *)iconItems
{
    if (!_iconItems) {
        _iconItems = @[@"tupian1.png",@"tupian2.png",@"tupian3.png"
                       ];
    }
    return _iconItems;
}
- (void)DemoCollectionViewDelegate:(NSInteger)sectionIndex withCell:(NSInteger)cellIndex
{
   NSString *message = [[NSString alloc] initWithFormat:@"点第%ld个section第%ld个cell",(long)sectionIndex,(long)cellIndex];
   NSLog(@"%@", message);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
