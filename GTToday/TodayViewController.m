//
//  TodayViewController.m
//  GTToday
//
//  Created by penghuizhang on 2020/3/6.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <TencentOpenAPI/QQApiInterface.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:({
        UIButton *buttton = [[UIButton alloc] initWithFrame:CGRectMake(100, 0, 200, 100)];
        [buttton setTitle:@"点击跳转" forState:UIControlStateNormal];
        [buttton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [buttton addTarget:self action:@selector(_openSampleApp) forControlEvents:UIControlEventTouchUpInside];
        buttton;
    })];
    
    NSUserDefaults *userDefault =  [[NSUserDefaults alloc] initWithSuiteName:@"group.com.penghuizhang.sample"];
    [userDefault objectForKey:@"title"];
    NSLog(@"");
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {

    completionHandler(NCUpdateResultNewData);
}

#pragma mark -

- (void)_openSampleApp{
    [self.extensionContext openURL:[NSURL URLWithString:@"GTTest://"] completionHandler:^(BOOL success) {
        
    }];
}

@end
