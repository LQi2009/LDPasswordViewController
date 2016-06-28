//
//  LZNumberTool.m
//  LZAccount
//
//  Created by Artron_LQQ on 16/6/3.
//  Copyright © 2016年 Artup. All rights reserved.
//

#import "LZNumberTool.h"

static NSString *numberPasswordStateKey = @"numberPasswordStateKey";
static NSString *numberPasswordValueKey = @"numberPasswordValueKey";
@implementation LZNumberTool

+ (void)saveNumberPasswordEnableState:(BOOL)enable {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber * num = [NSNumber numberWithBool:enable];
    if (enable == NO) {
        
        [defaults removeObjectForKey:numberPasswordValueKey];
    }
    
    [defaults setObject:num forKey:numberPasswordStateKey];
    [defaults synchronize];
}

+ (BOOL)getNumberPasswordEnableState {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber * num = [defaults objectForKey:numberPasswordStateKey];
    BOOL show = [num boolValue];
    
    NSString *password = [self getNumberPasswordValue];
    
    if (password && show) {
        return YES;
    } else {
        return NO;
    }
}

+ (void)saveNumberPasswordValue:(NSString*)value {
    
    if ([self getNumberPasswordEnableState] == NO) {
        
        [self saveNumberPasswordEnableState:YES];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:numberPasswordValueKey];
    [defaults synchronize];
}

+ (NSString*)getNumberPasswordValue {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [defaults objectForKey:numberPasswordValueKey];
    
    return value;
}
@end
