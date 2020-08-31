//
//  LogIn.swift
//  PROductivo
//
//  Created by Usuario Principal on 08/08/20.
//  Copyright © 2020 Loklo. All rights reserved.
//

import UIKit
import Firebase
class LogIn: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
                 self.navigationController?.setNavigationBarHidden(true, animated: animated)
               super.viewWillAppear(animated)
             }
    override func viewWillDisappear(_ animated: Bool) {
                 self.navigationController?.setNavigationBarHidden(false,animated: animated )
                 super.viewWillDisappear(animated)
             }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    override func  touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    func setUpElements()
    {
        ErrorInfo.alpha = 0
        
    }
    
    @IBOutlet weak var mailInfo: UITextField!
    @IBOutlet weak var passInfo: UITextField!
    @IBOutlet weak var ErrorInfo: UILabel!
    @IBAction func ActionLogIn(_ sender: Any) {
        //validate TextFields
        let error = validateFields()
        if error != nil {
            showError(error!)
        }else
        {
            //SignIN
                 let email = mailInfo.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                 let password = passInfo.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                 Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                     if error != nil
                     {
                        self.showError("wrong email or password")
                     }else
                     {
                        inicializador.refreshClases()
                            run(after: 3) {
                                self.transitionToHome()
                            }
                     }
                 }
        }
    }
    func showError(_ message:String)
       {
           ErrorInfo.text = message
           ErrorInfo.alpha = 1
       }
     func validateFields() -> String?
       {
           //checar si los campos tienen datos
           if mailInfo.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passInfo.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
           
               return "Please fill all the Fields"
           }
           return nil
       }
    func transitionToHome()
    {
        let homeViewController = storyboard?.instantiateViewController( withIdentifier: Constants.Storyboard.homeViewController) as? NavOG
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
}
