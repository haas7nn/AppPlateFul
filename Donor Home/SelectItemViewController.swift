import UIKit

class SelectItemViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Outlets
    @IBOutlet weak var dropdownButton: UIButton!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var weeklyButton: UIButton!
    @IBOutlet weak var monthlyButton: UIButton!
    
    
    
    
    // MARK: - Data
    let items = ["Shawarma", "Mojito", "Pizza", "Humus"]
    private var datePicker: UIDatePicker?
    var selectedFrequency: String? // "Monthly" or "Weekly"
    //private var originalDropdownTitle: String?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDropdownButton()
        setupNumberTextField()
        setupDatePicker()
        dropdownButton.layer.cornerRadius = 10
        weeklyButton.layer.cornerRadius = 10
        monthlyButton.layer.cornerRadius = 10
        
        //originalDropdownTitle = dropdownButton.title(for: .normal)
        
        
        
       
            
          
        
    }
    //to make the textfieldnumber only accept numbers
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        // Allow backspace
        if string.isEmpty {
            return true
        }
        
        // Allow only digits
        if string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil {
            let alert = UIAlertController(
                title: "Invalid Input",
                message: "Please enter numbers only.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return false
        }
        
        return true
    }
    
   
    
    // MARK: - Setup UI
    func setupDropdownButton() {
        dropdownButton.setTitle("Select", for: .normal)
        dropdownButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        
        // Force title to a single line and truncate long text
        dropdownButton.titleLabel?.numberOfLines = 1
        dropdownButton.titleLabel?.lineBreakMode = .byTruncatingTail
        dropdownButton.titleLabel?.adjustsFontSizeToFitWidth = true
        dropdownButton.titleLabel?.minimumScaleFactor = 0.7
        
        // Keep image on right
        //dropdownButton.semanticContentAttribute = .forceRightToLeft
        dropdownButton.contentHorizontalAlignment = .center
        
        // Optional: add spacing between text and image (chevron)
        dropdownButton.configuration?.imagePadding = 8
    }
    
    func setupNumberTextField() {
        numberTextField.keyboardType = .numberPad
        numberTextField.delegate = self
        numberTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.preferredDatePickerStyle = .wheels
        datePicker?.locale = Locale(identifier: "en_US")
        dateTextField.inputView = datePicker
        
        // Add toolbar with Done button
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(doneTapped))
        toolbar.setItems([doneButton], animated: true)
        dateTextField.inputAccessoryView = toolbar
    }
    
    // MARK: - Dropdown Button Action
    @IBAction func dropdownTapped(_ sender: UIButton) {
        
        
        
        /*let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Add items
        for item in items {
            alert.addAction(UIAlertAction(title: item, style: .default, handler: { _ in
                sender.setTitle(item, for: .normal)
            }))
        }
        
        // Clear option
        alert.addAction(UIAlertAction(title: "Clear", style: .destructive, handler: { _ in
            // Reset to original storyboard title
            if let defaultTitle = self.originalDropdownTitle {
                sender.setTitle(defaultTitle, for: .normal)
            }
        }))
        
        // Cancel option
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // iPad compatibility
        if let popover = alert.popoverPresentationController {
            popover.sourceView = sender
            popover.sourceRect = sender.bounds
        }
        
        present(alert, animated: true)*/
        
        
        
        
       
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            // Add selectable items
            for item in items {
                alert.addAction(UIAlertAction(title: item, style: .default, handler: { _ in
                    sender.setTitle(item, for: .normal)
                }))
            }
            
            // Clear option: always reset to "Select"
            alert.addAction(UIAlertAction(title: "Clear", style: .destructive, handler: { _ in
                sender.setTitle("Select", for: .normal)
            }))
            
            // Cancel option
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            // iPad support
            if let popover = alert.popoverPresentationController {
                popover.sourceView = sender
                popover.sourceRect = sender.bounds
            }
            
            present(alert, animated: true)
        
        
    }
    
    // MARK: - Number Field
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, let number = Int(text) {
            print("User typed number:", number)
        } else {
            print("Invalid number or empty")
        }
    }
    
    // MARK: - Date Picker Done
    @objc func doneTapped() {
        if let date = datePicker?.date {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            dateTextField.text = formatter.string(from: date)
        }
        dateTextField.resignFirstResponder()
    }
    
    // MARK: - Monthly / Weekly Buttons
    // MARK: - Monthly / Weekly Buttons
    @IBAction func monthlyButtonTapped(_ sender: UIButton) {
        // Check if dropdown selection is valid
        guard dropdownButton.title(for: .normal) != "Select" else {
            let alert = UIAlertController(title: "Error", message: "Please select an item first.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        selectedFrequency = "Monthly"
        goToConfirmation()
    }
    
   

   
    
    
    
    
    
    

    @IBAction func weeklyButtonTapped(_ sender: UIButton) {
        // Check if dropdown selection is valid
        guard dropdownButton.title(for: .normal) != "Select" else {
            let alert = UIAlertController(title: "Error", message: "Please select an item first.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        selectedFrequency = "Weekly"
        goToConfirmation()
    }

    // MARK: - Input Validation
    func validateInputs() -> Bool {
        // 1️⃣ Dropdown selected?
        if dropdownButton.currentTitle == "Select Item" {
            let alert = UIAlertController(title: "Missing Item", message: "Please select an item.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return false
        }

        // 2️⃣ Number field valid?
        guard let numberText = numberTextField.text, let _ = Int(numberText), !numberText.isEmpty else {
            let alert = UIAlertController(title: "Invalid Quantity", message: "Please enter a valid number.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return false
        }

        // 3️⃣ Date selected?
        guard let dateText = dateTextField.text, !dateText.isEmpty else {
            let alert = UIAlertController(title: "Missing Date", message: "Please select a date.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return false
        }

        // ✅ All good
        return true
    }
    
    // MARK: - Navigation
    func goToConfirmation() {
        guard let date = dateTextField.text, !date.isEmpty else {
            let alert = UIAlertController(title: "Error",
                                          message: "Please select a date first.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        // Perform the segue once
        performSegue(withIdentifier: "goToConfirmation", sender: self)
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToConfirmation",
           let destination = segue.destination as? ConfirmationViewController {
            destination.selectedDate = dateTextField.text ?? ""
            destination.selectedFrequency = selectedFrequency ?? ""
        }
    }
    
    
    
    
    
    }
