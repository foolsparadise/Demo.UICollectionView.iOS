//
//  DemoCollectionView.m
//  
//
//  Created by foolsparadise on 22/3/2019.
//  Copyright © 2019 github.com/foolsparadise All rights reserved.
//

#import "DemoCollectionView.h"
#define DEFAULT_ApP_FONT @"helvetica"
#define DeMO_FONT(fontSize) [UIFont fontWithName:DEFAULT_ApP_FONT size:(fontSize)]

@implementation DemoCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        self.title.textColor = [UIColor blackColor];
        self.title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.title];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        //[self.button setTitle:NSLocalizedStringFromTable(@"取消",@"InfoPlist",nil) forState:UIControlStateNormal];
        NSString *resourePath = [[NSBundle mainBundle] resourcePath];
        UIImage *image = [UIImage imageWithContentsOfFile:[resourePath stringByAppendingPathComponent:@"check_close"]];
        [self.button setBackgroundImage:image forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.button.titleLabel setFont:DeMO_FONT(22)];
        self.button.titleLabel.textColor = [UIColor blueColor];
        //[self.button sizeToFit];
        [self.button addTarget:self action:@selector(cancelSelect) forControlEvents:UIControlEventTouchUpInside];
        self.button.frame = CGRectMake(10, 10, 30, 30);
        [self addSubview:self.button];
        
    }
    return self;
}

@end

@implementation DemoCollectionView

#pragma mark --Initializers
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewFlowLayout *)flowLayout {
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        //不要忘记初始化；
        self.collectionArray = [[NSMutableArray alloc] initWithCapacity:9999];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        self.collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        [self.collectionView registerClass:[DemoCollectionViewCell class] forCellWithReuseIdentifier:@"DemoCollectionViewCell"];
        
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.collectionView];
        
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        [self.collectionView registerClass:[DemoCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
        
        
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DemoCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"DemoCollectionViewCell" forIndexPath:indexPath];
//    cell.imageView.image = image;
//    cell.descLabel.text = [NSString stringWithFormat:@"%@", obj.objname];
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
    
    //    NSString *message = [[NSString alloc] initWithFormat:@"你点击了第%ld个section，第%ld个cell",(long)indexPath.section,(long)indexPath.row];
    //    NSLog(@"%@", message);

    [self.mydelegate DemoCollectionViewDelegate:(long)indexPath.section withCell:(long)indexPath.row];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //    return CGSizeMake((SCREEN_WIDTH - 80) / 3, (SCREEN_WIDTH - 80) / 3 + 20);
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

@end



@implementation DemoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        //        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - 80) / 3, (SCREEN_WIDTH - 80) / 3)];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-100)*0.5, 25, 100, 100)];
        [self.imageView setUserInteractionEnabled:true];
        [self addSubview:self.imageView];
        self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, self.frame.size.width, 50)];
        self.descLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.descLabel];
        
//        [self.selectImageView makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.right).offset(@(-1));
//            make.bottom.equalTo(self.bottom).offset(@(-1));
//            make.size.equalTo(CGSizeMake(22, 22));
//        }];
//
        
        
    }
    return self;
}

@end
