//
//  DCDingDingSSOModule.m
//  LibWeexDCDingDingSSO
//
//  Created by simple on 2019/4/22.
//  Copyright © 2019年 simple. All rights reserved.
//

#import "DCDingDingSSOModule.h"
#import "WXUtility.h"
#import <DTShareKit/DTOpenKit.h>

@interface DCDingDingSSOModule()
@property (nonatomic, copy) WXModuleKeepAliveCallback callback;
@end
@implementation DCDingDingSSOModule


@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(alert:callback:))


#pragma mark - Export Method


- (void)alert:(NSDictionary *)options callback:(WXModuleKeepAliveCallback)callback
{
    NSLog(@"执行");
    _callback = callback;
    DTAuthorizeReq *authReq = [DTAuthorizeReq new];
    authReq.bundleId = @"com.yunzhiyin";
    BOOL result = [DTOpenAPI sendReq:authReq]; 
    if (result) {
        NSLog(@"授权登录 发送成功.");
    }
    else {
        NSLog(@"授权登录 发送失败.");
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLogin:) name:@"DingDingSSO" object:nil];
//    if(callback){
//        NSDictionary *dic = @{@"result":@"发送成功 "};
//        callback(dic,TRUE);
//    }
    
}

- (void)handleLogin:(NSNotification*)noti{
    if(_callback){
        _callback(noti.object,TRUE);
    }
}

@end
