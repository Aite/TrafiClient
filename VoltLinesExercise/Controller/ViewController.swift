//
//  ViewController.swift
//  VoltLinesExercise
//
//  Created by Alaa Al-Zaibak on 25.05.2018.
//  Copyright © 2018 Alaa Al-Zaibak. All rights reserved.
//

import UIKit
import GoogleMaps
import SnapKit

class ViewController: UIViewController {

    private var mapView : GMSMapView!
    private var stopMarkersDictionary : [String : GMSMarker]?
    var viewModel : MarkerListViewModel? {
        didSet {
            refreshMarkers()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        // Levant location
//        let lat = 41.080037
//        let long = 29.008330
//
        // Rio De Janeiro location
        let lat = -22.891144
        let long = -43.225440

        loadGoogleMap(withLatitude: lat, longitude: long)
        loadStops(atLatitude: lat, longitude: long, radius: 500)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Private Methods

    /* Loads google map viewing the passed location
     */
    private func loadGoogleMap(withLatitude lat: Double, longitude long: Double) {

        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self

        view.addSubview(mapView)

        mapView.snp.makeConstraints { (constraintMaker) in
            if #available(iOS 11, *) {
                constraintMaker.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
                constraintMaker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            } else {
                constraintMaker.top.equalToSuperview()
                constraintMaker.bottom.equalToSuperview()
            }
            constraintMaker.leading.equalToSuperview()
            constraintMaker.trailing.equalToSuperview()
        }
    }

    /* Loads the stops at the location using TrafiAPIManager, and create markers for them on the map.
     * It shows an alert to the user if an error occurred
     */
    private func loadStops(atLatitude lat: Double, longitude long: Double, radius: Double) {
        TrafiAPIManager.default.retreiveStops(atLatitude: lat, longitude: long, radius: radius) { (stopsArray, error) in
            guard error == nil else {
                // Show an alert to the user if an error occurred
                let alert = UIAlertController(title: "Error!", message: "Can't connect to the server, please try again later!", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                return
            }
            guard let stops = stopsArray else {
                // Do nothing if there are no stops in the array
                return
            }

            self.viewModel = MarkerListViewModel(stops: stops)
        }
    }

    private func refreshMarkers() -> Void {
        var newMarkers = [String : GMSMarker]()

        // create marker for each marker model view and set its properties (reuse existing marker if it has the same id)
        if let markerViewModels = viewModel?.markerViewModels {
            for markerViewModel in markerViewModels {
                var marker = stopMarkersDictionary?.removeValue(forKey: markerViewModel.id)
                if marker == nil {
                    marker = GMSMarker()
                    // Add the stop to the marker as user data to be used later if needed
                    marker?.map = self.mapView
                }

                newMarkers[markerViewModel.id] = marker

                marker?.position = markerViewModel.position
                marker?.title = markerViewModel.title
                marker?.userData = markerViewModel.stop
            }
        }

        // Remove old markers from the map
        if let markers = stopMarkersDictionary?.values {
            for marker in markers {
                marker.map = nil
                marker.userData = nil
            }
        }

        // set markers dictionary
        self.stopMarkersDictionary = newMarkers
    }
}

extension ViewController : GMSMapViewDelegate {

    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let leftCoordinates = mapView.projection.visibleRegion().nearLeft;
        let rightCoordinates = mapView.projection.visibleRegion().nearRight;
        let distance = Utilities.default.getDistanceMetresBetweenLocationCoordinates(leftCoordinates, rightCoordinates);

        loadStops(atLatitude: position.target.latitude, longitude: position.target.longitude, radius: distance * 0.6)
    }
}
