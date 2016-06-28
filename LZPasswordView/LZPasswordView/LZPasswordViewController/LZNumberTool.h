//
//  LZNumberTool.h
//  LZAccount
//
//  Created by Artron_LQQ on 16/6/3.
//  Copyright © 2016年 Artup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZNumberTool : NSObject

+ (void)saveNumberPasswordEnableState:(BOOL)enable ;
+ (BOOL)getNumberPasswordEnableState ;

+ (void)saveNumberPasswordValue:(NSString*)value ;
+ (NSString*)getNumberPasswordValue;
@end
