//
//  RegistrarProfesorViewController.swift
//  20plus
//
//  Created by Cristian Trigo on 6/24/18.
//  Copyright © 2018 renato. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class RegistrarProfesorViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    var cursoArray=[cursoItem]()
    var horarioArray=[horario]()
    var distritoArray=[zona]()
    var id = 0

    @IBOutlet weak var pvCursos: UIPickerView!
    @IBOutlet weak var pvHorario: UIPickerView!
    @IBOutlet weak var pvDistrito: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows : Int = 0
        if pickerView == pvCursos{
            countrows = self.cursoArray.count
        }
        else if pickerView == pvHorario{
            countrows = self.horarioArray.count
        }
        else if pickerView == pvDistrito{
            countrows = self.distritoArray.count
        }
        return countrows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var retornar : String = ""
        if pickerView == pvCursos{
            return cursoArray[row].nombre+" : "+cursoArray[row].grado
        }
        else if pickerView == pvHorario{
            return horarioArray[row].horarioinicio+"-"+horarioArray[row].horariofin+":"+horarioArray[row].dia
        }
        else if pickerView == pvDistrito{
            return distritoArray[row].zona1
        }
        return retornar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pvCursos.dataSource=self
        pvCursos.delegate=self
        pvHorario.dataSource=self
        pvHorario.delegate=self
        pvDistrito.dataSource=self
        pvDistrito.delegate=self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/cursogrado").responseJSON{
            response in
            if let json = response.result.value{
                let sJSON = JSON(json)
                for(_,subJson):(String, JSON) in sJSON{
                    let objCurso = cursoItem()
                    objCurso.contenido=subJson["contenido"].stringValue
                    objCurso.grado=subJson["grado"].stringValue
                    objCurso.nombre = subJson["nombre"].stringValue
                    objCurso.idcursogrado = subJson["idcursogrado"].intValue
                    self.cursoArray.append(objCurso)
                }
                self.pvCursos.reloadAllComponents()
            }
        }
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/horarios").responseJSON{
            response in
            if let json = response.result.value{
                let sJSON = JSON(json)
                for(_,subJson):(String, JSON) in sJSON{
                    let objHorario = horario()
                    objHorario.dia=subJson["dia"].stringValue
                    objHorario.horariofin=subJson["horafin"].stringValue
                    objHorario.horarioinicio = subJson["horainicio"].stringValue
                    objHorario.idhorario = subJson["idhorario"].intValue
                    self.horarioArray.append(objHorario)
                }
                self.pvHorario.reloadAllComponents()
            }
        }
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/zonas").responseJSON{
            response in
            if let json = response.result.value{
                let sJSON = JSON(json)
                for(index,subJson):(String, JSON) in sJSON{
                    let objZona = zona()
                    objZona.zona1 = subJson["zona1"].stringValue
                    objZona.idzona = subJson["idzona"].intValue
                    self.distritoArray.append(objZona)
                }
                self.pvDistrito.reloadAllComponents()
            }
        }
        
    }
    
    @IBAction func Registrar(_ sender: Any) {
        var idcurso = 0
        var idhorario = 0
        var idzona = 0
        let userDefaults = UserDefaults.standard
        /*
        let correo : String = userDefaults.string(forKey: "email")!
        let password : String = userDefaults.string(forKey: "password")!
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/profesors?email=" + correo + "&password=" + password).responseJSON { response in
            let sJson = JSON(response.result.value)
            if(sJson["idprofesor"] != JSON.null){
                userDefaults.set(sJson["idprofesor"].intValue, forKey: "UserId")
            }
        }*/
        
        
        
        let userId : Int = userDefaults.integer(forKey: "UserId")
        
        if let objCurso : cursoItem = self.cursoArray[self.pvCursos.selectedRow(inComponent: 0)]{
            idcurso = objCurso.idcursogrado
        }
        let parameters1 : Parameters = ["id_profesor" : userId,
                                        "id_cursogrado" : idcurso]
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/profesor_cursogrado", method: .post, parameters: parameters1)
        
        if let objHorario : horario = self.horarioArray[self.pvHorario.selectedRow(inComponent: 0)]{
            idhorario = objHorario.idhorario
        }
        
        let parameters2 : Parameters = ["id_profesor" : userId,
                                       "id_horario" : idhorario,
                                       "estado" : "Disponible"]
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/profesor_horario", method: .post, parameters: parameters2)
        
        if let objZona : zona = self.distritoArray[self.pvDistrito.selectedRow(inComponent: 0)]{
            idzona = objZona.idzona
        }
        let parameters3 : Parameters = ["id_profe" : userId,
                                       "id_zona" : idzona]
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/profesor_zona", method: .post, parameters: parameters3)
        
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
