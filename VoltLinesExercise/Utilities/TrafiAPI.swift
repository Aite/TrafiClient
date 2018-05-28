//
//  TrafiAPI.swift
//  VoltLinesExercise
//
//  Created by Alaa Al-Zaibak on 26.05.2018.
//  Copyright © 2018 Alaa Al-Zaibak. All rights reserved.
//

import UIKit
import Moya

fileprivate let apiKey = "sandbox_key_not_for_production"

enum TrafiAPI {
    case nearbyStops(latitiude: Double, longitiude: Double, radius: Double)
    case departures(stopId: String, region: String)
}

// MARK: - TargetType Protocol Implementation
extension TrafiAPI: TargetType {
    var baseURL: URL { return URL(string: "http://api-ext.trafi.com")! }
    var path: String {
        switch self {
        case .nearbyStops(_, _, _):
            return "/stops/nearby"
        case .departures(_, _):
            return "/departures"
        }
    }
    var method: Moya.Method {
        switch self {
        case .nearbyStops, .departures:
            return .get
        }
    }
    var task: Task {
        switch self {
        case let .nearbyStops(latitiude, longitiude, radius):
            return .requestParameters(parameters: ["lat": latitiude, "lng": longitiude, "radius": radius, "api_key": apiKey], encoding: URLEncoding.queryString)
        case let .departures(stopId, region):
            return .requestParameters(parameters: ["stop_id": stopId, "region": region, "api_key": apiKey], encoding: URLEncoding.queryString)
        }
    }
    var sampleData: Data {
        switch self {
        case .nearbyStops(let latitiude, let longitiude, _):
            return "{\"Stops\": [ {\"Id\": \"string\", \"Name\": \"string\", \"Direction\": \"string\", \"Coordinate\": { \"Lat\": \(latitiude), \"Lng\": \(longitiude) } } ]}".utf8Encoded
        case .departures(let stopId, _):
            return "{ \"Stop\": { \"Id\": \(stopId), \"Name\": \"string\", \"Direction\": \"string\", \"Coordinate\": { \"Lat\": 0, \"Lng\": 0 } }, \"Schedules\": [ { \"ScheduleId\": \"string\", \"Name\": \"string\", \"IconUrl\": \"string\", \"Color\": \"string\", \"TrackId\": \"string\", \"Destination\": \"string\", \"Departures\": [ { \"TimeUtc\": 0, \"TimeLocal\": \"string\", \"RemainingMinutes\": 0, \"IsRealtime\": true, \"VehicleId\": \"string\" } ] } ] }".utf8Encoded
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json", "Accept": "application/json"]
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
