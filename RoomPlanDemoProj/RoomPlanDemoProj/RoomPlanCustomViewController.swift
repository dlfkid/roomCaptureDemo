//
//  RoomPlanCustomViewController.swift
//  RoomPlanDemoProj
//
//  Created by ravendeng on 2022/11/3.
//

import UIKit
import PinLayout

class RoomPlanCustomViewController: UIViewController {
    
    lazy private var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("close", for: .normal)
        button.addTarget(self, action: #selector(closeButtonDidTappedAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Custom Room Plan"
        view.backgroundColor = .white
        view.addSubview(closeButton)
    }
    
    @objc func closeButtonDidTappedAction() {
        self.dismiss(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.pin.top(view.safeAreaInsets.top).marginTop(20).left(16).sizeToFit()
    }
}
