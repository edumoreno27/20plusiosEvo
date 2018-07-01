//
//  ViewController.swift
//  20plus
//
//  Created by renato on 5/29/18.
//  Copyright © 2018 renato. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
class ViewController: UIViewController {

    @IBOutlet weak var txtCorreoElcrotnico: UITextField!
    
    @IBOutlet weak var txtPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLoginPressed(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/padres?email="+txtCorreoElcrotnico.text! + "&password="+txtPass.text!).responseJSON { response in
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")                         // response serialization result
                
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                }
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)") // original server data as UTF8 string
                }
            //doble llave en el json por eos no se peude leer con el; metodo usualk
                let sJson = JSON(response.result.value)
                if(sJson["idpadre"] != JSON.null){
                    print(sJson["nombre"])
                    userDefaults.set(sJson["idpadre"].intValue, forKey: "UserId")
                    self.performSegue(withIdentifier: "loginPadre", sender: nil)
                    
                }
        }
        
            Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/profesors?email="+txtCorreoElcrotnico.text! + "&password="+txtPass.text!).responseJSON { response in
                let sJsonProfe = JSON(response.result.value)
                if(sJsonProfe["idprofesor"] != JSON.null){
                    print(sJsonProfe["nombre"])
                    userDefaults.set(sJsonProfe["idprofesor"].intValue, forKey: "UserId")
                    self.performSegue(withIdentifier: "loginProfesor", sender: nil)
                    
                }
                
            }
        /*
         else {
         print("ERROR GG MEN A dormir >V")
         
         let alert = UIAlertController(title: "Fatal FAIl!!", message: "Ops!", preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
         NSLog("The \"OK\" alert occured.")
         }))
         self.present(alert, animated: true, completion: nil)
         
         }
         */
    }
}


