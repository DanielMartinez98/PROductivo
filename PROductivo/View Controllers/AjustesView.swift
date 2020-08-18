//
//  AjustesView.swift
//  PROductivo
//
//  Created by Usuario Principal on 08/08/20.
//  Copyright © 2020 Loklo. All rights reserved.
//

import UIKit
import Firebase

class AjustesView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func clickLogOut(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            transitionToLogIn()
            inicializador = acciones()
        }catch {print("error")}
        
        
    }
    func transitionToLogIn()
    {
        let logIn = storyboard?.instantiateViewController( withIdentifier: Constants.Storyboard.LogInController) as? NavOG
        view.window?.rootViewController = logIn
        view.window?.makeKeyAndVisible()
    }
    

   
}
