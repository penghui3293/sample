//
//  GTVideoViewController.m
//  SampleApp
//
//  Created by penghuizhang on 2020/2/13.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import "GTVideoViewController.h"
#import "GTVideoCoverView.h"
#import "GTVideoToolbar.h"

@interface GTVideoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation GTVideoViewController

- (instancetype) init{
    self  = [super init];
    if (self) {
        self.tabBarItem.title = @"视频";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/video@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/video_selected@2x.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.minimumLineSpacing = 0;
//    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width/16*9 + GTVideoToolbarHeight);
    
    UICollectionView *collectionView =[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:[GTVideoCoverView class] forCellWithReuseIdentifier:@"GTVideoCoverView"];
    
    [self.view addSubview:collectionView];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GTVideoCoverView" forIndexPath:indexPath];
    if ([cell isKindOfClass:[GTVideoCoverView class]]) {
        [ (GTVideoCoverView *)cell layoutWithVideoCoverUrl:@"icon.bundle/videoCover@3x.jpeg" videoUrl:@"http://vfx.mtime.cn/Video/2019/03/09/mp4/190309153658147087.mp4"];
//        http://220.249.115.46:18080/wav/Lovey_Dovey.mp4
    }
    return cell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.item % 3 ==0) {
//        return CGSizeMake(self.view.bounds.size.width, 100);
//    }else{
//        return CGSizeMake((self.view.bounds.size.width - 10)/2, 300);
//    }
//}

@end
