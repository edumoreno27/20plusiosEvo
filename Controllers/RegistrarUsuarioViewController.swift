//
//  RegistrarUsuarioViewController.swift
//  20plus
//
//  Created by renato mercado luna on 6/15/18.
//  Copyright © 2018 renato. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class RegistrarUsuarioViewController: UIViewController {

    //Outlets
    
    @IBOutlet weak var txtNombreUsuario: UITextField!
    @IBOutlet weak var txtApellidoUsuario: UITextField!
    @IBOutlet weak var txtContraseniaUsuario: UITextField!
    @IBOutlet weak var txtconfirmarcontreniaUsuario: UITextField!
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtCelular: UITextField!
    @IBOutlet weak var txtDni: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnSavePressed(_ sender: Any) {
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RegistrarTipo"{
            let registrarTipo=segue.destination as! RegistrarTipoViewController
            registrarTipo.nombre=txtNombreUsuario.text!
            registrarTipo.apellido=txtApellidoUsuario.text!
            registrarTipo.password=txtContraseniaUsuario.text!
            registrarTipo.correo=txtCorreo.text!
            registrarTipo.celular=txtCelular.text!
            registrarTipo.dni=txtDni.text!
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
