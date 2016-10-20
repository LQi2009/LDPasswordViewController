//
//  LZPasswordView.m
//  LZAccount
//
//  Created by Artron_LQQ on 16/6/1.
//  Copyright © 2016年 Artup. All rights reserved.
//

#define PLZKeyboardHeight 250

#import "LZPasswordView.h"

@interface LZPasswordView ()

@property (strong, nonatomic)NSMutableArray *viewArray;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *warnLabel;
@property (strong, nonatomic) UIView *numberBackgroundView;
@property (strong, nonatomic) UIView *textBackgroundView;
@end
@implementation LZPasswordView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.backgroundColor = PLZColorFromRGB(239, 239, 244);
        [self setupUI];
    }
    
    return self;
}

- (NSMutableArray *)viewArray {
    if (_viewArray == nil) {
        _viewArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _viewArray;
}

- (void)setupUI {
    
    CGFloat height = (PLZSCREEN_HEIGHT - PLZNavigationHeight - PLZKeyboardHeight - 120.0)/5.0;
    
    NSLog(@"%f",PLZSCREEN_HEIGHT - PLZNavigationHeight - PLZKeyboardHeight);
    
    UILabel *titleLabel = [[UILabel alloc]init];

    titleLabel.frame = CGRectMake(0, height, PLZSCREEN_WIDTH, 30);
    titleLabel.text = @"请输入密码";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor blackColor];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIView *psBgView = [[UIView alloc]init];
    psBgView.backgroundColor = self.backgroundColor;
    psBgView.frame = CGRectMake(0, 2*height + 30, PLZSCREEN_WIDTH, 30);
    [self addSubview:psBgView];
    self.numberBackgroundView = psBgView;
    
//    self.textBackgroundView.frame = CGRectMake(0, 2*height + 30, PLZSCREEN_WIDTH, 30);
//    [self addSubview:self.textBackgroundView];
    
    
    NSInteger width = 20;
    NSInteger paging = (PLZSCREEN_WIDTH - width * 7)/2;
    for (int i = 0; i < 4; i++) {
        UIView *vi = [[UIView alloc]init];
        vi.frame = CGRectMake(paging + (2*width) * i,27/2.0, width, 3);
        vi.tag = 1;
        vi.backgroundColor = [UIColor blackColor];
        [psBgView addSubview:vi];
        [self.viewArray addObject:vi];
    }
    
    UILabel *warnLabel = [[UILabel alloc]init];
//    warnLabel.center = CGPointMake(self.center.x, 4*LZNavigationHeight);
//    warnLabel.bounds = CGRectMake(0, 0, 200, 30);
    warnLabel.frame = CGRectMake(0, 3*height + 60, PLZSCREEN_WIDTH, 30);
    warnLabel.textAlignment = NSTextAlignmentCenter;
    warnLabel.font = [UIFont systemFontOfSize:14];
    warnLabel.textColor = [UIColor redColor];
    warnLabel.text = @"两次密码输入不一致,请重新输入!";
    warnLabel.hidden = YES;
    [self addSubview:warnLabel];
    self.warnLabel = warnLabel;
    
    UIButton *changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    changeButton.center = CGPointMake(PLZSCREEN_WIDTH/2.0, 4*height + 100);
    changeButton.frame = CGRectMake((PLZSCREEN_WIDTH - 100)/2.0, 4*height + 110, 100, 30);
    changeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [changeButton setTitle:@"密码选项" forState:UIControlStateNormal];
    [changeButton setTitleColor:PLZColorFromRGB(0, 121, 253) forState:UIControlStateNormal];
    [changeButton addTarget:self action:@selector(changeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:changeButton];
}


- (void)changeButtonClick:(UIButton*)button {
    
    if (self.backBlock) {
        self.backBlock(button);
    }
}

- (void)resetView {
    for (UIView *vi in self.viewArray) {
        if (vi.tag > 0) {
            vi.bounds = vi.bounds = CGRectMake(0, 0, 20, 3);
            vi.layer.cornerRadius = 0;
            vi.tag = 1;
        }
    }
}

- (void)changeViewAtIndex:(NSInteger)index {
    
    UIView *view = [self.viewArray objectAtIndex:index];
    if (view.tag == 2) {
    
        view.bounds = CGRectMake(0, 0, 20, 3);
        view.layer.cornerRadius = 0;
        view.tag = 1;
    } else {
        
        view.bounds = CGRectMake(0, 0, 16, 16);
        view.layer.cornerRadius = 8;
        view.tag = 2;
    }
}

- (UIView *)textBackgroundView {
    
    if (_textBackgroundView == nil) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        UITextField *textField = [[UITextField alloc]init];
        textField.frame = CGRectMake(20, 0, PLZSCREEN_WIDTH - 40, 30);
//        textField.backgroundColor = [UIColor redColor];
        [view addSubview:textField];
        
        _textBackgroundView = view;
    }
    
    return _textBackgroundView;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    _title = title;
}

- (void)setShowWarning:(BOOL)showWarning {
    self.warnLabel.hidden = !showWarning;
    _showWarning = showWarning;
}

- (void)showWarningWithString:(NSString*)string {
    
    self.warnLabel.hidden = NO;
    self.warnLabel.text = string;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
