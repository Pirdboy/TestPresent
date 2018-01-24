//
//  PBBadgeButton.m
//  MPBBank-Vista
//
//  Created by liuliang on 16/7/19.
//
//

#import "PBBadgeButton.h"

#import "JSBadgeView.h"
#import "UIImage+Color.h"

static const CGFloat PBBadgeButtonTitleFontSize = 10;
static const CGFloat PBBadgeButtonNoTitleSize = 28;

@interface PBBadgeButton ()


@end

@implementation PBBadgeButton

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title
{
    self = [super init];
    if (self) {
        [self configWithImage:image title:title];
    }
    return self;
}

- (void)configWithImage:(UIImage *)image title:(NSString *)title {
    if(title.length > 3) {
        title = [[title substringToIndex:3] stringByAppendingString:@"..."];
    }
    
    //icon size may be {20, 20}
    CGFloat imgWidth = image.size.width;
    CGFloat imgHeight = image.size.height;
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:PBBadgeButtonTitleFontSize]}];
    CGFloat titleWidth = titleSize.width;
    CGFloat titleHeight = PBBadgeButtonTitleFontSize;//titleSize.height;
    CGFloat imageTitleGap = 2;
    CGFloat buttonWidth = MAX(MAX(imgWidth, titleWidth),30);
    CGFloat buttonHeight = MAX(imgHeight+titleHeight+imageTitleGap,30);
    if (title.length == 0) {
        buttonWidth = 28;
        buttonHeight = 28;
    }
    
    
//    [self setFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
    //订单图标被压缩
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
    
    [self setImage:image forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:PBBadgeButtonTitleFontSize];
    [self setTitle:title forState:UIControlStateNormal];
    
    [self layoutSelf];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutSelf];
}

- (void)layoutSelf {
    // Center image
    [self setFrame:CGRectMake(0, 0, 32, 32)];
    self.imageView.frame = CGRectMake(0, 0, 15, 18); //???
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.imageView.frame.size.height/2;
    self.imageView.center = center;
    
    //Center text
    self.titleLabel.frame = CGRectMake(0, 0, 32, 10); //???
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = self.imageView.frame.size.height+ 2;
    
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
