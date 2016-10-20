//
//  LZPasswordViewController.h
//  LZPasswordView
//
//  Created by Artron_LQQ on 2016/10/20.
//  Copyright © 2016年 Artup. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LZPasswordStyle) {
    
    LZPasswordStyleSetting,
    LZPasswordStyleVerity,
    LZPasswordStyleUpdate,
    LZPasswordStyleScreen,
};

typedef void(^successBlock)();
@interface LZPasswordViewController : UIViewController

@property (nonatomic, assign) LZPasswordStyle style;

- (void)showInViewController:(UIViewController *)vc style:(LZPasswordStyle)style ;

- (void)verifySuccess:(void(^)())success;
@end

@protocol LZPasswordDelegate <NSObject>



@end
