//
//  HomeProfeViewController.swift
//  20plus
//
//  Created by Alumnos on 16/06/18.
//  Copyright © 2018 renato. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class HomeProfeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Create a porfessor for test
        
        
        
        
        let parameters : Parameters = ["id_padre" : 1, "id_servicio" : 1, "id_horario" : 1 , "hora" : "testCorreo@c", "celular" : "123456789", "descripcion" : "test", "preciomax" : 12 , "preciomin":1 , "experiencia":"ninguna","califcacion":5,"dni":"123456"]
        
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/tutorias", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            print("Result Value: \(String(describing: response.result.value))")               // response serialization result
            
            
        }
 
        
        
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
