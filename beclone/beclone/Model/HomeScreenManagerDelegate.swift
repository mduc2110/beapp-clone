//
//  HomeScreenManagerDelegate.swift
//  beclone
//
//  Created by duc.vu1 on 04/04/2022.
//

import Foundation

protocol HomeScreenManagerDelegate {
    func didGetBackgroundForHomeScreen(urlBackground : String)
    func didGetSectionsList(sectionsData : [SessionModel])
}
