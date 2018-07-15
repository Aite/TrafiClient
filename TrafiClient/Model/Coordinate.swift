//
//  Coordinate.swift
//  TrafiClient
//
//  Created by Alaa Al-Zaibak on 26.05.2018.
//  Copyright © 2018 Alaa Al-Zaibak. All rights reserved.
//

import UIKit

class Coordinate {
    public var latitiude : Double;
    public var longitiude : Double;

    init(lat: Double, lng: Double) {
        latitiude = lat;
        longitiude = lng
    }

    convenience init?(json: [String: Double]) {
        if let lat = json["Lat"], let lng = json["Lng"] {
            self.init(lat: lat, lng: lng)
        }
        else {
            return nil
        }
    }
}
