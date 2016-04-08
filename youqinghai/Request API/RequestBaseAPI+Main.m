
//
//  RequestBaseAPI+Main.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/22.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RequestBaseAPI+Main.h"

NSString *const getHomePageData = @"app/homepage/getHomePageData";
NSString *const getTouristroutesList = @"app/touristroutes/getTouristroutesList";
NSString *const getTourisDetails = @"app/touristroutes/getTourisDetails";
NSString *const getTourisEvaluate = @"app/touristroutes/getTourisEvaluate";
NSString *const getServiceIntroduction = @"app/touristroutes/getServiceIntroduction";
NSString *const addDriverOrRoteId = @"app/touristroutes/addDriverOrRoteId";

@implementation RequestBaseAPI (Main)

-(RACSignal *)getHomePageDataWithMark:(NSInteger)mark
                        withPageIndex:(NSInteger)pageIndex
                         withPageSize:(NSInteger)pageSize{
    
    NSString *params = [NSString stringWithFormat:@"server=%@&pageIndex=%ld&pageSize=%ld",getHomePageData,pageIndex,pageSize];
    
    return [self requestWithType:RequestAPITypePost
                          params:[self getDesEncryptWithString:params]];
}

-(RACSignal *)getTouristroutesListWithTypeId:(NSInteger)typeId
                               wihtPageIndex:(NSInteger)pageIndex
                                withPageSize:(NSInteger)pageSize{
    
    NSString *params = [NSString stringWithFormat:@"server=%@&typeId=%ld&pageIndex=%ld&pageSize=%ld",getTouristroutesList,typeId,pageIndex,pageSize];
    
    return [self requestWithType:RequestAPITypePost
                          params:[self getDesEncryptWithString:params]];
}

-(RACSignal *)getTourisDetailsWithTourisId:(NSInteger)tourisId
                                withUserId:(NSInteger)userId{
    
    NSString *params = [NSString stringWithFormat:@"server=%@&tourisId=%ld&userId=%ld",getTourisDetails,tourisId,userId];
    
    return [self requestWithType:RequestAPITypePost
                          params:[self getDesEncryptWithString:params]];
}

-(RACSignal *)getTourisEvaluateWithTourisId:(NSInteger)tourisId
                              withPageIndex:(NSInteger)pageIndex
                               withPageSize:(NSInteger)pageSize{
    
    NSString *params = [NSString stringWithFormat:@"server=%@&tourisId=%ld&pageIndex=%ld&pageSize=%ld",getTourisEvaluate,tourisId,pageIndex,pageSize];
    
    return [self requestWithType:RequestAPITypePost
                          params:[self getDesEncryptWithString:params]];
}

-(RACSignal *)getServiceIntroductionWithRouteId:(NSInteger)routeId{
    
    NSString *params = [NSString stringWithFormat:@"server=%@&routeId=%ld",getServiceIntroduction,routeId];
    
    return [self requestWithType:RequestAPITypePost params:[self getDesEncryptWithString:params]];
}

-(RACSignal *)addDriverOrRoteIdWithUserId:(NSInteger)userId withTypeId:(NSInteger)typeId withType:(NSInteger)type{
    
    NSString *parasm = [NSString stringWithFormat:@"server=%@&userId=%ld&typeId=%ld&type=%ld",addDriverOrRoteId,userId,typeId,type];
    
    return [self requestWithType:RequestAPITypePost params:[self getDesEncryptWithString:parasm]];
    
}
@end
