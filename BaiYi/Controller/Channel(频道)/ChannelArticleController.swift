//
//  ChannelArticleController.swift
//  BaiYi
//
//  Created by zhaoyuanjing on 2020/07/27.
//  Copyright © 2020 gansukanglin. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON
import MJRefresh
import SDCycleScrollView

class ChannelArticleController: BaseViewController ,Requestable {

    
    var parentNavigationController: UINavigationController?
    let topAdvertisementViewHeight = screenWidth * 0.4
       
    var tableView:UITableView!
    
    var bgView:UIView!
    
     
    var AdvertisementView:SDCycleScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        loadData()
    }
        
     func initUI(){
        initTableView()
     }
    
    func loadData(){
        
    }
    
        override func viewWillAppear(_ animated: Bool) {
//            print(bgView!.frame)
//            print(tableView!.frame)
        }
 
      override func onFailure(responseCode: String, description: String, requestPath: String) {
          tableView.mj_header?.endRefreshing()
          tableView.mj_footer?.endRefreshing()
          super.onFailure(responseCode: responseCode, description: description, requestPath: requestPath)
      }
      
      override func onResponse(requestPath: String, responseResult: JSON, methodType: HttpMethodType) {
          super.onResponse(requestPath: requestPath, responseResult: responseResult, methodType: methodType)
          tableView.mj_header?.endRefreshing()
          tableView.mj_footer?.endRefreshing()
      }
      
      func initTableView(){
           tableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - navigationHeaderAndStatusbarHeight - bottomNavigationHeight - pageMenuHeight), style: .plain)
           tableView.delegate = self
           tableView.dataSource = self
           //tableView.separatorStyle = .none
           tableView.registerNibWithTableViewCellName(name: HomeTopRankCell.nameOfClass)
           tableView.registerNibWithTableViewCellName(name: RecommendFirstCell.nameOfClass)
           tableView.registerNibWithTableViewCellName(name: RecommendOtherCell.nameOfClass)
         
           tableView.tableHeaderView = getAdvertisementView()
//           let addressHeadRefresh = GmmMJRefreshGifHeader(refreshingTarget: self, refreshingAction: #selector(refreshList))
//            tableView.mj_header = addressHeadRefresh
//
//           tableView.mj_header?.beginRefreshing()
//
//           let footerRefresh = GmmMJRefreshAutoGifFooter(refreshingTarget: self, refreshingAction: #selector(pullRefreshList))
//           tableView.mj_footer = footerRefresh
        
        
         bgView.addSubview(tableView)
 
         tableView.tableFooterView = UIView()
       }
      
    
    //为了解决插件一个buf，垫一层view
    func initBgview(){
        bgView = UIView.init(frame:  CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight - navigationHeaderAndStatusbarHeight - bottomNavigationHeight - pageMenuHeight))
                  
        view.addSubview(bgView)
    }
      @objc func pullRefreshList() {
           
      }
      @objc func refreshList() {
           
      }
      
      //    //获取轮播图
      func getAdvertisementView() -> UIView {
               //[SDCycleScrollView cycleScrollViewWithFrame: imagesGroup:图片数组];
          let image1 = UIImage.init(named: "banner1")
          let image2 = UIImage.init(named: "banner2")
          let image3 = UIImage.init(named: "banner3")
            
          let imageArr = [image1,image2,image3]
          guard let advertisementView = SDCycleScrollView.init(frame: CGRect.init(x: 8, y: 8 , width: screenWidth - 16, height: topAdvertisementViewHeight), imageNamesGroup: imageArr as [Any]) else { return UIView() as! SDCycleScrollView }
          
          advertisementView.layer.cornerRadius = 16;
          advertisementView.layer.masksToBounds = true;
              
        let bannerView:UIView = UIView.init(frame:  CGRect.init(x: 0, y: 0, width: screenWidth, height: topAdvertisementViewHeight + 16))
          bannerView.addSubview(advertisementView)
          //advertisementView.delegate = self
          return bannerView
      }
    
      func getMenuCellType(index:Int) ->menuCellType{
            return menuCellType.init(rawValue: index)!
      }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}//实现tableview的代理方法
extension ChannelArticleController:UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
  
            let cell = tableView.dequeueReusableCell(withIdentifier: RecommendOtherCell.nameOfClass) as! RecommendOtherCell
                             //cell.delegeta = self
            cell.selectionStyle = .none
            return cell
         
      }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 108
           
     }
 
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
 }
