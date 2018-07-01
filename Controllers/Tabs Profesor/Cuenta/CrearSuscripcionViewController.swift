//
//  CrearSuscripcionViewController.swift
//  20plus
//
//  Created by Cristian Trigo on 6/29/18.
//  Copyright © 2018 renato. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class CrearSuscripcionViewController: UIViewController{

    @IBOutlet weak var dpInicio: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Agregar(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        let id : Int = userDefaults.integer(forKey: "UserId")
        //var idprofe = ""
        //idprofe = String(id)
        
        let parameters : Parameters = ["fechainicio" : dpInicio.date, "id_profesor" : id]
        
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/suscripcions", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            print("Result Value: \(String(describing: response.result.value))")               // response serialization result
            
            switch(response.result){
            case .failure(_):
                let alert = UIAlertController(title: "Fail!", message: "Intentalo de nuevo!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                break;
            case .success:                    self.navigationController?.popViewController(animated: true)
            break;
            }
            
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
