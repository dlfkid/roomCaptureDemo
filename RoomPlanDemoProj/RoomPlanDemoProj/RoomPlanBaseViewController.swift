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
        button.addTarget(self, action: #selector(exportResultFunction), for: .touchUpInside)
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
            return
        }
        let alertController = UIAlertController(title: "Finished", message: "Your captured model is ready, you wanna quit with out exporting it?", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { action in
            self.closeButtonDidTappedAction()
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
        alertController.addAction(cancelAction)
        alertController.addAction(alertAction)
        
        present(alertController, animated: true)
    }
    
    @objc func exportResultFunction() {
        
        let inputAlert = UIAlertController(title: "导出模型", message: "输入模型名称", preferredStyle: .alert)
        
        inputAlert.addTextField()
        
        let confirmAction = UIAlertAction(title: "确定", style: .default) { [unowned inputAlert] _ in
            guard let textField = inputAlert.textFields?.first else {
                return
            }
            let modelName = textField.text ?? "roomPlanScanModel"
            self.exportRoomPlanModel(modelName: modelName)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        
        inputAlert.addAction(confirmAction)
        inputAlert.addAction(cancelAction)
        
        present(inputAlert, animated: true)
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
    
    func exportRoomPlanModel(modelName: String) {
        do {
            let destinationURL = USDZPathHelper.scanedModelPath(modelName: modelName)
            
            guard let destinationURL else {
                return
            }
            
            try finishedCapturedRoom?.export(to: destinationURL, exportOptions: .parametric)
            
            let activityVC = UIActivityViewController(activityItems: [destinationURL], applicationActivities: nil)
            activityVC.modalPresentationStyle = .popover
            
            present(activityVC, animated: true, completion: nil)
            if let popOver = activityVC.popoverPresentationController {
                popOver.sourceView = view
            }
        } catch {
            let action = UIAlertAction(title: "确定", style: .cancel)
            let alertController = UIAlertController(title: "导出失败", message: error.localizedDescription, preferredStyle: .alert)
            alertController.addAction(action)
            self.present(alertController, animated: true)
        }
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
