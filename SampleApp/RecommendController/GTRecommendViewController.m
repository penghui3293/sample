//
//  GTRecommendViewController.m
//  SampleApp
//
//  Created by penghuizhang on 2020/2/14.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import "GTRecommendViewController.h"
#import "RNSHandler.h"

@interface GTRecommendViewController ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong, readwrite) RNSHandler *handler;

@end

@implementation GTRecommendViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"推荐";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/like@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/like_selected@2x.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 5, self.view.bounds.size.height);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    _handler = [[RNSHandler alloc]initWithScrollView:scrollView
                          externalScrollViewDelegate:self
                                     scrollWorkRange:200.f
                       componentViewStateChangeBlock:^(RNSComponentViewState state,
                                                       NSObject<RNSModelProtocol> *componentItem, __kindof UIView *componentView) {
        NSLog(@"");
        // 复用回收View状态变化处理
        // 进入准备区 & 进入展示 & 离开展示 & 离开准备区
    }];

//    NSArray *colorArray  = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor],[UIColor lightGrayColor],[UIColor grayColor]];
//    NSArray *typeArray = [NSArray arrayWithObjects:@"keji",@"yule",@"shishang", nil];
//    for (int i=0; i<[typeArray count]; i++) {
//        [scrollView addSubview:({
//
//           UIView *view = [[UITableView alloc] initWithFrame:CGRectMake(scrollView.bounds.size.width*i, 0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
//            view.backgroundColor = [colorArray objectAtIndex:i];
//            view;
//        })];
//    }
    [self.view addSubview:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll - %@", @(scrollView.contentOffset.x));
}

//- (void)viewClick{
//
//    NSURL *urlScheme = [NSURL URLWithString:@"testScheme://"];
//    BOOL canOpenURL =  [[UIApplication sharedApplication] canOpenURL:urlScheme];
//
//   [ [UIApplication sharedApplication] openURL:urlScheme options:nil completionHandler:^(BOOL success) {
//        NSLog(@"");
//   }];
//}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

@end
