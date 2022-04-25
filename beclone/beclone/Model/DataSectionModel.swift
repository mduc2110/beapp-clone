//
//  DataSessionModel.swift
//  beclone
//
//  Created by duc.vu1 on 06/04/2022.
//

import Foundation


struct DataSectionModel {
    let type: String
    let id: Int
    let name: String
    let order: Int
    let title: Title
    let url: String
    let image: String
    let is_new: Int
    let is_enabled_label: Int
    let label: Label?
    let is_enabled: Bool
    let title_key: String
    let promoted: Int
    let need_updated: Bool
}

struct Label {
    let en : String
    let vi : String
}

struct Title {
    let en: String
    let vi: String
}
