//
//  HomeViewController.swift
//  BaiYi
//
//  Created by zhaoyuanjing on 2020/07/24.
//  Copyright © 2020 gansukanglin. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON
import MJRefresh
import SDCycleScrollView




enum MenuType: Int {
    case Articel = 0// 文章
    case Video  // 视频
    case Report // 病例
}

enum menuCellType: Int{
     case Rank = 0
     case Recommend
 }

class HomeViewController: BaseViewController ,Requestable{
 
    let topAdvertisementViewHeight = screenWidth * 0.4
    
    var tableView:UITableView!
  
    var AdvertisementView:SDCycleScrollView!
    var searView:HomeSearchView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = ""
 
        initUI()
        loadData()
     }
    
    func initUI(){
          initTableView()
          initSearchView()
    }

    func loadData(){
        let HomeAllResumeParams = HomeAPI.HomeAllResumePathAndParams()
              postRequest(pathAndParams: HomeAllResumeParams,showHUD: false)
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
    func initSearchView(){
        searView = Bundle.main.loadNibNamed("HomeSearchView", owner: nil, options: nil)!.first as? HomeSearchView
        searView.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: 44)
        searView.delegate = self
        self.navigationController?.navigationBar.addSubview(searView)
      
    }
    
    func initTableView(){
         tableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - 64 ), style: .plain)
         tableView.delegate = self
         tableView.dataSource = self
         tableView.separatorStyle = .none
         tableView.registerNibWithTableViewCellName(name: HomeTopRankCell.nameOfClass)
         tableView.registerNibWithTableViewCellName(name: RecommendFirstCell.nameOfClass)
         tableView.registerNibWithTableViewCellName(name: RecommendOtherCell.nameOfClass)
        
       
         tableView.tableHeaderView = getAdvertisementViewS()
       //  let addressHeadRefresh = GmmMJRefreshGifHeader(refreshingTarget: self, refreshingAction: #selector(refreshList))
        //  tableView.mj_header = addressHeadRefresh

       //  tableView.mj_header?.beginRefreshing()

       //  let footerRefresh = GmmMJRefreshAutoGifFooter(refreshingTarget: self, refreshingAction: #selector(pullRefreshList))
       //  tableView.mj_footer = footerRefresh
         
          view.addSubview(tableView)
         
         tableView.tableFooterView = UIView()
     }
    
    @objc func pullRefreshList() {
         
    }
    @objc func refreshList() {
         
    }
    
    //    //获取轮播图
    func getAdvertisementViewS() -> UIView {
             //[SDCycleScrollView cycleScrollViewWithFrame: imagesGroup:图片数组];
        let image1 = UIImage.init(named: "banner1")
        let image2 = UIImage.init(named: "banner2")
        let image3 = UIImage.init(named: "banner3")
          
        let imageArr = [image1,image2,image3]
        guard let advertisementView = SDCycleScrollView.init(frame: CGRect.init(x: 8, y: 8, width: screenWidth - 16, height: topAdvertisementViewHeight), imageNamesGroup: imageArr as [Any]) else { return UIView() as! SDCycleScrollView }
        
        advertisementView.layer.cornerRadius = 16;
        advertisementView.layer.masksToBounds = true;
            
        let bannerView = UIView.init(frame:  CGRect.init(x: 0, y: 0, width: screenWidth, height: topAdvertisementViewHeight + 16))
        bannerView.addSubview(advertisementView)
        //advertisementView.delegate = self
        return bannerView
    }
  
    func getMenuCellType(index:Int) ->menuCellType{
          return menuCellType.init(rawValue: index)!
    }


}
//实现tableview的代理方法
extension HomeViewController:UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch getMenuCellType(index: section){
               case .Rank:
                    return 1
               case .Recommend:
                    return 10
            }
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let section = indexPath.section
        let row = indexPath.row
        switch getMenuCellType(index: section){
             case .Rank:
                  let cell = tableView.dequeueReusableCell(withIdentifier: HomeTopRankCell.nameOfClass) as! HomeTopRankCell
                             //cell.delegeta = self
                    cell.selectionStyle = .none
                    return cell
             case .Recommend:
                if row == 0{
                    let cell = tableView.dequeueReusableCell(withIdentifier: RecommendFirstCell.nameOfClass) as! RecommendFirstCell
                             //cell.delegeta = self
                    cell.selectionStyle = .none
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: RecommendOtherCell.nameOfClass) as! RecommendOtherCell
                             //cell.delegeta = self
                    cell.selectionStyle = .none
                    return cell
               }
         }
      }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
              let row = indexPath.row
              switch getMenuCellType(index: section){
                   case .Rank:
                        return 260
                   case .Recommend:
                      if row == 0{
                        return 220
                      }else{
                         return 108
                     }
               }
     }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = Bundle.main.loadNibNamed("HomeRankHeaderView", owner: nil, options: nil)!.first as! HomeRankHeaderView
        sectionView.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: 44)
        switch getMenuCellType(index: section){
     
         case .Rank:
             sectionView.name.text = "本周排行"
             return sectionView
         case .Recommend:
              sectionView.name.text = "好友推荐"
              sectionView.moreBtn.setTitle("更多", for: .normal)
              return sectionView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         switch getMenuCellType(index: section){
            default:
              return 44
          }
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
 }
//搜索代理
extension HomeViewController:HomeSearchViewDelegate{
   
     func searchActoin() {
        print("fdsafdsafdsfsda")
//       let controller =  UIStoryboard.getCMSearchViewController()
//       self.pushViewController(controller, animated: true)
     }
}
