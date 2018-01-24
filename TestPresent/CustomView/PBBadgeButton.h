//
//  PBBadgeButton.h
//  MPBBank-Vista
//
//  Created by liuliang on 16/7/19.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PBBadgeButtonBagdeColorStyle) {
    PBBadgeButtonBadgeColorStyleRedWhite, //红底白字
    PBBadgeButtonBadgeColorStyleWhiteRed, //白底红字
    PBBadgeButtonBadgeColorStyleBlackWhite, //黑底白字
    PBBadgeButtonBadgeColorStyleGoldBlack, //金底白字
    PBBadgeButtonBadgeColorStyleDefault = PBBadgeButtonBadgeColorStyleRedWhite,
};

@interface PBBadgeButton : UIButton


/**
 设置支持红点的按钮,会根据通用版或者尊享版自行设置样式

 @param image 按钮图片
 @param title 文字(为空时只显示按钮28*28)
 @return
 */
- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title;


@property (nonatomic, assign) NSInteger badgeNumber;
@property (nonatomic, assign) PBBadgeButtonBagdeColorStyle badgeColorStyle;

@end
