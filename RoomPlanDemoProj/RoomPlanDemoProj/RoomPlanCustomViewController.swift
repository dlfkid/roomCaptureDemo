//
//  RoomPlanCustomViewController.swift
//  RoomPlanDemoProj
//
//  Created by ravendeng on 2022/11/3.
//

import UIKit
import PinLayout
import RealityKit
import RoomPlan
import ARKit

class RoomPlanCustomViewController: UIViewController {
    
    var previewVisualizer: Visualizer!
    
    lazy private var arView: ARView = {
        let view = ARView(frame: .zero)
        return view
    }()
    
    lazy private var captureSession: RoomCaptureSession = {
        let session = RoomCaptureSession()
        arView.session = session.arSession
        return session
    }()
    
    lazy private var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("close", for: .normal)
        button.addTarget(self, action: #selector(closeButtonDidTappedAction), for: .touchUpInside)
        return button
    }()
    
    var roomBuilder = RoomBuilder(options: [.beautifyObjects])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Custom Room Plan"
        view.backgroundColor = .white
        view.addSubview(arView)
        view.addSubview(closeButton)
        captureSession.delegate = self
    }
    
    @objc func closeButtonDidTappedAction() {
        self.dismiss(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        arView.pin.pinEdges()
        closeButton.pin.top(view.safeAreaInsets.top).marginTop(20).left(16).sizeToFit()
        
    }
}

extension RoomPlanCustomViewController: RoomCaptureSessionDelegate {
    
    func captureSession(_ session: RoomCaptureSession, didUpdate room: CapturedRoom) {
        previewVisualizer.update(model: room)
    }
    
    func captureSession(_ session: RoomCaptureSession, didProvide instruction: RoomCaptureSession.Instruction) {
        previewVisualizer.provide(instruction)
    }
    
    func captureSession(_ session: RoomCaptureSession, didEndWith data: CapturedRoomData, error: Error?) {
        if let error = error {
            print("Error: \(error)")
        }
        Task {
            do {
                let finalRoom = try await roomBuilder.capturedRoom(from: data)
                previewVisualizer.update(model: finalRoom)
            } catch {
                print("\(error)")
            }
            
        }
    }
}
