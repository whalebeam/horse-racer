//
//  WebViewController.swift
//  horse-racer
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    
    // MARK: Properties
    
    let request: URLRequest
    
    weak var coordinator: WebCoordinator?
    
    lazy var webView: WKWebView = {
       
        let configuration = WKWebViewConfiguration()
        let contentController = WKUserContentController()
        
        // Attach a Script Message Handler so we can be informed of JavaScript events.
        contentController.add(scriptMessageHandler, name: "horseRacer")
        configuration.userContentController = contentController

        let webView = WKWebView(frame: .zero, configuration: configuration)
                
        return webView
    }()
    
    let scriptMessageHandler: WebScriptMessageHandler = {
        let handler = WebScriptMessageHandler()
        return handler
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .systemGray
        return indicator
    }()
    
    // Test Injection Override
    lazy var load: (URLRequest) -> WKNavigation? = webView.load(_:)
    
    
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
        configureAndStartWebView()
        configureConstraints()
    }
    
    
    // MARK: Helpers
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: webView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: webView.centerYAnchor)
        ])
    }
    
    func configureAndStartWebView() {
        scriptMessageHandler.delegate = self
        webView.addSubview(activityIndicator)
        webView.navigationDelegate = self
        activityIndicator.startAnimating()
        
        _ = load(request)
    }
    
}


// MARK: - WKNavigationDelegate

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if navigationAction.navigationType == .linkActivated {
            
            // Cancel the navigation if the user tries to navigate to a non skybet page.
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

// MARK: - WebScriptMessageHandlerDelegate

extension WebViewController: WebScriptMessageHandlerDelegate {
    
    func handleMessage(handler: WebScriptMessageHandler, message: [String : String]) {
        // In the future we could handle an event that the web page has sent us.
    }
    
    func handleError(handler: WebScriptMessageHandler, error: MessageHandlerError) {
        // handle the error
    }
    
}
