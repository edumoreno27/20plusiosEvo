//
//  MiCuentaPadreViewController.swift
//  20plus
//
//  Created by Alumnos on 16/06/18.
//  Copyright © 2018 renato. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class MiCuentaPadreViewController: UIViewController {
    var id = 0
    var obPadre = padre()
    
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtApellido: UITextField!
    @IBOutlet weak var txtDNI: UITextField!
    @IBOutlet weak var txtcorreo: UITextField!
    @IBOutlet weak var txtContrasenia: UITextField!
    @IBOutlet weak var txtDistrito: UITextField!
    @IBOutlet weak var txtDepartamento: UITextField!
    @IBOutlet weak var txtDireccion: UITextField!
    @IBOutlet weak var txtProvincia: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //GETId
        
        let userDefaults = UserDefaults.standard
        let userId : Int = userDefaults.integer(forKey: "UserId")
        id = userId
        
    
        
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/padres").responseJSON { response in
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                //Read json
                let sJson = JSON(json)
                
                for (_,subJson):(String, JSON) in sJson {
                    // Do something you want
                    if( userId == subJson["idpadre"].intValue){
                        let objItem = padre()
                        objItem.nombre = subJson["nombre"].stringValue
                        objItem.apellido = subJson["apellido"].stringValue
                        objItem.dni = subJson["dni"].stringValue
                        objItem.email = subJson["email"].stringValue
                        objItem.password = subJson["password"].stringValue
                        objItem.distrito = subJson["distrito"].stringValue
                        objItem.departamento = subJson["departamento"].stringValue
                        objItem.departamento = subJson["direccion"].stringValue
                        objItem.departamento = subJson["provincia"].stringValue
                        
                        
                        
                        self.txtName.text = String(objItem.nombre)
                        self.txtApellido.text = objItem.apellido
                        self.txtDNI.text = objItem.dni
                        self.txtContrasenia.text = objItem.password
                        self.txtDistrito.text = objItem.distrito
                        self.txtDepartamento.text = objItem.departamento
                        self.txtDireccion.text = objItem.direccion
                        self.txtcorreo.text = objItem.email
                        self.txtProvincia.text = objItem.provincia
                        
                    }
                }
                
            }
        }
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnPressedGuardarCVambiosPadre(_ sender: Any) {
        
        //Cambiar valores
        
        obPadre.nombre = self.txtName.text!
        obPadre.apellido = self.txtApellido.text!
        obPadre.dni = self.txtDNI.text!
        obPadre.password = self.txtContrasenia.text!
        obPadre.distrito = self.txtDistrito.text!
        obPadre.departamento = self.txtDepartamento.text!
        obPadre.direccion = self.txtDireccion.text!
        obPadre.email = self.txtcorreo.text!
        obPadre.provincia = self.txtProvincia.text!
        
        
        
        
        
        let parameters : Parameters = ["idpadre":id,"nombre" : obPadre.nombre,
                                       "apellido" : obPadre.apellido,
                                       "password" : obPadre.password,
                                       "email" : obPadre.email,
                                       "celular" : obPadre.celular,
                                       "dni" : obPadre.dni,"distrito": obPadre.distrito , "departamento": obPadre.departamento , "direccion": obPadre.direccion , "provincia": obPadre.provincia]
        
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/padres", method: .post, parameters: parameters)
        
        
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
