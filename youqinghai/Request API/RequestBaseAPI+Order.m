//
//  RequestBaseAPI+Order.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RequestBaseAPI+Order.h"

NSString const *calcCharteredPrice = @"app/payOrder/calcCharteredPrice";
NSString const *addOrder = @"app/payOrder/addOrder";
NSString const *calcPrice = @"app/payOrder/calcPrice";

NSString const *notifyUrl = @"app/paycall/notifyUrl";
NSString const *cancelOrder = @"app/myOrder/cancelOrder";
NSString const *removeOrder = @"app/myOrder/removeOrder";

NSString const *getUserOrderList = @"app/myOrder/getUserOrderList";
NSString const *getUserOrderDetail = @"app/myOrder/getOrderDetails";

NSString *const sendEva = @"app/myOrder/evaluationFeatureOrDriver";
@implementation RequestBaseAPI (Order)

-(RACSignal *)calcCharteredPriceWithTraveId:(NSInteger)traveId
                              withCarTypeId:(NSInteger)driverId
                            withIsInsurance:(NSInteger)isInsurance{
    
    NSString *params = [NSString stringWithFormat:@"server=%@&traveId=%ld&driverId=%ld",calcCharteredPrice,traveId,driverId];//[NSString stringWithFormat:@"server=%@&traveId=%ld&carTypeId=%ld&isInsurance=%ld",calcCharteredPrice,traveId,carTypeId,isInsurance];
    
    return [self requestWithType:RequestAPITypePost params:[self getDesEncryptWithString:params]];
}

-(RACSignal *)calcPriceWithTraveId:(NSInteger)traveId{
    NSString *params = [NSString stringWithFormat:@"server=%@&traveId=%ld",calcPrice,traveId];
    
    return [self requestWithType:RequestAPITypePost params:[self getDesEncryptWithString:params]];
}

-(RACSignal *)addOrderWithOrder:(Order *)order{
    
    NSString *params = [order mj_JSONString];
    params = [params stringByReplacingOccurrencesOfString:@"{" withString:@""];
    params = [params stringByReplacingOccurrencesOfString:@"}" withString:@""];
    params = [params stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    params = [params stringByReplacingOccurrencesOfString:@":" withString:@"="];
    params = [params stringByReplacingOccurrencesOfString:@"," withString:@"&"];
    params = [NSString stringWithFormat:@"server=%@&%@",addOrder,params];
    return [self requestWithType:RequestAPITypePost params:[self getDesEncryptWithString:params]];
}


-(RACSignal *)getUserOrderList:(NSInteger)userId
                           wihtState:(NSInteger)state
                        withPageIndex:(NSInteger)pageIndex
                         withPageSize:(NSInteger)pageSize{
    
    NSString *params;
    if (state >= 0) {
        params = [NSString stringWithFormat:@"server=%@&userId=%ld&state=%ld&pageIndex=%ld&pageSize=%ld",getUserOrderList,userId,state,pageIndex,pageSize];
    }else{
        params = [NSString stringWithFormat:@"server=%@&userId=%ld&pageIndex=%ld&pageSize=%ld",getUserOrderList,userId,pageIndex,pageSize];
    }
    
    return [self requestWithType:RequestAPITypePost params:[self getDesEncryptWithString:params]];
}
-(RACSignal *)getUserOrderDetailOrderId:(NSString*)orderId
{
    NSString *params= [NSString stringWithFormat:@"server=%@&orderId=%@",getUserOrderDetail,orderId];
        return [self requestWithType:RequestAPITypePost params:[self getDesEncryptWithString:params]];
}


-(RACSignal *)notifyUrlWithOutTradeNo:(NSString *)out_trade_no withTotalFee:(NSString *)totalFee{
    
    NSString *params = [NSString stringWithFormat:@"server=%@&out_trade_no=%@&total_fee=%@",notifyUrl,out_trade_no,totalFee];
    
    return [self requestWithType:RequestAPITypePost params:[self getDesEncryptWithString:params]];
}

-(RACSignal *)cancelOrderWithOrderNo:(NSString *)orderNo{
    NSString *params = [NSString stringWithFormat:@"server=%@&orderId=%@",cancelOrder,orderNo];
    return [self requestWithType:RequestAPITypePost params:[self getDesEncryptWithString:params]];
}

-(RACSignal *)removeOrder:(NSString *)orderId{
    NSString *params = [NSString stringWithFormat:@"server=%@&orderId=%@",removeOrder,orderId];
    return  [self requestWithType:RequestAPITypePost params:[self getDesEncryptWithString:params]];
}
-(RACSignal *)sendEvaWithtourisId:(NSString *)tourisId withorderId:(NSString *)orderId withImageAr:(NSArray *)imageAr withcontent:(NSString *)content withscore:(NSString *)score withcontents:(NSString *)contents
{
    NSDictionary *param = @{@"tourisId":tourisId?tourisId:@"",@"orderId":orderId?orderId:@"",@"content":content?content:@"",@"score":content?content:@"",@"contents":contents?contents:@""};
    return[ [self ZpostApiString:sendEva params:param attachKey:@"fileName" attachData:imageAr] map:^id(ResponseBaseData *data) {
        if (!data.result_data) {
            data.result_data = @"";
        }
        return data.result_data;
    }];
}
@end
