//
//  LZPasswordViewController.h
//  LZPasswordView
//
//  Created by Artron_LQQ on 16/6/1.
//  Copyright © 2016年 Artup. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^verifyPSWBlock)(BOOL show);
typedef NS_ENUM(NSInteger, LZNumberPasswordState) {
    
    LZNumberPasswordStateSetting = 0,//设置数字密码
    LZNumberPasswordStateVerify,//验证数字密码
    LZNumberPasswordStateReset,//重置数字密码
};

@interface LZPasswordViewController : UIViewController

@property (assign, nonatomic)NSInteger passwordStete;
@property (copy, nonatomic)verifyPSWBlock showBlock;

- (instancetype)initWithState:(LZNumberPasswordState)state;
@end
