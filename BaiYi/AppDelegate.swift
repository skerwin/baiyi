//
//  AppDelegate.swift
//  BaiYi
//
//  Created by zhaoyuanjing on 2020/07/23.
//  Copyright © 2020 gansukanglin. All rights reserved.
//

import UIKit
import XHLaunchAd

 
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
 
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        XHLaunchAd.setLaunch(.launchScreen)
        let imageAdconfiguration = XHLaunchImageAdConfiguration.default()
        imageAdconfiguration.duration = 1;
        imageAdconfiguration.imageNameOrURLString = "adImage4.gif"
        imageAdconfiguration.openModel = "http://www.it7090.com"
        XHLaunchAd.imageAd(with: imageAdconfiguration, delegate: self)

        self.window?.rootViewController = MainTabBarController()
        
        return true
    }
 
    
//    //配置广告数据
//    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
//    //广告停留时间
//    imageAdconfiguration.duration = 5;
//    //广告frame
//    imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-150);
//    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
//    imageAdconfiguration.imageNameOrURLString = @"image0.jpg";
//    //设置GIF动图是否只循环播放一次(仅对动图设置有效)
//    imageAdconfiguration.GIFImageCycleOnce = NO;
//    //网络图片缓存机制(只对网络图片有效)
//    imageAdconfiguration.imageOption = XHLaunchAdImageRefreshCached;
//    //图片填充模式
//    imageAdconfiguration.contentMode = UIViewContentModeScaleToFill;
//     //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
//    imageAdconfiguration.openModel = @"http://www.it7090.com";
//    //广告显示完成动画
//    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
//    //广告显示完成动画时间
//    imageAdconfiguration.showFinishAnimateTime = 0.8;
//    //跳过按钮类型
//    imageAdconfiguration.skipButtonType = SkipTypeTimeText;
//    //后台返回时,是否显示广告
//    imageAdconfiguration.showEnterForeground = NO;
    
    //这个暂时不用
    func setGifLauchImage() {
          let lauchvc = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()

          let gifPath = Bundle.main.url(forResource: "adImage4", withExtension: "gif")
          let launchImgV = UIImageView()
          launchImgV.frame = (window?.frame)!
          launchImgV.image = UIImage.animatedImage(withAnimatedGIFURL: gifPath!)
          lauchvc?.view.addSubview(launchImgV)
        

          self.window?.addSubview((lauchvc?.view)!)
          self.window?.bringSubviewToFront((lauchvc?.view)!)
          launchImgV.backgroundColor = UIColor.white
          window?.rootViewController = lauchvc

           DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
               launchImgV.removeFromSuperview()
               self.window?.rootViewController = MainTabBarController()
          })
        
     }

//
     func applicationWillResignActive(_ application: UIApplication) {
           // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
           // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
       }

       func applicationDidEnterBackground(_ application: UIApplication) {
           // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
           // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
       }

       func applicationWillEnterForeground(_ application: UIApplication) {
           // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
       }

       func applicationDidBecomeActive(_ application: UIApplication) {
           // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
       }

       func applicationWillTerminate(_ application: UIApplication) {
           // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
       }


}

