//
//  Calendario.swift
//  PROductivo
//
//  Created by Usuario Principal on 04/08/20.
//  Copyright © 2020 Loklo. All rights reserved.
//

import UIKit
import FSCalendar
import Firebase
class Calendario: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UITableViewDelegate, UITableViewDataSource {
    var arreglo = [tareaMain]()
    var arregloDia = [tareaMain]()
    var dia = Date()
    var ref : DatabaseReference!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var tabla: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        tabla.dataSource = self
        tabla.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    func reloading()
    {
        self.tabla.beginUpdates()
        self.tabla.endUpdates()
        self.tabla.reloadData()
        self.calendar.reloadData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        dia = date
        reloading()
    }
    func llenarArreglo()
    {
        arreglo.removeAll()
        var ContC = 0
        var ContT = 0
        var ContH = -1
        var mientras = tareaMain()
        for n in nuevaListaClase
        {
            for c in n.listaTarea
            {
                mientras = tareaMain()
                mientras.inizializar(a: c, b: ContC, c: ContT)
                arreglo.append(mientras)
                ContT += 1
            }
            for c in n.tareasHechas
            {
                mientras = tareaMain()
                mientras.inizializar(a: c, b: ContC, c: ContH)
                arreglo.append(mientras)
                ContH -= 1
            }
            ContC += 1
        }
    }
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        var cont = 0
        for n in arreglo
        {
            if formatter.string(from: n.tarea.fecha).elementsEqual(formatter.string(from: date))
            {
                cont += 1
            }
        }
        if cont == 0
        {
            return 0
        }else if cont == 1
        {
            return 1
        }else {return 3}
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        var cont = 0
        arregloDia = [tareaMain]()
        for n in arreglo
        {
            if formatter.string(from: n.tarea.fecha).elementsEqual(formatter.string(from: dia))
           {
            arregloDia.append(n)
           cont += 1
           }
        }
        return cont
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cellAct
            let a = arregloDia[indexPath.row]
            cell.MyLabel.text = a.tarea.nombre
            cell.MyImage.backgroundColor = nuevaListaClase[a.num].colores
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-dd-MM"
            let today = formatter.date(from: formatter.string(from: Date()))
            cell.myDias.text = String(format: "%0.f", (a.tarea.fecha.timeIntervalSince(today!)/86400).rounded().magnitude)
            cell.Cnum = a.num
            cell.Tnum = a.numt
            if a.numt < 0
            {
                cell.backgroundColor = UIColor.systemGreen
                cell.MyLabel.textColor = UIColor.black
                cell.myDias.textColor = UIColor.black
            }else{
                if a.numt >= 0 && (a.tarea.fecha.timeIntervalSince(today!)/86400).rounded()<0{
                cell.backgroundColor = UIColor.systemRed
                cell.MyLabel.textColor = UIColor.black
                cell.myDias.textColor = UIColor.black
                }
                else
                {
                cell.backgroundColor = UIColor.systemBackground
                cell.MyLabel.textColor = UIColor.label
                cell.myDias.textColor = UIColor.label
                }
            }
            return (cell)
        }
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
        {
            if editingStyle == UITableViewCell.EditingStyle.delete
            {
                ref = Database.database().reference()
                if arregloDia[indexPath.row].numt >= 0
                {
                    let c = arregloDia[indexPath.row].num
                    let t = arregloDia[indexPath.row].numt
                    self.ref?.child("Tareas").child(Auth.auth().currentUser!.uid).child(nuevaListaClase[c].id).child(nuevaListaClase[c].listaTarea[t].nombre).removeValue()
                nuevaListaClase[c].listaTarea.remove(at: t)
                }
                else {
                    let c = arregloDia[indexPath.row].num
                    let t = arregloDia[indexPath.row].numt
                    self.ref?.child("Tareas Hechas").child(Auth.auth().currentUser!.uid).child(nuevaListaClase[c].id).child(nuevaListaClase[c].tareasHechas[t].nombre).removeValue()
                    nuevaListaClase[c].tareasHechas.remove(at: (t * -1 ) - 1)
                }
                arregloDia.remove(at: indexPath.row)
               reloading()
            }
        }
}
