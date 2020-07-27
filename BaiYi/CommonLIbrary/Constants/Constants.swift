//
//  Constants.swift
//  BossJob
//
//  Created by zhaoyuanjing on 2017/09/27.
//  Copyright © 2017年 zhaoyuanjing. All rights reserved.
//

import Foundation
import UIKit

let keychainServiceName = "iEC-O2O-Buyer" // Keychain

struct Constants {
    
    static let firebaseToken = "firebaseRegistration"
    static let appVersion = "appVersion" // 程序版本号
    static let account = "account" // 帐号
    static let lastTimeLoginAccount = "lastTimeLoginAccount" // 上一次登录的账号
    static let userid = "userid" // 用户Id
    static let password = "password" // 用户Id
    static let companyid = "companyid" //公司id
    static let loginId = "loginId" // 登陆帐号
    static let ishadHRInfo = "ishadHRInfo" // 是否添加过登陆信息
    
    static let name = "name" // name
    static let photo = "photo" // phote
    
    
    static let token = "token"
    static let mobile = "mobile" // 手机号
    static let selectedCityId = "selectedCityId"
    static let selectedCityName = "selectedCityName"
    static let isLogin = "isLogin" // 是否登录
 
    static let lngLat = "lngLat"
    static let lng = "lng"
    static let lat = "lat"
    static let sureTag = 1
    static let cancelTag = 0
    
    static let savePwd = "savePwd"
    
     // 分页信息
    static let total = "total"
 
    //角色信息
    static let requestTimestamp = "requestTimestamp"
    static let userType = "userType";
    static let person = "1";
    static let company = "0";
    static let verificationCode = "verificationCode";
    
    static let postPosition = "postPosition"
    static let approved = "approved"
    
 
    //注册通知名称（公司的）
    static let mineRefreshNotification = "mineRefreshNotification"
    static let postjobBackNotification = "postjobBackNotification"
    
    static let HomePageNavChangeNotification = "HomePageNavChangeNotification"
    
    //注册通知名称（个人的）
    static let PersonCenterRefreshNotification = "PersonCenterRefreshNotification"
    
    //个人简历编辑即时通知刷新
    static let MyResumeControllerrRefreshNotification = "MyResumeControllerrRefreshNotification"
    
    //个人简历编辑即时通知刷新
    static let TokenChangeRefreshNotification = "TokenChangeRefreshNotification"
 
    static let serverIp = "serverIp"
    
    //搜索历史
     static let historyWord = "historyWord"
    
    
    //商品id //一般不会变   企业
     static let firstAdCard = "1000000009"   //一级推广卡
     static let secondAdCard = "1000000010"  //二级推广卡
    static let  areaFirstAdCard = "1000000011"  //地区二级推广卡
    static let  areaSecondAdCard = "1000000012"  //地区二级推广卡
     static let urgentTopCard = "1000000001"  // 职位加急置顶卡
     static let topCard = "1000000002"        // 职位加顶卡
     static let atuoRefreshCard = "1000000005"  // 自动刷新卡
     static let refreshCard = "1000000003"    // 普通刷新卡
     static let rapidCard = "1000000007"      //  达人直通卡
     static let rapidGiftBag = "1000000008"     // 达人直通大礼包
    static let  refreshGiftBag = "1000000004"    //  普通刷新大礼包
    
    
    //个人
    static let  resumetemplate = "100004"
    static let  learningmaterials = "100002"
    static let  InterviewGuide = "100003"
    static let  resumetop = "100001"
    static let  CoinCharge = ""
    
    
    
    
    
 }
