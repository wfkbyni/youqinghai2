//
//  RequestBaseAPI+User.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/20.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RequestBaseAPI.h"

typedef NS_ENUM(NSInteger, UserRegisterType) {
    UserRegisterTypeWithRegister = 0,    // 注册
    UserRegisterTypeWithForget,          // 忘记密码
    UserRegisterTypeWithChangePhone,     // 更换手机
    UserRegisterTypeWiwhEditPassword     // 修改登录密码
};

@interface RequestBaseAPI (User)

/**
 *  @brief 接口说明：主要用于客户端用户注册
 *
 *  @param phone    手机号
 *  @param password 密码
 *  @param code     验证码
 *  @param type     0注册，1:忘记密码，2更换手机，3修改登录密码
 *
 *  @return <#return value description#>
 */
- (RACSignal *)userRegisterWithPhone:(NSString *)phone
                        withPassword:(NSString *)password
                            withCode:(NSString *)code
                            withType:(UserRegisterType)type;

/**
 *  登录操作
 *
 *  @param phone    手机号
 *  @param password 密码
 *
 *  @return <#return value description#>
 */
-(RACSignal *)userLoginWithPhone:(NSString *)phone
                    withPassWord:(NSString *)password;
/**
 *  忘记密码
 *
 *  @param phone    电话号
 *  @param password 密码
 *  @param smscode  验证码
 *  @param type     类型
 *
 *  @return <#return value description#>
 */
-(RACSignal *)userForgetWithPhone:(NSString *)phone
                    withPassWord:(NSString *)password
                      withsmscode:(NSString*)smscode
                         withtype:(UserRegisterType)type;
@end
