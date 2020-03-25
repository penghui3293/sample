//
//  GTVideoCoverView.m
//  SampleApp
//
//  Created by penghuizhang on 2020/2/22.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import "GTVideoCoverView.h"
#import "GTVideoPlayer.h"
#import "GTVideoToolbar.h"

@interface GTVideoCoverView ()

@property (nonatomic, strong, readwrite) UIImageView *coverView;
@property (nonatomic, strong, readwrite) UIImageView *playButton;
@property (nonatomic, strong, readwrite) NSString *videoUrl;

@property (nonatomic, strong, readwrite) IBOutlet UISlider *progressView;
@property(nonatomic,strong,readwrite)GTVideoToolbar *videoToobar;

@end

@implementation GTVideoCoverView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _coverView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - GTVideoToolbarHeight)];
            _coverView;
        })];
        [_coverView addSubview:({
            _playButton = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - 50) / 2, (self.frame.size.height-GTVideoToolbarHeight - 50) / 2, 50, 50)];
            _playButton.image = [UIImage imageNamed:@"icon.bundle/videoPlay@2x.png"];
            _playButton;
        })];

        [self addSubview:({
            _progressView = [[UISlider alloc] initWithFrame:CGRectMake(0, self.frame.size.height-GTVideoToolbarHeight-10, self.frame.size.width, 10)];
            [_progressView setThumbImage:[UIImage imageNamed:@"icon.bundle/progressSlider@2x.png"] forState:(UIControlStateNormal)];
            _progressView;
        })];
        
        [self addSubview:({
            _videoToobar = [[GTVideoToolbar alloc] initWithFrame:CGRectMake(0, _coverView.frame.size.height, frame.size.width, GTVideoToolbarHeight)];
            _videoToobar;
        })];

        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_tapToPlay)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)dealloc {
    
}

#pragma mark - public method
- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl {
    _coverView.image = [UIImage imageNamed:videoCoverUrl];
    _videoUrl = videoUrl;
    [ _videoToobar layoutWithModel:nil];
}

#pragma mark - private method
- (void)_tapToPlay {
    [[GTVideoPlayer Player] playVideoWithUrl:_videoUrl attachView:_coverView attachSlider:_progressView];
}

@end
