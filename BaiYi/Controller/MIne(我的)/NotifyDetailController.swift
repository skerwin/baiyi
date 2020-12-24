//
//  NotifyDetailController.swift
//  BaiYi
//
//  Created by zhaoyuanjing on 2020/08/26.
//  Copyright © 2020 gansukanglin. All rights reserved.
//

import UIKit

class NotifyDetailController: BaseViewController {

    
    var model = NotifyModel()

    
    @IBOutlet weak var contentView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headimage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "消息详情"

        headimage.layer.cornerRadius = 30;
        headimage.layer.masksToBounds = true
        
        headimage.displayheadNotifyImageWithURL(url: model?.admin?.avatar_url)
        titleLabel.text = model?.title
        timeLabel.text = DateUtils.timeStampToStringDetail("\(String(describing: model!.created_at))")
        contentView.text = model?.content
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
