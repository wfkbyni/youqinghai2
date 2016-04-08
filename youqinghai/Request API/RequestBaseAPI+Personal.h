//
//  RequestBaseAPI+Personal.h
//  youqinghai
//
//  Created by snailz on 16/3/28.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RequestBaseAPI.h"

@interface RequestBaseAPI(Personal)
/**
 *  获取消息中心数据
 *
 *  @param index    页码
 *  @param pageSize 每页数量
 *
 *  @return <#return value description#>
 */
-(RACSignal*)messDataWithPageIndex:(NSString*)index
                      withPageSize:(NSString*)pageSize;
/**
 *  上传用户头像
 *
 *  @param data 图片数据
 *
 *  @return <#return value description#>
 */
-(RACSignal*)ImageHeaderDataWithData:(NSData*)data;
/**
 *  修改用户信息
 *
 *  @param nickName  昵称
 *  @param sex       性别
 *  @param autograph 签名
 *
 *  @return <#return value description#>
 */
-(RACSignal*)userInfoWithNickName:(NSString*)nickName
                          withSex:(NSString*)sex
                    withAutograph:(NSString*)autograph;
/**
 *  获取验证码
 *
 *  @param phone 手机号
 *  @param type  类型
 *  @param State 类型
 *
 *  @return <#return value description#>
 */
-(RACSignal*)phoneWithphone:(NSString*)phone
                          withtype:(NSString*)type
                    withState:(NSString*)State;
/**
 *  修改绑定手机
 *
 *  @param userId  用户名
 *  @param oldTel  绑定手机
 *  @param newTel  新手机
 *  @param codesms 验证码
 *
 *  @return <#return value description#>
 */
-(RACSignal*)userModfPhoneWithuserId:(NSString*)userId
                          witholdTel:(NSString*)oldTel
                          withnewTel:(NSString*)newTel
                         withcodesms:(NSString*)codesms
                            withtype:(NSString*)type;
/**
 *  修改登录密码
 *
 *  @param userId  用户名
 *  @param tel     电话号码
 *  @param oldpass 旧密码
 *  @param codesms 验证码
 *  @param newpass 新密码
 *  @param type    类型
 *
 *  @return <#return value description#>
 */
-(RACSignal*)userLoginPassWithuserId:(NSString*)userId
                             withTel:(NSString*)tel
                         witholdpass:(NSString*)oldpass
                         withcodesms:(NSString*)codesms
                         withnewpass:(NSString*)newpass
                            withtype:(NSString*)type;
/**
 *  获取消息详情
 *
 *  @param messId 消息id
 *
 *  @return <#return value description#>
 */
-(RACSignal*)messdetailedWithmessId:(NSString*)messId;
/**
 *  发布定制旅游
 *
 *  @param userId            <#userId description#>
 *  @param contacts          <#contacts description#>
 *  @param phone             <#phone description#>
 *  @param travelnum         <#travelnum description#>
 *  @param travelTime        <#travelTime description#>
 *  @param departure         <#departure description#>
 *  @param destination       <#destination description#>
 *  @param channelscenicspot <#channelscenicspot description#>
 *
 *  @return <#return value description#>
 */
-(RACSignal*)userCustomWithuserId:(NSString*)userId
                             withcontacts:(NSString*)contacts
                         withphone:(NSString*)phone
                         withtravelnum:(NSString*)travelnum
                         withtravelTime:(NSString*)travelTime
                        withdeparture:(NSString*)departure
                    withdestination:(NSString*)destination
                    withchannelscenicspot:(NSString*)channelscenicspot;
/**
 *  定制列表
 *
 *  @param index    <#index description#>
 *  @param pageSize <#pageSize description#>
 *
 *  @return <#return value description#>
 */
-(RACSignal*)userCustomListWithPageIndex:(NSString*)index
                      withPageSize:(NSString*)pageSize;
/**
 *  关注路线
 *
 *  @param index    <#index description#>
 *  @param pageSize <#pageSize description#>
 *
 *  @return <#return value description#>
 */
-(RACSignal*)userRouteWithPageIndex:(NSString*)index
                            withPageSize:(NSString*)pageSize;
/**
 *  关注的司机
 *
 *  @param index    <#index description#>
 *  @param pageSize <#pageSize description#>
 *
 *  @return <#return value description#>
 */
-(RACSignal*)userDriverListWithPageIndex:(NSString*)index
                       withPageSize:(NSString*)pageSize;
/**
 *  关注的游记
 *
 *  @param index    <#index description#>
 *  @param pageSize <#pageSize description#>
 *
 *  @return <#return value description#>
 */
-(RACSignal*)userTravelsListWithPageIndex:(NSString*)index
                            withPageSize:(NSString*)pageSize;

/**
 *  关注用户列表
 *
 *  @param index    <#index description#>
 *  @param pageSize <#pageSize description#>
 *
 *  @return <#return value description#>
 */
-(RACSignal*)userFollowUserListWithPageIndex:(NSString*)index
                             withPageSize:(NSString*)pageSize;
@end
