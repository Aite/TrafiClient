//
//  StopTooltip.swift
//  VoltLinesExercise
//
//  Created by Alaa Al-Zaibak on 29.05.2018.
//  Copyright © 2018 Alaa Al-Zaibak. All rights reserved.
//

import UIKit

class StopTooltip: NSObject {
    var name : String
    var directionText : String?
    var distanceText : String?
    var schedules = [StopSchedule]()

    init(name: String, directionText: String?, distanceText: String?, schedules: [StopSchedule]?) {
        self.name = name
        if let schedules = schedules {
            self.schedules.append(contentsOf: schedules)
        }
    }

    convenience init(name: String) {
        self.init(name: name, directionText: nil, distanceText: nil, schedules: nil)
    }

    convenience init(json: [String: Any]) {
        let name = (json["Name"] as? String) ?? "Unknown"
        let directionText = json["DirectionText"] as? String
        let distanceText = json["DistanceText"] as? String

        var schedules = [StopSchedule]()
        if let SchedulesArray = json["SchedulesAtStop"] as? [[String: String]] {
            for scheduleDictionary in SchedulesArray {
                if let stopSchedule = StopSchedule(json: scheduleDictionary) {
                    schedules.append(stopSchedule)
                }
            }
        }

        self.init(name: name, directionText: directionText, distanceText: distanceText, schedules: schedules)

    }
}
