//
//  RegistrarTipoViewController.swift
//  20plus
//
//  Created by Cristian Trigo on 6/29/18.
//  Copyright © 2018 renato. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class RegistrarTipoViewController: UIViewController {
    var nombre=""
    var apellido=""
    var password=""
    var correo=""
    var celular=""
    var dni=""
    var id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func RegistrarProfesor(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        //Set parameters
        let parameters : Parameters = ["nombre" : nombre,
                                       "apellido" : apellido,
                                       "password" : password,
                                       "email" : correo,
                                       "celular" : celular,
                                       "descripcion" : "Nuevo",
                                       "preciomax" : 0,
                                       "preciomin" : 0,
                                       "experiencia" : "ninguna",
                                       "calificacion" : 3,
                                       "dni" : dni]
        
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/profesors", method: .post, parameters: parameters)
        
        
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/profesors?email=" + correo + "&password=" + password).responseJSON { response in
            let sJson = JSON(response.result.value)
            if(sJson["idprofesor"] != JSON.null){
                userDefaults.set(sJson["idprofesor"].intValue, forKey: "UserId")
            }
            //self.id = sJson["idprofesor"].intValue
            //userDefaults.set(self.id, forKey: "UserId")
        }
        
    }
    
    @IBAction func RegistrarPadre(_ sender: Any) {
        //let userDefaults = UserDefaults.standard
        let parameters : Parameters = ["nombre" : nombre,
                                       "apellido" : apellido,
                                       "password" : password,
                                       "email" : correo,
                                       "celular" : celular,
                                       "dni" : dni]
        
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/padres", method: .post, parameters: parameters)
        
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/padres?email=" + correo + "&password=" + password).responseJSON { response in
            let sJson = JSON(response.result.value)
            self.id = sJson["idpadre"].intValue
            UserDefaults.standard.set(sJson["idpadre"].intValue, forKey: "UserId")
        }
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "idprofe"{
            let enviarid=segue.destination as! RegistrarProfesorViewController
            enviarid.id=id
        }
        if segue.identifier == "idpadre"{
            /*
            let enviaridBuscar=segue.destination as! BuscarProfesoresViewController
            let enviaridFavoritos=segue.destination as! FavoritosController
            let enviaridMensajes=segue.destination as! MisMensajesViewController
            //let enviaridMisClases=segue.destination as! MisClasesViewController
            let enviaridMicuenta=segue.destination as! MiCuentaPadreViewController
            enviaridBuscar.id=id
            enviaridFavoritos.id=id
            enviaridMensajes.id=id
            enviaridMicuenta.id=id
         */
        }
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
