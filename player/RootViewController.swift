//
//  RootViewController.swift
//  player
//
//  Created by bing.wang on 15/1/19.
//  Copyright (c) 2015年 devil. All rights reserved.
//

import UIKit

class RootViewController:RESideMenu,RESideMenuDelegate{
    
       override func awakeFromNib() {
        menuPreferredStatusBarStyle = UIStatusBarStyle.LightContent;
        contentViewShadowColor = UIColor.blackColor()
        contentViewShadowOffset = CGSizeMake(0, 0);
        contentViewShadowOpacity = 0.6;
        contentViewShadowRadius = 12;
        contentViewShadowEnabled = true;
        

        let main:AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("NavController")
        let leftMenu:AnyObject!=self.storyboard?.instantiateViewControllerWithIdentifier("LeftMenuViewController")
       // let rightMenu:AnyObject!=self.storyboard?.instantiateViewControllerWithIdentifier("RightMenuViewController")
        contentViewController=main as!  UINavigationController
        leftMenuViewController=leftMenu as! LeftMenuViewController
        //rightMenuViewController=rightMenu as RightMenuViewController
        self.backgroundImage = UIImage(named: "Stars")
        
        self.delegate = self;
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
