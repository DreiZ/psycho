//
//  ZPublicManager.h
//  zcfBase
//
//  Created by zzz on 2018/5/8.
//  Copyright © 2018年 zcf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUserModel.h"
typedef NS_ENUM(NSUInteger, HNFormatterType) {
    HNFormatterTypeAny,                 //不过滤
    HNFormatterTypePhoneNumber,         //11位电话号码
    HNFormatterTypeNumber,              //数字
    HNFormatterTypeDecimal,             //小数
    HNFormatterTypeAlphabet,            //英文字母
    HNFormatterTypeNumberAndAlphabet,   //数字+英文字母
    HNFormatterTypeIDCard,              //18位身份证
    HNFormatterTypeCustom               //自定义
};

@interface ZPublicManager : NSObject
+(ZPublicManager *) shareInstance;

@property(nonatomic, strong) NSString *deviceUuid;//设备uuid 设备唯一值
@property(nonatomic, strong) NSData *deviceTokenData;//设备推送标识
@property(nonatomic, strong) NSString *versionNum;
@property(nonatomic, assign) NSInteger cartNum;
@property(nonatomic, assign) BOOL isLogin;
@property(nonatomic, strong) ZUserModel *user;
@property(nonatomic, strong) NSDictionary *verInfoDic;//版本和升级信息

/**
 退出登录
 
 @param isTokenOut 是否是登录过期
 @param alertMsg 弹窗户提示
 */
-(void)alertLoginOut:(BOOL)isTokenOut
             withMsg:(NSString *)alertMsg;
/**
 重新登录，获取最新信息
 */
-(void)autoLoginUser;



/**
 清除当前用户
 */
-(void)clearUserInfo;


/**
 退出当前用户
 */
-(void)loginOutUserAndReLogin;

/**
 判断用户id是不是自己
 
 @param memberId 用户id
 @return 是否是自己
 */
-(BOOL)isMyMemberId:(NSString *)memberId;
/**
 获取用户默认地址
 */
-(void)getDefaultAddress;

-(void)checkNetwork;
-(BOOL)isNetworkEnableNew;
-(BOOL)isReachableViaWiFi;


-(void)updateDevictToken;
-(NSInteger)getDevice;

/**
 *  初始化网络
 */
-(void)monitoringNetwork;
/**
 *  是否有网络
 *
 *  @return 是否有网络
 */
-(BOOL)isNetWork;
/**
 *  初始化友盟分享
 */
-(void)umenShare;

//比较版本号
-(BOOL)isShowExtend;

/**
 *  在APPStore打开APP
 */
-(void)openAppUrl;


/**
 判断是否可以打开网络
 */
- (BOOL)isNetworkEnable;

@end
