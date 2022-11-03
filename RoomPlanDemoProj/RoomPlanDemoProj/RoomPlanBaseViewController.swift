//
//  RoomPlanBaseViewController.swift
//  RoomPlanDemoProj
//
//  Created by ravendeng on 2022/11/3.
//

import UIKit

class RoomPlanBaseViewController: UIViewController {

    lazy private var closeButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("close", for: .normal)
        button.addTarget(self, action: #selector(closeButtonDidTappedAction), for: .touchUpInside)
        return button
    }()
    
    lazy private var doneButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("done", for: .normal)
        button.addTarget(self, action: #selector(doneButtonDidTappedAction), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Base Room Plan"
        view.backgroundColor = .white
        view.addSubview(closeButton)
        view.addSubview(doneButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        closeButton.pin.top(view.safeAreaInsets.top).marginTop(20).left(16).sizeToFit()
        
        doneButton.pin.top(to: closeButton.edge.top).right(16).sizeToFit()
    }
    
    @objc func closeButtonDidTappedAction() {
        self.dismiss(animated: true)
    }
    
    @objc func doneButtonDidTappedAction() {
        
    }

}

extension RoomPlanBaseViewController {
    
}
