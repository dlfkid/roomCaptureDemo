//
//  USDZPathHelper.swift
//  RoomPlanDemoProj
//
//  Created by ravendeng on 2022/11/7.
//

import Foundation

class USDZPathHelper {
    
    static let kRoomPlanDefaultDir: String = "RoomPlanScannedResults"
    
    public class func scanedModelPath(modelName: String) -> URL? {
        var documentDirectoryHome: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        documentDirectoryHome.append("/\(USDZPathHelper.kRoomPlanDefaultDir)/\(modelName).usdz")
        return URL(fileURLWithPath: documentDirectoryHome)
    }
    
    public class func allStoredScannedModelNames() -> [String] {
        var finalResults:[String] = []
        var documentDirectoryHome: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        documentDirectoryHome.append("/\(USDZPathHelper.kRoomPlanDefaultDir)")
        do {
            let urls = try FileManager.default.contentsOfDirectory(atPath: documentDirectoryHome)
            for url in urls {
                finalResults.append(url)
            }
        } catch {
            print("\(error)")
        }
        return finalResults
    }
    
    public class func deleteScannedModelWithName(modelName: String, completion:(_ error: Error?) -> Void) {
        guard let targetModel = scanedModelPath(modelName: modelName) else {
            completion(nil)
            return
        }
        do {
            try FileManager.default.removeItem(at: targetModel.deletingPathExtension())
            completion(nil)
        } catch {
            completion(error)
        }
    }
}
