//
//  JSParamHandler.m
//  JSToNativeDemo
//
//  Created by mouxiaochun on 15/7/9.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import "JSParamHandler.h"
@implementation NSString (JSParam)
/**
 *  将URL路径'?'后的参数剔除
 *
 *  @return 剔除参数后的路径
 */
- (NSString* ) trimParamsOfURL{
    
    NSRange range = [self rangeOfString:@"?"];
    if (range.location != NSNotFound) {
        NSString *url = [self stringByReplacingCharactersInRange:NSMakeRange(range.location, self.length-range.location) withString:@""];
        return url;
    }
    return self;
}

/**
 *  对字符串进行编码
 *
 *  @param encodeType 编码类型
 *
 *  @return 编码后的字符串
 */
- (NSString* ) urlEncode:(UrlStringEncodeType)encodeType{
    NSString *urlString = @"";
    if (encodeType == UrlStringEncodeType_UTF8onlyChinese) {
        urlString = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }else if (encodeType == UrlStringEncodeType_UTF8){
        urlString = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil,(CFStringRef)self, nil,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
    }
    return urlString;
}


/**
 *  解析url获取 参数转换成字典
 *
 *  @param encodeType 编码类型
 *
 *  @return
 */
- (NSMutableDictionary* ) trimParamsFromURL:(UrlStringEncodeType)encodeType{
    if(self.length>0){
        NSRange range = [self rangeOfString:@"?"];
        if(range.location!=NSNotFound){
            NSString *url = @"";
            range = NSMakeRange(0, range.location+1);
            url = [self stringByReplacingCharactersInRange:range withString:@""];
            NSArray* params =[url componentsSeparatedByString:@"&"];
            NSMutableDictionary *returnDic = [NSMutableDictionary new];
            for (NSString *paramStr in params) {
                NSArray* aParam =[paramStr componentsSeparatedByString:@"="];
                if (aParam.count>=2) {
                    NSString *value = aParam[1];
                    //对value 进行utf-8编码
                    value = [value urlEncode:encodeType];
                    [returnDic setValue:value forKey:aParam[0]];
                }
            }
            if ([returnDic allKeys].count>0) {
                return returnDic;
            }
        }
        
    }
    return nil;
}


@end


/*** 加密key值 和 value的字段需要与服务端统一 ***/
/*** 服务端会根据这两个值进行解密 ***/

static NSString *Crypt_Key = @"Crypt_Key";
static NSString *Crypt_Value = @"Crypt_Value";

@implementation NSDictionary (JSParam)
/**
 *  将字典中的字段拼凑成中‘&key=value’的形式
 *
 *  @param encodeType 编码类型
 *
 *  @return 拼凑后的字符串
 */
- (NSString* ) urlParamToString:(UrlStringEncodeType)encodeType{
    __block NSMutableString *urlParamString = [NSMutableString new];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *keyUrlEncode = [NSString stringWithFormat:@"%@",key];
        NSString *valueUrlEncode = [NSString stringWithFormat:@"%@",obj];
        
        valueUrlEncode = [valueUrlEncode urlEncode:encodeType];
        
        [urlParamString appendFormat:@"&%@=%@",keyUrlEncode,valueUrlEncode];
    }];
    return urlParamString;
}

/**
 *  参数加密，key值，是随机生成的一个字符串 
 *
 *  @return 加密后的数据
 */
- (NSMutableDictionary* ) encryptParams{
    //将NSDictionary转为json字符串
    NSMutableDictionary *rtnParam = nil;
    
    return rtnParam;
}


/**
 *  从字典中根据Key值获取对应的值，当遇到取出的对象是数组或字典时，则转成json字符串再回传给js
 *
 *  @param key
 *
 *  @return 字符串
 */
- (id) getValueFromJSParam: (NSString* ) key {
    if (![key isKindOfClass:[NSString class]])
        return nil;
    
    key = [key stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (key.length == 0) return nil;
    id keyValue = [self objectForKey:key];
    if([keyValue isKindOfClass:[NSDictionary class]]||[keyValue isKindOfClass:[NSArray class]]){
        NSData *data = [NSJSONSerialization dataWithJSONObject:keyValue options:NSJSONWritingPrettyPrinted error:nil];
        NSString *value = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
      //如果遇到json串里面有'\' 则将其替换掉
      NSRange range = [value rangeOfString:@"\\"];
      if (range.location > 0) {
        value = [value stringByReplacingOccurrencesOfString:@"\\" withString:@""];
      }
      return value;
    }else{
        return keyValue;
    }
}


@end
