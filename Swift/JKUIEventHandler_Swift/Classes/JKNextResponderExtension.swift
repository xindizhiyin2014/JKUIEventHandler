//
//  NextResponderExtension.swift
//  JKUIEventHandler_Swift
//
//  Created by JackLee on 2021/9/26.
//

import Foundation
private var nextResponderKey = "jk_nextResponder"

extension UIResponder {
    
    private class WeakWarp {
        weak var responder: UIResponder?
        init(obj: UIResponder?) {
            self.responder = obj
        }
    }
    
    public var jk_nextResponder: UIResponder? {
        get {
            if let obj = objc_getAssociatedObject(self, &nextResponderKey) as? WeakWarp {
                return obj.responder
            } else {
                return nil
            }
        }
        set {
            if let obj = newValue {
                objc_setAssociatedObject(self, &nextResponderKey, WeakWarp(obj: obj), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            } else {
                objc_setAssociatedObject(self, &nextResponderKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
