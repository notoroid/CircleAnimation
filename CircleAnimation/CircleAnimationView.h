//
//  CircleAnimationView.h
//  CircleAnimation
//
//  Created by 能登 要 on 2015/05/06.
//  Copyright (c) 2015年 Irimasu Densan Planning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleAnimationView : UIView

@property (strong,nonatomic) UIColor *circleColor;
@property (assign,nonatomic) CGFloat value;
@property (assign,nonatomic) CGFloat strokeWidth;
- (void) setValue:(CGFloat)value animated:(BOOL)animated;

@end
