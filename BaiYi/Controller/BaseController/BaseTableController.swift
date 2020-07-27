//
//  BaseTableController.swift
//  BossJob
//
//  Created by zhaoyuanjing on 2017/09/26.
//  Copyright © 2017年 zhaoyuanjing. All rights reserved.
//

import UIKit
import SDCycleScrollView
import SwiftyJSON



class BaseTableController: UITableViewController,AccountAndPasswordPresenter,AlertPresenter {

    var isDisplayEmptyView = false
    var isAll = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .all
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.tokenChange(note:)), name: NSNotification.Name(rawValue: Constants.TokenChangeRefreshNotification), object: nil)

   
    }
    @objc func tokenChange(note: NSNotification){
        
        if note.object != nil {
            if self.isLogin == true {
                 self.showSingleButtonAlertDialog(message: "您的账号已在其他终端登陆，请重新登录") { (type) in
                    self.logoutAccount(account: "")
                    //UIApplication.shared.keyWindow?.rootViewController = UIStoryboard.loginController()
                }
              }
         }
     }
    
    func onResponse(requestPath: String, responseResult: JSON, methodType: HttpMethodType) {
        isDisplayEmptyView = true
        DialogueUtils.dismiss()
    }
    func onFailure(responseCode: String, description: String, requestPath: String) {
        DialogueUtils.dismiss()
        DialogueUtils.showError(withStatus: description)
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
     // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    func createRightNavItem(title:String = "",imageStr:String = "") {
      
    }

  
    
    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.resignFirstResponder()
        
    }
    
    
    //收键盘注册点击事件
    func backKeyBoard(){
        self.view.addGestureRecognizer(UITapGestureRecognizer(target:self, action:#selector(self.handleTap(sender:))))
    }
    
    
    //对应方法
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            //  你的textfield.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }
    

}
