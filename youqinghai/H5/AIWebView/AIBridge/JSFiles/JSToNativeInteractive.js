//引入JS文件
//document.write('<script src="../scripts/ipu/JSToNativeCommon.js"><\/script>')
document.write('<script src="JSToNativeCommon.js"><\/script>')
//****************************对外提供js方法定义区**********************************
/**备注:以下方法只作为实例提供给common.js文件书写**/


////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////游青海需要使用到的JS接口////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////

/**
 ** 调用分享
 **/
function jumpToNativeTravelShare(title,introduce,Id,imageURL){
    var jsParam = {'title':title,'introduce':introduce,'Id':Id,'imageURL':imageURL};
    sendMessage('jumpToNativeTravelShare:',jsParam)
    
}

/**
 ** 获取当前APP登陆用户的ID，如果木有登陆需要跳转到登陆页面，还回值为空
 **/
function getUserIdNeedLogin(jsCallback) {

    sendMessage('getUserIdNeedLogin',null,jsCallback)

}
/**
 ** 获取当前APP登陆用户的ID，如果木有登陆不需要跳转到登陆页面，还回值为空
 **/
function getUserIdNotNeedLogin(jsCallback) {
    
    sendMessage('getUserIdNotNeedLogin',null,jsCallback)
    
}
/**
 ** 跳转到游记详情
 **/
function jumpToTravelDetail(title,travelsId) {
    openPage('assets/html/travels_details.html',{'travelsId':travelsId},title,0,false);
    
}
/**
 ** 跳转到游记个人详情
 **/
function jumpToPersonDetail(title,userid){

    openPage('assets/html/travels_personal.html',{'userid':userid},title,0,false);

}
/**
 ** 拉起评论
 **/
function jumpToTravelComment(travelId) {
    sendMessage('jumpToTravelComment')
}

/**
 ** 返回上一页
 **/
function clickreturn () {
    popByCount(1,false);
}

/**
 **获取参数,这里需要注意的是，获取当前页面的参数，统一使用这个接口，
 **不管是travelsId,还是userid，
 **js端传的什么key,就拿什么key来取
 **/
function getValueFromJSParam(key,jsCallback){
    sendMessage('getValueFromJSParam:',key,jsCallback);
}


function getTravelId(jsCallback) {
    sendMessage('getValueFromJSParam:','travelsId',jsCallback);
    
}

function getTravelPersonId(jsCallback) {
    sendMessage('getValueFromJSParam:','userid',jsCallback);

}


///////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////游青海JS接口**END////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////


//设置页面标题
function setPageTitle (title)
{
    sendMessage('setPageTitle:',title)
}

//返回按钮
function  backButtonAction()
{
    sendMessage('backButtonAction');
}
//关闭加载框
function  hideHUD()
{
    sendMessage('hideHUD');
}
//显示加载框
function  showHUD()
{
    sendMessage('showHUD');
}

function showHUD(title) {
  sendMessage('showHUD:',title);
}

function showToast(msg)
{
    sendMessage('showToast:',msg);
}

//跳转到下一个页面
function  openPage (pagePath, jsonParam, title, isInter,isEncrpty){
    var jsParam = {'pagePath':pagePath,'isInter':isInter,'isEncrpty':isEncrpty};
    if(jsonParam) jsParam.param = jsonParam;
    if(title) jsParam.title = title;
    sendMessage('openPage:',jsParam);
}

function openNativePage (className,jsonParam,title){
    var jsParam = {'className':className};
    if(jsonParam) jsParam.param = jsonParam;
    if(title) jsParam.title = title;
    sendMessage('openNativePage:',jsParam);
}

/**
 *  通过OC端发送请求
 *
 *  @param url        请求url
 *  @param jsonObj    请求参数
 *  @param isEncrpty  是否加密
 *  @param cache      true,使用缓存
 *  @param jsCallback
 *
 */
function postRequestFromJS (url,jsonObj,isEncrpty,cache,jsCallback)
{
    if(url == null) return;//url无效
    var jsParam = {'url':url};
    //一定要判断jsonObj是否有值，否则会导致发送消息失败
    if(jsonObj) jsParam.param = jsonObj;
    jsParam.isEncrpty = isEncrpty;
    jsParam.cache = cache;
    sendMessage('postRequestFromJS:completion:', jsParam, jsCallback);
}



//回退
function popByCount (count,needReload){
    if(count==null){
        count=0;
    }
    if(needReload==null){
        needReload = false;
    }
    var jsonParam = {'count':count,'needReload':needReload};
    sendMessage('popByCount:',jsonParam);
}


//当前页面刷新
function refresh() {
  sendMessage('refresh');
}

function setImageBarItem(imagePath,direction) {
    
    var jsonParam = {'barItemImage':imagePath,'direction':direction};
    sendMessage('setImageBarItem:',jsonParam);
}


function showCustomAlert(title,message,leftButtonTitle,rightButtonTitle,jsCallback) {
     if(message == null) alert('message不能为空');
    var jsParam              = {'message':message};
    jsParam.title            = title;
    if(leftButtonTitle)
        jsParam.leftButtonTitle  = leftButtonTitle;
    if(rightButtonTitle)
        jsParam.rightButtonTitle = rightButtonTitle;
    sendMessage('showCustomAlert:',jsParam,jsCallback);
}


function toLoginView () {
    
    sendMessage('toLoginView');
}

//设置右上角按钮
function setRightBarItem(title){
    sendMessage('setRightBarItem:',title);
}

//设置左上角按钮
function setLeftBarItem(){
    sendMessage('setLeftBarItem');
}

//设置左上角返回按钮

function setBackBarItem(){
    sendMessage('setBackBarItem');
}

//到侧边栏
function showMenu(){
    sendMessage('showMenu');
}


 function setTextBarItem(barItemTitle,direction,fontSize,color) {
    
    var jsParam = {'barItemTitle':barItemTitle};
    if(direction != null) {
        jsParam.direction = direction;
    }
    jsParam.fontSize = fontSize;
    if(color != null) jsParam.color = color;
    sendMessage('setTextBarItem:',jsParam)
}




//获取url参数
function getValueFromURLParam(key,jsCallback){
    sendMessage('getValueFromURLParam:',key,jsCallback);
}

//保存SessionID
function saveSessionID(sessionID) {
    sendMessage('saveSessionID:',sessionID);
}

//获取sessionID
function getSessionID(jsCallback) {

    sendMessage('getSessionID',null,jsCallback);
}

//保存loginInfo
function saveLoginInfo(loginInfo) {
  sendMessage('saveLoginInfo:',loginInfo);
}

//获取登录loginInfo
function getLoginInfo(jsCallback)
{
  sendMessage('getLoginInfo',null,jsCallback);
}

//消息提示 类似安卓的toast效果
function showToast(message) {

    sendMessage('messageOfToastStyle:',message);
}

//分别对应: 提示内容(必填)，左按钮(必填),右按钮(选填,可为null),弹窗的tag数值(选填)
function showSysAlert(message,leftButtonTitle,rightButtonTitle,index) {
    
    var jsParam = {'message':message,'leftButtonTitle':leftButtonTitle};
    if(rightButtonTitle!=null)
        jsParam.rightButtonTitle = rightButtonTitle;
    if(index != 0)
        jsParam.index = index;
    sendMessage('showSysAlert:',jsParam);
}

function testMethods(){
    
    sendMessage('testMethod:params2:params3:block:','abc');
    
}

function registerKeyboardEvent() {
    
    sendMessage('registerKeyboardEvent');
}




/*
 var clickObj =new function(){
 this.leftButtonClick = function(){
 alert('你点击了左侧原生按钮！');
 backButtonAction();
 };
 
 this.rightButtonClick = function(){
 alert('你点击了右侧原生按钮！');
 
 };
 };
 
 */

//****************************oc2Js方法注册区域**********************************

var kEventActionToJS = 'kEventActionToJS'; //原生按钮被点击


//注册原生按钮点击事件
function ocToJs_EventAction(){
    ocToJs_registerHandler(kEventActionToJS,function(jsonParam){
                           //这里可以根据业务编辑您的代码
                           var key = jsonParam.key;
                           var value = jsonParam.value;
                           var eventType = jsonParam.eventType;
                           if (eventType == 'bar') {
                           if  (key == 'right'){
                           clickObj.rightButtonClick();
                           }else{
                           clickObj.leftButtonClick();
                           }
                           }else if(eventType == 'alert') {
                                var index = jsonParam.index;
                               if  (key == 'right'){
                                   alertObj.rightAlertButtonClick(index);
                               }else{
                                   alertObj.leftAlertButtonClick(index);
                               }
                           }
                           });
                           
}

//注册所有事件
function bridgeRegisterHandler(){
    //接收原生到JS的消息
    ocToJs_EventAction();
}
