import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Properties
    let geocoder = CLGeocoder()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }

    // MARK: - Actions
    @IBAction func searchLocation(_ sender: Any) {
        guard let address = locationTextField.text, !address.isEmpty else {
            showAlert(title: "Error", message: "Please enter a location")
            return
        }

        geocode(address: address)
    }
    
    // MARK: - Functions
    func geocode(address: String) {
        geocoder.geocodeAddressString(address) { [weak self] placemarks, error in
            guard let self = self else { return }
            
            if let error = error {
                self.showAlert(title: "Error", message: "Could not find location: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first, let location = placemark.location else {
                self.showAlert(title: "Error", message: "Location not found")
                return
            }
            
            let coordinate = location.coordinate
            print("Coordinates: \(coordinate.latitude), \(coordinate.longitude)")
            
            // Show on map
            let region = MKCoordinateRegion(center: coordinate,
                                            latitudinalMeters: 1000,
                                            longitudinalMeters: 1000)
            self.mapView.setRegion(region, animated: true)
            
            // Add a pin
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = address
            self.mapView.addAnnotation(annotation)
        }
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBAction func timeChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy • hh:mm a" // Example: 08:35 PM
        // formatter.dateFormat = "HH:mm" // 24-hour format if you want: 20:35
        
        let selectedTime = formatter.string(from: sender.date)
        print("Selected Time:", selectedTime)
        
        timeLabel.text = selectedTime // only if you have a label to show it
    }
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Success",
                                      message: "Pick up is successful!",
                                      preferredStyle: .alert)
        
        // Add OK button to dismiss
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        // Show the alert
        self.present(alert, animated: true)
    }
    
    }
    

// MARK: - Map View Delegate
extension LocationViewController: MKMapViewDelegate {
    // Optional: customize annotation if needed
}

