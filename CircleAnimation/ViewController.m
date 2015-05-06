//
//  ViewController.m
//  CircleAnimation
//
//  Created by 能登 要 on 2015/05/06.
//  Copyright (c) 2015年 Irimasu Densan Planning. All rights reserved.
//

#import "ViewController.h"
#import "CircleAnimationView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet CircleAnimationView *circle1View;
@property (weak, nonatomic) IBOutlet CircleAnimationView *circle2View;
@property (weak, nonatomic) IBOutlet CircleAnimationView *circle3View;
@property (weak, nonatomic) IBOutlet UILabel *labelCircle1;
@property (weak, nonatomic) IBOutlet UILabel *labelCircle2;
@property (weak, nonatomic) IBOutlet UILabel *labelCircle3;
@property (strong,nonatomic) NSArray *values1;
@property (strong,nonatomic) NSArray *values2;
@property (strong,nonatomic) NSArray *values3;
@property (assign,nonatomic) NSInteger index;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _values1 = @[@0.5,@0.7,@0.1,@0.6,@0.8,@0.2,@0.4,@0.9];
    _values2 = @[@0.1,@0.3,@0.7,@1.0,@0.8,@0.2,@0.4,@0.9];
    _values3 = @[@0.8,@0.2,@0.4,@0.9,@0.1,@0.3,@0.7,@1.0];
    
    [self updateCircleLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateCircleLabel
{
    _labelCircle1.text = [NSString stringWithFormat:@"%@°",@(ceil(360 * _circle1View.value))];
    _labelCircle2.text = [NSString stringWithFormat:@"%@°",@(ceil(360 * _circle2View.value))];
    _labelCircle3.text = [NSString stringWithFormat:@"%@°",@(ceil(360 * _circle3View.value))];
}

- (IBAction)onTap:(id)sender
{
    _index++;
    
    [_circle1View setValue:[_values1[ _index % _values3.count] floatValue] animated:YES];
    [_circle2View setValue:[_values2[ _index % _values3.count] floatValue] animated:YES];
    [_circle3View setValue:[_values3[ _index % _values3.count] floatValue] animated:YES];

    [self updateCircleLabel];
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
