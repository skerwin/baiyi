//
//  Requestable.swift
//  WisdomJapan
//
//  Created by zhaoyuanjing on 2017/09/15.
//  Copyright © 2017年 zhaoyuanjing. All rights reserved.
//

import SwiftyJSON
import Foundation
 
enum HttpMethodType {
    case GET
    case POST
    case PUT
    case DELETE
}

/**
 *  网络请求相关提供者
 */
protocol Requestable {
    func isNetworkConnected()
    
    func postRequestCache(pathAndParams: PathAndParams, showHUD: Bool, needCache: Bool) //带cache的post 请求
    
    func postRequest(pathAndParams: PathAndParams, showHUD: Bool)
    func getRequest(pathAndParams: PathAndParams, showHUD: Bool, needCache: Bool)
    func putRequest(pathAndParams: PathAndParams, showHUD: Bool)
    func deleteRequest(pathAndParams: PathAndParams, showHUD: Bool)
    
    /**
     服务器处理成功时调用此方法
     
     - parameter requestPath:    请求的路径
     - parameter responseResult: responseData包装的JSON对象
     */
    func onResponse(requestPath: String, responseResult: SwiftyJSON.JSON, methodType: HttpMethodType)
    func onResponse(requestPath: String, responseResult: SwiftyJSON.JSON, methodType: HttpMethodType, responseTimestamp: String, needCache: Bool)
    
    /**
     网络请求错误执行此方法
     
     - parameter responseCode: 返回错误码
     - parameter description:  错误描述
     */
    func onFailure(responseCode: String, description: String, requestPath: String)
    func onFailure(responseCode: String, description: String)
}
extension Requestable where Self: UIViewController {
    
    func isNetworkConnected() {}
    
    func postRequest(pathAndParams: PathAndParams, showHUD: Bool = false) {
        if showHUD { DialogueUtils.showWithStatus() }
        HttpRequest.postRequest(pathAndParams: pathAndParams) { (responseResult) -> Void in
            self.processResponseResult(requestPath: pathAndParams.0, responseResult: responseResult, methodType: .POST)
        }
    }
    
    func postRequestCache(pathAndParams: PathAndParams, showHUD: Bool, needCache: Bool) {
        if showHUD { DialogueUtils.showWithStatus() }
        HttpRequest.postRequest(pathAndParams: pathAndParams) { (responseResult) -> Void in
            self.processResponseResult(requestPath: pathAndParams.0, responseResult: responseResult, methodType: .POST, needCache: needCache)
        }
    }
    
    func postRequestSpecical(url:String = "chat",pathAndParams: PathAndParams, showHUD: Bool = false) {
        if showHUD { DialogueUtils.showWithStatus() }
        HttpRequest.postRequestSpecical(url: url ,pathAndParams: pathAndParams) { (responseResult) -> Void in
            self.processResponseResult(requestPath: pathAndParams.0, responseResult: responseResult, methodType: .POST)
        }
    }
    
 
    func getRequest(pathAndParams: PathAndParams, showHUD: Bool, needCache: Bool) {
        
    }
    
    func putRequest(pathAndParams: PathAndParams, showHUD: Bool) {
        
    }
    
    func deleteRequest(pathAndParams: PathAndParams, showHUD: Bool) {
        
    }
    
    
    func onResponse(requestPath: String, responseResult: SwiftyJSON.JSON, methodType: HttpMethodType) {}
    
    func onResponse(requestPath: String, responseResult: SwiftyJSON.JSON, methodType: HttpMethodType, responseTimestamp: String, needCache: Bool = false) {
        onResponse(requestPath: requestPath, responseResult: responseResult, methodType: methodType)
     }
    
    func onFailure(responseCode: String, description: String) {}
    
    func onFailure(responseCode: String, description: String, requestPath: String = "") {
         onFailure(responseCode: responseCode, description: description)
    }
 
    /**
     处理网络请求返回的结果
     
     - parameter requestPath:    请求的路径
     - parameter responseResult: 返回的结果枚举
     */
    func processResponseResult(requestPath: String, responseResult: ResponseResult<SwiftyJSON.JSON>, methodType: HttpMethodType, needCache: Bool = false) {
        switch responseResult {
        case .Success(let responseJSON):
            DialogueUtils.dismiss()
            let responseCode = responseJSON[BerResponseConstants.responseCode].stringValue
            let errorCode = responseJSON[BerResponseConstants.errorCode].stringValue
            let responseToken = responseJSON[BerResponseConstants.token].string
 
 
            
            if responseToken != nil {
                if responseToken == "700001" || responseToken == "700000" || responseToken == "700003" || responseToken == "700004" || responseToken == "700005"{
                    //发出退出消息 清空本地缓存
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.TokenChangeRefreshNotification), object: responseToken)
                }else{
                    setValueForKey(value: responseToken as AnyObject, key: Constants.token)
                }
            }
            
            if responseCode == BerResponseConstants.Code.Success.rawValue {
                if errorCode == ""{
                    let responseData = responseJSON[BerResponseConstants.responseData]
                    let responseTimestamp = responseJSON[BerResponseConstants.responseTimestamp].stringValue
                    if needCache, let cacheValue = responseData.rawString() { // 缓存开启的标志
                        let chace = Cache.CacheManager.sharedInstance
                        try? chace?.setObject(cacheValue, forKey: requestPath)
                    }
                      self.onResponse(requestPath: requestPath, responseResult: responseData, methodType: methodType, responseTimestamp: responseTimestamp)
                }else{
                    
                    let responseData = responseJSON[BerResponseConstants.responseData]
                    let errorMessage = responseData[BerResponseConstants.errorMessage].stringValue
                    self.onFailure(responseCode: errorCode, description: errorMessage, requestPath: requestPath)
                 }
            } else if responseCode == BerResponseConstants.Code.NoPermission.rawValue { // Token 失效
 
            } else if responseCode == BerResponseConstants.Code.NoBankCard.rawValue {
                var desc = responseJSON[BerResponseConstants.desc].stringValue
                 if desc.isEmpty {
                    desc = responseJSON[BerResponseConstants.errorMessage].stringValue
                }
                self.onFailure(responseCode: responseCode, description: desc, requestPath: requestPath)
            } else {
               // todo  为了调获取简历接口 暂时通过
//                 let responseData = responseJSON[BerResponseConstants.responseData]
//                 let responseTimestamp = responseJSON[BerResponseConstants.responseTimestamp].stringValue
//                 self.onResponse(requestPath: requestPath, responseResult: responseData, methodType: methodType, responseTimestamp: responseTimestamp)
 
                let responseData = responseJSON[BerResponseConstants.responseData]
                var desc = responseJSON[BerResponseConstants.desc].stringValue
                if desc.isEmpty {
                    desc = responseData[BerResponseConstants.errorMessage].stringValue
                }
                self.onFailure(responseCode: responseCode, description: desc, requestPath: requestPath)
            }
            
        case .Failure( _):
          DialogueUtils.dismiss()
            self.onFailure(responseCode:BerResponseConstants.Code.NetworkNotConnected.rawValue, description: BerResponseConstants.networkNotConnectedTips, requestPath: requestPath)
            //showOnlyTextHUD(BerResponseConstants.networkNotConnectedTips)
        }
    }
    
}
