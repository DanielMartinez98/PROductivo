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
var seleccion = informacion()
var organizer = [tareaMain]()
var nuevaListaClase = [principalClase]()
let dispatchGroup = DispatchGroup()
var inicializador = acciones()
var fileURL = URL.self
var ref : DatabaseReference!
class principalClase {
    var id = String()
    var colores = UIColor()
    var listaTarea = [principalTarea]()
    var tareasHechas = [principalTarea]()
    func inizializar(a: String , b: UIColor)
    {
        id = a
        colores = b
    }
    func agregarTarea(a: principalTarea)
    {
        listaTarea.append(a)
    }
    func tareaHecha(a: principalTarea)
    {
        tareasHechas.append(a)
    }
}

class principalTarea{
    var nombre = String()
    var fecha = Date()
    func inizializar(a:String, c:Date )
    {
        nombre = a
        fecha = c
    }
}

class tareaMain{
    var tarea = principalTarea()
    var num = Int()
    var numt = Int()
    func inizializar(a: principalTarea, b: Int, c: Int)
    {
        tarea = a
        num = b
        numt = c
    }
}
class informacion
{
    var nClase = Int()
    var nTarea = Int()
    var nLista = Int()
    func inicializar(clas:Int, tar: Int)
    {
        nClase = clas
        nTarea = tar
    }
    func organizando(lis: Int)
    {
        nLista = lis
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
                   let color = snapshot.childSnapshot(forPath: "color").value as! String
                   let c = color.components(separatedBy: ";")
                   let red = CGFloat((c[1] as NSString).floatValue)
                   let green = CGFloat((c[2] as NSString).floatValue)
                   let blue = CGFloat((c[3] as NSString).floatValue)
                   let alph = CGFloat((c[4] as NSString).floatValue)
                   let a = principalClase()
                   a.inizializar(a: nombre, b: UIColor(red: red, green: green, blue: blue, alpha: alph))
                   nuevaListaClase.append(a)
                var cont = 0
                let g = n
                    ref?.child("Tareas").child(UserID).child(snapshot.key).observe(.childAdded)
                                          { (snap) in
                                               let nombre = snap.key as String
                                               let fecha = snap.childSnapshot(forPath: "Fecha").value as! String
                                               let formatter = DateFormatter()
                                               formatter.dateFormat = "YYYY-dd-MM"
                                               let today = formatter.date(from: formatter.string(from: Date()))
                                               let dia = formatter.date(from: fecha)!
                                               let a = principalTarea()
                                               a.inizializar(a: nombre, c: dia)
                                               nuevaListaClase[g].agregarTarea(a: a)
                                               let b = tareaMain()
                                                   if (dia.timeIntervalSince(today!)/86400).rounded() >= 0
                                                       {
                                                           b.inizializar(a: a, b: g, c: cont)
                                                           organizer.append(b)
                                                       }
                                               cont += 1
                                           }
                    ref?.child("Tareas Hechas").child(UserID).child(snapshot.key).observe(.childAdded)
                                              { (snap) in
                                                   let nombre = snap.key as String
                                                   let fecha = snap.childSnapshot(forPath: "Fecha").value as! String
                                                   let formatter = DateFormatter()
                                                   formatter.dateFormat = "YYYY-dd-MM"
                                                   let dia = formatter.date(from: fecha)!
                                                   let a = principalTarea()
                                                   a.inizializar(a: nombre, c: dia)
                                                   nuevaListaClase[g].tareaHecha(a: a)
                                               }
                   n += 1
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
