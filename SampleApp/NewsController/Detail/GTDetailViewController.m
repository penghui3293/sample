//
//  GTDetailViewController.m
//  SampleApp
//
//  Created by penghuizhang on 2020/3/20.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import "GTDetailViewController.h"
#import <WebKit/WebKit.h>
#import "GTScreen.h"
#import "GTMediator.h"
#import "GTLogin.h"
#import "GTListItem.h"
#import "GTCommentManager.h"

@interface GTDetailViewController ()<WKNavigationDelegate>
@property (nonatomic, strong, readwrite) WKWebView *webView;
@property (nonatomic, strong, readwrite) UIProgressView *progressView;
@property (nonatomic,strong,readwrite) UIImageView *bottomView;
@property (nonatomic,strong,readwrite) UITextField *textField;
@property (nonatomic, copy, readwrite) GTListItem *item;
@end

@implementation GTDetailViewController

+ (void)load {
//    [GTMediator registerScheme:@"detail://" processBlock:^(NSDictionary * _Nonnull params) {
//        GTListItem *item = (GTListItem *)[params objectForKey:@"item"];
//        UINavigationController *navigationController = (UINavigationController *)[params objectForKey:@"controller"];
//        GTDetailViewController *controller = [[GTDetailViewController alloc] initWithItem:item];
//        [navigationController pushViewController:controller animated:YES];
//    }];
    
    [GTMediator  registerProtocol:@protocol(GTDetailViewControllerProtocol) class:self.class];
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (instancetype)initWithItem:(GTListItem *)item{
    self = [super init];
    if (self) {
        self.item = item;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(_shareArticle)];

    [self.view addSubview:({
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, STATUSBARHEIGHT + 44, self.view.frame.size.width, self.view.frame.size.height - STATUSBARHEIGHT - 44)];
        self.webView.navigationDelegate = self;
        self.webView;
    })];

    [self.view addSubview:({
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, STATUSBARHEIGHT + 44, self.view.frame.size.width, 20)];
        self.progressView;
    })];
    
    [self.view addSubview:({
        self.bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT -50, self.view.frame.size.width, 50)];
        self.bottomView.backgroundColor = [UIColor whiteColor];
        self.bottomView;
    })];
    
    [self.view addSubview:({
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 45, self.view.frame.size.width/2, 40)];
        _textField.backgroundColor = [UIColor lightGrayColor];
        _textField.layer.cornerRadius = 20;
        _textField.placeholder = @"写评论...";
        _textField;
    })];

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.item.articleUrl]]];

    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_showCommentView)];
    [_textField  addGestureRecognizer:tapGesture];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    //Webview加载完成
    //此时并不代表整个Web页面已经渲染结束
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context {
    //加载进度条
    self.progressView.progress = self.webView.estimatedProgress;
}

#pragma mark -

- (__kindof UIViewController *)detailViewControllerWithItem:(GTListItem *)item{
    return [[[self class] alloc] initWithItem:item];
}

#pragma mark -

- (void)_shareArticle{
    [[GTLogin sharedLogin] shareToQQWithListItem:_item];
}

#pragma mark -

-(void) _showCommentView{
    [[GTCommentManager shareManager] showCommentView];
}



@end
