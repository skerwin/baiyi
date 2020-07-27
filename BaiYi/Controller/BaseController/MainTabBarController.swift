//
//  MainTabBarController.swift
//  BaiYi
//
//  Created by zhaoyuanjing on 2020/07/23.
//  Copyright © 2020 gansukanglin. All rights reserved.
//

import UIKit



enum TabbarContentType: Int {
    case HomePage = 0, Channel, Articl, Mine
}

class MainTabBarController: SwipeableTabBarController {

    
    
    let HomePageController = HomeViewController()
    let ChannelController = ChannelViewController()
    let ArticleController = ViewController()
    let MineController = ViewController()
         
    
    override func viewDidLoad() {
        

        super.viewDidLoad()
 
        addChildViewControllers()
        if let viewControllers = viewControllers {
            selectedViewController = viewControllers[0]
        }
 
             /// Set the animation type for swipe
         swipeAnimatedTransitioning?.animationType = SwipeAnimationType.overlap

            /// Set the animation type for tap
         tapAnimatedTransitioning?.animationType = SwipeAnimationType.push

            /// if you want cycling switch tab, set true 'isCyclingEnabled'
         isCyclingEnabled = false

            /// Disable custom transition on tap.
         tapAnimatedTransitioning = nil
            
            /// Set swipe to only work when strictly horizontal.
         diagonalSwipeEnabled = false
        }
        
    
    private func addChildViewControllers() {
         addNavChildViewController(controller: HomePageController, title: "首页",
                               image: UIImage(named: "icon_home")!,
                               selectedImage: UIImage(named: "icon_home_selected")!,
                               tag: TabbarContentType.HomePage.rawValue)
         addNavChildViewController(controller: ChannelController, title: "公司",
                               image: UIImage(named: "company")!,
                               selectedImage: UIImage(named: "company_selected")!,
                               tag: TabbarContentType.Channel.rawValue)
         addNavChildViewController(controller: ArticleController, title: "聊天",
                               image: UIImage(named: "chat")!,
                               selectedImage: UIImage(named: "chat_selecteded")!,
                               tag: TabbarContentType.Articl.rawValue)
         addNavChildViewController(controller: MineController, title: "我的",
                               image: UIImage(named: "mine")!,
                               selectedImage: UIImage(named: "mine_selected")!,
                               tag: TabbarContentType.Mine.rawValue)
       //  self.delegate = self
        
    }
    
    
      private func addNavChildViewController(controller: UIViewController, title: String, image: UIImage, selectedImage: UIImage, tag:Int) {
           controller.title = title
           // controller.tabBarItem = ESTabBarItem.init(title: title, image: image, selectedImage: UIImage)
           controller.tabBarItem.image = image
           controller.tabBarItem.tag = tag
           controller.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
           let navController = MainNavigationController(rootViewController: controller)
 
           addChild(navController)
           
       }
    
        func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            // Handle didSelect viewController method here
        }

}
