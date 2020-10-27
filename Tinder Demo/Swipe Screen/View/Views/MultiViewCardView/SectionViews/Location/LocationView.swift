//
//  LocationView.swift
//  Tinder Demo
//
//  Created by Colin Murphy on 10/26/20.
//

import MapKit

class LocationView: UIView {

    // MARK: - IBOutlets

    @IBOutlet weak private var locationLabel: UILabel!
    @IBOutlet weak private var mapView: MKMapView!
    @IBOutlet weak private var contentView: UIView!

    // MARK: - Inits

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {

        Bundle.main.loadNibNamed("LocationView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.layer.cornerRadius = 15
        mapView.layer.borderWidth = 0.5
        mapView.layer.borderColor = UIColor.lightGray.cgColor
        mapView.isUserInteractionEnabled = false
    }

    // MARK: - Setup

    func setInfo(user: User) {

        locationLabel.text = user.fullLocation
        guard let latitudeString = user.location?.coordinates?.latitude,
              let latitude = Double(latitudeString),
              let longitudeString = user.location?.coordinates?.longitude,
              let longitude = Double(longitudeString) else { return }

        let annotation = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 50.0, longitudeDelta: 50.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
    }
}
