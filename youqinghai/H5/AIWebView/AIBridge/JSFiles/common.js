var common = new function(){
  var isIOS = false;
  var isAndroid = false;
  
  this.androidClient = function(){
    return isAndroid;
  };
  
  this.IOSClient = function(){
    return isIOS;
  };
  
  //递归检查HostApp常量是否注入，递归时间设定为0.1秒执行一次
  this.checkHostApp = function(callback){
    if(isAndroid){
      var mcounter = 0;
      var originCb = callback;
      callback = function(){
        if(!window.HostApp && mcounter++ < 15){
          setTimeout(callback, 100);
        } else {
          originCb();
        }
      }
      callback();
    } else {
      callback();
    }
  }
  
  
  /*
   * 与服务器端通讯，获取服务器端的数据
   * jsonObj  是json格式的字符串
   * url		服务器端servlet的路径，前面域名部分会自动拼接
   * jsCallback 回调js函数，具体可参考test1.html页面
   * */
  this.httpPost = function(jsonObj, url, jsCallback){
    if(isAndroid){
      HostApp.httpPost(jsonObj,url,jsCallback);
    } else if(isIOS){
      var jsParam = {'url':url};
      if(jsonObj != null) jsParam.param = jsonObj;
      sendMessage('sendHttpRequest:completion:', jsParam, jsCallback);
    }
  };
  
  /*
   * 打开新的页面，其中包含三中类型，可参考isInter参数说明
   * pagePath			类似url，根据不同的类型传递不同的url， 0和1时均为路径，-1时为公网路径。
   * jsonParam		传递的json格式的参数（需要传递的数据都通过此参数进行传递）
   * title			打开新的页面，页面标题是什么
   * isInter			-1 以http开头内容    0 访问积分服务器端动态页   1 加载模板html页面
   * jsonParam    如果当前页面需要缩放 则jsonParam里面需要添加一个key:isScales value:true/false。
   * */
  this.openPage = function(pagePath, jsonParam, title, isInter, isEncrpty){
    if(!jsonParam){
      jsonParam = {};
    }
    if(!isEncrpty){
      isEncrpty = false;
    }
    if(isAndroid){
      HostApp.openPage(pagePath, jsonParam, title, isInter, isEncrpty);
    } else if(isIOS){
      var jsParam = {'pagePath':pagePath,'title':title,'isInter':isInter, 'isEncrpty':isEncrpty};
		    if(jsonParam) jsParam.param = jsonParam;
		    sendMessage('openPage:',jsParam);
    }
  };
  
  /*获取页面之间传递的请求参数，name  为 参数名，返回参数值*/
  this.getParamValue = function(name){
    this.getUrlParam(name,function(msg){
                     if(null==msg || msg==""){
                     this.getParam(name,function(msg){
                                   return msg;
                                   });
                     }else{
                     return msg;
                     }
                     });
  };
  
  /*
   * 原生跳转H5页面时，通过此参数获取原生传递过来的数据。
   * key			获取数据的key值
   * jsCallback	js回调方法
   * */
  this.getUrlParam = function(key, jsCallback){
    if(isAndroid){
      HostApp.getUrlParam(key, jsCallback);
    } else if(isIOS){
      sendMessage('getValueFromURLParam:',key,jsCallback);
    }
  };
  
  /*
   * H5跳转H5页面时，通过此参数获取原生传递过来的数据。
   * key			获取数据的key值
   * jsCallback	js回调方法
   * */
  this.getParam = function(key, jsCallback){
    if(isAndroid){
      HostApp.getParam(key, jsCallback);
    } else if(isIOS){
      sendMessage('getValueFromJSParam:',key,jsCallback);
    }
  };
  
  /*
   * H5页面跳转回原生时使用。count 为-1时回到首页，0或者为空时跳到上一级的原生页。
   * */
  this.back = function(count){
    if(count != -1){
      count = 0;
    }
    if(isAndroid){
      HostApp.goBack(count);
    } else if(isIOS){
      var needReload = false;
      if(count==null){
        count=0;
      }
      if(needReload==null){
        needReload = false;
      }
      var jsonParam = {'count':count,'needReload':needReload};
      sendMessage('popByCount:',jsonParam);
    }
  };
  
  /*
   * H5页面间跳转
   * */
  this.backView = function(count){
    if(isAndroid){
      HostApp.back(count);
    } else if(isIOS){
      var needReload = false;
      if(count==null){
        count=0;
      }
      if(needReload==null){
        needReload = false;
      }
      var jsonParam = {'count':count,'needReload':needReload};
      sendMessage('popByCount:',jsonParam);
    }
  };
  
  /*
   * 业务：解决浏览历史问题（之前使用cookie保存，cookie过多之后会造成客户端白屏问题）
   * 解决：将比较大的数据保存到应用目录下
   * */
  this.saveWebViewData = function(key, value){
    if(isAndroid){
      HostApp.saveWebViewData(key,value);
    }
  };
  
  /*
   * 业务：解决浏览历史问题（之前使用cookie保存，cookie过多之后会造成客户端白屏问题）
   * 解决：从应用目录下获取数据
   * */
  this.getWebViewData = function(key, jsCallback){
    if(isAndroid){
      HostApp.getWebViewData(key, jsCallback);
    }
  };
  
  //////////////////绿点相关JS接口开始////////////////////
  
  this.getJFMallCachePath = function(jsCallback){
    if(isAndroid){
      HostApp.getJFMallCachePath(jsCallback);
    } else if(isIOS){
      sendMessage('getJFMallCachePath',null,jsCallback);
    }
  };
  
  
  /*
   * 获取用户TOKEN值
   * @return 用户TOKEN值
   */
  this.getToken = function(jsCallback){
    if(isAndroid){
      HostApp.getToken(jsCallback);
    } else if(isIOS){
      sendMessage('getToken',null,jsCallback);
    }
  };
  
  /*
   * 判断用户是否登录
   * @return 用户是否登录
   */
  this.isLogin = function(jsCallback){
    if(isAndroid){
      HostApp.isLogin(jsCallback);
    } else if(isIOS){
      sendMessage('isLogin',null,jsCallback);
    }
  };
  
  this.outTime = function(){
    if(isAndroid){
      return HostApp.timeOut();
    } else if(isIOS){
      sendMessage('outTime');
    }
  };
  
  this.showDialog1 = function(message){
    if(isAndroid){
      HostApp.showDialog(message);
    } else if(isIOS){
      
    }
  };
  
  this.showDialog2 = function(message, btnLeft, btnRight){
    if(isAndroid){
      HostApp.showDialog(message, btnLeft, btnRight);
    } else if(isIOS){
      
    }
  };
  
  this.dismissDialog = function(){
    if(isAndroid){
      HostApp.dismissDialog();
    } else if(isIOS){
      
    }
  };
  
  this.dismissProgressDialog = function(){
    if(isAndroid){
      HostApp.dismissProgressDialog();
    } else if(isIOS){
      
    }
  };
  
  this.showToast = function(message){
    if(isAndroid){
      HostApp.showToast(message);
    } else if(isIOS){
      sendMessage('messageOfToastStyle:',message);
    }
  };
  
  this.share = function(message1, message2){
    if(isAndroid){
      HostApp.showShareMenu(message1, message2);
    } else if(isIOS){
    }
  };
  
  /*
   * 显示登录框
   */
  this.toLoginView = function(){
    if(isAndroid){
      HostApp.showLoginWindow();
    } else if(isIOS){
      sendMessage('toLoginView');
    }
  };
  
  this.setPageTitle = function(title){
    if(isAndroid){
      HostApp.setPageTitle(title);
    } else if(isIOS){
      sendMessage('setPageTitle:',title)
    }
  };
  
  this.setRightButtonText = function(text){
    if(isAndroid){
      HostApp.setRightButtonText(text);
    } else if(isIOS){
      sendMessage('setRightBarItem:',text);
    }
  };
  
  /**设置导航栏上的纯文本按钮
   *barItemTitle:按钮文字
   *direction: 0 左侧 1右侧
   *fontSize: 按钮文字大小
   *color: 按钮文字颜色,16进制,如:#FFFFFF
   **/
  this.setTextBarItem = function(barItemTitle,direction,fontSize,color){
    if(isAndroid){
      HostApp.setRightButtonText(barItemTitle);
    } else if(isIOS){
      var jsParam = {'barItemTitle':barItemTitle};
      if(direction != null) {
        jsParam.direction = direction;
      }
      jsParam.fontSize = fontSize;
      if(color != null) jsParam.color = color;
      sendMessage('setTextBarItem:',jsParam);
    }
  };
  
  /**设置导航栏上的图片按钮
   *imagePath:图片路径
   *direction: 0 左侧 1右侧
   **/
  this.setImageBarItem = function(imagePath,direction){
    if(isAndroid){
    } else if(isIOS){
      var jsonParam = {'barItemImage':imagePath,'direction':direction};
      sendMessage('setImageBarItem:',jsonParam);
    }
  };
  
  //分别对应: 提示内容(必填)，左按钮(必填),右按钮(选填,可为null),弹窗的tag数值(选填)
  this.showSysAlert  =  function showSysAlert(message,leftButtonTitle,rightButtonTitle,index) {
    
    if(isAndroid){
    } else if(isIOS){
      var jsParam = {'message':message,'leftButtonTitle':leftButtonTitle};
      if(rightButtonTitle!=null)
        jsParam.rightButtonTitle = rightButtonTitle;
      if(index != 0)
        jsParam.index = index;
      sendMessage('showSysAlert:',jsParam);
    }
    
  }
  
  
  
  this.showDXAlert = function(title,message,leftButtonTitle,rightButtonTitle){
    if(isAndroid){
    } else if(isIOS){
      if(message == null) alert('message不能为空');
      var jsParam              = {'message':message};
      jsParam.title            = title;
      if(leftButtonTitle)
        jsParam.leftButtonTitle  = leftButtonTitle;
      if(rightButtonTitle)
        jsParam.rightButtonTitle = rightButtonTitle;
      sendMessage('showDXAlert:',jsParam);
    }
  };
  
  
  
  /*
   * 获取sessionID
   *
   */
  this.getSessionID= function(jsCallback){
    if(isAndroid){
      //安卓需补充
    } else if(isIOS){
      sendMessage('getSessionID',null,jsCallback);
    }
  };
  /*
   * 获取loginInfo
   *
   */
  this.getLoginInfo= function(jsCallback){
    if(isAndroid){
      //安卓需补充
    } else if(isIOS){
      sendMessage('getLoginInfo',null,jsCallback);
    }
  };
  /**
   *打开侧边栏
   */
  
  this.showMenu = function(){
    if(isAndroid){
      
    }else if (isIOS){
      sendMessage('showMenu');
    }
  }
  
  /**
   *加载菊花
   */
  this.showHUD = function() {
    if(isAndroid){
      
    }else if (isIOS) {
      sendMessage('showHUD');
    }
  }
  /**
   *加载菊花  自定义文字
   */
  this.showHUD = function(title) {
    if(isAndroid){
      
    }else if (isIOS) {
      sendMessage('showHUD:',title);
    }
  }
  /**
   *隐藏菊花
   */
  this.hideHUD = function() {
    if(isAndroid){
      
    }else if (isIOS) {
      sendMessage('hideHUD');
    }
  }
  /**
   *  当前页面刷新操作
   */
  this.refresh = function() {
    if(isAndroid){
      
    }else if(isIOS){
      sendMessage('refresh');
    }
  }
  //////////////////绿点相关JS接口结束////////////////////
  
  
  this.init = new function(){
    var u = navigator.userAgent, app = navigator.appVersion;
    var trident = u.indexOf('Trident') > -1; //IE内核
    var presto = u.indexOf('Presto') > -1; //opera内核
    var webKit = u.indexOf('AppleWebKit') > -1; //苹果、谷歌内核
    var gecko = u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1; //火狐内核
    var mobile = !!u.match(/AppleWebKit.*Mobile.*/) || !!u.match(/AppleWebKit/); //是否为移动终端
    var ios = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
                        var android = u.indexOf('Android') > -1 || u.indexOf('Linux') > -1; //android终端或者uc浏览器
                        var iPhone = u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1; //是否为iPhone或者QQHD浏览器
                        var iPad = u.indexOf('iPad') > -1; //是否iPad
                        var webApp = u.indexOf('Safari') == -1; //是否web应该程序，没有头部与底部
                        if(ios || iPhone || iPad){
                        isIOS = true;
                        } else if (android){
                        isAndroid = true;
                        }
                        };
                        return common;
                        };
                        
