//
//  WebScriptMessageHandler.swift
//  horse-racer
//

import WebKit

enum MessageHandlerError {
    case invalidMessageResponse
}

protocol WebScriptMessageHandlerDelegate: class {
    func handleMessage(handler: WebScriptMessageHandler, message: [String: String])
    func handleError(handler: WebScriptMessageHandler, error: MessageHandlerError)
}

final class WebScriptMessageHandler: NSObject, WKScriptMessageHandler {
    
    weak var delegate: WebScriptMessageHandlerDelegate?
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        guard let body = message.body as? [String: String] else {
            
            delegate?.handleError(handler: self, error: .invalidMessageResponse)
            return
        }
        
        delegate?.handleMessage(handler: self, message: body)
        
    }
    
}
