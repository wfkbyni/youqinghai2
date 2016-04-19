# VODBCache(基于MJExtension和FMDB的数据缓存)

[![License Apache](http://img.shields.io/cocoapods/l/VODBCache.svg?style=flat)](https://raw.githubusercontent.com/pozi119/VODBCacheDemo/master/LICENSE)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/v/VODBCache.svg?style=flat)](http://cocoapods.org/?q=VODBCache)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/VODBCache.svg?style=flat)](http://cocoapods.org/?q=VODBCache)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%207%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
[![Build Status](https://travis-ci.org/pozi119/VODBCacheDemo.svg?branch=master)](https://travis-ci.org/pozi119/VODBCacheDemo)

* 本项目包含了 数据缓存(VODBCache), 网络请求缓存(VOURLCache).
* VOURLCache未经严格测试,慎用,使用CocoaPods不会导入VOURLCache.
* 以下只针对VODBCache作说明

# 功能说明:
* 项目中必须包含MJExtension和FMDB,主要用于缓存网络请求获取的JSON对象
* 只缓存数字和字符串类型的数据
* 支持数据的 增 删 改 查
* 可自动添加新字段(不支持从旧字段更名)
* 可自定义表名,默认使用数据模型的类名作为表名
* 可自动更新数据,结合allowUpdatePropertyNamesForCache 和 ignoredUpdatePropertyNamesForCache, 具体请参考注释
* 创建数据表时,会自动创建3个字段 voconstraint(唯一性约束), vocreatetime(创建时间), 更新时间(voupdatetime)

# 安装
* Cocoapods导入(会自动导入MJRefresh,FMDB):
```ruby
pod 'VODBCache'
```
* 手动导入
  * 将`VODBCache`文件夹的所有源码拽入项目
  * 使用Cocoapods或者手动导入MJExtension和FMDB

# 使用:
* 在数据模型的.h和需要使用VODBCache源码中包含头文件
* 1-6是在数据模型中实现的方法.
```objc
#import "NSObject+VODBCache.h"
```
1.在需要缓存的数据模型中实现 + load 方法如下:
```objc
+ (void)load{
	[self initVODBCache];
}
```
2.自定义表名,可选,默认使用类名作为表名
```objc
+ (NSString *)manualTableName{
    return @"weather";
}
```
3.数据唯一性约束,可选,建议都实现此方法.
```objc
- (NSString *)uniquenessConstraint{
    return [NSString stringWithFormat:@"%@%@%@", self.postCode, self.citycode, self.pinyin];
}
```
4.不缓存的属性字段,可选.
```objc
+ (NSArray  *)ignoredPropertyNamesForCache{
    return @[@"WD",@"WS"];
}
```
5.当发生冲突时只更新指定的属性(用法和4相同,示例代码中没有),可选.
```objc
+ (NSArray  *)allowUpdatePropertyNamesForCache{
    return @[@"WD",@"WS"];
}
```
6.当发生冲突时忽略更新的属性,优先级高于5(用法和4相同,示例代码中没有),可选.
```objc
+ (NSArray  *)ignoredUpdatePropertyNamesForCache{
    return @[@"WD",@"WS"];
}
```
7.增删改查使用方法请直接查看注释,增删改查使用的condition和sort均为NSArray类型,示例如下(来自目前开发的项目):
```objc
NSArray *condition = @[[NSString stringWithFormat:@"commentId = \"%@\"",@(comment.identifier)]];
NSArray *sort = @[@"submitTime DESC"];
[WXCommentReply objectsFromCacheWithCondition:condition sort:sort start:0 count:1 success:^(NSArray *array) {
    //do something with array (array 是 WXCommentReply 对象数组)
} failure:^(NSError *error) {
    //do something with error;
}];
```
   * a.具体查询是根据condition和sort拼接成SQL语句,当然也可以自己写SQL语句.
   * b.condition和sort数组的的字符串应注意双引号的使用
   
8.如运行时候,出现如下错误:
```ruby
 (19: UNIQUE constraint failed: weather.voconstraint)
```
此错误说明唯一性冲突,一般可忽略.如果缓存数据时 updateWhenConflict 为 YES, 出现此冲突则会自动更新相关字段的值
运行时console可能会有各种db操作的提示,此版本仍保持显示, 若要关闭,请自行修改代码, 在inTransaction的block中加入
```objc
db.logsErrors = NO;
```
# 备注
* 此版本VODBCache已经使用在公司的项目中,暂未发现明显问题.
* 准备研究Realm, VODBCache只进行维护.

欢迎大家多提issue.
