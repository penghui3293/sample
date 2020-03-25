//
//  GTNewsViewController.m
//  SampleApp
//
//  Created by penghuizhang on 2020/2/13.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import "GTNewsViewController.h"
#import "GTNormalTableViewCell.h"
#import "GTDeleteCellView.h"
#import "GTMediator.h"
#import "GTListLoader.h"
#import "GTListItem.h"
#import "GTSearchBar.h"
#import "GTScreen.h"
#import "GTCommentManager.h"

@interface GTNewsViewController ()<UITableViewDataSource, UITableViewDelegate, GTNormalTableViewCellDelegate>

@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) NSArray *dataArray;
@property (nonatomic, strong, readwrite) GTListLoader *listLoader;
@property(nonatomic,strong,readwrite)NSString *type;

@end

@implementation GTNewsViewController

#pragma mark - life cycle
- (instancetype)initWithUrlString:(NSString *)type {
    self = [super init];
//    _dataArray = @[].mutableCopy;
    if (self) {
        self.tabBarItem.title = @"新闻";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/page@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/page_selected@2x.png"];
//        for (int i = 0; i < 20; i++) {
//            [_dataArray addObject:@(i)];
//        }
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];

    self.listLoader = [[GTListLoader alloc]init];
    __weak typeof(self) wself = self;
//    [self.listLoader loadListDataWithFinishBlock:^(Boolean success, NSArray<GTListItem *> *_Nonnull dataArray) {
//        __strong typeof(self) strongSelf  = wself;
//        strongSelf.dataArray = dataArray;
//        [strongSelf.tableView reloadData];
//    }];
    [self.listLoader loadListDataWithFinishBlock:^(Boolean success, NSArray<GTListItem *> * _Nonnull dataArray) {
        __strong typeof(self) strongSelf  = wself;
                strongSelf.dataArray = dataArray;
                [strongSelf.tableView reloadData];
    } type:self.type];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self.tabBarController.navigationItem setTitleView:({
        GTSearchBar *searchBar = [[GTSearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - UI(24),  self.navigationController.navigationBar.bounds.size.height)];
        searchBar;
        
//        UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - UI(10),  self.navigationController.navigationBar.bounds.size.height)];
//        button.backgroundColor = [ UIColor lightGrayColor];
//        [ button addTarget:self action:@selector(_showCommentView) forControlEvents:UIControlEventTouchUpInside];
//        button;
    })];
    
}

#pragma mark - UITableViewDelagate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GTListItem *item = [self.dataArray objectAtIndex:indexPath.row];

//    __kindof  UIViewController *detailController =  [GTMediator detailViewControllerWithUrl:item.articleUrl];
//    detailController.title =   item.title;
//
////    [NSString stringWithFormat:@"%@", @(indexPath.row)]
//    detailController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStyleDone target:self action:@selector(popController)];
//    [self.navigationController pushViewController:detailController animated:YES];
//    [GTMediator openUrl:@"detail://" params:@{@"url":item.articleUrl,@"controller":self.navigationController}];
    
    Class cls = [GTMediator classForProtocol:@protocol(GTDetailViewControllerProtocol)];
   __kindof  UIViewController *detailController = [ [ cls alloc] detailViewControllerWithItem:item];
    detailController.title =   item.authorName;
    detailController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStyleDone target:self action:@selector(popController)];
    [self.navigationController pushViewController:detailController animated:YES];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:item.uniqueKey];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GTNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[GTNormalTableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"id"];
        cell.delegate = self;
    }
    [cell layoutTableViewCellWithItem:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton {
    //动画演示
    GTDeleteCellView *deleteView = [[GTDeleteCellView alloc] initWithFrame:self.view.bounds];

    CGRect rect = [tableViewCell convertRect:deleteButton.frame toView:nil];

    __weak typeof(self) wself = self;
    [deleteView showDeleteViewFromPoint:rect.origin clickBlock:^{
        __strong typeof(wself) strongSelf  = wself;
        NSIndexPath *delIndexPath = [strongSelf.tableView indexPathForCell:tableViewCell];

        if (strongSelf.dataArray.count > delIndexPath.row) {
            //删除数据
            NSMutableArray *dataArrayTmp = [strongSelf.dataArray  mutableCopy];
            [dataArrayTmp removeObjectAtIndex:delIndexPath.row];
            strongSelf.dataArray = [dataArrayTmp copy];
            //删除cell
            [strongSelf.tableView deleteRowsAtIndexPaths:@[delIndexPath] withRowAnimation:(UITableViewRowAnimationFade)];
        }
    }];
}

- (void)popController {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
