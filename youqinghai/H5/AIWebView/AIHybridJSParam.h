//
//  AIHybridJSParam.h
//  AIWebView
//
//  Created by mouxiaochun on 15/8/21.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 *  来自JS的参数类型
 */
typedef NSDictionary JSDictionary ;
typedef NSMutableDictionary JSMDictionary;




#pragma mark ---

/**
 *   Webview 加载文件路径类型
 */
typedef NS_ENUM(NSUInteger, HybridWebViewLoadType){
    /**
     *  模板文件 -->  documents下面的文件加载
     */
    HybridWebViewLoadType_Templet = 0,
    /**
     *  本地工程文件 -->  bundle下面文件加载
     */
    HybridWebViewLoadType_Local = 1,
    /**
     *  远程url加载
     */
    HybridWebViewLoadType_URL = 2
};
/**
 *   从JS中获取的url类型
 */
typedef NS_ENUM(NSInteger, HybridUrlLoadType){
    /**
     *  -1公网地址,需要拼接本地已配置好的服务器地址
     */
    HybridUrlLoadType_Public = -1,
    /**
     *  直接加载远程url
     */
    HybridUrlLoadType_URL = 0,
    
    /**
     *  加载模板文件
     */
    HybridUrlLoadType_Templet = 1
};




////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////

static NSString *key_FileURL      = @"key_FileURL";
static NSString *key_NestedPush   = @"key_NestedPush";
static NSString *key_UrlLoadType  = @"key_UrlLoadType";
static NSString *key_WebviewLoadType  = @"key_WebviewLoadType";
static NSString *key_ParamFromURL     = @"paramFromURL";

static NSString *key_PagePath   = @"pagePath";//加载url路径
static NSString *key_Encrypt    = @"isEncrpty";//网络请求时是否需要加密
static NSString *key_JSParam    = @"param";   //从JS中传入的参数用于网络请求
static NSString *key_Title      = @"title";   //在push新VC时，设置VC的标题
static NSString *key_IsInter      = @"isInter";
static NSString *key_IsScales   = @"isScales"; //在push新VC,设置新VC的web view自适应属性

////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////





@interface UIWebView (JSParam)
#pragma mark -- Properties


@property (nonatomic, strong) JSMDictionary *jsonParam;

@property (nonatomic, strong) JSMDictionary *paramFromURL;

/**
 *  从JS中获取到的url类型
 */
@property (nonatomic, assign) HybridUrlLoadType urlLoadType;
/**
 *  webview加载文件的路径类型
 */
@property (nonatomic, assign) HybridWebViewLoadType webviewLoadType;

/**
 *  YES 需要加密，NO 不需要加密
 */
@property (nonatomic, assign) BOOL isEncrypt;

/**
 *  文件路径，本地文件、模板文件、远程链接
 */
@property (nonatomic, strong)  NSString *fileURL;

/**
 *  url类型 -1公网地址 0积分动态页面(如jsp) 1积分模板页面 2 加载本地bundle文件
 */
@property (nonatomic, strong) NSString *isInter;

/*
 * 是否需要UI Web View自适应内容  isScales YES 需要 NO 不需要
 */
@property (nonatomic, assign) BOOL isScales;
/**
 *  加载前的参数处理
 */
-(void)preparedForLoad;

/**
 *  从JSParam中根据Key值获取对应的值，当遇到取出的对象是数组或字典时，则转成json字符串再回传给js
 *
 *  @param key
 *
 *  @return 字符串
 */
- (id) getValueFromJSParam: (NSString* ) key;

/**
 * 从paramFromURL中根据Key值获取对应的值，当遇到取出的对象是数组或字典时，则转成json字符串再回传给js
 *
 *  @param key
 *
 *  @return 字符串
 */
- (id) getValueFromURLParam:(NSString *)key;

@end


@interface UIViewController (JSParam)


/**
 *  YES 已经push了一个新VC，则openPage不会打开新VC
 */
@property (nonatomic, assign) BOOL isNestedPush;

@property (nonatomic, strong) JSMDictionary *jsonParamForNative;

/**
 *  从JSParam中根据Key值获取对应的值，当遇到取出的对象是数组或字典时，则转成json字符串再回传给js
 *
 *  @param key
 *
 *  @return 字符串
 */
- (id) getValueFromJSParamForNative: (NSString* ) key;

- (id) getValueFromJSParam:(NSString *)key;

- (id) getValueFromURLParam:(NSString *)key;

@end




