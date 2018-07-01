//
//  SolictarClasePadreViewController.swift
//  20plus
//
//  Created by renato mercado luna on 6/29/18.
//  Copyright © 2018 renato. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class SolictarClasePadreViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    @IBOutlet weak var profesorCurso: UIPickerView!
    @IBOutlet weak var pickerHorarioDisponible: UIPickerView!
    
    @IBOutlet weak var txtnumeroDeHoras: UITextField!
    
    //Cursos
    var cursosProfe = [cursoItem]()
    var cursosProfeIDS = [Int]()
    
    //Fecha
    var fechas = [profesor_horario]()
    var fechasIDS = [Int]()
    
    //Horairos Disponibledds
    var horariosDisponibles = [horario]()
    var horariosDisponiblesIDS = [Int]()
    
    var Horarios : String = ""
    var Curso : String = ""
    var idHorario : Int = 0
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == pickerHorarioDisponible {
            return self.horariosDisponibles.count
        }else if pickerView == profesorCurso {
            return self.cursosProfe.count
        }else{
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == pickerHorarioDisponible {
            return self.horariosDisponibles[row].horarioinicio + " - "  + self.horariosDisponibles[row].horariofin + "  " + self.horariosDisponibles[row].dia
        }else if pickerView == profesorCurso {
            return self.cursosProfe[row].contenido
        }else{
            return ""
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        profesorCurso.delegate = self
        profesorCurso.dataSource = self
        pickerHorarioDisponible.delegate = self
        pickerHorarioDisponible.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        let userDefaults = UserDefaults.standard
        let profeId : Int = userDefaults.integer(forKey: "selectedPorfeId")
        //Jalar cursos
        //BUSCA SI PROFESOR TINEE UCROS REFGISTRADOS
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/profesor_cursogrado").responseJSON{
            response in
            if let json = response.result.value{
                let sJSON = JSON(json)
                for(_,subJson):(String, JSON) in sJSON{
                    if subJson["id_profesor"].intValue==profeId {
                        self.cursosProfeIDS.append(subJson["id_cursogrado"].intValue)
                        self.Curso = subJson["id_cursogrado"].stringValue
                        
                    }
                }
            }
            for index in self.cursosProfeIDS {
                Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/cursogrado?id="+String(index)).responseJSON{
                    response in
                    if let json = response.result.value{
                        let sJson = JSON(response.result.value)
                        let objCurso = cursoItem()
                        objCurso.contenido = sJson["contenido"].stringValue
                        objCurso.idcursogrado = sJson["idcursogrado"].intValue
                        self.cursosProfe.append(objCurso)
                    }
                    self.profesorCurso.reloadAllComponents()
                }
            }
        }
        
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/horarios?idprofe="+String(profeId)).responseJSON{
            response in
            if let json = response.result.value{
                let sJSON = JSON(json)
                for(_,subJson):(String, JSON) in sJSON{
                    let objH = horario()
                    objH.dia = subJson["dia"].stringValue
                    objH.idhorario = subJson["idhorario"].intValue
                    objH.horarioinicio = subJson["horainicio"].stringValue
                    objH.horariofin = subJson["horafin"].stringValue
                    self.horariosDisponibles.append(objH)
                }
            }
            self.pickerHorarioDisponible.reloadAllComponents()
        }
        
        
        
        
    }
    

    @IBAction func btnPressedCreateTutoria(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        let padreId : Int = userDefaults.integer(forKey: "UserId")
        
        let parameters : Parameters = ["hora" : "" /*self.horariosDisponibles[self.pickerHorarioDisponible.selectedRow(inComponent: 0)].horarioinicio*/,"fecha" : "","precio" : Double(20),"comentario" : "","calificacion" : 0,"id_padre" : 6,"estado" : "En espera","curso" : "Matematica"/*self.cursosProfe[self.profesorCurso.selectedRow(inComponent: 0)].contenido*/,"id_horario": 1/*self.horariosDisponibles[self.pickerHorarioDisponible.selectedRow(inComponent: 0)].idhorario*/,"id_servicio" : 1,"numerohoras" : 4/*self.txtnumeroDeHoras.text!*/]
        
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/tutorias", method: .post, parameters: parameters).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            print("Result Value: \(String(describing: response.result.value))")               // response serialization result
            
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
