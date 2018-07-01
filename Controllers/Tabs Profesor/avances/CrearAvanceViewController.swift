//
//  CrearAvanceViewController.swift
//  20plus
//
//  Created by renato mercado luna on 6/28/18.
//  Copyright © 2018 renato. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class CrearAvanceViewController: UIViewController {

    
    @IBOutlet weak var txtDescripcion: UITextField!
    @IBOutlet weak var lblFecha: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    override func viewDidAppear(_ animated: Bool) {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: Date())
        self.lblFecha.text = myString
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBtnCrearAvancePressed(_ sender: Any) {
        
        
        //Get profeID
        let userDefaults = UserDefaults.standard
        
        //Get padreID
        let tutoriaId : Int = userDefaults.integer(forKey: "selectedPadreAvancedId")
        
        let currentDateTime = Date()
        
        
        
        let parameters : Parameters = ["idTutoria" : tutoriaId, "Description" : self.txtDescripcion.text!, "fecha" : currentDateTime]
        
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/resumenclases", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
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
