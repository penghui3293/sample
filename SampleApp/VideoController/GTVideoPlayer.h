//
//  GTVideoPlayer.h
//  SampleApp
//
//  Created by penghuizhang on 2020/2/23.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTVideoPlayer : NSObject

+(GTVideoPlayer *)Player;

- (void)playVideoWithUrl:(NSString *)videoUrl attachView:(UIView *)attachView attachSlider:(UISlider *)attachSlider;

@end

NS_ASSUME_NONNULL_END
