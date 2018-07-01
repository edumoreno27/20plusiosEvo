//
//  VerAvanceViewController.swift
//  20plus
//
//  Created by renato mercado luna on 6/28/18.
//  Copyright © 2018 renato. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class VerAvanceViewController: UIViewController {
    var avance = 0
    
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblDescriptioon: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Get profeID
        //let userDefaults = UserDefaults.standard
        //Get padreID
        //let tutoriaId : Int = userDefaults.integer(forKey: "selectedPadreAvancedId")
        
        
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/resumenclases").responseJSON{
            response in
            if let json = response.result.value{
                let sJSON = JSON(json)
                for(_,subJson):(String, JSON) in sJSON{
                    
                    if(subJson["idtutoria"].intValue == self.avance){
                     
                        self.lblDescriptioon.text=subJson["descripcion"].stringValue
                        self.lblFecha.text=subJson["descripcion"].stringValue
                        
                    }
                }
            }
        
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
