//
//  ScreenUtils.swift
//  gank.io
//
//  Created by YuliangTao on 16/1/1.
//  Copyright © 2016年 Berchina.Mobile. All rights reserved.
//  屏幕工具类

import Foundation
import UIKit

// 屏幕大小尺寸
let screenBounds = UIScreen.main.bounds
let screenSize   = screenBounds.size
let screenWidth  = screenSize.width
let screenHeight = screenSize.height
let gridWidth: CGFloat = (screenSize.width / 2) - 4.0

let iPhone5ScreenWidth: CGFloat = 320
let iPhone6PScreenWidth: CGFloat = 414.0

// 导航栏高度
let navigationHeight: CGFloat = 44.0
let statubarHeight: CGFloat = 20.0
let navigationHeaderAndStatusbarHeight: CGFloat = navigationHeight + statubarHeight

// 底部导航栏高度
let bottomNavigationHeight: CGFloat = 49.0

let pageMenuHeight: CGFloat = 44.0

let defaultRowHeight: CGFloat = 44.5



var majorVersion: String {
    get {
        let infoDictionary = Bundle.main.infoDictionary
        // 主程序版本号
        let majorVersion : AnyObject! = infoDictionary! ["CFBundleShortVersionString"] as AnyObject
        return majorVersion as? String ?? ""
        //return "\(String(describing: majorVersion))"
    }
}

var bundleId: String {
    get {
        return Bundle.main.bundleIdentifier ?? ""
    }
}
