//
//  MyFlyLabel.h
//  MyFly
//
//  Created by Mac User12 on 24/07/15.
//  Copyright (c) 2015 Mac User7. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface MyFlyLabel : UILabel

@property (nonatomic, readwrite) VerticalAlignment va;

@end