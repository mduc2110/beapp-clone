//
//  HomeScreenManager.swift
//  beclone
//
//  Created by duc.vu1 on 04/04/2022.
//

import Foundation
import UIKit

struct HomeScreenManager {
    
    var delegate : HomeScreenManagerDelegate?
    
    func getHomeData() {
        let body : [String : Any] = [
            "client_info" : [
                "env" : "qa",
                "device_type" : 1,
                "location" : [
                    "longitude": 106.69368464146106,
                    "latitude": 10.782660491413475
                ],
                "locale": "vi",
                "os_version": "12.4",
                "client_id": "EEBUOvQq7RRJBxJm",
                "app_version": "3614",
                "customer_package_name": "xyz.be.customer"
            ],
            "access_token": K.accessToken
        ]
        
        guard let encodedBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted) else { return }
        
        // create post request
        let url = URL(string: K.apiURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = encodedBody
        request.allHTTPHeaderFields = [
            "Content-Type" : "application/json",
            "access_token" : K.accessToken
        ]
//        var session = URLSession(configuration: .default)
//        URLSession.shared.uploadTask(with: <#T##URLRequest#>, from: <#T##Data#>)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            parseJSON(with : data)

        }
        task.resume()
        
    }
    
    func demo() throws -> Int {
        if true {
            return 1
        } else {
            throw NSError()
        }
    }
    
    private func parseJSON(with data : Data) {
        
        if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let array = responseJSON["sessions"] as? [[String: Any]],
           let backgroundImage = responseJSON["background_image"] as? String
        {
//            let sessions = array.map ({ (item) -> SessionModel? in
//                if let id = item["id"] as? Int,
//                   let name = item["name"] as? String,
//                   let order = item["order"] as? Int,
//                   let type = item["type"] as? String,
////                   let data = item["data"] as? [String],
//                   let metaData = item["meta_data"] as? [String: Any],
////                   let title = item["title"],
//                   let hash = item["hash"] as? String {
//
////                    let data = data.map({ item -> DataSectionModel? in
//////                        if let id = item {
////                            print(item)
//////                        }
////                        return nil
////                    })
////                    let meta = metaData.map { [$0.key : $0.value] }
////                    print(meta)
////                    return nil
//                    return SessionModel(id: id, name: name, order: order, type: type, metaData: metaData,  hash: hash)
//
//                }
//                else {
//                    return nil
//                }
//
//
//            })

            setSessionData(sessionsData: array.toSections())
            setBackground(urlBackground: backgroundImage)
        }
    }
    
    func setBackground(urlBackground : String) {
//        print(urlBackground)
        self.delegate?.didSetBackgroundForHomeScreen(urlBackground: urlBackground)
    }
    
    func setSessionData(sessionsData : [SectionModel?]) {
        let safeSessionData = sessionsData.compactMap { $0 }
        self.delegate?.didGetSectionsList(sectionsData: safeSessionData)
    }
}

fileprivate extension Dictionary where Key == String, Value == Any {
    func toDataSectionModel() -> DataSectionModel? {
        guard
            let type = self["@type"] as? String,
            let id = self["id"] as? Int,
            let name = self["name"] as? String,
            let order = self["order"] as? Int,
            let title = self["title"] as? [String : Any],
            let url = self["url"] as? String,
            let image = self["image"] as? String,
            let is_new = self["is_new"] as? Int,
            let is_enabled_label = self["is_enabled_label"] as? Int,
            let label = self["label"] as? [String : Any]?,
            let is_enabled = self["is_enabled"] as? Bool,
            let title_key = self["title_key"] as? String,
            let promoted = self["promoted"] as? Int,
            let need_updated = self["need_updated"] as? Bool,
            let vi = title["vi"] as? String,
            let en = title["en"] as? String
        else {
            return nil
        }
        
        let decodedTitle: Title = Title(en: en, vi: vi)
        var decodedLabel: Label?
        
        if  let label = label,
            let vi = label["vi"] as? String,
            let en = label["en"] as? String {
            decodedLabel = Label(en: en, vi: vi)
        } else {
            decodedLabel = nil
        }
        
        return DataSectionModel(
            type: type,
            id: id,
            name: name,
            order: order,
            title: decodedTitle,
            url: url,
            image: image,
            is_new: is_new,
            is_enabled_label: is_enabled_label,
            label: decodedLabel,
            is_enabled: is_enabled,
            title_key: title_key,
            promoted: promoted,
            need_updated: need_updated
        )
    }
}

fileprivate extension Array where Element == Dictionary<String, Any> {
    func toSections() -> [SectionModel?] {
        let sectionsModel = map { (item) -> SectionModel? in //compact map
            guard let id = item["id"] as? Int,
                  let name = item["name"] as? String,
                  let order = item["order"] as? Int,
                  let type = item["type"] as? String,
                  let data = item["data"] as? [[String : Any]],
                  let metaData = item["meta_data"] as? [String: Any],
                  let hash = item["hash"] as? String
            else { return nil }
            
            if type != "native_banner", type != "trip", type != "grid", type != "banner" {
                return nil
            }
            
            let dataSession : [DataSectionModel?] = data.map(HomeMapper.toDataSectionModel)//data.map { $0.toDataSectionModel() }
            
            let unwrappedData : [DataSectionModel]?
            
            if dataSession.count > 0 {
                unwrappedData = dataSession.map { $0! }
            } else {
                unwrappedData = nil
            }
            
            return SectionModel(id: id, name: name, order: order, type: Type(rawValue: type) ?? Type.none, data: unwrappedData,  metaData: metaData,  hash: hash)
        }
        return sectionsModel
    }
}

fileprivate struct HomeMapper {
    static func toDataSectionModel(data: [String: Any]) -> DataSectionModel? {
        guard
            let type = data["@type"] as? String,
            let id = data["id"] as? Int,
            let name = data["name"] as? String,
            let order = data["order"] as? Int,
            let title = data["title"] as? [String : Any],
            let url = data["url"] as? String,
            let image = data["image"] as? String,
            let is_new = data["is_new"] as? Int,
            let is_enabled_label = data["is_enabled_label"] as? Int,
            let label = data["label"] as? [String : Any]?,
            let is_enabled = data["is_enabled"] as? Bool,
            let title_key = data["title_key"] as? String,
            let promoted = data["promoted"] as? Int,
            let need_updated = data["need_updated"] as? Bool,
            let vi = title["vi"] as? String,
            let en = title["en"] as? String
        else {
            return nil
        }
        
        let decodedTitle: Title = Title(en: en, vi: vi)
        var decodedLabel: Label?
        
        if  let label = label,
            let vi = label["vi"] as? String,
            let en = label["en"] as? String {
            decodedLabel = Label(en: en, vi: vi)
        } else {
            decodedLabel = nil
        }
        
        return DataSectionModel(
            type: type,
            id: id,
            name: name,
            order: order,
            title: decodedTitle,
            url: url,
            image: image,
            is_new: is_new,
            is_enabled_label: is_enabled_label,
            label: decodedLabel,
            is_enabled: is_enabled,
            title_key: title_key,
            promoted: promoted,
            need_updated: need_updated
        )
    }
}

