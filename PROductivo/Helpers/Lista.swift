//
//  Lista.swift
//  PROductivo
//
//  Created by Usuario Principal on 05/08/20.
//  Copyright © 2020 Loklo. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseDatabase
var nuevaListaClase = [principalClase]()
let dispatchGroup = DispatchGroup()
var inicializador = acciones()
var fileURL = URL.self
var ref : DatabaseReference!
class principalClase {
    var id = String()
    func inizializar(a: String)
    {
        id = a
    }

}

class Tarea{
    var id = Int()
    var clase = String()
    var nombre = String()
    var fecha = Date()
    var status = Bool()
    func inizializar(Id: Int, Clase: String, Nombre: String, Fecha: Date, Status: Bool )
    {
        id = Id
        clase = Clase
        nombre = Nombre
        fecha = Fecha
        status = Status
    }
}
var check = false
func isPasswordValid(_ password : String)->Bool
{
    let passwordTest = NSPredicate(format: "SELF MATCHES %@","^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}" )
    return passwordTest.evaluate(with: password)
}
func run(after seconds: Int, completion: @escaping() -> Void)
{
    let deadline = DispatchTime.now() + .seconds(seconds)
    DispatchQueue.main.asyncAfter(deadline: deadline) {
        completion()
    }
    
}
class acciones
{
    func refreshClases()
        {
        dispatchGroup.enter()
        run(after: 0) {
            nuevaListaClase.removeAll()
            var n = 0
            ref = Database.database().reference()
            let UserID = Auth.auth().currentUser!.uid
            ref?.child("Clases").child(UserID).observe(.childAdded) { (snapshot) in
                   let nombre = snapshot.key as String
                   let a = principalClase()
                   a.inizializar(a: nombre)
                   nuevaListaClase.append(a)
                   
                   let g = n
                   n += 1
                   }
            ref?.child("Tareas").child(UserID).observe(.childAdded) { snap in
                 var cont = 0
                 let nombre = snap.key as String
                 let fecha = snap.childSnapshot(forPath: "Fecha").value as! String
                 let a = Tarea()
                 let formatter = DateFormatter()
                 formatter.dateFormat = "YYYY-dd-MM"
                 let today = formatter.date(from: formatter.string(from: Date()))
                 let dia = formatter.date(from: fecha)!
                a.inizializar(Id: cont, Clase: <#T##String#>, Nombre: <#T##String#>, Fecha: <#T##Date#>, Status: <#T##Bool#>)
                 cont += 1
             }
                   
                dispatchGroup.leave()
           }
       }
    /* func refreshTarea()
       {

           run(after: 2)
           {
                  organizer.removeAll()
                  ref = Database.database().reference()
            let UserID = Auth.auth().currentUser!.uid
               if nuevaListaClase.count == 0
               {
               print("no hay clases")
               }
                else
                {
                for n in 0...nuevaListaClase.count-1
                  {
                    var cont = 0
                       
                    ref?.child("Tareas").child(UserID).child(nuevaListaClase[n].id).observe(.childAdded)
                       { (snapshot) in
                            let nombre = snapshot.key as String
                            let fecha = snapshot.childSnapshot(forPath: "Fecha").value as! String
                            let formatter = DateFormatter()
                            formatter.dateFormat = "YYYY-dd-MM"
                            let today = formatter.date(from: formatter.string(from: Date()))
                            let dia = formatter.date(from: fecha)!
                            let a = principalTarea()
                            a.inizializar(a: nombre, c: dia)
                            nuevaListaClase[n].agregarTarea(a: a)
                            let b = tareaMain()
                                if (dia.timeIntervalSince(today!)/86400).rounded() >= 0
                                    {
                                        b.inizializar(a: a, b: n, c: cont)
                                        organizer.append(b)
                                    }
                            cont += 1
                        }
                }
                    
                for h in 0...nuevaListaClase.count-1
                          {
                               ref?.child("Tareas Hechas").child(UserID).child(nuevaListaClase[h].id).observe(.childAdded)
                               { (snapshot) in
                                    let nombre = snapshot.key as String
                                    let fecha = snapshot.childSnapshot(forPath: "Fecha").value as! String
                                    let formatter = DateFormatter()
                                    formatter.dateFormat = "YYYY-dd-MM"
                                    let dia = formatter.date(from: fecha)!
                                    let a = principalTarea()
                                    a.inizializar(a: nombre, c: dia)
                                    nuevaListaClase[h].tareaHecha(a: a)
                                }
                            }
            }
        }
    }
*/
}
