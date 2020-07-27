//
//  ArticleSmallCell.swift
//  BaiYi
//
//  Created by zhaoyuanjing on 2020/07/24.
//  Copyright © 2020 gansukanglin. All rights reserved.
//

import UIKit

class ArticleSmallCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.layer.borderWidth = 1;

        bgView.layer.cornerRadius = 13;

        bgView.layer.borderColor = ZYJColor.mainLine.cgColor;
        // Initialization code
    }

    @IBOutlet weak var bgView: UIView!
}
