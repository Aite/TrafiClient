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

    func updateSchedules(json: [[String: Any]]) {
        var scheduleNames = [String]()
        for rawSchedule in json {
            if let scheduleName = rawSchedule["Name"] as? String {
                guard !scheduleNames.contains(scheduleName) else {
                    continue
                }
                scheduleNames.append(scheduleName)
                if let schedule = self.schedule(withName: scheduleName) {
                    schedule.update(json: rawSchedule)
                }
            }
        }
    }

    func schedule(withName name: String) -> StopSchedule? {
        for schedule in schedules {
            if schedule.name == name {
                return schedule
            }
        }
        
        return nil
    }
}
