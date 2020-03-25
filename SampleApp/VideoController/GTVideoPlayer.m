//
//  GTVideoPlayer.m
//  SampleApp
//
//  Created by penghuizhang on 2020/2/23.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import "GTVideoPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface GTVideoPlayer ()

@property (nonatomic, readwrite) CGFloat videoDuration;

@property (nonatomic, strong, readwrite) AVPlayerItem *videoItem;
@property (nonatomic, strong, readwrite) AVPlayer *videoPlayer;
@property (nonatomic, strong, readwrite) AVPlayerLayer *playerLayer;


@end

@implementation GTVideoPlayer

+ (GTVideoPlayer *)Player {
    static GTVideoPlayer *player;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[GTVideoPlayer alloc]init];
    });
    return player;
}

- (void)playVideoWithUrl:(NSString *)videoUrl attachView:(UIView *)attachView attachSlider:(UISlider *)attachSlider {
    
    [self _stopPlay];
    
    NSURL *videoURL = [NSURL URLWithString:videoUrl];

    AVAsset *asset = [AVAsset assetWithURL:videoURL];

    _videoItem = [AVPlayerItem playerItemWithAsset:asset];

    [_videoItem addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew) context:nil];
    [_videoItem addObserver:self forKeyPath:@"loadedTimeRanges" options:(NSKeyValueObservingOptionNew) context:nil];

    _videoPlayer = [AVPlayer playerWithPlayerItem:_videoItem];

//    __weak typeof(self) weakSelf = self;
    [_videoPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
//        __strong typeof(weakSelf) strongSef = weakSelf;

        CGFloat videoCurrentTime =  CMTimeGetSeconds(time);
//        strongSef.attachSlider.value
        attachSlider.value = videoCurrentTime / self.videoDuration;
        NSLog(@"播放时间:%@", @(CMTimeGetSeconds(time)));
        NSLog(@"进度条:%@", @(videoCurrentTime / self.videoDuration));
    }];

    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_videoPlayer];

    _playerLayer.frame = attachView.bounds;

    [attachView.layer addSublayer:_playerLayer];

    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(_handlePlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)_stopPlay {
    [_playerLayer removeFromSuperlayer];
    [[NSNotificationCenter  defaultCenter] removeObserver:self];

    [_videoItem removeObserver:self forKeyPath:@"status"];
    [_videoItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    _videoItem = nil;

    _videoPlayer = nil;
}

- (void)_handlePlayEnd {
    [_videoPlayer seekToTime:CMTimeMake(0, 1)];

//    [_coverView addSubview:({
//        _playButton = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - 50) / 2, (self.frame.size.height - 50) / 2, 50, 50)];
//         _playButton.image = [UIImage imageNamed:@"icon.bundle/video_stop@2x.png"];
//        _playButton;
//    })];

    [_videoPlayer play ];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        if (((NSNumber *)[change objectForKey:NSKeyValueChangeNewKey]).integerValue == AVPlayerItemStatusReadyToPlay) {
            [_videoPlayer play ];
            CMTime duration =  _videoItem.duration;
            self.videoDuration =  CMTimeGetSeconds(duration);
            
            NSLog(@"视频时间:%@", @(_videoDuration));
        } else {
            NSLog(@"");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSLog(@"缓冲:%@", [change objectForKey:NSKeyValueChangeNewKey]);
    }
}

@end
