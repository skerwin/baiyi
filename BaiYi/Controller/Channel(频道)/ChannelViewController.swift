//
//  ChannelViewController.swift
//  BaiYi
//
//  Created by zhaoyuanjing on 2020/07/27.
//  Copyright © 2020 gansukanglin. All rights reserved.
//

import UIKit
import PageMenu

class ChannelViewController:BaseViewController ,Requestable  {

    var searView:HomeSearchView!
    var pageMenu : CAPSPageMenu?
    var controllerArray : [UIViewController] = []
    var controller1:ChannelArticleController!
    var controller2:ChannelReportController!
    var controller3:ChannelVideoController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        
        controller1 = ChannelArticleController()
        controller1.initBgview()
        
        controller1.title = "文章"
        controller1.parentNavigationController = self.navigationController
               
               
        controller2 = ChannelReportController()
        controller2.title = "病例"
        controller2.parentNavigationController = self.navigationController
              
        controller3 = ChannelVideoController()
        
        controller3.title = "视频"
        controller3.parentNavigationController = self.navigationController
        initUI()

        // Do any additional setup after loading the view.
    }
    
     func initUI(){
         initSearchView()
         initpageMenu()
     }
    
    func initpageMenu(){
       
         
         
         controllerArray.append(controller1)
         controllerArray.append(controller2)
         controllerArray.append(controller3)
 
         let parameters: [CAPSPageMenuOption] = [
             CAPSPageMenuOption.menuHeight(44),
             CAPSPageMenuOption.menuItemSeparatorWidth(4),
             CAPSPageMenuOption.useMenuLikeSegmentedControl(true),
             CAPSPageMenuOption.menuItemSeparatorPercentageHeight(0),
             CAPSPageMenuOption.scrollAnimationDurationOnMenuItemTap(0),
             CAPSPageMenuOption.selectionIndicatorColor(ZYJColor.main),
             CAPSPageMenuOption.selectedMenuItemLabelColor(ZYJColor.main),
             CAPSPageMenuOption.unselectedMenuItemLabelColor(UIColor.darkGray),
             CAPSPageMenuOption.bottomMenuHairlineColor(UIColor.clear),
             CAPSPageMenuOption.viewBackgroundColor(UIColor.white),
             CAPSPageMenuOption.scrollMenuBackgroundColor(UIColor.white),
             CAPSPageMenuOption.menuItemWidth(40),
             CAPSPageMenuOption.menuItemFont(UIFont.systemFont(ofSize: 17.0))
         ]
         pageMenu = CAPSPageMenu.init(viewControllers: controllerArray, frame: CGRect.init(x: 0, y:64, width: screenWidth, height: screenHeight - navigationHeaderAndStatusbarHeight - bottomNavigationHeight), pageMenuOptions: parameters)
         pageMenu?.delegate = self
         
         self.view.addSubview(pageMenu!.view)
        
        
    }
     func initSearchView(){
          searView = Bundle.main.loadNibNamed("HomeSearchView", owner: nil, options: nil)!.first as? HomeSearchView
          searView.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: 44)
          searView.delegate = self
          self.navigationController?.navigationBar.addSubview(searView)
        
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
//搜索代理
extension ChannelViewController:HomeSearchViewDelegate{
   
     func searchActoin() {
        print("fdsafdsafdsfsda")
//       let controller =  UIStoryboard.getCMSearchViewController()
//       self.pushViewController(controller, animated: true)
     }
}
extension ChannelViewController:CAPSPageMenuDelegate{
    
    override func willMove(toParent parent: UIViewController?) {
        
    }
    func willMoveToPage(_ controller: UIViewController, index: Int) {
        
    }
}
