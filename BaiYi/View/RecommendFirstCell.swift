//
//  RecommendFirstCell.swift
//  BaiYi
//
//  Created by zhaoyuanjing on 2020/07/27.
//  Copyright © 2020 gansukanglin. All rights reserved.
//

import UIKit

class RecommendFirstCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var adimage: UIImageView!
    @IBOutlet weak var readCount: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        adimage.layer.cornerRadius = 16;
        adimage.layer.masksToBounds = true;
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
