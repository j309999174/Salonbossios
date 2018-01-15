//
//  ViewController.swift
//  Salonbossios
//
//  Created by 江东 on 2018/1/15.
//  Copyright © 2018年 江东. All rights reserved.
//

import UIKit
import WebKit


class ViewController: UIViewController, WKUIDelegate, WKScriptMessageHandler{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        //js调用储存用户ID
        if(message.name == "ioscosidsave"){
            print("美容师ID\(message.body)")
            
            UserDefaults.standard.set(message.body, forKey: "cosid")
            print("储存的美容师id\(String(describing: UserDefaults.standard.string(forKey: "cosid")!))")
        }
    }
    
    

    var webView: WKWebView!
    var myURL: URL!
    var passresut: String!="http://47.96.173.116/salonboss/salonbosslogin/123"
    
    override func loadView() {
        //创建配置
        let webConfiguration = WKWebViewConfiguration()
        //创建用户脚本，负责swift调js
        let userScript = WKUserScript(source: "redHeader()", injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        webConfiguration.userContentController.addUserScript(userScript)
        //内容控制，负责js调用swift
        
        webConfiguration.userContentController.add(self,name: "ioscosidsave")
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


}

