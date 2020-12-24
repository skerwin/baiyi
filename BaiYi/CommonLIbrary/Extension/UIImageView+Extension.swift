//
//  UIImageView+Extension.swift
//  gank.io
//
//  Created by YuliangTao on 16/1/31.
//  Copyright © 2016年 Berchina.Mobile. All rights reserved.

import Foundation
import UIKit
import Kingfisher

class ImageCacheManager {
    static let `default` = ImageCache(name: "imageCache")
    //KingfisherOptionsInfoItem.targetCache(ImageCacheManager.default)
}
 // MARK: - 对应UIImageView的异步显示网络图片
extension UIImageView {
    
    func displayImageWithURL(url: String?,isOpenScale: Bool = true) {
        contentMode = .scaleToFill
        
        
//         if url == nil || url! == ""{
//             self.image = UIImage.init(named: "zhanweitu2")
//        }else{
//            guard let imageUrl = URL.init(string:url!) else { return }
//
//            self.kf.setImage(with: ImageResource.init(downloadURL: imageUrl), placeholder: UIImage.init(named: "zhanweitu2"), options:  [KingfisherOptionsInfoItem.targetCache(ImageCacheManager.default)], progressBlock: nil){ (reslt) in
//            }
//         }
        
        if url == nil || url! == ""{
                  self.image = UIImage.init(named: "zhanweitu2")
             }else{
                 guard let imageUrl = URL.init(string:url!.urlEncoded()) else { return }
                 
                 self.kf.setImage(with: ImageResource.init(downloadURL: imageUrl), placeholder: UIImage.init(named: "zhanweitu2"), options:  [KingfisherOptionsInfoItem.targetCache(ImageCacheManager.default)], progressBlock: nil){ (reslt) in
                 }
              // KingfisherOptionsInfoItem.forceRefresh
              // [KingfisherOptionsInfoItem.targetCache(ImageCacheManager.default)]
             }
    }
    
    func displayImageWithEncodedURL(url: String?,isOpenScale: Bool = true) {
        contentMode = .scaleToFill
        
         if url == nil || url! == ""{
             self.image = UIImage.init(named: "zhanweitu2")
        }else{
            guard let imageUrl = URL.init(string:url!.urlEncoded()) else { return }
            
            self.kf.setImage(with: ImageResource.init(downloadURL: imageUrl), placeholder: UIImage.init(named: "zhanweitu2"), options:  [KingfisherOptionsInfoItem.targetCache(ImageCacheManager.default)], progressBlock: nil){ (reslt) in
            }
         // KingfisherOptionsInfoItem.forceRefresh
         // [KingfisherOptionsInfoItem.targetCache(ImageCacheManager.default)]
        }
    }
    
    func displayHeadImageWithURL(url: String?,isOpenScale: Bool = true) {
         contentMode = .scaleToFill
          if url == nil || url! == ""{
              self.image = UIImage.init(named: "wodetouxiang")
         }else{
             guard let imageUrl = URL.init(string:url!) else { return }
             self.kf.setImage(with: ImageResource.init(downloadURL: imageUrl), placeholder: UIImage.init(named: "wodetouxiang"), options:  [KingfisherOptionsInfoItem.targetCache(ImageCacheManager.default)], progressBlock: nil){ (reslt) in
             }
         }
     }
    
    // let strUrl = vmodel!.url.urlEncoded()
    
    func displayheadNotifyImageWithURL(url: String?,isOpenScale: Bool = true) {
            contentMode = .scaleToFill
             if url == nil || url! == ""{
                 self.image = UIImage.init(named: "headNotify")
            }else{
                guard let imageUrl = URL.init(string:url!) else { return }
                self.kf.setImage(with: ImageResource.init(downloadURL: imageUrl), placeholder: UIImage.init(named: "wodetouxiang"), options:  [KingfisherOptionsInfoItem.targetCache(ImageCacheManager.default)], progressBlock: nil){ (reslt) in
                }
            }
        }
    
    
 
    func displayImageWithForceLoadURL(url: String?,isOpenScale: Bool = true) {
        contentMode = .scaleToFill
        if url == nil || url! == ""{
            self.image = UIImage.init(named: "comDefaultImg")
        }else{
            guard let imageUrl = URL.init(string:url!) else { return }
            self.kf.setImage(with: ImageResource.init(downloadURL: imageUrl), placeholder: UIImage.init(named: "blurHeader"), options:   [KingfisherOptionsInfoItem.forceRefresh], progressBlock: nil){ (reslt) in
            }
         }
    }
     /// 边框
    func setBorder() {
        self.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        self.layer.cornerRadius = 1
        self.layer.borderWidth = 0.5
    }
     //gif 处理
    public func loadGif(name: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(name: name)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
