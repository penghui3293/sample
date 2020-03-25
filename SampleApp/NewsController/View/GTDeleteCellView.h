//
//  GTDeleteCellView.h
//  SampleApp
//
//  Created by penghuizhang on 2020/2/18.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 击出现删除cell的确认浮层
@interface GTDeleteCellView : UIView

/// 点击出现删除cell的确认浮层
/// @param point 点击的位置
/// @param clickBlock 点击后的操作
- (void) showDeleteViewFromPoint:(CGPoint)point clickBlock:(dispatch_block_t)clickBlock;

@end

NS_ASSUME_NONNULL_END
