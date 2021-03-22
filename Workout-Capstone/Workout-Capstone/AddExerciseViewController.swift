//
//  AddExerciseViewController.swift
//  Workout-Capstone
//
//  Created by Ron Avrahami on 3/15/21.
//

import UIKit

protocol AddExerciseProtocal: AnyObject {
    func updateExercise(exercise: Exercise)
    func addExercise(exercise: Exercise)
}

class AddExerciseViewController: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var exerciseNameTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var timeGoalTextField: UITextField!
    @IBOutlet weak var requiresEquiptmentControl: UISegmentedControl!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var muscleGroupDropDownButton: UIButton!
    @IBOutlet weak var muscleGroupPicker: UIPickerView!
    @IBOutlet weak var muscleGroupLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
    
    let muscleGroups: [MuscleGroup] = [.defualt, .arms, .back, .legs, .shoulders, .chest, .core]
    var pickedMuscle: MuscleGroup?
    weak var delegate: AddExerciseProtocal?
    
    var titlePlaceHolder: String?
    var exerciseNameTextFieldPlaceHolder: String?
    var repsTextFieldPlaceHolder: Int?
    var timeGoalTextFieldPlaceHolder: Int?
    var requiresEquiptmentPlaceHolder: Int?
    var descriptionTextViewPlaceHolder: String?
    var muscleGroupPickerStatePlaceHolder: MuscleGroup?
    var isEdit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isEdit == true {
            submitButton.setTitle("Save", for: .normal)
        }
        muscleGroupPicker.delegate = self
        muscleGroupPicker.dataSource = self
        descriptionTextView.delegate = self
        
        muscleGroupPicker.isHidden = true
        submitButton.isEnabled = false
        
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 12, left: 6, bottom: 12, right: 6)
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.opaqueSeparator.cgColor
        descriptionTextView.layer.cornerRadius = 10
        
        muscleGroupDropDownButton.setImage(UIImage(systemName: "arrow.forward.circle", withConfiguration: largeConfig), for: .normal)
        muscleGroupDropDownButton.setImage(UIImage(systemName: "arrow.down.circle", withConfiguration: largeConfig), for: .selected)
                
        if let nameTitle = exerciseNameTextFieldPlaceHolder, let repsCount = repsTextFieldPlaceHolder, let timeGoal = timeGoalTextFieldPlaceHolder, let segmentIndex = requiresEquiptmentPlaceHolder, let descriptionText = descriptionTextViewPlaceHolder, let muscleGroupLabelPlaceHolder = muscleGroupPickerStatePlaceHolder?.rawValue {
            
            pickedMuscle = muscleGroupPickerStatePlaceHolder
            
            titleLabel.text = nameTitle
            exerciseNameTextField.text = nameTitle
            repsTextField.text = "\(repsCount)"
            timeGoalTextField.text = "\(timeGoal)"
            descriptionTextView.text = descriptionText
            descriptionTextView.textColor = .black
            muscleGroupLabel.text = "Muscle Group: \(muscleGroupLabelPlaceHolder)"
            requiresEquiptmentControl.selectedSegmentIndex = segmentIndex
            let muscleIndex = muscleGroups.firstIndex { (index) -> Bool in
                index.rawValue == muscleGroupLabelPlaceHolder
            }
            guard muscleIndex != nil else {
                return
            }
            muscleGroupPicker.selectRow(muscleIndex!, inComponent: 0, animated: false)
        } else {
            titleLabel.text = "New Exercise"
            exerciseNameTextField.text = ""
            exerciseNameTextField.placeholder = "New Exercise"
            descriptionTextView.text = "Description"
            descriptionTextView.textColor = UIColor.placeholderText
            muscleGroupLabel.text = "Muscle Group: Pick Group"
        }
        
        enableSubmitCheck()

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        resetValue()
        enableSubmitCheck()
        view.endEditing(true)
    }
    
    @IBAction func exerciseTextFieldEdited(_ sender: Any) {
        titleLabel.text = exerciseNameTextField.text
        if exerciseNameTextField.text == "" {
            titleLabel.text = "New Exercise"
        }
        enableSubmitCheck()
    }
    
    @IBAction func repsTextFieldEdited(_ sender: Any) {
        enableSubmitCheck()
    }
    @IBAction func timeGoalTextFieldEditing(_ sender: Any) {
        enableSubmitCheck()
    }
    
    @IBAction func muscleGroupDropDownButtonTapped(_ sender: Any) {
        muscleGroupDropDownButton.isSelected.toggle()
        muscleGroupPicker.isHidden.toggle()
    }
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        let reps = Int(repsTextField.text!)
        let equiptmentReq: Bool = (requiresEquiptmentControl.selectedSegmentIndex != 0) ? false : true
        let time = Int(timeGoalTextField.text!)
        let timeGoal = TimeInterval(time!) // Must enter int in text field
        
        let exercise = Exercise(name: titleLabel.text, image: nil, timer: timeGoal, reps: reps, requiresEquipment: equiptmentReq, muscle: pickedMuscle , description: descriptionTextView.text)
        
        guard isEdit == false else {
        delegate?.updateExercise(exercise: exercise)
            return
        }
        delegate?.addExercise(exercise: exercise)
    }
    
    func enableSubmitCheck() {
        if (exerciseNameTextField.text != "") && (repsTextField.text != "") && (timeGoalTextField.text != "") && (descriptionTextView.textColor != .placeholderText) && (descriptionTextView.text != "") && (muscleGroupLabel.text != "Muscle Group: Pick Group") {
            submitButton.isEnabled = true
        } else {
            submitButton.isEnabled = false
        }
    }
    
    func resetValue() {
        if exerciseNameTextField.text == "" {
            if exerciseNameTextFieldPlaceHolder != nil  {
            titleLabel.text = exerciseNameTextFieldPlaceHolder
            exerciseNameTextField.text = exerciseNameTextFieldPlaceHolder
            } else {
                titleLabel.text = "New Exercise"
            }
        }
        if repsTextField.text == "" {
            if repsTextFieldPlaceHolder != nil {
                repsTextField.text = "\(repsTextFieldPlaceHolder!)"
            } else {
            repsTextField.placeholder = "0"
            }
        }
        if timeGoalTextField.text == "" {
            guard let timeGoal = timeGoalTextFieldPlaceHolder else {
                repsTextField.placeholder = "0"
                return
            }
            timeGoalTextField.text = "\(timeGoal)"
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.placeholderText {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        enableSubmitCheck()
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.hasText == false {
            if descriptionTextViewPlaceHolder != nil {
                descriptionTextView.textColor = UIColor.black
            } else {
                descriptionTextView.textColor = UIColor.placeholderText
            }
            textView.text = descriptionTextViewPlaceHolder ?? "Description"
        }
    }
    
    //MARK: - PickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return muscleGroups.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard row != 0 else {
            return "Pick Group"
        }
        return muscleGroups[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        enableSubmitCheck()
        guard row != 0 else {
            muscleGroupLabel.text = "Muscle Group: Pick Group"
            enableSubmitCheck()
            return
        }
        pickedMuscle = muscleGroups[row]
        muscleGroupLabel.text = "Muscle Group: \(muscleGroups[row].rawValue)"
        enableSubmitCheck()
        self.view.endEditing(true)
    }
}
