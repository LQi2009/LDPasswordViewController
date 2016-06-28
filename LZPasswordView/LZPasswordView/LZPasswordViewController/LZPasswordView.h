//
//  LZPasswordView.h
//  LZAccount
//
//  Created by Artron_LQQ on 16/6/1.
//  Copyright © 2016年 Artup. All rights reserved.
//

#define PLZSCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define PLZSCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width

// Hex色值
#define PLZColorFromHex(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define PLZNavigationHeight 64
#define PLZTabBarHeight 49

#define PLZNavigationBackgroundColor PLZColorFromHex(0x0075a9)
//R G B 颜色
#define PLZColorFromRGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#import <UIKit/UIKit.h>

typedef void(^buttonClick)(UIButton *button);
@interface LZPasswordView : UIView

@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL showWarning;
@property (copy, nonatomic) buttonClick backBlock;

- (void)changeViewAtIndex:(NSInteger)index;
- (void)resetView;
- (void)showWarningWithString:(NSString*)string;
@end
