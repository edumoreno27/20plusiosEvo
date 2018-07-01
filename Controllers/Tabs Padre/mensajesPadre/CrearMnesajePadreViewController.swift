//
//  CrearMnesajePadreViewController.swift
//  20plus
//
//  Created by renato mercado luna on 6/30/18.
//  Copyright © 2018 renato. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class CrearMnesajePadreViewController: UIViewController {

    @IBOutlet weak var txtMensaje: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var btnPressedCrearMnesaje: UIButton!
    
    @IBAction func btnPreesssedd(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        let padreId : Int = userDefaults.integer(forKey: "UserId")
        
        let parameters : Parameters = ["hora" : "","fecha" : "","contenido" : txtMensaje.text,"id_padre" : padreId,"id_profe" : 27 ,"remitente" : "El padre"]
        
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/mensajes", method: .post, parameters: parameters).responseJSON { response in
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
