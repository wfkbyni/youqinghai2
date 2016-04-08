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

#define pageSize 20

@implementation MainViewModel

-(instancetype)init{
    if (self = [super init]) {
        self.mark = 1;
    }
    return self;
}

-(RACSignal *)getHomePageData{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getHomePageDataWithMark:self.mark
                                                                 withPageIndex:1
                                                                  withPageSize:pageSize]
                         map:^id(id value) {
        
        self.homePageData = [HomePageData mj_objectWithKeyValues:value];
        
        return self.homePageData;
    }];
    
    return signal;
}

-(RACSignal *)getTouristroutesList{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getTouristroutesListWithTypeId:self.typeId
                                                                        wihtPageIndex:1
                                                                         withPageSize:pageSize]
                         map:^id(id value) {
        
        self.recommends = [Recommend mj_objectArrayWithKeyValuesArray:value];
        
        return self.recommends;
    }];
    
    return signal;
}

-(RACSignal *)getTourisDetails{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getTourisDetailsWithTourisId:self.typeId
                                                                         withUserId:myUserId]
                         map:^id(id value) {
       
        self.traveltrip = [Traveltrip mj_objectWithKeyValues:value];
        
        return self.traveltrip;
    }];
    
    return signal;
}

-(RACSignal *)getTourisEvaluate{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getTourisEvaluateWithTourisId:self.tourisId
                                                                       withPageIndex:1
                                                                        withPageSize:pageSize]
                         map:^id(id value) {
        
        self.tourisEvaluate = [TourisEvaluate mj_objectArrayWithKeyValuesArray:value];
        
        return self.tourisEvaluate;
    }];
    
    return signal;
}

-(RACSignal *)getServiceIntroduction{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getServiceIntroductionWithRouteId:self.tourisId]
                         map:^id(id value) {
                             
        return value;
    }];
    
    return signal;
}

-(RACSignal *)addDriverOrRoteId{
    RACSignal *signal = [[[RequestBaseAPI standardAPI] addDriverOrRoteIdWithUserId:myUserId
                                                                        withTypeId:self.tourisId
                                                                          withType:0]
                         map:^id(id value) {
        
                             
        return value;
    }];
    
    return signal;
    
    
}

@end
