//
//  HelpAndSupportVC.swift
//  NewSmileHS
//
//  Created by thang on 23/07/2021.
//

import UIKit
import WebKit

let helpAndSupport = "https://development.newsmile.app/help/support/customer="

class HelpAndSupportVC: UIViewController {

    private var webView: WKWebView!
    var accessToken: String?
    
    private var url: URL? {
        if let token = accessToken, let url = URL(string: "\(helpAndSupport)\(token)") {
            return url
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWebViewConfiguration { config in
            self.setupWebView(config: config)
            self.loadURL()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if #available(iOS 11.0, *) {
            self.webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
                self.setData(cookies, key: "cookies")
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

extension HelpAndSupportVC {
    
    private func setupWebView(config: WKWebViewConfiguration) {
        self.webView = WKWebView(frame: CGRect.zero, configuration: config)
        self.webView.navigationDelegate = self
        self.webView.uiDelegate = self
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.webView)
        
        NSLayoutConstraint.activate([
            self.webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.webView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
    }
    
    private func getWebViewConfiguration(_ completion: @escaping ((WKWebViewConfiguration) -> Void)) {
        //Need to reuse the same process pool to achieve cookie persistence
        let processPool: WKProcessPool
        if let pool: WKProcessPool = self.getData(key: "pool") as? WKProcessPool {
            processPool = pool
        } else {
            processPool = WKProcessPool()
            self.setData(processPool, key: "pool")
        }
        
        let group = DispatchGroup()
        let configuration = WKWebViewConfiguration()
        configuration.processPool = processPool
        
        if let cookies: [HTTPCookie] = self.getData(key: "cookies") as? [HTTPCookie] {
            for cookie in cookies {
                if #available(iOS 11.0, *) {
                    group.enter()
                    configuration.websiteDataStore.httpCookieStore.setCookie(cookie) {
                        print("Set cookie = \(cookie) with name = \(cookie.name)")
                        group.leave()
                    }
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            completion(configuration)
        }
    }
    
    private func loadURL() {
        guard let url = url else { return }
        let urlRequest = URLRequest(url: url)
        self.webView.load(urlRequest)
    }
    
    func setData(_ value: Any, key: String) {
        do {
            let archivedPool = try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
            UserDefaults.standard.set(archivedPool, forKey: key)
            UserDefaults.standard.synchronize()
        } catch {
            print(error.localizedDescription)
        }
    }

    func getData(key: String) -> Any? {
        guard let val = UserDefaults.standard.value(forKey: key) as? Data else { return nil }
        do {
            if let unarchivedPool = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(val) {
                return unarchivedPool
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

extension HelpAndSupportVC: WKUIDelegate, WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
}
