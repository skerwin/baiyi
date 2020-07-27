//
//  BaseViewController.swift
//  BossJob
//
//  Created by zhaoyuanjing on 2017/09/26.
//  Copyright © 2017年 zhaoyuanjing. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaseViewController: UIViewController,AccountAndPasswordPresenter,AlertPresenter {
    
    
   var isDisplayEmptyView = false

    override func viewDidLoad() {
        super.viewDidLoad()
       // self.edgesForExtendedLayout = .all
        NotificationCenter.default.addObserver(self, selector: #selector(self.tokenChange(note:)), name: NSNotification.Name(rawValue: Constants.TokenChangeRefreshNotification), object: nil)
      
    }
    @objc func tokenChange(note: NSNotification){
        
        if note.object != nil {
            if self.isLogin == true {
                self.showSingleButtonAlertDialog(message: "您的账号已在其他终端登陆，或账号已被修改，请重新登录") { (type) in
                    self.logoutAccount(account: "")
                    //UIApplication.shared.keyWindow?.rootViewController = UIStoryboard.loginController()
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    
    func onResponse(requestPath: String, responseResult: JSON, methodType: HttpMethodType) {
        isDisplayEmptyView = true
        DialogueUtils.dismiss()
    }
    func onFailure(responseCode: String, description: String, requestPath: String) {
         DialogueUtils.dismiss()
         DialogueUtils.showError(withStatus: description)
    }
    
    func rightNavBtnClick(){
        //跳转前的操作写这里
        
    }
    
//    func dismissEmptyDataView() {
//        if let _ = emptyDataView {
//            for subView in view.subviews {
//                if subView.tag == emptyDataViewTag {
//                    subView.removeFromSuperview()
//                } else {
//                    subView.hidden = false
//                }
//            }
//        }
//    }
    
    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.resignFirstResponder()
        
    }
    
 
    //收键盘注册点击事件
    func backKeyBoard(){
        self.view.addGestureRecognizer(UITapGestureRecognizer(target:self, action:#selector(self.handleTap(sender:))))
    }
    
    func pushToScanController () {
//        let controller = UIStoryboard.getLoginScanController()
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    //对应方法
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            //  你的textfield.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }
   //自定义导航栏之后会失去全屏滑动返回效果
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
