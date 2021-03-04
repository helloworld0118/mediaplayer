//
//  MainController.swift
//  player
//
//  Created by bing.wang on 15/1/8.
//  Copyright (c) 2015年 devil. All rights reserved.
//
import UIKit

class MainController: UITableViewController,GCDAsyncSocketDelegate {
    
    @IBOutlet var moviesTable: UITableView!
    var asyncSocket:GCDAsyncSocket!
    var movies:NSMutableArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        movies = NSMutableArray()
        self.loadFiles()

//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"set Pattern" style:UIBarButtonSystemItemAction target:self action:@selector(doPattern)];
          //self.navigationItem.rightBarButtonItem=UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "clickRightButton")
     
        
    }
    /*
    var dateComp=NSDateComponents()
    dateComp.year=2015
    dateComp.month=02
    dateComp.day=05
    dateComp.hour=13
    dateComp.minute=010
    dateComp.timeZone=NSTimeZone.systemTimeZone()
    var calender=NSCalendar(calendarIdentifier: NSGregorianCalendar)
    var date=calender?.dateFromComponents(dateComp)
    var notification:UILocalNotification=UILocalNotification()
    notification.category="hello"
    notification.alertBody="world"
    notification.fireDate=date
    print("\(date)")
    UIApplication.sharedApplication().scheduleLocalNotification(notification)
    */
    func clickRightButton(){
      
        let lockVc=TestViewController()
        lockVc.infoLabelStatus = InfoStatusFirstTimeSetting
        self.presentViewController(lockVc, animated: true, completion: nil)
      //self.presentViewController(webViewController, animated: true, completion: nil)
      //  connect()
//        let vc : AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("viewController")
//        let controller = vc as! ViewController
//        controller.title="CCTV12"
//        controller.isWeb=true
//        controller.webUrl="http://tv.cntv.cn/live/cctv12"
//        self.navigationController?.presentViewController(controller, animated: true, completion: nil)
     
    }
    /*
    func connect() {
        asyncSocket = GCDAsyncSocket(delegate: self, delegateQueue: dispatch_get_main_queue())
         var err: NSError?
        if(!asyncSocket.connectToHost("192.168.202.100", onPort: 3006, error:&err)){
            print("====\(err?.debugDescription)=====")
        }
        let requestStr:NSString = "hello world"
        let data=requestStr.dataUsingEncoding(NSUTF8StringEncoding)
//        NSData *requestData = [requestStr dataUsingEncoding:NSUTF8StringEncoding];
        asyncSocket.writeData(data, withTimeout: -1, tag: 1)
        //asyncSocket.readDataToData(GCDAsyncSocket.CRLFData(), withTimeout: -1, tag: 97)
        //  [_socket readDataToLength:sizeof(int32_t) withTimeout:-1 tag:REQUEST_HEADER_TAG];
        asyncSocket.readDataWithTimeout(-1, tag: 0)
    }*/
    func socket(socket : GCDAsyncSocket, didConnectToHost host:String, port p:UInt16){
        print("=====did====")
    }

    func socket(sock: GCDAsyncSocket!, didReadData data: NSData!, withTag tag: Int) {
        let msg=NSString(data: data, encoding: NSUTF8StringEncoding)
        print("\(tag)=====read====\(msg)====")

    }
    func loadFiles(){
        let fm=NSFileManager()
        let paths=NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.UserDomainMask, true)
        let docDir: AnyObject = paths[0]
        let files=fm.subpathsAtPath(docDir as! String)
        let array = NSArray(array: files!)
        for str in array {
            movies.addObject(str)
        }
    }
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        let vc : AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("viewController")
        let controller = vc as! ViewController
        controller.title=movies![row] as? String
        controller.isWeb=false
        self.navigationController?.presentViewController(controller, animated: true, completion: nil)
       // self.navigationController?.pushViewController(controller, animated: true)
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        let row = indexPath.row
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        //[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.textLabel?.text=movies![row] as? String
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
