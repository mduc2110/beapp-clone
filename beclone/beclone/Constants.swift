//
//  Constant.swift
//  beclone
//
//  Created by duc.vu1 on 04/04/2022.
//

import Foundation

struct K {
    static let apiURL = "https://gw-qa.veep.me/api/v1/be-configuration/customer/get_home_sessions_v2"
    static let accessToken = "662866274d810db738ce7521fbb6c6f1cd0b61f938c8172f4cc391bf7e34a6f8"
    static let initialCellIdentifier = "initialCellIdentifier"
    struct SessionType {
        static let NATIVE_BANNER = "native_banner"
        static let TRIP = "trip"
        static let SCHEDULE = "schedule"
        static let SERVICE = "grid"
        static let OTHER_SERVICE = "other_service"
    }
}
