//
//  MapViewController.swift
//  daval_tourinst_app
//
//  Created by Daniel Felipe Valencia Rodriguez on 16/09/22.
//

import Foundation
import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    //var dataController : DataController = (UIApplication.shared.delegate as! AppDelegate).dataController
    var longGestureRecognizer: UILongPressGestureRecognizer!
    private var selectedLocation: CLLocation?
    //private var selectedPin: Pin!
    //private var fetchedResultsController: NSFetchedResultsController<Pin>!

    
    // MARK: - LifeCycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.isZoomEnabled = true
      //  mapView.delegate = self
    }


}
