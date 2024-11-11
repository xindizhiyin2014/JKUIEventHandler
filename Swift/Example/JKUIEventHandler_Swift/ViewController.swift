//
//  ViewController.swift
//  JKUIEventHandler_Swift
//
//  Created by xindizhiyin2014 on 09/26/2021.
//  Copyright (c) 2021 xindizhiyin2014. All rights reserved.
//

import UIKit
import JKUIEventHandler_Swift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = .white
        let customView = JKCustomView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2))
        view.addSubview(customView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: JKChainEventProtocol {
    func jk_receiveChainEvent(eventName: String, data: Any?) -> Bool {
        if eventName == JKCustomView.btnClickedEvent() {
            print("data: \(data)")
        }
        return false
    }
}

