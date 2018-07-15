//
//  StopSchedule.swift
//  TrafiClient
//
//  Created by Alaa Al-Zaibak on 29.05.2018.
//  Copyright © 2018 Alaa Al-Zaibak. All rights reserved.
//

import UIKit

class StopSchedule: NSObject {
    var name : String
    var destination : String?
    var departures = [Departure]()
    var remainingMinutes : Int? {
        if departures.count > 0 {
            return departures[0].remainingMinutes
        }
        return nil
    }

    init(name: String) {
        self.name = name
    }

    convenience init?(json: [String: String]) {
        guard let name = json["Name"] else {
            return nil
        }

        self.init(name: name)
    }

    func update(json: [String: Any]) {
        self.destination = json["Destination"] as? String
        if let rawDepartures = json["Departures"] as? [[String: Any]] {
            for rawDeparture in rawDepartures {
                if let departure = Departure(json: rawDeparture) {
                    self.departures.append(departure)
                }
            }
            departures.sort { (departure1, departure2) -> Bool in
                return departure1.remainingMinutes < departure2.remainingMinutes
            }
        }
    }
}
