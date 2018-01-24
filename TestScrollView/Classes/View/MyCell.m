//
//  MyCell.m
//  TestScrollView
//
//  Created by pirdboy on 2018/1/22.
//  Copyright © 2018年 CMB. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        _label = [[UILabel alloc] init];
        [self.contentView addSubview:_imageView];
        [self.contentView addSubview:_label];
    }
    return self;
}

- (void)layoutSubviews {
    
}

@end
