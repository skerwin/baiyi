//
//  LoginController.swift
//  BaiYi
//
//  Created by zhaoyuanjing on 2020/08/06.
//  Copyright © 2020 gansukanglin. All rights reserved.
//

import UIKit
import SwiftyJSON
import IQKeyboardManagerSwift
import ObjectMapper
 
class LoginController: BaseViewController,Requestable{
    
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var accountBorderView: UIView!
    @IBOutlet weak var passwordBorderView: UIView!
    @IBOutlet weak var accountText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
 
    
    
    @IBAction func backAction(_ sender: Any) {
        self.reloadLogin!()
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var forgetBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    var reloadLogin:(() -> Void)?
    
    var account = ""
    var password = ""
    
    var usermodel = UserModel()
    
    var isFromMineCenter = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "登录"
        backBtn.isHidden = true
        backBtn.isEnabled = false
        
        accountBorderView.layer.cornerRadius = 5;
        accountBorderView.layer.masksToBounds = true;
        accountBorderView.layer.borderWidth = 1
        accountBorderView.layer.borderColor = ZYJColor.testLine.cgColor
 
        passwordBorderView.layer.cornerRadius = 5;
        passwordBorderView.layer.masksToBounds = true;
        passwordBorderView.layer.borderWidth = 1
        passwordBorderView.layer.borderColor = ZYJColor.testLine.cgColor
        
        forgetBtn.setTitleColor(ZYJColor.main, for: .normal)
        registerBtn.setTitleColor(UIColor.black, for: .normal)
        
        loginBtn.layer.cornerRadius = 10;
        loginBtn.layer.masksToBounds = true;
              // careBtn.titleLabel?.textColor = ZYJColor.main
        createRightNavItem(title: "返回", imageStr: "backarrow")
                     
     }
    
    func createRightNavItem(title:String = "返回",imageStr:String = "") {
        if imageStr == ""{
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: title, style: .plain, target: self, action:  #selector(rightNavBtnClick))
        }else{
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: imageStr), style: .plain, target: self, action: #selector(rightNavBtnClick))
        }
         
        
    }
    
    
    @objc func rightNavBtnClick(){
        
        self.reloadLogin!()
        self.dismiss(animated: true, completion: nil)
        //跳转前的操作写这里
        
    }
    
    @IBAction func loginBtnAction(_ sender: Any) {
        
          account = accountText.text!
          password = passwordText.text!
          
          if account.isLengthEmpty(){
              DialogueUtils.showError(withStatus: "账号不能为空")
              return
          }
          if password.isLengthEmpty(){
              DialogueUtils.showError(withStatus: "密码不能为空")
              return
          }
        

        let pathAndParams = HomeAPI.LoginPathAndParams(mobile: account, password: password)
          DialogueUtils.showWithStatus("正在登录")
          postRequest(pathAndParams: pathAndParams,showHUD: false)
        
       
    }
    
    @IBAction func registerBtnAction(_ sender: Any) {
        
        
        let controller = UIStoryboard.getRegisterController()
        let navController = MainNavigationController(rootViewController: controller)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
        
//        let controller = UIStoryboard.getRegisterController()
//        controller.modalPresentationStyle = .fullScreen
//        self.present(controller, animated: true) {
//        }
        
        
        //self.navigationController?.pushViewController(controller, animated: true)
 
 
    }
    
    override func onResponse(requestPath: String, responseResult: JSON, methodType: HttpMethodType) {
        //ischeck 是否审核  0 未审核  1  审核中  2 通过审核 3 审核为通过
        super.onResponse(requestPath: requestPath, responseResult: responseResult, methodType: methodType)
        
        usermodel = Mapper<UserModel>().map(JSONObject: responseResult["user"].rawValue)
        let token = responseResult["token"].stringValue
        let adzoneId = usermodel?.id
        let phone = usermodel?.mobile
        
        setValueForKey(value: usermodel?.avatar_url as AnyObject, key: Constants.avatar)
        setValueForKey(value: usermodel?.doctorModel?.check_status as AnyObject, key: Constants.isCheck)
        setValueForKey(value: usermodel?.realname as AnyObject, key: Constants.truename)
        setValueForKey(value: usermodel?.nickname as AnyObject, key: Constants.nickname)
        setValueForKey(value: usermodel?.sex as AnyObject, key: Constants.gender)
        saveAccountAndPassword(account: phone!, password: password, token: token, userid: adzoneId!)
        
        //DialogueUtils.showSuccess(withStatus: "登陆成功")
        UIApplication.shared.keyWindow?.rootViewController = MainTabBarController()
        
//        self.reloadLogin!()
//        self.dismiss(animated: true, completion: nil)
 
 
    }
    
    override func onFailure(responseCode: String, description: String, requestPath: String) {
        
        super.onFailure(responseCode: responseCode, description: description, requestPath: requestPath)
        
    }
    
    @IBAction func forgetPasswordAction(_ sender: Any) {
        
        let controller = UIStoryboard.getGetBackPasswordController()
        
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
        
    }

    @IBAction func privateRuleAction(_ sender: Any) {
        let conroller = PrivateStatusViewController()
         self.present(conroller, animated: true, completion: nil)
     }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            IQKeyboardManager.shared.enable = true
           IQKeyboardManager.shared.enableAutoToolbar = true
    
       }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        accountText.resignFirstResponder()
        passwordText.resignFirstResponder()
     }
       
    override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(animated)
          IQKeyboardManager.shared.enable = false
           IQKeyboardManager.shared.enableAutoToolbar = false
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
