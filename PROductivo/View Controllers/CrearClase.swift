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
import FirebaseAuth
class CrearClase: UIViewController, UITextFieldDelegate{
    var num = 0
    var ref : DatabaseReference!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var nav: UINavigationItem!
    override func viewDidAppear(_ animated: Bool) {
        num = 0
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         myButton.isEnabled = false
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
    @IBAction func addItem(_ sender: Any)
    {
        
    }
                          
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    
/* extension UIApplication
    {
        func endEditing()
        {
        sendAction(#selector(UIResponder.resignFirstResponder),to: nil, from: nil, for: nil)
        }
    }*/
}
