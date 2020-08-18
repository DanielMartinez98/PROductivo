//
//  CrearTarea.swift
//  PROductivo
//
//  Created by Usuario Principal on 05/08/20.
//  Copyright © 2020 Loklo. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
class CrearTarea: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var ref : DatabaseReference!
    var clas = Int()
    @IBOutlet weak var Fecha: UIDatePicker!
    @IBOutlet weak var Input: UITextField!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var Picker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Picker.dataSource = self
        Picker.delegate = self
        myButton.isEnabled = false
        Fecha.minimumDate = Date.init(timeIntervalSinceNow: 0)
    }
    @IBAction func AddItem(_ sender: AnyObject) {
        ref = Database.database().reference()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-dd-MM"
        let date = formatter.string(from: Fecha.date)
        self.ref.child("Tareas").child(Auth.auth().currentUser!.uid).child(nuevaListaClase[clas].id).child("\(Input.text!)").setValue(["Fecha": "\(date)"])
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    override func  touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    @IBAction func cambioText(_ sender: Any) {
        if Input.text != ""
        {
            if nuevaListaClase.count == 0{
                myButton.isEnabled = false
            }
            else{
                myButton.isEnabled = true
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (nuevaListaClase.count)
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nuevaListaClase[row].id
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        clas = row
    }
}
