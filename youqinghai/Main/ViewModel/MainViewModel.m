//
//  MainViewModel.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/22.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "MainViewModel.h"
#import "RequestBaseAPI+Main.h"

#import "HomePageData.h"

#define pageSize 10

@implementation MainViewModel

-(instancetype)init{
    if (self = [super init]) {
        self.mark = 1;
        self.pageIndex = 1;
    }
    return self;
}

-(RACSignal *)getHomePageData{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getHomePageDataWithMark:self.mark
                                                                 withPageIndex:self.pageIndex
                                                                  withPageSize:pageSize]
                         map:^id(ResponseBaseData *data) {
        
                             if (!self.homePageData || self.pageIndex == 1) {
                                 self.homePageData = [HomePageData mj_objectWithKeyValues:data.result_data];
                             }else{
                                 HomePageData *homePageData = [HomePageData mj_objectWithKeyValues:data.result_data];
                                 
                                 NSArray *recommends = homePageData.recommend;
                                 NSMutableArray *arrays = [NSMutableArray arrayWithArray:self.homePageData.recommend];
                                 [arrays addObjectsFromArray:recommends];
                                 self.homePageData.recommend = arrays;
                             }
        
        return self.homePageData;
    }];
    
    return signal;
}

-(RACSignal *)getTouristroutesList{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getTouristroutesListWithTypeId:self.typeId
                                                                        wihtPageIndex:self.pageIndex
                                                                         withPageSize:pageSize]
                         map:^id(ResponseBaseData *data) {
        
        self.recommends = [Recommend mj_objectArrayWithKeyValuesArray:data.result_data];
        
        return self.recommends;
    }];
    
    return signal;
}

-(RACSignal *)getTourisDetails{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getTourisDetailsWithTourisId:self.typeId
                                                                         withUserId:[[ZUserModel shareUserModel].userId integerValue]]
                         map:^id(ResponseBaseData *data) {
       
        self.traveltrip = [Traveltrip mj_objectWithKeyValues:data.result_data];
        
        return self.traveltrip;
    }];
    
    return signal;
}

-(RACSignal *)getTourisEvaluate{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getTourisEvaluateWithTourisId:self.tourisId
                                                                       withPageIndex:self.pageIndex
                                                                        withPageSize:pageSize]
                         map:^id(ResponseBaseData *data) {
        
        self.tourisEvaluate = [TourisEvaluate mj_objectArrayWithKeyValuesArray:data.result_data];
        
        return self.tourisEvaluate;
    }];
    
    return signal;
}

-(RACSignal *)getServiceIntroduction{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getServiceIntroductionWithRouteId:self.tourisId]
                         map:^id(ResponseBaseData *data) {
                             
        return data.result_data;
    }];
    
    return signal;
}

-(RACSignal *)addDriverOrRoteIdWithUserId:(NSInteger)userId withTravelId:(NSInteger)travelId withType:(NSInteger)type{
    RACSignal *signal = [[[RequestBaseAPI standardAPI] addDriverOrRoteIdWithUserId:userId
                                                                        withTypeId:travelId
                                                                          withType:type]
                         map:^id(ResponseBaseData *data) {
        
                             
        return data;
    }];
    
    return signal;
    
}

-(RACSignal *)addTravelsUserCollectionWithUserId:(NSInteger)userId withTravelId:(NSInteger)travelId withType:(NSInteger)type{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] addTravelsUserCollectionWithUserId:userId withTravelId:travelId withType:type] map:^id(ResponseBaseData *data) {
       
        return data
        ;    }];
    
    return signal;
}

@end
