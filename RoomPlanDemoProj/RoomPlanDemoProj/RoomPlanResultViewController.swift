//
//  RoomPlanResultViewController.swift
//  RoomPlanDemoProj
//
//  Created by ravendeng on 2022/11/7.
//

import UIKit
import RoomPlan

class RoomPlanResultViewController: UIViewController {
    
    var capturedModels: [CapturedRoom]?
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "resuse")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension RoomPlanResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuse", for: indexPath)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return capturedModels?.count ?? 0
    }
}
