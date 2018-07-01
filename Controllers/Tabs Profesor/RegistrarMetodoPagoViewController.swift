//
//  RegistrarMetodoPagoViewController.swift
//  20plus
//
//  Created by Cristian Trigo on 6/25/18.
//  Copyright © 2018 renato. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class RegistrarMetodoPagoViewController: UIViewController {

    var id=0
    
    @IBOutlet weak var txtTarjeta: UITextField!
    @IBOutlet weak var dpFecha: UIDatePicker!
    @IBOutlet weak var txtCodigo: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func botonCrear(_ sender: Any) {
        let parameters : Parameters = ["nombre" : "Nuevo",
                                       "numerotarjeta" : txtTarjeta.text!,
                                       "fecha" : dpFecha.date,
                                       "cvv" : txtCodigo.text!]
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/metodopagoes",method: .post, parameters : parameters)
        
        
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
