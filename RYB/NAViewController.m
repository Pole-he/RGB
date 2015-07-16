//
//  NAViewController.m
//  RYB
//
//  Created by Nathan-he on 14-6-30.
//  Copyright (c) 2014年 Nathan. All rights reserved.
//

#import "NAViewController.h"
#import "NAChildView.h"
#import "POP.h"

@interface NAViewController ()
@property(nonatomic,weak) UIView *viewGroup;
@property(nonatomic,weak) UILabel *label;
@property(nonatomic,strong) NSMutableArray *viewArr;
@end

@implementation NAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewArr = [NSMutableArray array];
	self.view.backgroundColor = UIColorFromRGB(0xffffff, 1.0);
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, (ScreenHeight-ScreenWidth)/2, ScreenWidth, ScreenWidth)];
    view.backgroundColor = UIColorFromRGB(0xe1e1e1, 1.0);
    self.viewGroup = view;
    [self.view addSubview:view];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, view.frame.origin.y+view.frame.size.height+20, ScreenWidth, 15)];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"0";
    self.label = label;
    [self.view addSubview:label];
    
    int width = ScreenWidth/8;
    
    for (int i=0; i<64; i++) {
        NAChildView *child = [[NAChildView alloc]init];
        child.tag=i+100;
        child.frame = CGRectMake((i%8)*width, (i/8)*width, width, width);
        [view addSubview:child];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectorChild:)];
        [child addGestureRecognizer:tap];
    }
}

-(void)selectorChild:(UITapGestureRecognizer *)tap
{
    NAChildView *view = (NAChildView *)tap.view;
    if (view.typeColor!=0) {
        return;
    }
    [view setColor];
    [self animationForView:view];
}

-(void) animationForView:(UIView *)view
{
    
    [UIView transitionWithView:view
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^(void){
                        
                    }
     
                    completion:^(BOOL finished) {
                        if (finished) {
                            [self.viewArr removeAllObjects];
                            [self.viewArr addObject:view];
                            [self calculate:view];
                            if (self.viewArr.count>=3) {
                                [self addNum:self.viewArr.count*10];
                                for (NAChildView *child in self.viewArr) {
                                    [child reset];
                                }
                            }
                        }
                    }];
}

- (void) animationFinished: (id) sender withView:(NAChildView *)view{
    
    NSLog(@"animationFinished !");
    
    [self calculate:view];

}

-(void) addNum:(int) num
{
    
    int original = [self.label.text intValue];
    int value = num +original;
    POPBasicAnimation *animation = [POPBasicAnimation animation];
    animation.property = [self animationProperty];
    animation.fromValue = @(original);
    animation.toValue = @(value);
    animation.duration = 0.1f;
    //增加animation 时间函数控制
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.label pop_addAnimation:animation forKey:@"numberLabelAnimation"];
}

- (POPMutableAnimatableProperty *)animationProperty {
    return [POPMutableAnimatableProperty
            propertyWithName:@"com.curer.test"
            initializer:^(POPMutableAnimatableProperty *prop) {
                prop.writeBlock = ^(id obj, const CGFloat values[]) {
                    UILabel *label = (UILabel *)obj;
                    NSNumber *number = @(values[0]);
                    int num = [number intValue];
                    label.text = [@(num) stringValue];
                };
            }];
}


-(void) calculate:(UIView *)v
{
    
    NAChildView *view = (NAChildView *)v;
    int tag = view.tag-100;
    
    int top = tag/8;//距离此view上面View个数
    int left = tag%8;//距离此view左边View个数
    int right = 8-left-1;//距离此view右边View个数
    int bottom = 8-top-1;//距离此view下面View个数
    
    NAChildView *l1;
    NAChildView *t1;
    NAChildView *r1;
    NAChildView *b1;
    if (top>=1) {
        t1 =(NAChildView *)[self.viewGroup viewWithTag:tag-8+100];
    }
    
    if (bottom>=1) {
        b1 =(NAChildView *)[self.viewGroup viewWithTag:tag+8+100];
    }
    if (left>=1) {
        l1 =(NAChildView *)[self.viewGroup viewWithTag:tag-1+100];
    }
    if(right>=1)
    {
        r1 =(NAChildView *)[self.viewGroup viewWithTag:tag+1+100];
    }
        
    
    if(l1!=nil && l1.typeColor == view.typeColor)
    {
        if (![self.viewArr containsObject:l1]) {
            [self.viewArr addObject:l1];
            [self calculate:l1];
        }
    }
    
    if(r1!=nil && r1.typeColor == view.typeColor)
    {
        if (![self.viewArr containsObject:r1]) {
            [self.viewArr addObject:r1];
            [self calculate:r1];
        }
    }
    
    if(t1!=nil && t1.typeColor == view.typeColor)
    {
        if (![self.viewArr containsObject:t1]) {
            [self.viewArr addObject:t1];
            [self calculate:t1];
        }
    }
    
    if(b1!=nil && b1.typeColor == view.typeColor)
    {
        if (![self.viewArr containsObject:b1]) {
            [self.viewArr addObject:b1];
            [self calculate:b1];
        }
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
