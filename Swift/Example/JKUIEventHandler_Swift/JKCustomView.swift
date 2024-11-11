//
//  JKCustomView.swift
//  JKUIEventHandler_Swift_Example
//
//  Created by jack on 2024/11/11.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import JKUIEventHandler_Swift

class JKCustomView: UIView {
    
    private lazy var btn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("点击", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .blue
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        bindUIActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
       self.backgroundColor = .yellow
       addSubview(btn)
    }
    
    func setupConstraints() {
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 30)
    }
    
    func bindUIActions() {
        btn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
    }
    
    @objc func btnClicked() {
        sendChainEvent(eventName: JKCustomView.btnClickedEvent(), data: ["key":"test"])
    }
    
    
    static func btnClickedEvent() ->String {
        return "JKCustomView.btnClickedEvent"
    }
}
