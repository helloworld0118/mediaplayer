//
//  ViewController.swift
//  player
//
//  Created by bing.wang on 15/1/7.
//  Copyright (c) 2015年 devil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var movieplayer: UIView!
    var cbPlayerController:CyberPlayerController!
    var toolBar:UIView!
    var navBar:UIView!
    var btnDo:UIButton!
    var labTitle:UILabel!
    var sliderPro:UISlider!
    var btnTimeAll:UIButton!
    var btnTimeCurrent:UIButton!
    var timer:NSTimer!
    var isWeb:Bool!
    var webUrl:String!
    var tapOnVideoRecognizer:UITapGestureRecognizer!
    var doubletapOnVideoRecognizer:UITapGestureRecognizer!
    var leftOnVideoRecognizer:UISwipeGestureRecognizer!
    var rightOnVideoRecognizer:UISwipeGestureRecognizer!
    override func viewDidLoad() {
        //[[UIApplication sharedApplication] setStatusBarOrientation:[self interfaceOrientation] animated:NO];
       
        super.viewDidLoad()
        let msAk = "vVd7XOk88d2lQPdkHAbzAdjN"
        let msSK = "9SGhNGx8D3vvhcpTzAStM4sfFB76GKVh"
        CyberPlayerController.setBAEAPIKey(msAk, secretKey: msSK)
        cbPlayerController = CyberPlayerController()
        cbPlayerController.view.frame=movieplayer.frame
        self.movieplayer.addSubview(cbPlayerController.view)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onpreparedListener:", name: CyberPlayerLoadDidPreparedNotification, object:nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "seekComplete:", name:CyberPlayerSeekingDidFinishNotification, object:nil)
        let str=NSHomeDirectory()+"/Documents/"+self.title!
        var URL:NSURL!
        if(isWeb == true){
            URL = NSURL(string: webUrl)
        }else{
            URL = NSURL(fileURLWithPath: str)
        }
        cbPlayerController.contentURL = URL
        cbPlayerController.shouldAutoplay = true
        //cbPlayerController.prepareToPlay()
        cbPlayerController.start()
        let initFrame = CGRect(x:0,y:0,width:1,height:45)
        toolBar = UIView(frame: initFrame)
        navBar = UIView(frame: initFrame)
        sliderPro=UISlider(frame: initFrame)
        labTitle=UILabel(frame: initFrame)
        btnDo=UIButton(frame: initFrame)
        btnTimeAll=UIButton(frame: initFrame)
        btnTimeCurrent=UIButton(frame: initFrame)
        self.movieplayer.addSubview(toolBar)
        self.movieplayer.addSubview(navBar)
        toolBar.addSubview(sliderPro)
        toolBar.addSubview(btnTimeAll)
        toolBar.addSubview(btnTimeCurrent)
        toolBar.backgroundColor=UIColor(red: 0/255, green:0/255, blue: 0/255, alpha: 0)
        navBar.addSubview(btnDo)
        navBar.addSubview(labTitle)
        navBar.backgroundColor=UIColor(red: 0/255, green:0/255, blue: 0/255, alpha: 0)
        sliderPro.addTarget(self, action: "dragStart:", forControlEvents: UIControlEvents.TouchDown)
        sliderPro.addTarget(self, action: "dragDo:", forControlEvents: UIControlEvents.TouchUpInside)
        sliderPro.addTarget(self, action: "dragChange:", forControlEvents: UIControlEvents.ValueChanged)
        sliderPro.continuous = true;
        sliderPro.value = 0.0
        btnDo.setTitle("Done", forState: UIControlState.Normal)
        btnDo.addTarget(self, action:  "clickRightButton", forControlEvents: UIControlEvents.TouchDown)
//        let rightButton=UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "clickRightButton")
//        let navigationItem=UINavigationItem()
//        navigationItem.setRightBarButtonItem(rightButton, animated: false)
//        navigationItem.title = self.title!
        //navBar.pushNavigationItem(navigationItem, animated: navBar.addSubview(navigationItem)
        labTitle.text=self.title!
        labTitle.textColor=UIColor.whiteColor()
        tapOnVideoRecognizer=UITapGestureRecognizer(target: self, action: "toggleControlsVisible")
        tapOnVideoRecognizer.numberOfTapsRequired=1
        tapOnVideoRecognizer.numberOfTouchesRequired=1
        doubletapOnVideoRecognizer=UITapGestureRecognizer(target: self, action: "playAndPause")
        doubletapOnVideoRecognizer.numberOfTapsRequired=1
        doubletapOnVideoRecognizer.numberOfTouchesRequired=2
        leftOnVideoRecognizer=UISwipeGestureRecognizer(target: self, action: "move:")
        leftOnVideoRecognizer.direction=UISwipeGestureRecognizerDirection.Left
        rightOnVideoRecognizer=UISwipeGestureRecognizer(target: self, action: "move:")
        rightOnVideoRecognizer.direction=UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(tapOnVideoRecognizer)
        self.view.addGestureRecognizer(doubletapOnVideoRecognizer)
        self.view.addGestureRecognizer(leftOnVideoRecognizer)
        self.view.addGestureRecognizer(rightOnVideoRecognizer)
    }
    func initframe(){
        var rect = UIScreen.mainScreen().bounds
        var size = rect.size
        var width = size.width
        var height = size.height
        cbPlayerController.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        var y = height-45
        toolBar.frame=CGRect(x: 0, y: y, width: width, height: 45)
        navBar.frame=CGRect(x: 0, y: 0, width: width, height: 55)
        btnDo.frame=CGRect(x: width-70, y: 0, width: 50, height: 55)
        labTitle.frame=CGRect(x:50, y: 0, width: width-120, height: 55)
        sliderPro.frame=CGRect(x: 100, y: 0, width: width-200, height: 45)
        btnTimeAll.frame=CGRect(x:width-100,y:0,width:100,height:45)
        btnTimeAll.setTitleColor(UIColor(red: 13/255, green: 148/255, blue: 252/255, alpha: 1.0), forState:UIControlState.Normal)
        btnDo.setTitleColor(UIColor(red: 13/255, green: 148/255, blue: 252/255, alpha: 1.0), forState:UIControlState.Normal)
        btnTimeAll.setTitle("--:--", forState:UIControlState.Normal)
        btnTimeCurrent.frame=CGRect(x:0,y:0,width:100,height:45)
        btnTimeCurrent.setTitle("--:--", forState:UIControlState.Normal)
        btnTimeCurrent.setTitleColor(UIColor(red: 13/255, green: 148/255, blue: 252/255, alpha: 1.0), forState:UIControlState.Normal)
    }
    func move(swipeGestureRecognizer:UISwipeGestureRecognizer){
        var space = cbPlayerController.duration/100
        if swipeGestureRecognizer.direction==UISwipeGestureRecognizerDirection.Left{
            cbPlayerController.seekTo(cbPlayerController.currentPlaybackTime-space)
        }else if swipeGestureRecognizer.direction==UISwipeGestureRecognizerDirection.Right{
            cbPlayerController.seekTo(cbPlayerController.currentPlaybackTime+space)
        }
    }
    func playAndPause(){
      switch cbPlayerController.playbackState {
        case CBPMoviePlaybackStatePlaying:
            cbPlayerController.pause()
        case CBPMoviePlaybackStatePaused:
            cbPlayerController.start()
        default:
            cbPlayerController.start()
        }
    }
    func toggleControlsVisible() {
        var isHidden = !self.navBar.hidden
        self.navBar.hidden = isHidden
        self.toolBar.hidden = isHidden
        UIApplication.sharedApplication().statusBarHidden = isHidden
    }
  
    func clickRightButton(){
        if timer.valid{
            timer.invalidate()
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func onpreparedListener(aNotification:NSNotification){
        //视频文件完成初始化，开始播放视频并启动刷新timer。
        sliderPro.maximumValue = Float(Int(cbPlayerController.duration))
       self.startTimer()
    }
    func seekComplete(notification:NSNotification){
        //开始启动UI刷新
        self.startTimer()
    }
    func startTimer(){
    //为了保证UI刷新在主线程中完成。
        
        dispatch_async(dispatch_get_main_queue(),{
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.5,target: self, selector:"timerHandler:", userInfo: nil, repeats: true)
        })
    }

    func dragStart(sender: UISlider) {
       // self.stopTimer()
        if timer.valid{
            timer.invalidate()
        }
    }
    func dragDo(sender: UISlider){
            //实现视频播放位置切换，
        
        let currentTIme = sliderPro.value;

        cbPlayerController.seekTo(NSTimeInterval(currentTIme))
        
    }
    func dragChange(sender: UISlider) {
        self.refreshProgress(Int(sliderPro.value), allSecond: Int(cbPlayerController.duration))
    }
    func timerHandler(nSTimer:NSTimer){
        if(cbPlayerController != nil){
            self.refreshProgress(Int(cbPlayerController.currentPlaybackTime), allSecond: Int(cbPlayerController.duration))
        }
    
    }
    func refreshProgress(currentTime:Int,allSecond:Int){
        var dict = self.convertSecond2HourMinuteSecond(currentTime)
        var strPlayedTime = self.getTimeString(dict,prefix: "")
        var dictAll = self.convertSecond2HourMinuteSecond(allSecond)
        var strAll = self.getTimeString(dictAll,prefix: "")
        btnTimeAll.setTitle(strAll, forState:UIControlState.Normal)
        btnTimeCurrent.setTitle(strPlayedTime, forState:UIControlState.Normal)
        sliderPro.value = Float(currentTime)
      
    }
    func getTimeString(dict:NSDictionary,prefix:String) ->String
    {
        var hour = dict.objectForKey("hour")?.integerValue
        var minute = dict.objectForKey("minute")?.integerValue
        var second = dict.objectForKey("second")?.integerValue
        var  formatter = hour < 10 ? "0%d" : "%d";
        var  strHour = NSString(format:formatter, hour!)
        formatter = minute < 10 ? "0%d" : "%d";
        var strMinute = NSString(format:formatter, minute!)
        formatter = second < 10 ? "0%d" : "%d";
        var strSecond = NSString(format:formatter, second!)
        return  NSString(format:"%@%@:%@:%@",  prefix, strHour, strMinute, strSecond) as String
    }
    func convertSecond2HourMinuteSecond(second:Int)->NSMutableDictionary
    {
        var dict = NSMutableDictionary()
        var hour = 0
        var minute = 0
        hour = second / 3600;
        minute = (second - hour * 3600) / 60;
        let second = second - hour * 3600 - minute *  60;
        dict.setObject(hour, forKey: "hour")
        dict.setObject(minute, forKey: "minute")
        dict.setObject(second, forKey: "second")
        return dict;
    }
    func startPlayback(){
    }
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        var rect = UIScreen.mainScreen().bounds
        var size = rect.size
        var width = size.width
        var height = size.height
        cbPlayerController.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }

   
    override func shouldAutorotate() -> Bool{
        return true
    }

    override func viewWillAppear(animated: Bool) {
        self.initframe()
        UIApplication.sharedApplication().idleTimerDisabled = true
        let useDefaulte=NSUserDefaults.standardUserDefaults()
        let pro=useDefaulte.floatForKey(self.title!)
        if pro != 0.0 {
            cbPlayerController.seekTo(NSTimeInterval(pro))
            sliderPro.value = pro
        }
        super.viewWillAppear(true)
    }
//    override func supportedInterfaceOrientations() -> Int{
//        return Int(UIInterfaceOrientationMask.LandscapeRight.rawValue)
//    }
    override func viewWillDisappear(animated: Bool) {
        if cbPlayerController != nil {
            NSNotificationCenter.defaultCenter().removeObserver(self, name: CyberPlayerLoadDidPreparedNotification, object: nil)
            NSNotificationCenter.defaultCenter().removeObserver(self, name: CyberPlayerSeekingDidFinishNotification, object: nil)
                cbPlayerController.stop()
                cbPlayerController=nil
        }
        let useDefaulte=NSUserDefaults.standardUserDefaults()
        useDefaulte.setFloat(sliderPro.value, forKey: self.title!)
        useDefaulte.synchronize()
        self.view.removeGestureRecognizer(tapOnVideoRecognizer)
        self.view.removeGestureRecognizer(doubletapOnVideoRecognizer)
        self.view.removeGestureRecognizer(leftOnVideoRecognizer)
        self.view.removeGestureRecognizer(rightOnVideoRecognizer)

    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
}

