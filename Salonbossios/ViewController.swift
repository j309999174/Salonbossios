//
//  ViewController.swift
//  Salonbossios
//
//  Created by 江东 on 2018/1/15.
//  Copyright © 2018年 江东. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore


class ViewController: UIViewController, WKUIDelegate, WKScriptMessageHandler{
    
    

    var webView: WKWebView!
    var myURL: URL!
    var passresut: String!="https://www.oushelun.cn/salonboss/cusorder/123"
    
    override func loadView() {
        //创建配置
        let webConfiguration = WKWebViewConfiguration()
        //创建用户脚本，负责swift调js
        let userScript = WKUserScript(source: "redHeader()", injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        webConfiguration.userContentController.addUserScript(userScript)
        //内容控制，负责js调用swift
        
        webConfiguration.userContentController.add(self,name: "salonbosstoken")
        //webview加入配置
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true,animated: false)
        //链接改为扫描后的的值
        myURL = URL(string: passresut)
        
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        //self.musicplay()
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("调用1salonbosstoken")
        //js调用储存用户ID
        if(message.name == "salonbosstoken"){
            print("调用salonbosstoken")
            //储存deviceToken
            let urlmessage:String!="https://www.oushelun.cn/decorateajax/salonbosstoken/123/\(UserDefaults.standard.string(forKey: "deviceToken")!)"
            let toSearchword = CFURLCreateStringByAddingPercentEscapes(nil, urlmessage! as CFString, nil, "!*'();@&=+$,?%#[]" as CFString, CFStringBuiltInEncodings.UTF8.rawValue)
            print(toSearchword!)
            let request = URLRequest(url: URL(string: toSearchword! as String)!)
            let configuration = URLSessionConfiguration.default
            
            let session = URLSession(configuration: configuration,
                                     delegate: self as? URLSessionDelegate, delegateQueue:OperationQueue.main)
            
            let dataTask = session.dataTask(with: request,
                                            completionHandler: {(data, response, error) -> Void in
                                                if error != nil{}else{
                                                    print("数据")
                                                    print(data as Any)
                                                }})
            //使用resume方法启动任务
            dataTask.resume()
            print("完成salonbosstoken")
        }
    }
    

}

