//
//  AdministradorClases.swift
//  PROductivo
//
//  Created by Usuario Principal on 05/08/20.
//  Copyright © 2020 Loklo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class AdministradorClases: UIViewController, UITableViewDelegate, UITableViewDataSource {
var ref : DatabaseReference?
    override func viewDidAppear(_ animated: Bool)
    {
        myTableView.reloadData()
        myTableView.beginUpdates()
        myTableView.endUpdates()
        if nuevaListaClase.count != 0
        {
            for a in 0...nuevaListaClase.count-1
            {
                print("soy la clase #\(a) y me llamo \(nuevaListaClase[a].id)")
            }
        }
        viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet weak var myTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (nuevaListaClase.count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath) as! cellClas
        let a = nuevaListaClase[indexPath.row]
        cell.myLabel.text = a.id
        cell.myImage.backgroundColor = a.colores
        return (cell)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            eliminarClase(a: nuevaListaClase[indexPath.row].id)
            nuevaListaClase.remove(at: indexPath.row)
            myTableView.reloadData()
        }
    }
    func eliminarClase (a: String)
    {
        self.ref = Database.database().reference()
        let UserID = Auth.auth().currentUser!.uid
        ref?.child("Clases").child(UserID).child(a).removeValue()
        ref?.child("Tareas").child(UserID).child(a).removeValue()
        ref?.child("Tareas Hechas").child(UserID).child(a).removeValue()
    }
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
       }
   @IBAction func myUnwindAction(unwindsegue:SegueCreando)
   {}
}
