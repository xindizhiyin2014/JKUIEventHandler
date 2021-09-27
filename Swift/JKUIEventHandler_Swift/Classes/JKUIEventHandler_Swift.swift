//
//  JKUIEventHandler_Swift.swift
//  JKUIEventHandler_Swift
//
//  Created by JackLee on 2021/9/26.
//

import UIKit
public protocol JKChainEventProtocol {
    
    /// 接收到链式事件
    /// - Parameters:
    ///   - eventName:事件名称
    ///   - data: 数据
    func jk_receiveChainEvent(eventName: String, data: Any?) -> Bool
}

public protocol JKBroadcastEventProtocol {
    
    /// 接收广播事件
    /// - Parameters:
    ///   - eventName: 事件名称
    ///   - data:  数据
    func jk_receiveBroadcastEvent(eventName: String, data: Any?) -> Bool
}

public extension UIResponder {
    
    func sendChainEvent(eventName: String, data: Any?) {
        var responder = self.jk_nextResponder
        while let currentResponder = responder {
            if !currentResponder.isKind(of: UIWindow.self) && !currentResponder.isKind(of: UIApplication.self) {
                if let handler = currentResponder as? JKChainEventProtocol {
                    if (handler.jk_receiveChainEvent(eventName: eventName, data: data)) {
                        responder = currentResponder.jk_nextResponder
                    } else {
                        break
                    }
                } else {
                    responder = currentResponder.jk_nextResponder
                }
            } else {
                break
            }
        }
    }
    
    func broadcastEvent(eventName: String, data: Any?) {
        
        if let vc = self as? UIViewController {
            if let responder = vc as? JKBroadcastEventProtocol {
                if (!responder.jk_receiveBroadcastEvent(eventName: eventName, data: data)) {
                    return
                }
            }
            
            for subVc in vc.children {
                subVc.broadcastEvent(eventName: eventName, data: data)
            }
            
            if let subView = vc.view as? JKBroadcastEventProtocol {
                if (!subView.jk_receiveBroadcastEvent(eventName: eventName, data: data)) {
                    return
                }
            }
            
            for subView in vc.view.subviews {
                subView.broadcastEvent(eventName: eventName, data: data)
            }
        } else if let view = self as? UIView {
            if let responderView = view as? JKBroadcastEventProtocol {
                if (!responderView.jk_receiveBroadcastEvent(eventName: eventName, data: data)) {
                    return
                }
                for subView in view.subviews {
                    subView.broadcastEvent(eventName: eventName, data: data)
                }
            }
        }
    }
}
