//
//  CrearCuenta.swift
//  PROductivo
//
//  Created by Usuario Principal on 09/08/20.
//  Copyright © 2020 Loklo. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseDatabase
class CrearCuenta: UIViewController, UITextFieldDelegate{

    
    var ref: DatabaseReference!
    @IBOutlet weak var infoMail: UITextField!
    @IBOutlet weak var InfoPass: UITextField!
    @IBOutlet weak var InfoPass2: UITextField!
    @IBOutlet weak var InfoError: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    @IBAction func GoButton(_ sender: Any) {
        let error = validateFields()
        
        if error != nil
        {
            //there is an error, show error message
            showError(error!)
        }
        else
        {
            //Create  cleaned version of the data
            let mail = infoMail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwor = InfoPass.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            //Create the Users
            Auth.auth().createUser(withEmail: mail, password: passwor) { (result, err) in
                //check for errors
                if err != nil
                {
                    self.showError("Error Creating User")
                }
                else
                {
                     let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["uid": result!.user.uid]){ (error) in
                        if error != nil
                        {
                            self.showError("User data was incorrectly saved")
                        }
                        self.ref = Database.database().reference()
                        self.ref.child("users").child(Auth.auth().currentUser!.uid).setValue(["Nombre": "no manches"])
                        print(" Impression: \(Auth.auth().currentUser!.uid)")
                        self.transitionToHome()
                    }
                }
            }
        }
       }
    func setUpElements()
       {
           InfoError.alpha = 0
           
       }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag
        if tag == 20
        {
            InfoPass.becomeFirstResponder()
        }else if tag == 40
        {
            InfoPass2.becomeFirstResponder()
        }
        else { self.view.endEditing(true)}
        return false
    }
    @objc func keyboardWillShow(notification: NSNotification)
    {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else
        {
            return
        }
        self.view.frame.origin.y = 0-keyboardSize.height
    }
    //check fields to prove that data is correct
    func validateFields()->String?
    {
        //checar si los campos tienen datos
        if infoMail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            InfoPass.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            InfoPass2.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""
        {
            return "Please fill all the Fields"
        }
        //check if password Fields are Equal
        if InfoPass.text != InfoPass2.text
        {
            return "please make sure your password is equal in both Fields"
        }
        //Check to make sure password is Secure
        let cleanPassword = InfoPass.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isPasswordValid(cleanPassword) == false
        {
            return "make sure your password is at least 8 characters and contains a special Character and a number"
        }
        
        return nil
    }
    func showError(_ message:String)
    {
        InfoError.text = message
        InfoError.alpha = 1
    }
    func transitionToHome()
    {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? NavOG
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }

}
