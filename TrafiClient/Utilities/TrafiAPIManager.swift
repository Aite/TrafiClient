//
//  TrafiAPIManager.swift
//  TrafiClient
//
//  Created by Alaa Al-Zaibak on 27.05.2018.
//  Copyright © 2018 Alaa Al-Zaibak. All rights reserved.
//

import UIKit
import Moya

class TrafiAPIManager: NSObject {
    /* Holds the singleton instance.
     */
    private static var instance = TrafiAPIManager()

    /* Returns the default singleton instance.
     */
    open class var `default`: TrafiAPIManager {
        get {
            return instance
        }
    }

    /* Holds Moya provider instance for TrafiAPI.
     */
    private let provider = MoyaProvider<TrafiAPI>()

    /* Gets the stops info at the location using TrafiAPI, create Stop instances, and send them in the completion block to the caller in array.
     * If an error occurred it will be returned in the parameter `error` and the parameter `stops` will be nil
     */
    public func retreiveStops(atLatitude lat: Double, longitude long: Double, radius: Double, _ completion: @escaping (_ stops: [Stop]?, _ error: Error?) -> Void) {
        provider.request(.nearbyStops(latitiude: lat, longitiude: long, radius: radius)) { result in

            switch result {
            case let .success(moyaResponse):
                do {
                    _ = try moyaResponse.filterSuccessfulStatusCodes()
                    let json = try moyaResponse.mapJSON()

                    var stops = [Stop]()
                    if let json = json as? [String: Any] {
                        if let rawStops = json["Stops"] as? [[String: Any]] {
                            var stopIds = [String]()
                            for rawStop in rawStops {
                                if let stop = Stop(json: rawStop) {
                                    guard !stopIds.contains(stop.id) else {
                                        continue
                                    }
                                    stopIds.append(stop.id)
                                    stops.append(stop)
                                }
                            }
                        }
                    }
                    completion(stops, nil)
                }
                catch let error {
                    // show an error to your user
                    print(error)
                    completion(nil, error)
                }

            case let .failure(error):
                print(error)
                completion(nil, error)

            }
        }
    }

    /* Gets the stop departures info using TrafiAPI, set them to the Stop instance, and send a success variable in the completion block to the caller.
     * If an error occurred it will be returned in the parameter `error` and the parameter `success` will be false
     */
    public func retreiveStopDepartures(for stop: Stop, region: String, _ completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        provider.request(.departures(stopId: stop.id, region: region)) { result in

            switch result {
            case let .success(moyaResponse):
                do {
                    _ = try moyaResponse.filterSuccessfulStatusCodes()
                    let json = try moyaResponse.mapJSON()

                    if let json = json as? [String: Any] {
                        
                        if let rawStopSchedules = json["Schedules"] as? [[String: Any]] {
                            stop.tooltip.updateSchedules(json: rawStopSchedules)
                        }
                    }
                    completion(true, nil)
                }
                catch let error {
                    // show an error to your user
                    print(error)
                    completion(false, error)
                }

            case let .failure(error):
                print(error)
                completion(false, error)

            }
        }
    }
}
