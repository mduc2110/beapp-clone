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
    let type: String
    let data: [DataSectionModel]?
    let metaData: [String : Any]?
    let hash: String
}

