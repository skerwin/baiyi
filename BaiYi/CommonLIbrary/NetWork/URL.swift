//
//  URL.swift
//  BossJob
//
//  Created by zhaoyuanjing on 2017/11/03.
//  Copyright © 2017年 zhaoyuanjing. All rights reserved.
//

import Foundation
struct URLs {
    
    enum Environment: Int {
         case SIT        = 1 // 测试环境
         case UAT        = 2 // 试运行环境
         case Product    = 3 // 生产环境
     }
    
    static var currentEnvironment       = Environment.SIT
    static let currentEnvironmentKey    = "currentEnvironment"
 
    static let sitHostAddress           = getAPIIp()
    static let uatHostAddress           = getAPIIp()
    static let productHostAddress       = getAPIIp()
    
//    static func getIp() -> String {
//        
//        var ip = "api.zhipin168.jp/"
// 
//        return ip
//       // setValueForKey(value: str as AnyObject, key: Constants.serverIp)
//    }
     static func getAPIIp() -> String {
      
        return "https://api.zhipin168.jp/"
       // return "https://" + "testapi.zhipin168.jp/"
       //   return "http://" + "192.168.1.78:8080/bossapi/"
     }
    static func getChatip() -> String {
        
        return "wss://chat.zhipin168.jp/"
     //  return "https://" + "testchat.zhipin168.jp/"
     //   return "http://" + "192.168.1.78" + ":8080/bossjobchat/"
        
    }
    
    static func getHostAddress() -> String {
        if objectForKey(key: currentEnvironmentKey) == nil { // 默认 sit
            return sitHostAddress
        }
        switch (objectForKey(key: currentEnvironmentKey) as? Int)! {
        case Environment.Product.rawValue:
            return productHostAddress
        case Environment.SIT.rawValue:
            return sitHostAddress
        default: // 默认sit
            return sitHostAddress
        }
    }
     /// 当前的网络环境
    static func getCurrentEnvironment() -> Environment {
        if objectForKey(key: currentEnvironmentKey) == nil { // 默认 sit
            return .SIT
        }
        let currentEnvironmentIntValue = objectForKey(key: currentEnvironmentKey) as! Int
        switch currentEnvironmentIntValue {
        case Environment.Product.rawValue:
            return .Product
        case Environment.SIT.rawValue:
            return .SIT
         default: // 默认sit
            return .SIT
        }
    }
}
