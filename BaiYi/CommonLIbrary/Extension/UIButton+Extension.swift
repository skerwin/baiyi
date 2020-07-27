//
//  UIButton+Extension.swift
//  BossJob
//
//  Created by zhaoyuanjing on 2018/11/26.
//  Copyright © 2018年 zhaoyuanjing. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIButton {
    
    func setBackImageWithURL(url: String?,isOpenScale: Bool = true) {
        contentMode = .scaleToFill
        if url == nil || url! == ""{
            self.setBackgroundImage(UIImage.init(named: "blurHeader"), for: .normal)
          }else{
              self.kf.setBackgroundImage(with: ImageResource.init(downloadURL: URL.init(string: ((url?.urlEncoded()))!)!), for: .normal, placeholder: UIImage.init(named: "blurHeader"), options: [KingfisherOptionsInfoItem.targetCache(ImageCacheManager.default)], progressBlock: nil) { (reslt) in
            
                }
          }
    }
    
     func setImageWithURL(url: String?,isOpenScale: Bool = true) {
           contentMode = .scaleToFill
           if url == nil || url! == ""{
               self.setImage(UIImage.init(named: "blurHeader"), for: .normal)
            }else{
               
            }
       }
}
