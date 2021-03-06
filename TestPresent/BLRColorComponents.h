//
//  BLRColorComponents.h
//  MPBBank-Vista
//
//  Created by zk on 15/6/4.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/// Blur color components.
///
@interface BLRColorComponents : NSObject

@property(nonatomic, assign) CGFloat radius;
@property(nonatomic, strong) UIColor *tintColor;
@property(nonatomic, assign) CGFloat saturationDeltaFactor;
@property(nonatomic, strong) UIImage *maskImage;

///Light color effect.
///
+ (BLRColorComponents *) lightEffect;

///Dark color effect.
///
+ (BLRColorComponents *) darkEffect;

///Coral color effect.
///
+ (BLRColorComponents *) coralEffect;

///Neon color effect.
///
+ (BLRColorComponents *) neonEffect;

///Sky color effect.
///
+ (BLRColorComponents *) skyEffect;

+ (BLRColorComponents *) globalSearchEffect;

@end
