//
//  CrearClase.swift
//  PROductivo
//
//  Created by Usuario Principal on 05/08/20.
//  Copyright © 2020 Loklo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class CrearClase: UIViewController, UITextFieldDelegate{
    var color = String()
    var num = 0
    var ref : DatabaseReference!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var Slider1: UISlider!
    @IBOutlet weak var Slider2: UISlider!
    @IBOutlet weak var Slider3: UISlider!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var nav: UINavigationItem!
    override func viewDidAppear(_ animated: Bool) {
        num = 0
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         myButton.isEnabled = false
        color = ";\(CGFloat(Slider1.value)/255);\(CGFloat(Slider2.value)/255);\(CGFloat(Slider3.value)/255);1"
        myImage.backgroundColor = UIColor(red: 255/255, green: 0, blue: 0, alpha: 1)
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    @IBAction func actButton(_ sender: Any) {
        if Input.text != ""
        {
        myButton.isEnabled = true
        }
        else
        {
        myButton.isEnabled = false
        }
    }
    override func  touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    @IBOutlet weak var Input: UITextField!
    @IBAction func addItem(_ sender: Any) {
        if num == 0
            {
            num += 1
            ref = Database.database().reference()
            let UID = Auth.auth().currentUser!.uid
            let a = principalClase()
            let c = color.components(separatedBy: ";")
            let red = CGFloat((c[1] as NSString).floatValue)
            let green = CGFloat((c[2] as NSString).floatValue)
            let blue = CGFloat((c[3] as NSString).floatValue)
            let alph = CGFloat((c[4] as NSString).floatValue)
            self.ref.child("Clases").child(UID).child("\(Input.text!)").setValue(["color": "\(color)"])
            /*self.ref.child("Tareas").child(UID).child("\(Input.text!)").child("Vacio").setValue(["Fecha": "1990-01-01"])
            self.ref.child("Tareas Hechas").child(UID).child("\(Input.text!)").child("Vacio").setValue(["Fecha": "1990-01-01"])*/
            a.inizializar(a: (Input.text!), b: UIColor(red: red, green: green, blue: blue, alpha: alph))
            }
        }
    @IBAction func Slideraction(_ sender: Any) {
        color = ";\(CGFloat(Slider1.value)/255);\(CGFloat(Slider2.value)/255);\(CGFloat(Slider3.value)/255);1"
        let c = color.components(separatedBy: ";")
        let red = CGFloat((c[1] as NSString).floatValue)
        let green = CGFloat((c[2] as NSString).floatValue)
        let blue = CGFloat((c[3] as NSString).floatValue)
        let alph = CGFloat((c[4] as NSString).floatValue)
        myImage.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alph)
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension UIApplication{
    func endEditing()
    {
        sendAction(#selector(UIResponder.resignFirstResponder),to: nil, from: nil, for: nil)
    }
}
