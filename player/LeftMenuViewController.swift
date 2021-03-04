//
//  LeftMenuViewController.swift
//  player
//
//  Created by bing.wang on 15/1/19.
//  Copyright (c) 2015年 devil. All rights reserved.
//

import UIKit


class LeftMenuViewController: UIViewController,UITableViewDataSource ,UITableViewDelegate,RESideMenuDelegate{
    
    var menutableView:UITableView!
    
    override func viewDidLoad() {
        var rect = UIScreen.mainScreen().bounds
        var size = rect.size
        var width = size.width
        var height = size.height
        menutableView=UITableView(frame: CGRect(x: 0, y: 200, width: width, height: height-200))
        menutableView.backgroundColor=UIColor.clearColor()
        menutableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        menutableView.separatorColor=UIColor.clearColor()
        menutableView.delegate=self
        menutableView.dataSource=self
        self.view.addSubview(menutableView)
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        if(row==0){
            let vc : AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("NavController")
            let controller = vc as! UIViewController
            self.sideMenuViewController.setContentViewController(controller, animated: true)
            self.sideMenuViewController.hideMenuViewController()
        }else if(row==1){
            let navController=UINavigationController(rootViewController: TOWebViewController(URLString: "www.baidu.com"))
            self.sideMenuViewController.setContentViewController(navController, animated: true)
            self.sideMenuViewController.hideMenuViewController()
        }else if(row==2){
            /*
            let lockVc=TestViewController()
            let isPatternSet = (NSUserDefaults.standardUserDefaults().valueForKey("KeyForCurrentPatternToUnlock") != nil) ? true:false
            if(isPatternSet){
                lockVc.infoLabelStatus = InfoStatus;
            }else{
                lockVc.infoLabelStatus = InfoStatusFirstTimeSetting
            }
            self.sideMenuViewController.setContentViewController(lockVc, animated: true)
            self.sideMenuViewController.hideMenuViewController()
            */
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let row=indexPath.row
        var cell =  UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        if(row==0){
            cell.textLabel?.text = "首页"
        }else if(row==1){
             cell.textLabel?.text = "浏览器"
        }else if(row==2){
            cell.textLabel?.text = "电视直播"
        }
        cell.backgroundColor=UIColor.clearColor()
        cell.selectedBackgroundView=UIView()
        cell.selectedBackgroundView!.backgroundColor=UIColor(red: 238/255, green: 237/255, blue: 237/255, alpha:0.7)
        cell.textLabel?.textColor=UIColor.whiteColor()
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        menutableView.tableFooterView=view
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
