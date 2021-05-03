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
    @IBOutlet weak var requiresEquiptmentControl: UISegmentedControl!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var muscleGroupDropDownButton: UIButton!
    @IBOutlet weak var muscleGroupPicker: UIPickerView!
    @IBOutlet weak var muscleGroupLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var timeGoalPicker: UIPickerView!
    @IBOutlet weak var timeGoalLabel: UILabel!
    @IBOutlet weak var timeGoalDownButton: UIButton!
    
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
    
    
    var minutes:Int = 0
    var seconds:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if isEdit == true {
            submitButton.setTitle("Save", for: .normal)
        }
        muscleGroupPicker.delegate = self
        muscleGroupPicker.dataSource = self
        timeGoalPicker.delegate = self
        timeGoalPicker.dataSource = self
        descriptionTextView.delegate = self
        
        muscleGroupPicker.isHidden = true
        timeGoalPicker.isHidden = true
        submitButton.isEnabled = false
        
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 12, left: 6, bottom: 12, right: 6)
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.opaqueSeparator.cgColor
        descriptionTextView.layer.cornerRadius = 10
        
        muscleGroupDropDownButton.setImage(UIImage(systemName: "arrow.forward.circle", withConfiguration: largeConfig), for: .normal)
        muscleGroupDropDownButton.setImage(UIImage(systemName: "arrow.down.circle", withConfiguration: largeConfig), for: .selected)
        
        timeGoalDownButton.setImage(UIImage(systemName: "arrow.forward.circle", withConfiguration: largeConfig), for: .normal)
        timeGoalDownButton.setImage(UIImage(systemName: "arrow.down.circle", withConfiguration: largeConfig), for: .selected)
                
        if let nameTitle = exerciseNameTextFieldPlaceHolder, let repsCount = repsTextFieldPlaceHolder, let timeGoal = timeGoalTextFieldPlaceHolder, let segmentIndex = requiresEquiptmentPlaceHolder, let descriptionText = descriptionTextViewPlaceHolder, let muscleGroupLabelPlaceHolder = muscleGroupPickerStatePlaceHolder?.rawValue {
            
            pickedMuscle = muscleGroupPickerStatePlaceHolder
            
            titleLabel.text = nameTitle
            exerciseNameTextField.text = nameTitle
            repsTextField.text = "\(repsCount)"
            descriptionTextView.text = descriptionText
            descriptionTextView.textColor = .black
            muscleGroupLabel.text = "Muscle Group: \(muscleGroupLabelPlaceHolder)"
            minutes = timeGoal/60
            seconds = timeGoal - (60 * minutes)
            
            timeGoalPicker.selectRow(minutes, inComponent: 0, animated: false)
            timeGoalPicker.selectRow(seconds, inComponent: 1, animated: false)

            timeGoalLabel.text = "Time Goal: \(minutes) Min \(seconds) Sec"
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
//    func uiLabelLength( uiLabel: UILabel, shouldChangeCharaters range: NSRange, replacementString string: String) -> Bool {
//        let currentText = uiLabel.text ?? ""
//
//        guard let stringRange = Range(range, in: currentText) else { return false}
//
//        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
//
//        return updatedText.count <= 16
//
//    }
    
    @IBAction func exerciseTextFieldEdited(_ sender: Any) {
        titleLabel.text = exerciseNameTextField.text?.maxLength(length: 16)
        exerciseNameTextField.text = exerciseNameTextField.text?.maxLength(length: 16)
        
        if exerciseNameTextField.text == "" {
            titleLabel.text = "New Exercise"
        }
        enableSubmitCheck()
    }
    
    @IBAction func repsTextFieldEdited(_ sender: Any) {
        enableSubmitCheck()
    }
    
    @IBAction func muscleGroupDropDownButtonTapped(_ sender: Any) {
        muscleGroupDropDownButton.isSelected.toggle()
        muscleGroupPicker.isHidden.toggle()
        timeGoalDownButton.isSelected = false
        timeGoalPicker.isHidden = true
    }
    @IBAction func timeGoalDropDownButtonTapped(_ sender: Any) {
        timeGoalDownButton.isSelected.toggle()
        timeGoalPicker.isHidden.toggle()
        muscleGroupDropDownButton.isSelected = false
        muscleGroupPicker.isHidden = true
    }
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        let reps = Int(repsTextField.text!) ?? 0
        let equiptmentReq: Bool = (requiresEquiptmentControl.selectedSegmentIndex != 0) ? false : true
        let timeInSeconds = (60 * minutes) + seconds
        
        let exercise = Exercise(exerciseData: ExerciseData(name: titleLabel.text!, timeGoal: timeInSeconds, reps: reps, requiresEquipment: equiptmentReq, muscle: pickedMuscle! , description: descriptionTextView.text), id: UUID())
        
        guard isEdit == false else {
        delegate?.updateExercise(exercise: exercise)
            return
        }
        delegate?.addExercise(exercise: exercise)
    }
    
    func enableSubmitCheck() {
        if (exerciseNameTextField.text != "") && (repsTextField.text != "") && (timeGoalLabel.text != "") && (descriptionTextView.textColor != .placeholderText) && (descriptionTextView.text != "") && (muscleGroupLabel.text != "Muscle Group: Pick Group") {
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
        return pickerView.tag
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        guard pickerView.tag == 1 else {
            switch component {
            case 1:
                return 60
            case 2:
                return 60
            default:
                return 60
            }
        }
        return muscleGroups.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        guard pickerView.tag == 1 else {
            switch component {
            case 0:
                return "\(row) Min"
            case 1:
                return "\(row) Sec"
            default:
                return ""
            }
        }
        guard row != 0 else {
            return "Pick Group"
        }
        return muscleGroups[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        enableSubmitCheck()
        pickerView.tintColor = UIColor(named: "customOragne")
        guard pickerView.tag == 1 else {
        
            switch component {
            case 0:
                minutes = row
            case 1:
                seconds = row
            default:
                break;
            }
            timeGoalLabel.text = "Time Goal: \(minutes) Min \(seconds) Sec"
            enableSubmitCheck()
            self.view.endEditing(true)
            return
        }
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




