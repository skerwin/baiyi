//
//  HomeAPI.swift
//  BossJob
//
//  Created by zhaoyuanjing on 2017/12/01.
//  Copyright © 2017年 zhaoyuanjing. All rights reserved.
//

import Foundation
struct HomeAPI {
    
    //测试接口
    static let HomePositionResumePath = "http://192.168.1.11/api/category/add"
    static func HomeAllResumePathAndParams() -> PathAndParams {
        var paramsDictionary = Dictionary<String, AnyObject>()
        paramsDictionary["title"] = "nihao" as AnyObject
        paramsDictionary["linkTo"] = "nihaochuhuchuhcu" as AnyObject
        return (HomePositionResumePath, getRequestParamsDictionary(paramsDictionary: paramsDictionary))
    }
    
 }
