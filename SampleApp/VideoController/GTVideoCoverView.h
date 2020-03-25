//
//  GTVideoCoverView.h
//  SampleApp
//
//  Created by penghuizhang on 2020/2/22.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTVideoCoverView : UICollectionViewCell

- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl;

@end

NS_ASSUME_NONNULL_END
