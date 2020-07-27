//
//  ChannelSmallCell.swift
//  BaiYi
//
//  Created by zhaoyuanjing on 2020/07/24.
//  Copyright © 2020 gansukanglin. All rights reserved.
//

import UIKit

class ChannelSmallCell: UICollectionViewCell {
    @IBOutlet weak var bgview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgview.layer.borderWidth = 1;

        bgview.layer.cornerRadius = 13;
        bgview.layer.borderColor = ZYJColor.mainLine.cgColor;
        // Initialization code
    }

}
