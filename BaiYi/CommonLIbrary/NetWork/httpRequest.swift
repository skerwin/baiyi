//
//  httpRequest.swift
//  WisdomJapan
//
//  Created by zhaoyuanjing on 2017/09/15.
//  Copyright © 2017年 zhaoyuanjing. All rights reserved.
//
import Foundation
import SwiftyJSON
import Alamofire
/**
 *  网络请求统一入口
 */
struct HttpRequest {
    // 参考地址： http://qiita.com/k-yamada@github/items/569c4c97f0b8e4605e04
    class HttpManager {
        static let sharedInstance: SessionManager = {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
            configuration.timeoutIntervalForRequest = 15
            configuration.timeoutIntervalForResource = 15
            return SessionManager(configuration: configuration)
        }()
    }
    static func restfulRequest(methodType: HTTPMethod,
                               pathAndParams: PathAndParams,
                               urlStr: String = "",
                               completionHandler: @escaping (_ responseResult: ResponseResult<JSON>) -> Void){
        
        let requestPath = pathAndParams.0
        let parameters  = pathAndParams.1
        let parametersJson = JSON(parameters!)
        
        var url:URL!
//        if (urlStr != "") {
//            url = URL.init(string: URLs.getChatip() + requestPath)
//        }else{
//            url = URL.init(string: URLs.getHostAddress() + requestPath)
//        }
         url = URL.init(string:requestPath)
        
//
        var request: DataRequest?
          print(url!)
          print(parametersJson)
//        if requestPath == "P01_login/login" {
//            //  let responseToken = responseJSON[BerResponseConstants.token]
//            //  setValueForKey(value: responseToken as AnyObject, key: Constants.token)
//        }
        
//        构造header
        var headers:HTTPHeaders? = nil
        if (stringForKey(key: Constants.token) != nil && stringForKey(key: Constants.token) != "") {
             headers = [
            "Authorization": stringForKey(key: Constants.token),
            "Accept": "application/json"
                ] as? HTTPHeaders
        }
        switch methodType {
        case .get, .delete:
            request =  HttpManager.sharedInstance.request(url!, method: methodType, parameters: parameters!, encoding: JSONEncoding.default, headers: headers)
        case .post, .put:
            request =  HttpManager.sharedInstance.request(url!, method: methodType, parameters: parameters!, encoding: JSONEncoding.default, headers: headers)
        default:
            break
        }
          request?.responseJSON(completionHandler: { (response) in
            let result = response.result
            if result.isSuccess {
                if let json = response.result.value {
                    let responseJson = JSON(json)
                    print(url!)
                    print(responseJson)
                    completionHandler(.Success(responseJson))
                 }
             }else{
                completionHandler(.Failure(result.error!))
            }
        })

      }
    
 
    static func getRequest(pathAndParams: PathAndParams, completionHandler: @escaping (_ responseResult: ResponseResult<JSON>) -> Void) {
        restfulRequest(methodType: .get, pathAndParams: pathAndParams, completionHandler: completionHandler)
     }
 
    static func postRequest(pathAndParams: PathAndParams, completionHandler: @escaping (_ responseResult: ResponseResult<JSON>) -> Void) {
        restfulRequest(methodType: .post, pathAndParams: pathAndParams, completionHandler: completionHandler)
    }
    
    static func postRequestSpecical(url:String ,pathAndParams: PathAndParams, completionHandler: @escaping (_ responseResult: ResponseResult<JSON>) -> Void) {
        restfulRequest(methodType: .post, pathAndParams: pathAndParams,urlStr: url, completionHandler: completionHandler)
    }
 
    static func putRequest(pathAndParams: PathAndParams, completionHandler: @escaping (_ responseResult: ResponseResult<JSON>) -> Void) {
        restfulRequest(methodType: .put, pathAndParams: pathAndParams, completionHandler: completionHandler)
    }
    
    static func deleteRequest(pathAndParams: PathAndParams, completionHandler: @escaping (_ responseResult: ResponseResult<JSON>) -> Void) {
        restfulRequest(methodType: .delete, pathAndParams: pathAndParams, completionHandler: completionHandler)
     }
    
    
//    static func uploadImage(url:String,filePath:String,success: @escaping (_ content:String) -> Void, failure: @escaping (_ errorInfo: String?) -> Void){
//        let fileUrl = URL.init(fileURLWithPath: filePath)
//        let memberId = stringForKey(key: Constants.userid)!.data(using: String.Encoding.utf8, allowLossyConversion: false)
//        let userType = stringForKey(key: Constants.userType)!.data(using: String.Encoding.utf8, allowLossyConversion: false)
//        let upUrl = URL.init(string: URLs.getHostAddress() + url)
//         HttpManager.sharedInstance.upload(multipartFormData: { (multipartFormData) in
//            multipartFormData.append(memberId!, withName: "userId", mimeType: "text/plain")
//            multipartFormData.append(fileUrl, withName: "file")
//            multipartFormData.append(userType!, withName: "userType",mimeType: "text/plain")
//            if url == MemberAPI.companyLogoImgUploadPath {
//                let companyId = stringForKey(key: Constants.companyid)!.data(using: String.Encoding.utf8, allowLossyConversion: false)
//                multipartFormData.append(companyId!, withName: "companyId",mimeType: "text/plain")
//            }
//         }, to: upUrl!) { (result) in
//            switch result{
//            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
//                upload.responseJSON(completionHandler: { (responseData) in
//                    let result = responseData.result
//                    if result.isSuccess{
//                        if let json = responseData.result.value {
//                              let responseJson = JSON(json)
//                              // print(responseJson)
//                            if responseJson["responseCode"].stringValue == BerResponseConstants.Code.Success.rawValue{
//                                let content = responseJson["responseData"]
//                                success(content["url"].stringValue)
//                            }else{
//                               failure("图片服务器出错")
//                            }
//                         }
//                    }else{
//                        failure("图片服务器出错")
//                    }
//                 })
//             case.failure(let error):
//             //   print(error.localizedDescription)
//                failure("图片服务器出错")
//            }
//        }
//    }
 }
//                 upload.response(completionHandler: { (responseData) in
//                    let content = try!JSONSerialization.jsonObject(with: responseData.data!, options: JSONSerialization.ReadingOptions.allowFragments)
//                    print(content)
//
//                    if responseData.response != nil && responseData.data != nil{
//                        let stateCode = responseData.response?.statusCode
//                        if stateCode == 200 {
//                            if responseData.data!.count > 0 {
//                                let content = try!JSONSerialization.jsonObject(with: responseData.data!, options: JSONSerialization.ReadingOptions.allowFragments)
//                                print(content)
//                            }else{
//
//                            }
//                        }else {
//
//                        }
//                    }else {
//
//                    }
//                })
