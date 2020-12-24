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
   // https://demo.lnyouran.com 测试
   // "https://baiyi.lnyouran.com" 正式
    static var currentEnvironment       = Environment.SIT
    static let currentEnvironmentKey    = "currentEnvironment"
    static let sitHostAddress          = "https://demo.lnyouran.com"
    static let productHostAddress       = "https://demo.lnyouran.com"
    //static let uatHostAddress          = "https://demo.lnyouran.com“
    
 
    static func getAPIIp() -> String {
       // return "https://baiyi.lnyouran.com"
        return "https://demo.lnyouran.com"
    }
  
    
    static func getHostAddress() -> String {
         
        
        switch currentEnvironment {
           case Environment.Product:
              return productHostAddress
           case Environment.SIT:
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
