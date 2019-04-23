//
//  DCDingDingSSOProxy.m
//  LibWeexDCDingDingSSO
//
//  Created by simple on 2019/4/22.
//  Copyright © 2019年 simple. All rights reserved.
//

#import "DCDingDingSSOProxy.h"

@implementation DCDingDingSSOProxy

-(void)onCreateUniPlugin{
    NSLog(@"11111 有需要初始化的逻辑可以放这里！");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    NSLog(@"111111 有需要didFinishLaunchingWithOptions可以放这里！");
    [DTOpenAPI registerApp:@"dingoabu5uxvx7rq4rfvhs"];
    return YES;
}

- (BOOL)application:(UIApplication *_Nullable)application handleOpenURL:(NSURL *_Nullable)url{
    if (url) {
        if ([DTOpenAPI handleOpenURL:url delegate:self]) {
            return YES;
        }
    }
    return YES;
}

- (void)onReq:(DTBaseReq *)req {
    
}

- (void)onResp:(DTBaseResp *)resp {
    if ([resp isKindOfClass:[DTAuthorizeResp class]]) {
        DTAuthorizeResp *authResp = (DTAuthorizeResp *)resp;
        NSString *accessCode = authResp.accessCode;
        NSDictionary *result = @{@"accessCode":accessCode ? accessCode : @"",
                                 @"errorCode":@(resp.errorCode),
                                 @"errorMessage":resp.errorMessage
                                 };
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DingDingSSO" object:result];
        
//        [self showAlertTitle:@"授权登录"
//                     message:[NSString stringWithFormat:@"accessCode: %@, errorCode: %@, errorMsg: %@", accessCode, @(resp.errorCode), resp.errorMessage]];
    }
    else {
        NSDictionary *result = @{
                                 @"errorCode":@(resp.errorCode),
                                 @"errorMessage":resp.errorMessage
                                 };
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DingDingSSO" object:result];
    }
}


- (void)showAlertTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

@end
