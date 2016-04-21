//
//  ZCarEvaViewController.h
//  youqinghai
//
//  Created by snailz on 16/4/21.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface carEva :NSObject
@property (nonatomic, strong) NSMutableArray *evalist;
@property(nonatomic,copy)NSString *commentsEva;
@property(nonatomic,copy)NSString *bad;
@property(nonatomic,copy)NSString *praise;
@property(nonatomic,copy)NSString *countEva;
 
@end
@interface ZCarEvaViewController : BaseViewController
@property(nonatomic,copy)NSString *driverId;
@end
//"eavList": [
//{
//    "content": "服务很好，",
//    "id": 1,
//    "nickname": "yang",
//    "evatTime": 1457426579791,
//    "driverId": 1,
//    "headUrl": "9874562.jpg",
//    "eavscore": 3
//}
//            ],
//"commentsEva": 中评数,
//"bad": 差评数,
//"praise": 好评数,
//"countEva": 总评论数