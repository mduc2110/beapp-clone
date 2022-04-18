//
//  SessionModel.swift
//  beclone
//
//  Created by duc.vu1 on 06/04/2022.
//

import Foundation


struct SectionModel {
    let id: Int
    let name: String
    let order: Int
    let type: Type?
    let data: [DataSectionModel]?
    let metaData: [String : Any]?
    let hash: String
}

enum Type: String {
    case nativeBanner = "native_banner"
    case trip = "trip"
    case grid = "grid"
    case banner = "banner"
    case none = "none"
    
}

struct MyType: RawRepresentable, Equatable {
    typealias RawValue = String
    var rawValue: String
    
    init?(rawValue: String) {
        self.rawValue = rawValue
    }
    
    static let nativeBanner = MyType(rawValue: "native_banner")!
    static let trip = MyType(rawValue: "trip")!
    static let grid = MyType(rawValue: "grid")!
    static let banner = MyType(rawValue: "banner")!
}

func demo() {
    let a = MyType(rawValue: "trip")!
    switch a {
    case .trip:
        break
        
    case .nativeBanner:
        break
    default:
        break
    }
}
