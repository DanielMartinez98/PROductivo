//
//  alterarTarea.swift
//  PROductivo
//
//  Created by Usuario Principal on 07/08/20.
//  Copyright © 2020 Loklo. All rights reserved.
//

import UIKit
import Firebase

class alterarTarea: UIViewController {

    @IBOutlet weak var Texto: UILabel!
    @IBOutlet weak var Fecha: UIDatePicker!
    @IBOutlet weak var datoButton: UISwitch!
    var ref : DatabaseReference!
    @IBAction func pressButton(_ sender: Any) {
        check = !check
    }
    @IBAction func cambio(_ sender: Any) {
        if seleccion.nTarea>=0
        {
        nuevaListaClase[seleccion.nClase].listaTarea[seleccion.nTarea].fecha = Fecha.date
        }
        else
        {
        let a = (seleccion.nTarea + 1)*(-1)
        nuevaListaClase[seleccion.nClase].tareasHechas[a].fecha = Fecha.date
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if seleccion.nTarea>=0
        {
        Texto.text = nuevaListaClase[seleccion.nClase].listaTarea[seleccion.nTarea].nombre
        Fecha.date = nuevaListaClase[seleccion.nClase].listaTarea[seleccion.nTarea].fecha
        }else
        {
        let a = (seleccion.nTarea + 1)*(-1)
        Texto.text = nuevaListaClase[seleccion.nClase].tareasHechas[a].nombre
        Fecha.date = nuevaListaClase[seleccion.nClase].tareasHechas[a].fecha
        datoButton.isOn = true
        }
    }
    @IBAction func Realizarcambio(_ sender: Any) {
        if check == true
        {
            ref = Database.database().reference()
            if seleccion.nTarea>=0
            {
                let formatter = DateFormatter()
                formatter.dateFormat = "YYYY-dd-MM"
                let date = formatter.string(from: nuevaListaClase[seleccion.nClase].listaTarea[seleccion.nTarea].fecha)
                self.ref.child("Tareas Hechas").child(Auth.auth().currentUser!.uid).child(nuevaListaClase[seleccion.nClase].id).child(nuevaListaClase[seleccion.nClase].listaTarea[seleccion.nTarea].nombre).setValue(["Fecha": "\(date)"])
                self.ref.child("Tareas").child(Auth.auth().currentUser!.uid).child(nuevaListaClase[seleccion.nClase].id).child( nuevaListaClase[seleccion.nClase].listaTarea[seleccion.nTarea].nombre).removeValue()
                nuevaListaClase[seleccion.nClase].listaTarea.remove(at: seleccion.nTarea)
                organizer.remove(at: seleccion.nLista)
            }else
            {
                let a = (seleccion.nTarea + 1)*(-1)
                let formatter = DateFormatter()
                formatter.dateFormat = "YYYY-dd-MM"
                let date = formatter.string(from: nuevaListaClase[seleccion.nClase].listaTarea[seleccion.nTarea].fecha)
                self.ref.child("Tareas").child(Auth.auth().currentUser!.uid).child(nuevaListaClase[seleccion.nClase].id).child(nuevaListaClase[seleccion.nClase].tareasHechas[((seleccion.nTarea) * -1 - 1)].nombre).setValue(["Fecha": "\(date)"])
                self.ref.child("Tareas Hechas").child(Auth.auth().currentUser!.uid).child(nuevaListaClase[seleccion.nClase].id).child( nuevaListaClase[seleccion.nClase].tareasHechas[((seleccion.nTarea) * -1 - 1)].nombre).removeValue()
                nuevaListaClase[seleccion.nClase].tareasHechas.remove(at: a)
            }
            check = false
        }
    }
}

