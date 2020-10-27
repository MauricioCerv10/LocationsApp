//
//  MapaLocatorViewController.swift
//  CiudadesProject
//
//  Created by KMMX on 27/10/20.
//

import UIKit
import MapKit
class MapaLocatorViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapa: MKMapView!
    var currentCapital:Capital?
    override func viewDidLoad() {
        super.viewDidLoad()
        mapa.delegate = self
        mapa.addAnnotation(currentCapital!)
        
        let center = CLLocation(latitude: (currentCapital?.coordinate.latitude)!, longitude: (currentCapital?.coordinate.longitude)!)
        let regionRadius:CLLocationDistance = 10000.0
        let region = MKCoordinateRegion(center: center.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapa.setRegion(region, animated: true)        // Do any additional setup after loading the view.
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else {return nil}
        let identifier = "Capital"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        }else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else {return}
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
