//
//  AddExerciseViewController.swift
//  Workout-Capstone
//
//  Created by Ron Avrahami on 3/15/21.
//

import UIKit

protocol AddExerciseProtocal: AnyObject {
    func updateExercises(excercise: Exercise)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        muscleGroupPicker.delegate = self
        muscleGroupPicker.dataSource = self
        muscleGroupLabel.text = "Muscle Group: Pick Group"
        
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 12, left: 6, bottom: 12, right: 6)
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.opaqueSeparator.cgColor
        descriptionTextView.layer.cornerRadius = 10
        descriptionTextView.text = "Description"
        descriptionTextView.textColor = UIColor.placeholderText
        descriptionTextView.delegate = self
        
        muscleGroupDropDownButton.setImage(UIImage(systemName: "arrow.forward.circle", withConfiguration: largeConfig), for: .normal)
        muscleGroupDropDownButton.setImage(UIImage(systemName: "arrow.down.circle", withConfiguration: largeConfig), for: .selected)
        
        muscleGroupPicker.isHidden = true
        submitButton.isEnabled = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        enableSubmitCheck()
        view.endEditing(true)
    }
    
    @IBAction func exerciseTextFieldEdited(_ sender: Any) {
        enableSubmitCheck()
        guard exerciseNameTextField.text != "" else {
            titleLabel.text = "New Exercise"
            return
        }
        titleLabel.text = exerciseNameTextField.text
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
        
        let newExercise = Exercise(name: titleLabel.text, image: nil, timer: nil, reps: reps, requiresEquipment: equiptmentReq, muscle: pickedMuscle , description: descriptionTextView.text)
        delegate?.updateExercises(excercise: newExercise)
    }
    
    func enableSubmitCheck() {
        if (exerciseNameTextField.text != "") && (repsTextField.text != "") && (timeGoalTextField.text != "") && (descriptionTextView.textColor != .placeholderText) && (descriptionTextView.text != "") && (muscleGroupLabel.text != "Muscle Group: Pick Group") {
            submitButton.isEnabled = true
        } else {
            submitButton.isEnabled = false
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
            textView.text = "Description"
            textView.textColor = UIColor.placeholderText
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
