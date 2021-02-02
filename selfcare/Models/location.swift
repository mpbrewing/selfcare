//
//  location.swift
//  selfcare
//
//  Created by Michael Brewington on 1/24/21.
//

import Foundation
import UIKit

class LocationClass: NSObject {
    var locationName: String!
    var location: String!

    init(locationName: String, location: String) {
        self.locationName = locationName
        self.location = location
    }
}
