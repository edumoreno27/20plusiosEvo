//
//  MyProfessorFavViewController.swift
//  20plus
//
//  Created by renato mercado luna on 6/30/18.
//  Copyright © 2018 renato. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
class MyProfessorFavViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var profesor: profesor? = nil
    
    
    var id = 0
    //Cursos
    var categoriesCursosProfe = [cursoItem]()
    var categoriesCursosProfeIDS = [Int]()
    //Zonas
    var zonasProfe = [zona]()
    var zonasProfeIDS = [Int]()
    
    var dummyCalificacion : Int = 0
    var dummyNumero : Int = 0
    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblExperiencia: UILabel!
    @IBOutlet weak var lblNumero: UILabel!
    
    @IBOutlet weak var pickerCursos: UIPickerView!
    @IBOutlet weak var pickerZona: UIPickerView!
    
    //funcitons for pickers
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == pickerCursos{
            return self.categoriesCursosProfe.count
        }
        else if pickerView == pickerZona{
            return self.zonasProfe.count
        }else{
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == pickerCursos{
            return  self.categoriesCursosProfe[row].contenido
        }
        else if pickerView == pickerZona{
            return self.zonasProfe[row].zona1
        }else{
            return "campo vacio"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerCursos.dataSource=self
        pickerCursos.delegate=self
        pickerZona.dataSource=self
        pickerZona.delegate=self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(profesor?.nombre)
        
        
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(self.profesor?.idprofesor, forKey: "selectedPorfeId")
        
        
        //Jalar cursos
        var vlaieInt = 0
        vlaieInt =   (profesor?.idprofesor)!
        //BUSCA SI PROFESOR TINEE UCROS REFGISTRADOS
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/profesor_cursogrado").responseJSON{
            response in
            if let json = response.result.value{
                let sJSON = JSON(json)
                for(_,subJson):(String, JSON) in sJSON{
                    if subJson["id_profesor"].intValue==self.profesor?.idprofesor {
                        self.categoriesCursosProfeIDS.append(subJson["id_cursogrado"].intValue)
                    }
                }
            }
            for index in self.categoriesCursosProfeIDS {
                Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/cursogrado?id="+String(index)).responseJSON{
                    response in
                    if let json = response.result.value{
                        let sJson = JSON(response.result.value)
                        let objCurso = cursoItem()
                        objCurso.contenido = sJson["contenido"].stringValue
                        objCurso.idcursogrado = sJson["idcursogrado"].intValue
                        self.categoriesCursosProfe.append(objCurso)
                    }
                    self.pickerCursos.reloadAllComponents()
                }
            }
        }
        
        //Jalar zonas
        //BUSCA SI PROFESOR TINEE UCROS REFGISTRADOS
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/profesor_zona").responseJSON{
            response in
            if let json = response.result.value{
                let sJSON = JSON(json)
                for(_,subJson):(String, JSON) in sJSON{
                    if subJson["id_profe"].intValue==self.profesor?.idprofesor {
                        self.zonasProfeIDS.append(subJson["id_zona"].intValue)
                    }
                }
            }
            for index in self.zonasProfeIDS {
                Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/zonas?id="+String(index)).responseJSON{
                    response in
                    if let json = response.result.value{
                        let sJson = JSON(response.result.value)
                        let objCurso = zona()
                        objCurso.zona1 = sJson["zona1"].stringValue
                        objCurso.idzona = sJson["idzona"].intValue
                        self.zonasProfe.append(objCurso)
                    }
                    self.pickerZona.reloadAllComponents()
                }
            }
        }
        
        self.dummyCalificacion = (profesor?.calificacion)!
        self.dummyNumero = (profesor?.celular)!
        
        self.lblName.text=(profesor?.nombre)! + " " + (profesor?.apellido)!
        self.lblDescription.text=profesor?.descripcion
        self.lblNumero.text = String(self.dummyCalificacion)
        self.lblExperiencia.text = profesor?.experiencia
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
