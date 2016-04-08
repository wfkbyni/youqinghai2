//
//  Common.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/20.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#ifndef Common_h
#define Common_h

#define kScreenSize          [UIScreen mainScreen].bounds.size

#pragma mark - 调试
#define YQH_DEBUG

#ifdef YQH_DEBUG
#define YQHLog( s, ... ) NSLog( @"<%@:(%d)> %@", [[NSString stringWithFormat:@"%s",__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#define YQHDebugTimeStart NSDate *debugTimeStart = [NSDate date]
#define YQHDebugTimeEnd(str)  YQHLog(@"(%@)excute time: %@", str, @([[NSDate date] timeIntervalSinceDate:debugTimeStart]))
#else
#define YQHLog( s, ... )
#define YQHDebugTimeStart
#define YQHDebugTimeEnd(str)

#endif

#endif /* Common_h */
