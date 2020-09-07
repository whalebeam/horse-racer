//
//  WebViewController.swift
//  horse-racer
//
//  Created by David Gray on 07/09/2020.
//  Copyright © 2020 whalebeam. All rights reserved.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    
    // MARK: Properties
    
    let request: URLRequest
    
    weak var coordinator: WebCoordinator?
    
    var webView = WKWebView()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .systemGray
        return indicator
    }()
    
    
    // MARK: Init
    
    init(url: URL) {
        self.request = URLRequest(url: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: View Lifecycle
    
    override func loadView() {
        view = webView
    }
    
    override func viewDidLoad() {
        configureWebView()
        configureConstraints()
    }
    
    
    // MARK: Helpers
    
    func configureConstraints() {
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: webView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: webView.centerYAnchor)
        ])
        
    }
    
    func configureWebView() {
        webView.addSubview(activityIndicator)
        webView.navigationDelegate = self
        webView.load(request)
        activityIndicator.startAnimating()
    }
    
}


extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if navigationAction.navigationType == .linkActivated {
            
            // Let's cancel the navigation if the user tries to navigate to a non skybet page.
            guard let url = navigationAction.request.url, url.absoluteString.lowercased().contains("skybet") else {
                decisionHandler(.cancel)
                return
            }
            
            decisionHandler(.allow)
            
        } else {
            decisionHandler(.allow)
        }
        
    }
    
}
