//
//  RoomPlanResultViewController.swift
//  RoomPlanDemoProj
//
//  Created by ravendeng on 2022/11/7.
//

import UIKit
import RoomPlan
import PinLayout

class RoomPlanResultViewController: UIViewController {
    
    var capturedModels: [String]? = USDZPathHelper.allStoredScannedModelNames()
    
    lazy private var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Room Plan Results"
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        let leftButton = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissRoomPlanResults))
        self.navigationItem.setLeftBarButton(leftButton, animated: true)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuse")
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all(view.pin.safeArea)
    }
    
    @objc func dismissRoomPlanResults() {
        self.dismiss(animated: true)
    }
}

extension RoomPlanResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "reuse", for: indexPath)
        cell.textLabel?.text = capturedModels?[indexPath.row]
        cell.accessoryType = .detailButton
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let models = capturedModels else {
            return 0
        }
        return models.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let modelName: String = capturedModels![indexPath.row]
            USDZPathHelper.deleteScannedModelWithName(modelName: modelName) { error in
                if (error != nil) {
                    print("Delete model failed with error: \(error.debugDescription)")
                    return
                }
                capturedModels = USDZPathHelper.allStoredScannedModelNames()
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modelName: String = capturedModels![indexPath.row]
        guard let preProcessUrl = USDZPathHelper.scanedModelPath(modelName: modelName) else {
            return
        }
        let finalUrl: URL = preProcessUrl.deletingPathExtension()
        let activityVC = UIActivityViewController(activityItems: [finalUrl], applicationActivities: nil)
        activityVC.modalPresentationStyle = .popover
        
        present(activityVC, animated: true, completion: nil)
        if let popOver = activityVC.popoverPresentationController {
            popOver.sourceView = view
        }
    }
}
