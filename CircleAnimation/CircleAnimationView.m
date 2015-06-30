//
//  CircleAnimationView.m
//  CircleAnimation
//
//  Created by 能登 要 on 2015/05/06.
//  Copyright (c) 2015年 Irimasu Densan Planning. All rights reserved.
//

#import "CircleAnimationView.h"
#import "StyleKit.h"

typedef CGFloat (^easeblock_t)(CGFloat t,CGFloat b,CGFloat c,CGFloat d,NSDictionary* params);

@interface CircleAnimationView ()
{
    // currentValue
    CGFloat _value;
    
    // for easyease animation
    CGFloat _startValue;
    CGFloat _length;
    CGFloat _endValue;
    
    // for display link
    CFTimeInterval _beginTime;
    CFTimeInterval _totalTime;
    __weak CADisplayLink *_displayLink;
}
@end

@implementation CircleAnimationView

- (CGFloat) value
{
    return _displayLink == nil ? _value : _endValue;
}

- (void) setValue:(CGFloat)value
{
    [self setValue:value animated:NO];
}

- (void) setValue:(CGFloat)value animated:(BOOL)animated
{
    if( value != _value ){
        if( animated ){
            _startValue = _displayLink == nil ? _value : _endValue;
            _length = value - _startValue;
            _endValue = value;
            
            [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
                // アニメーションを解除
            
            _beginTime = CACurrentMediaTime();
            _totalTime = .5f;
            
            CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(event:)];
            [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
            
            _displayLink = link;
        }else{
            _value = value;
            [self setNeedsDisplay];
        }
    }
}

-(void)event:(CADisplayLink *)link
{
    CGFloat ratio = ([link timestamp] - _beginTime) / _totalTime;
    if (ratio >= 1.0) {
        _value = _endValue;
        [self setNeedsDisplay];
        [link removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        return;
    }
    
    static easeblock_t easeoutBlock = ^CGFloat (CGFloat t,CGFloat b,CGFloat c,CGFloat d,NSDictionary* params){
        return (t==d) ? b+c : c * 1.001 * (-pow(2, -10 * t/d) + 1) + b;
    };
    
    _value = easeoutBlock(ratio,_startValue,_length,1.0,nil) /*_startValue + (_length) * ratio*/;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [StyleKit drawCircleWithFrame: rect circleColor:_circleColor != nil ? _circleColor : [UIColor colorWithRed: 0.98 green: 0.22 blue: 0.529 alpha: 1] endAngle:360.0 * _value interactiveFrame:rect brushWidth:_strokeWidth != 0.0 ? _strokeWidth : 29.0];
}

@end
