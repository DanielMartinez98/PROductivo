//
//  Main.swift
//  PROductivo
//
//  Created by Usuario Principal on 04/08/20.
//  Copyright © 2020 Loklo. All rights reserved.
//

import UIKit
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseDatabase

class Main: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var ref : DatabaseReference!
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        myTableView.dataSource = self
        myTableView.delegate = self
        super.viewDidLoad()
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
     override func viewDidAppear(_ animated: Bool) {
        myTableView.reloadData()
        myTableView.beginUpdates()
        myTableView.endUpdates()
        self.viewWillAppear(animated)
     }
    func reloading()
    {
        self.myTableView.beginUpdates()
        self.myTableView.endUpdates()
        self.myTableView.reloadData()
    }
    @IBAction func myUnwindAction(unwindsegue:SegueCreando){}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
     {
        return (organizer.count)
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cellAct
        let a = organizer[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-dd-MM"
        let today = formatter.date(from: formatter.string(from: Date()))
        cell.MyLabel.text = a.tarea.nombre
        cell.MyImage.tintColor = nuevaListaClase[a.num].colores
        cell.myDias.text = String(format: "%0.f", (a.tarea.fecha.timeIntervalSince(today!)/86400).rounded().magnitude)
        cell.Cnum = a.num
        cell.Tnum = a.numt
        return (cell)
     }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
        
    }
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
     {
            ref = Database.database().reference()
         if editingStyle == UITableViewCell.EditingStyle.delete
         {
            let c = organizer[indexPath.row].num
            let t = organizer[indexPath.row].numt
            self.ref?.child("Tareas").child(Auth.auth().currentUser!.uid).child(nuevaListaClase[c].id).child(nuevaListaClase[c].listaTarea[t].nombre).removeValue()
            nuevaListaClase[c].listaTarea.remove(at: t)
            organizer.remove(at: indexPath.row)
         }
                      reloading()
     }
}
