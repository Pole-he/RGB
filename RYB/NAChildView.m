//
//  NAChildView.m
//  RYB
//
//  Created by Nathan-he on 14-6-30.
//  Copyright (c) 2014年 Nathan. All rights reserved.
//

#import "NAChildView.h"

@interface NAChildView()
{
    NSArray *colors;
    UIColor *color1;
    UIColor *color2;
    UIColor *color3;
    UIColor *color4;
}

@end

@implementation NAChildView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.typeColor = 0;
        self.layer.borderWidth=.5;
        self.layer.borderColor=CGColorFromRGB(0xd0d0d0, 1.0);
        color1 = UIColorFromRGB(0xFE4848, 1.0);//红
        color2 = UIColorFromRGB(0xFECE35, 1.0);//黄
        color3 = UIColorFromRGB(0x4FA7FE, 1.0);//蓝
        color4 = UIColorFromRGB(0x49FCA3, 1.0);//绿
        colors = [NSArray arrayWithObjects:color1,color2,color3,color4, nil];
    }
    return self;
}

-(void) setColor
{
    int random = arc4random()%4;
    UIColor *color = colors[random];
    if (color == color1) {
        self.typeColor = 1;
    }else if(color == color2)
    {
        self.typeColor =2;
    }else if(color == color3)
    {
        self.typeColor =3;
    }else if(color == color4)
    {
        self.typeColor =4;
    }
    self.backgroundColor = color;
    self.layer.borderColor=[color CGColor];
}

-(void) reset
{
    self.typeColor=0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.layer.borderColor=CGColorFromRGB(0xd0d0d0, 1.0);
        self.backgroundColor = [UIColor clearColor];
    }];
}
@end
