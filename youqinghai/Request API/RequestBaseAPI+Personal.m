//
//  RequestBaseAPI+Personal.m
//  youqinghai
//
//  Created by snailz on 16/3/28.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RequestBaseAPI+Personal.h"
#import "GTMBase64+Des.h"
#import "ZUserModel.h"
NSString *const personalMess = @"app/message/getMessageList";
NSString *const personalMessdetailed = @"app/message/getMessDetails";
NSString *const personalHeaderUrl = @"app/user/modifyTheAvatat";
NSString *const personalUserInfo = @"app/user/modifyUserInfo";
NSString *const personalPhone = @"app/smscheckcode/sendCheckCodeSms";
NSString *const personalModfPhone = @"app/user/modifyUserPhone";
NSString *const personalLoginPass = @"app/user/modifyLoginPass";
NSString *const personaladdCustom = @"app/customizedtourism/addCustomizedtoursm";
NSString *const personaladdCustomList = @"app/customizedtourism/getCustomizedTourismList";
NSString *const personalRoute = @"app/collection/getTravelsList";
NSString *const personalDriverList = @"app/collection/getFollowDriverList";
NSString *const personalTravelsList= @"app/collection/getFollowTravelsList";
NSString *const personalFollowUserList= @"app/collection/getFollowUserList";
NSString *const personalFeedBack= @"app/feedback/addFeedBack";
NSString *const personaldeleteMess= @"app/message/deleteMess";
NSString *const personalgetCustomizedDetails= @"app/customizedtourism/getCustomizedDetails";
@implementation RequestBaseAPI (Personal)
-(RACSignal *)messDataWithPageIndex:(NSString *)index withPageSize:(NSString *)pageSize
{
    NSString *param = [NSString stringWithFormat:@"server=%@&userId=%@&pageIndex=%@&pageSize=%@",personalMess,[ZUserModel shareUserModel ].userId,index,pageSize];
    param = [GTMBase64 desEncrypt:param];
    return [[self requestWithType:RequestAPITypePost params:param]map:^id(ResponseBaseData *data) {
        if (!data.result_data) {
            data.result_data = @"";
        }
        return data.result_data;
    }];
}
-(RACSignal *)ImageHeaderDataWithData:(NSData *)data
{
    NSDictionary *param = @{@"userId":@([ZUserModel shareUserModel].userId.integerValue)};
    return [[self ZpostApiString:personalHeaderUrl params:param attachKey:@"fileName" attachData:@[data]] map:^id(ResponseBaseData *data) {
        if (!data.result_data) {
            data.result_data = @"";
        }
        return data.result_data;
    }];
}
-(RACSignal *)addFeedBackWithData:(NSArray *)imageAr andText:(NSString *)text
{
    NSDictionary *param = @{@"userDrverId":@([ZUserModel shareUserModel].userId.integerValue),@"type":@"0",@"content":text};
    return [[self ZpostApiString:personalFeedBack params:param attachKey:@"fileName" attachData:imageAr]map:^id(ResponseBaseData *data) {
        if (!data.result_data) {
            data.result_data = @"";
        }
        return data.result_data;
    }];
}

-(RACSignal *)userInfoWithNickName:(NSString *)nickName withSex:(NSString *)sex withAutograph:(NSString *)autograph
{
        NSString *param = [NSString stringWithFormat:@"server=%@&userId=%@&nickname=%@&sex=%@&autograph=%@",personalUserInfo,[ZUserModel shareUserModel ].userId,nickName,sex,autograph];
     param = [GTMBase64 desEncrypt:param];
    return [[self requestWithType:RequestAPITypePost params:param]map:^id(ResponseBaseData *data) {
        if (!data.result_data) {
            data.result_data = @"";
        }
        return data.result_data;
    }];
}
-(RACSignal *)phoneWithphone:(NSString *)phone withtype:(NSString *)type withState:(NSString *)State
{
    NSString *param = [NSString stringWithFormat:@"server=%@&phone=%@&type=%@&state=%@",personalPhone,phone,type,State];
    param = [GTMBase64 desEncrypt:param];
    return [[self requestWithType:RequestAPITypePost params:param]map:^id(ResponseBaseData *data) {
        if (!data.result_data) {
            data.result_data = @"";
        }
        return data.result_data;
    }];
}
-(RACSignal *)userModfPhoneWithuserId:(NSString *)userId witholdTel:(NSString *)oldTel withnewTel:(NSString *)newTel withcodesms:(NSThread *)codesms withtype:(NSString *)type
{
    NSString *param = [NSString stringWithFormat:@"server=%@&userId=%@&oldTel=%@&newTel=%@&codesms=%@&type=%@",personalModfPhone,userId,oldTel,newTel,codesms,type];
    param = [GTMBase64 desEncrypt:param];
    return [[self requestWithType:RequestAPITypePost params:param]map:^id(ResponseBaseData *data) {
        if (!data.result_data) {
            data.result_data = @"";
        }
        return data.result_data;
    }];
}
-(RACSignal *)userLoginPassWithuserId:(NSString *)userId withTel:(NSString *)tel witholdpass:(NSString *)oldpass withcodesms:(NSString *)codesms withnewpass:(NSString *)newpass withtype:(NSString *)type
{
    NSString *param = [NSString stringWithFormat:@"server=%@&userId=%@&tel=%@&oldpass=%@&smscode=%@&newpass=%@&type=%@",personalLoginPass,userId,tel,oldpass,codesms,newpass,type];
    param = [GTMBase64 desEncrypt:param];
    return [[self requestWithType:RequestAPITypePost params:param]map:^id(ResponseBaseData *data) {
        if (!data.result_data) {
            data.result_data = @"";
        }
        return data.result_data;
    }];
}
-(RACSignal *)messdetailedWithmessId:(NSString *)messId
{
    NSString *param = [NSString stringWithFormat:@"server=%@&messId=%@ ",personalMessdetailed,messId];
    param = [GTMBase64 desEncrypt:param];
    return [[self requestWithType:RequestAPITypePost params:param]map:^id(ResponseBaseData *data) {
        if (!data.result_data) {
            data.result_data = @"";
        }
        return data.result_data;
    }];
}
-(RACSignal *)userCustomWithuserId:(NSString *)userId withcontacts:(NSString *)contacts withphone:(NSString *)phone withtravelnum:(NSString *)travelnum withtravelTime:(NSString *)travelTime withdeparture:(NSString *)departure withdestination:(NSString *)destination withchannelscenicspot:(NSString *)channelscenicspot
{
    NSString *param = [NSString stringWithFormat:@"server=%@&userId=%@&contacts=%@&phone=%@&travelnum=%@&travelTime=%@&departure=%@&destination=%@&channelscenicspot=%@",personaladdCustom,userId,contacts,phone,travelnum,travelTime,departure,destination,channelscenicspot];
    param = [GTMBase64 desEncrypt:param];
    return [[self requestWithType:RequestAPITypePost params:param]map:^id(ResponseBaseData *data) {
        if (!data.result_data) {
            data.result_data = @"";
        }
        return data.result_data;
    }];
}
-(RACSignal *)userCustomListWithPageIndex:(NSString *)index withPageSize:(NSString *)pageSize
{
    NSString *param = [NSString stringWithFormat:@"server=%@&userId=%@&pageIndex=%@&pageSize=%@",personaladdCustomList,[ZUserModel shareUserModel ].userId,index,pageSize];
    param = [GTMBase64 desEncrypt:param];
    return [[self requestWithType:RequestAPITypePost params:param]map:^id(ResponseBaseData *data) {
        if (!data.result_data) {
            data.result_data = @"";
        }
        return data.result_data;
    }];
}
-(RACSignal *)userRouteWithPageIndex:(NSString *)index withPageSize:(NSString *)pageSize
{
    NSString *param = [NSString stringWithFormat:@"server=%@&userId=%@&pageIndex=%@&pageSize=%@",personalRoute,[ZUserModel shareUserModel ].userId,index,pageSize];
    param = [GTMBase64 desEncrypt:param];
    return [[self requestWithType:RequestAPITypePost params:param]map:^id(ResponseBaseData *data) {
        if (!data.result_data) {
            data.result_data = @"";
        }
        return data.result_data;
    }];
}
-(RACSignal *)userDriverListWithPageIndex:(NSString *)index withPageSize:(NSString *)pageSize
{
    NSString *param = [NSString stringWithFormat:@"server=%@&userId=%@&pageIndex=%@&pageSize=%@",personalDriverList,[ZUserModel shareUserModel ].userId,index,pageSize];
    param = [GTMBase64 desEncrypt:param];
    return [[self requestWithType:RequestAPITypePost params:param]map:^id(ResponseBaseData *data) {
        if (!data.result_data) {
            data.result_data = @"";
        }
        return data.result_data;
    }];
}
-(RACSignal *)userTravelsListWithPageIndex:(NSString *)index withPageSize:(NSString *)pageSize
{
    NSString *param = [NSString stringWithFormat:@"server=%@&userId=%@&pageIndex=%@&pageSize=%@",personalTravelsList,[ZUserModel shareUserModel ].userId,index,pageSize];
    param = [GTMBase64 desEncrypt:param];
    return [[self requestWithType:RequestAPITypePost params:param]map:^id(ResponseBaseData *data) {
        if (!data.result_data) {
            data.result_data = @"";
        }
        return data.result_data;
    }];
}
-(RACSignal *)userFollowUserListWithPageIndex:(NSString *)index withPageSize:(NSString *)pageSize
{
    NSString *param = [NSString stringWithFormat:@"server=%@&userId=%@&pageIndex=%@&pageSize=%@",personalFollowUserList,[ZUserModel shareUserModel ].userId,index,pageSize];
    param = [GTMBase64 desEncrypt:param];
    return [[self requestWithType:RequestAPITypePost params:param]map:^id(ResponseBaseData *data) {
        if (!data.result_data) {
            data.result_data = @"";
        }
        return data.result_data;
    }];
}
-(RACSignal *)userMessDeleteWithmessId:(NSString *)messId
{
    NSString *param = [NSString stringWithFormat:@"server=%@&messId=%@",personaldeleteMess,messId];
    param = [GTMBase64 desEncrypt:param];
    return [[self requestWithType:RequestAPITypePost params:param]map:^id(ResponseBaseData *data) {
        if (!data.result_data) {
            data.result_data = @"";
        }
        return data.result_data;
    }];
}
-(RACSignal *)userCustomDetailWithcustomId:(NSString *)customId
{
    NSString *param = [NSString stringWithFormat:@"server=%@&customId=%@",personalgetCustomizedDetails,customId];
    param = [GTMBase64 desEncrypt:param];
    return [[self requestWithType:RequestAPITypePost params:param]map:^id(ResponseBaseData *data) {
        if (!data.result_data) {
            data.result_data = @"";
        }
        return data.result_data;
    }];
}
@end
