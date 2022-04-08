//
//  HomeScreenManager.swift
//  beclone
//
//  Created by duc.vu1 on 04/04/2022.
//

import Foundation

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
        
        let encodedBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        
        guard let encodedBody = encodedBody else {return}
        
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
    
    func parseJSON(with data : Data) {
        
        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
        if let responseJSON = responseJSON as? [String: Any],
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
////                    let data = data.map({ item -> DataSessionModel? in
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
//
//            if let session_1 = sessions[0] {
//                print(session_1)
//            }
            let sessionsModel = convertRawDataToModel(dataArray: array)
            
            setSessionData(sessionsData: sessionsModel)
            
            setBackground(urlBackground: backgroundImage)
        }
    }
    func convertRawDataToModel(dataArray : [[String : Any]]) -> [SessionModel?] {
        let sessionsModel = dataArray.map ({ (item) -> SessionModel? in
            if let id = item["id"] as? Int,
               let name = item["name"] as? String,
               let order = item["order"] as? Int,
               let type = item["type"] as? String,
//                   let data = item["data"] as? [String],
               let metaData = item["meta_data"] as? [String: Any],
               let hash = item["hash"] as? String {
                return SessionModel(id: id, name: name, order: order, type: type, metaData: metaData,  hash: hash)
            }
            else {
                return nil
            }
        })
        return sessionsModel
    }
    
    func setBackground(urlBackground : String) {
//        print(urlBackground)
        self.delegate?.didGetBackgroundForHomeScreen(urlBackground: urlBackground)
    }
    
    func setSessionData(sessionsData : [SessionModel?]) {
        let safeSessionData = sessionsData.compactMap { $0 }
        self.delegate?.didGetSessionsList(sessionsData: safeSessionData)
    }
}
