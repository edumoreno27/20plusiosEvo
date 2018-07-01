//
//  VerClaseViewController.swift
//  20plus
//
//  Created by Cristian Trigo on 6/29/18.
//  Copyright © 2018 renato. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class VerClaseViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    var clase = 0
    var valor = 0
    var list = ["No Disponible","Disponible"]
    
    @IBOutlet weak var txtCurso: UILabel!
    
    @IBOutlet weak var pvClase: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        valor = row
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pvClase.dataSource=self
        pvClase.delegate=self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/tutorias").responseJSON{
            response in
            if let json = response.result.value{
                let sJSON = JSON(json)
                for(_,subJson):(String, JSON) in sJSON{
                    
                    if(subJson["idtutoria"].intValue == self.clase){
                        
                        self.txtCurso.text=subJson["curso"].stringValue
                        
                    }
                }
            }
            
        }
        
    }
    
    @IBAction func Actualizar(_ sender: Any) {
        let objEntidad = tutoria()
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/tutorias").responseJSON{
            response in
            if let json = response.result.value{
                let sJSON = JSON(json)
                for(_,subJson):(String, JSON) in sJSON{
                    
                    if(subJson["idtutoria"].intValue == self.clase){
                        objEntidad.idtutoria=subJson["idtutoria"].intValue
                        objEntidad.comentario=subJson["comentario"].stringValue
                        objEntidad.curso=subJson["curso"].stringValue
                        if self.valor == 0 { objEntidad.estado="No Disponible"}
                        if self.valor == 1 { objEntidad.estado="Disponible"}
                        objEntidad.hora = subJson["hora"].stringValue
                        objEntidad.numerohoras=subJson["numerohoras"].intValue
                        objEntidad.precio=subJson["precio"].doubleValue
                        objEntidad.id_padre=subJson["id_padre"].intValue
                        objEntidad.calificacion=subJson["calificacion"].intValue
                    }
                }
            }
            
        }
        
        let parameters : Parameters = ["idtutoria" : objEntidad.idtutoria,
                                       "precio" : objEntidad.precio,
                                       "comentario" : objEntidad.comentario,
                                       "calificacion" : objEntidad.calificacion,
                                       "id_padre" : objEntidad.id_padre,
                                       "estado" : objEntidad.estado,
                                       "curso" : objEntidad.curso,
                                       "id_horario" : objEntidad.id_horario,
                                       "numerohoras" : objEntidad.numerohoras]
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/tutorias", method: .post, parameters: parameters)
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
