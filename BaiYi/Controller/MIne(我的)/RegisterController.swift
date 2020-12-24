//
//  RegisterController.swift
//  BaiYi
//
//  Created by zhaoyuanjing on 2020/08/06.
//  Copyright © 2020 gansukanglin. All rights reserved.
//

import UIKit
import SwiftyJSON
import IQKeyboardManagerSwift

class RegisterController: BaseViewController,Requestable ,UITextFieldDelegate{
    
    @IBOutlet weak var accountBgview: UIView!
    @IBOutlet weak var vertifyCodeBgview: UIView!
    @IBOutlet weak var accountText: UITextField!
    @IBOutlet weak var vertifyCodeText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var psaawordBgview: UIView!
    
    @IBOutlet weak var vertifycodeBtn: UIButton!
    
    
    @IBOutlet weak var backBtn: UIButton!
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var account = ""
    var password = ""
    
    
    
    
    
    
    func createRightNavItem(title:String = "返回",imageStr:String = "") {
        if imageStr == ""{
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: title, style: .plain, target: self, action:  #selector(rightNavBtnClick))
        }else{
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: imageStr), style: .plain, target: self, action: #selector(rightNavBtnClick))
        }
         
        
    }
    
    
    @objc func rightNavBtnClick(){
        
        self.dismiss(animated: true, completion: nil)
        //跳转前的操作写这里
        
    }
    
    @IBAction func vertifycodeBtnAction(_ sender: Any) {
        
        account = accountText.text!

        if account.isLengthEmpty(){
            DialogueUtils.showError(withStatus: "账号不能为空")
            return
        }
        if !(CheckoutUtils.isMobile(mobile: account)){
            DialogueUtils.showWarning(withStatus: "请输入正确的手机号")
            return
        }
        let pathAndParams = HomeAPI.sendRegisterMessagecodePathAndParams(mobile: account)
        postRequest(pathAndParams: pathAndParams,showHUD: false)
        
        
    }
    
    override func onResponse(requestPath: String, responseResult: JSON, methodType: HttpMethodType) {
        super.onResponse(requestPath: requestPath, responseResult: responseResult, methodType: methodType)
        
        if requestPath == HomeAPI.sendRegisterMessagecodePath{
            vertifycodeBtn.setTitle("验证码已发送", for:.normal)
            vertifycodeBtn.isEnabled = false
            vertifyCodeText.placeholder = "请在5分钟内输入"
            vertifycodeBtn.backgroundColor = ZYJColor.Line.grey
            DialogueUtils.showSuccess(withStatus: "发送成功")
         }else {
            
            let account = responseResult["mobile"].stringValue
            let password = responseResult["password"].stringValue
            setValueForKey(value: account as AnyObject, key: Constants.account)
            setValueForKey(value: password as AnyObject, key: Constants.password)
            
            let controller = UIStoryboard.getAuthenController()
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        
        
    }
    
    override func onFailure(responseCode: String, description: String, requestPath: String) {
        
        super.onFailure(responseCode: responseCode, description: description, requestPath: requestPath)
        
    }
    
    
    
    @IBAction func registerBtn(_ sender: Any) {
        account = accountText.text!
        password = passwordText.text!
        
        
        if account.isLengthEmpty(){
            DialogueUtils.showError(withStatus: "账号不能为空")
            return
        }
        
        if !(CheckoutUtils.isMobile(mobile: account)){
            DialogueUtils.showWarning(withStatus: "请输入正确的手机号")
            return
        }
 
        var tempcode = ""
        tempcode = vertifyCodeText.text!
        if tempcode.isLengthEmpty() {
            DialogueUtils.showError(withStatus: "验证码不能为空")
            return
        }
        
        if password.isLengthEmpty(){
            DialogueUtils.showError(withStatus: "密码不能为空")
            return
        }
        
        if !(CheckoutUtils.isPasswordNOSpecial(pwd:password)){
            showOnlyTextHUD(text: "密码应在6—16个字符之间 且不能包含特殊字符")
            return
        }
        
        
        let pathAndParams = HomeAPI.sendRegisterPathAndParams(mobile: account, sms_code: tempcode, password: password)
        DialogueUtils.showWithStatus("正在注册")
        postRequest(pathAndParams: pathAndParams,showHUD: false)
    }
    
    
    @IBOutlet weak var registerBtnbtn: UIButton!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "注册"
        backBtn.isHidden = true
        backBtn.isEnabled = false
        
        accountText.delegate = self
        accountBgview.layer.cornerRadius = 5;
        accountBgview.layer.masksToBounds = true;
        accountBgview.layer.borderWidth = 1
        accountBgview.layer.borderColor = ZYJColor.testLine.cgColor
        
        vertifyCodeBgview.layer.cornerRadius = 5;
        vertifyCodeBgview.layer.masksToBounds = true;
        vertifyCodeBgview.layer.borderWidth = 1
        vertifyCodeBgview.layer.borderColor = ZYJColor.testLine.cgColor
        
        psaawordBgview.layer.cornerRadius = 5;
        psaawordBgview.layer.masksToBounds = true;
        psaawordBgview.layer.borderWidth = 1
        psaawordBgview.layer.borderColor = ZYJColor.testLine.cgColor
        
        registerBtnbtn.backgroundColor = ZYJColor.main
        registerBtnbtn.setTitleColor(UIColor.white, for: .normal)
        registerBtnbtn.layer.cornerRadius = 10;
        registerBtnbtn.layer.masksToBounds = true;
        
        vertifycodeBtn.backgroundColor = ZYJColor.main
        vertifycodeBtn.setTitle("获取验证码", for:.normal)
        vertifycodeBtn.setTitleColor(UIColor.white, for: .normal)
        vertifycodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        vertifycodeBtn.layer.cornerRadius = 15
        vertifycodeBtn.layer.masksToBounds = true
        
        createRightNavItem(title: "返回", imageStr: "backarrow")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        accountText.resignFirstResponder()
        vertifyCodeText.resignFirstResponder()
        passwordText.resignFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == accountText {
            if textField.text != account {
                vertifycodeBtn.backgroundColor = ZYJColor.main
                vertifycodeBtn.setTitle("获取验证码", for:.normal)
                vertifycodeBtn.isEnabled = true
                vertifyCodeText.placeholder = "请输入验证码"
            }
        }
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
//class hw_TextField: NSObject, UITextFieldDelegate
