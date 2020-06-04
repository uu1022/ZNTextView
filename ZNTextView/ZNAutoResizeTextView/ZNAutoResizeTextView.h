//
//  ZNView.h
//  LXViewShadowPath
//
//  Created by 张聪 on 2020/6/2.
//  Copyright © 2020 漫漫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZNAutoResizeTextView : UIView

@property (nonatomic,strong) UIFont *font;
@property (nonatomic,assign) CGFloat maxH;
@property (nonatomic,assign) CGFloat minH;
@end

NS_ASSUME_NONNULL_END
