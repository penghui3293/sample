//
//  GTCommentManager.h
//  SampleApp
//
//  Created by penghuizhang on 2020/3/7.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTCommentManager : UIView

+ (GTCommentManager *) shareManager;

- (void) showCommentView;

@end

NS_ASSUME_NONNULL_END
