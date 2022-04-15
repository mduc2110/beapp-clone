//
//  HomeScreenManagerDelegate.swift
//  beclone
//
//  Created by duc.vu1 on 04/04/2022.
//

import Foundation

protocol HomeScreenManagerDelegate {
    func didSetBackgroundForHomeScreen(urlBackground : String)
    func didGetSectionsList(sectionsData : [SectionModel])
}
