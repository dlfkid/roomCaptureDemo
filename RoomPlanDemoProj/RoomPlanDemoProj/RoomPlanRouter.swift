//
//  RoomPlanRouter.swift
//  RoomPlanDemoProj
//
//  Created by ravendeng on 2022/11/3.
//

import UIKit

@objc class RoomPlanRouter:NSObject {
    @objc public class func routeToRoomPlanBaseViewController(currentController: UIViewController) {
        let controller = RoomPlanBaseViewController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen;
        currentController.present(nav, animated: true)
    }
    
    @objc public class func routeToRoomPlanCustomViewController(currentController: UIViewController) {
        let controller = RoomPlanCustomViewController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen;
        currentController.present(nav, animated: true)
    }
    
    @objc public class func routeToCachedRoomPlanScanResults(currentController: UIViewController) {
        let controller = RoomPlanResultViewController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen;
        currentController.present(nav, animated: true)
    }
}
