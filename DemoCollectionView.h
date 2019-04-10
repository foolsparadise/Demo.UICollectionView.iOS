//
//  DemoCollectionView.h
//  
//
//  Created by foolsparadise on 22/3/2019.
//  Copyright © 2019 github.com/foolsparadise All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DemoCollectionViewDelegate <NSObject>
- (void)DemoCollectionViewDelegate:(NSInteger)sectionIndex withCell:(NSInteger)cellIndex;
@end

@interface DemoCollectionReusableView : UICollectionReusableView
@property(strong,nonatomic)UILabel *    title;
@property(strong,nonatomic)UIButton *   button;
@end

// cell default size 200x200 , only test in iPhone
@interface DemoCollectionView : UICollectionView <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(strong,nonatomic) UICollectionView *  collectionView;
@property(strong,nonatomic) NSMutableArray *    collectionArray;
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewFlowLayout *)flowLayout;
@property (nonatomic, weak) id <DemoCollectionViewDelegate> mydelegate;
@end

@interface DemoCollectionViewCell : UICollectionViewCell { }
@property(strong,nonatomic) UIImageView *   imageView;
@property(strong,nonatomic) UILabel *       descLabel;
@end
