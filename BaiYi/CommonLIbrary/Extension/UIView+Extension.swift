//
//  UIColor+Extension.swift
//  BossJob
//
//  Created by zhaoyuanjing on 2017/09/26.
//  Copyright © 2017年 zhaoyuanjing. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIView的扩展
extension UIView {
    
    
    func addcornerRadius(radius:CGFloat){
         self.layer.cornerRadius = radius
         self.layer.masksToBounds = true;
    }
    
    func addOnClickListener(target: AnyObject, action: Selector) {
        let gr = UITapGestureRecognizer(target: target, action: action)
        gr.numberOfTapsRequired = 1
        isUserInteractionEnabled = true
        addGestureRecognizer(gr)
    }
    
  
    
 
     func removeAllSubViews() {
        for subView: UIView in self.subviews {
            subView.removeFromSuperview()
        }
    }
    
    func showLoading() {
        hideLoading()
        let loadingView = UIActivityIndicatorView(style:
            UIActivityIndicatorView.Style.gray)
        loadingView.center = self.center
        addSubview(loadingView)
        bringSubviewToFront(loadingView)
        loadingView.startAnimating()
    }
    
    func hideLoading() {
        for subView: UIView in self.subviews {
            if subView.isKind(of:UIActivityIndicatorView.self) {
                var indicatorView = subView as? UIActivityIndicatorView
                if indicatorView!.isAnimating {
                    indicatorView!.stopAnimating()
                    indicatorView = nil
                }
            }
        }
    }
    
    
    
}
