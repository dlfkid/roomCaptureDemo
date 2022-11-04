//
//  RoomPlanBaseViewController.swift
//  RoomPlanDemoProj
//
//  Created by ravendeng on 2022/11/3.
//

import UIKit
import RoomPlan
import PinLayout

class RoomPlanBaseViewController: UIViewController {
    
    lazy private var roomCaptureView: RoomCaptureView = {
        let view = RoomCaptureView(frame: self.view.bounds)
        view.captureSession.delegate = self
        view.delegate = self
        return view
    }()

    lazy private var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("close", for: .normal)
        button.addTarget(self, action: #selector(closeButtonDidTappedAction), for: .touchUpInside)
        return button
    }()
    
    lazy private var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("done", for: .normal)
        button.addTarget(self, action: #selector(doneButtonDidTappedAction), for: .touchUpInside)
        return button
    }()
    
    lazy private var exportButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitle("Export", for: .normal)
        button.layer.cornerRadius = 22
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private var isScanning: Bool = false
    
    private var finishedCapturedRoom: CapturedRoom?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Base Room Plan"
        view.backgroundColor = .white
        view.addSubview(roomCaptureView)
        view.addSubview(closeButton)
        view.addSubview(doneButton)
        view.addSubview(exportButton)
        
        exportButton.isEnabled = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        roomCaptureView.pin.pinEdges()
        
        closeButton.pin.top(view.safeAreaInsets.top).marginTop(20).left(16).sizeToFit()
        
        doneButton.pin.top(to: closeButton.edge.top).right(16).sizeToFit()
        
        exportButton.pin.width(50%).height(44).hCenter().bottom(view.safeAreaInsets.bottom).marginBottom(20)
    }
    
    @objc func closeButtonDidTappedAction() {
        self.dismiss(animated: true)
    }
    
    @objc func doneButtonDidTappedAction() {
        if isScanning {
            stopSession()
        }
        closeButtonDidTappedAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startSession()
    }
    
    override func viewWillDisappear(_ flag: Bool) {
        super.viewWillDisappear(flag)
        stopSession()
    }
    
    private func startSession() {
        isScanning = true
        let configuration = RoomCaptureSession.Configuration()
        roomCaptureView.captureSession.run(configuration: configuration)
    }
    
    private func stopSession() {
        isScanning = false
        roomCaptureView.captureSession.stop()
        exportButton.isEnabled = true
    }

}

extension RoomPlanBaseViewController: RoomCaptureSessionDelegate {
    
}

extension RoomPlanBaseViewController: RoomCaptureViewDelegate {
    func captureView(shouldPresent roomDataForProcessing: CapturedRoomData, error: Error?) -> Bool {
        guard error == nil else {
            return false
        }
        return true
    }
    
    func captureView(didPresent processedResult: CapturedRoom, error: Error?) {
        finishedCapturedRoom = processedResult
    }
}
