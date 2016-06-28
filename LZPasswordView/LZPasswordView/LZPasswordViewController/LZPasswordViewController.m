//
//  LZPasswordViewController.m
//  LZPasswordView
//
//  Created by Artron_LQQ on 16/6/1.
//  Copyright © 2016年 Artup. All rights reserved.
//



#import "LZPasswordViewController.h"
#import "LZPasswordView.h"
#import "LZNumberTool.h"


@interface LZPasswordViewController ()<UITextFieldDelegate>
{
    BOOL _isHiddenNavigationBarWhenDisappear;//记录当页面消失时是否需要隐藏系统导航
    BOOL _isHasTabBarController;//是否含有tabbar
    BOOL _isHasNavitationController;//是否含有导航
}

@property (strong, nonatomic) LZPasswordView *firstView;
@property (strong, nonatomic) LZPasswordView *secondView;
@property (nonatomic,strong)NSMutableString *firstString;
@property (nonatomic,strong)NSMutableString *secondString;
@property (strong, nonatomic)UIScrollView *scrollView;
@end

@implementation LZPasswordViewController

#pragma mark - life cicle
- (instancetype)initWithState:(LZNumberPasswordState)state {
    
    self = [super init];
    if (self) {
        
        _passwordStete = state;
    }
    
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        _passwordStete = LZNumberPasswordStateSetting;
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    
    if (_isHasNavitationController == YES) {
        if (self.navigationController.navigationBarHidden == YES) {
            _isHiddenNavigationBarWhenDisappear = NO;
        } else {
            self.navigationController.navigationBarHidden = YES;
            _isHiddenNavigationBarWhenDisappear = YES;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    if (_isHiddenNavigationBarWhenDisappear == YES) {
        self.navigationController.navigationBarHidden = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _isHasNavitationController = self.navigationController?YES:NO;
    
    [self setupNavBar];
    [self setupMainView];
}

#pragma mark - 布局界面
- (void)setupNavBar {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, PLZSCREEN_WIDTH, PLZNavigationHeight)];
    bgView.backgroundColor = PLZNavigationBackgroundColor;
    [self.view addSubview:bgView];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(10, 20, 60, 44);
    
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:leftButton];
    
    UILabel *label = [[UILabel alloc]init];
    label.center = CGPointMake(PLZSCREEN_WIDTH/2.0, 42);
    label.bounds = CGRectMake(0, 0, 100, 44);
    label.text = @"设置密码";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:label];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, PLZNavigationHeight - 1, PLZSCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line];
}

- (void)leftButtonClick:(UIButton*)button {
    
    if (_isHasNavitationController == YES) {
        
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setupMainView {
    
    UITextField *text = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
    
    text.delegate = self;
    text.keyboardType = UIKeyboardTypeNumberPad;
    [text becomeFirstResponder];
    [self.view addSubview:text];
    
    UIScrollView *mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, PLZNavigationHeight, PLZSCREEN_WIDTH, PLZSCREEN_HEIGHT - PLZNavigationHeight)];
    
    if (self.passwordStete == LZNumberPasswordStateVerify) {
        
        mainScroll.contentSize = CGSizeMake(PLZSCREEN_WIDTH, 0);
    } else {
        mainScroll.contentSize = CGSizeMake(2*PLZSCREEN_WIDTH, 0);
    }
    
    mainScroll.scrollEnabled = NO;
    [self.view addSubview:mainScroll];
    self.scrollView = mainScroll;
    
    LZPasswordView *firstView = [[LZPasswordView alloc]init];
    firstView.frame = CGRectMake(0, 0, PLZSCREEN_WIDTH, PLZSCREEN_HEIGHT - PLZNavigationHeight);
    [mainScroll addSubview:firstView];
    self.firstView = firstView;
    if (self.passwordStete != LZNumberPasswordStateReset) {
        
        firstView.title = @"请输入密码";
    } else {
        
        firstView.title = @"请输入旧密码";
    }
    
    if (self.passwordStete != LZNumberPasswordStateVerify) {
        
        LZPasswordView *secondView = [[LZPasswordView alloc]init];
        secondView.frame = CGRectMake(PLZSCREEN_WIDTH, 0, PLZSCREEN_WIDTH, PLZSCREEN_HEIGHT - PLZNavigationHeight);
        secondView.title = @"请确认密码";
        [mainScroll addSubview:secondView];
        self.secondView = secondView;
    }
}

#pragma mark - UITextFieldDelegate ,验证输入信息
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    //点击的是删除键
    if (!string || string.length == 0) {
        
        if (self.firstString.length < 4) {
            
            if (self.firstString.length == 0) {
                return YES;
            }
            NSInteger index = 0;
            if (self.firstString.length == 1) {
                index = 0;
            } else {
                index = self.firstString.length - 1;
            }
            
            self.firstString = [[self.firstString substringToIndex:self.firstString.length - 1]mutableCopy];
            
            [self.firstView changeViewAtIndex:index];
        } else if (self.secondString.length < 4 && self.firstString.length == 4) {
            
            if (self.secondString.length == 0) {
                return YES;
            }
            
            self.secondString = [[self.secondString substringToIndex:self.secondString.length - 1]mutableCopy];
            [self.secondView changeViewAtIndex:self.secondString.length];
            
        } else {
            //            return NO;
        }
    } else {
        if (self.firstString.length < 4) {
            
            [self.firstString appendString:string];
            [self.firstView changeViewAtIndex:self.firstString.length - 1];
        } else if (self.secondString.length < 4 && self.firstString.length == 4) {
            
            [self.secondString appendString:string];
            [self.secondView changeViewAtIndex:self.secondString.length - 1];
        }
        
        //第一组密码输入完毕,调整视图
        if (self.firstString.length == 4 && self.secondString.length == 0) {
            
            [self firstPasswordInputOver];
        }
        
        //两组密码输入完毕
        if (self.firstString.length == 4 && self.secondString.length == 4) {
            
            [self secondPasswordInputOver];
        }
    }
    
    return YES;
}
//第一组密码输入完毕,,根据情况进行调整视图
- (void)firstPasswordInputOver {
    
    switch (self.passwordStete) {
        case LZNumberPasswordStateSetting: {
            
            [self.scrollView setContentOffset:CGPointMake(PLZSCREEN_WIDTH, 0) animated:YES];
        }
            break;
        case LZNumberPasswordStateVerify: {
            NSString *password = [LZNumberTool getNumberPasswordValue];
            if ([password isEqualToString:self.firstString]) {
                
                if (self.showBlock) {
                    self.showBlock(YES);
                }
                [self leftButtonClick:nil];
            } else {
                
                [self.firstView showWarningWithString:@"密码错误,请重新输入!"];
                self.firstString = [@"" mutableCopy];
                [self.firstView resetView];
            }
        }
            break;
        case LZNumberPasswordStateReset: {
            
            NSString *password = [LZNumberTool getNumberPasswordValue];
            if ([password isEqualToString:self.firstString]) {
                
                self.secondView.title = @"请输入新密码!";
                [self.scrollView setContentOffset:CGPointMake(PLZSCREEN_WIDTH, 0) animated:YES];
            } else {
                
                [self.firstView showWarningWithString:@"密码错误,请重新输入!"];
                self.firstString = [@"" mutableCopy];
                [self.firstView resetView];
            }
            
        }
            break;
            
        default:
            break;
    }
}

//第二组密码输入完毕,,根据情况进行验证
- (void)secondPasswordInputOver {
    
    switch (self.passwordStete) {
        case LZNumberPasswordStateSetting: {
            
            //判断两组密码是否相等
            if ([self.firstString isEqualToString:self.secondString]) {
                
                //保存数字密码
                [LZNumberTool saveNumberPasswordValue:self.secondString];
                [self alertShow];
            } else {
                
                [self.firstView resetView];
                [self.secondView resetView];
                [self.firstView setShowWarning:YES];
                [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                
                
                self.firstString = [@"" mutableCopy];
                self.secondString = [@"" mutableCopy];
            }
        }
            break;
        case LZNumberPasswordStateVerify: {
            
        }
            break;
        case LZNumberPasswordStateReset: {
            
            [LZNumberTool saveNumberPasswordValue:self.secondString];
            
            [self alertShow];
            
        }
            break;
            
        default:
            break;
    }
}

- (void)alertShow {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"恭喜,设置成功!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self leftButtonClick:nil];
    }];
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)changeStyle {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *num = [UIAlertAction actionWithTitle:@"6位数字密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:num];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 属性初始化
- (NSMutableString *)firstString {
    if (!_firstString) {
        _firstString = [[NSMutableString alloc]init];
    }
    
    return _firstString;
}

- (NSMutableString *)secondString {
    if (!_secondString) {
        _secondString = [[NSMutableString alloc]init];
    }
    
    return _secondString;
}


- (BOOL)shouldAutorotate {
    
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
