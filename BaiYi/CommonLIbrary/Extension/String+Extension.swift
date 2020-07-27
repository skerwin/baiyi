//
//  UIColor+Extension.swift
//  BossJob
//
//  Created by zhaoyuanjing on 2017/09/26.
//  Copyright © 2017年 zhaoyuanjing. All rights reserved.
//

import Foundation
import UIKit


 extension String {

    /// 获取字符串的长度
    var length: Int {
        get {
            return self.length
        }
     }
    //字符串本地化
     func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
      /**
     获取字符串的size
     */
    func getStringSize(width: CGFloat, fontSize: CGFloat) -> CGSize {
        let size  = self.boundingRect( with: CGSize.init(width: width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes:[NSAttributedString.Key.font:UIFont.systemFont(ofSize: fontSize)], context:nil).size
        return size
    }
    //判读是否为空
    
    func isEmptyStr() -> Bool{
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces).length == 0 ? true : false
    }
    
    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
    
    //判断是否是空“”
    func isLengthEmpty() -> Bool{
        return self == "" ? true : false
    }
    func authInfo() -> Bool{
        if (self.isLengthEmpty()) || (self.isEmptyStr()) || self == "请填写" || self == "请选择" || self == "请输入"{
            return false
        }
        return true
    }
 }
