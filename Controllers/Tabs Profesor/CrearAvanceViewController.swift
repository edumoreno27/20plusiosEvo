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
class CrearAvanceViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    var arreglo = [tutoria]()

    @IBOutlet weak var dpTutoria: UIPickerView!
    
    @IBOutlet weak var txtDescripcion: UITextField!
    @IBOutlet weak var lblFecha: UILabel!
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.arreglo.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arreglo[row].curso + "-" + arreglo[row].estado + "-" + arreglo[row].hora
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dpTutoria.dataSource=self
        dpTutoria.delegate=self
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: Date())
        self.lblFecha.text = myString
        
        let userDefaults = UserDefaults.standard
        let id : Int = userDefaults.integer(forKey: "UserId")
        var idprofe = ""
        idprofe = String(id)
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/tutorias?idpadre="+idprofe).responseJSON{
            response in
            if let json = response.result.value{
                let sJSON = JSON(json)
                for(_,subJson):(String, JSON) in sJSON{
                    let objEntidad = tutoria()
                    objEntidad.idtutoria=subJson["idtutoria"].intValue
                    objEntidad.comentario=subJson["comentario"].stringValue
                    objEntidad.curso=subJson["curso"].stringValue
                    objEntidad.estado=subJson["estado"].stringValue
                    objEntidad.hora = subJson["hora"].stringValue
                    objEntidad.numerohoras=subJson["numerohoras"].intValue
                    objEntidad.precio=subJson["precio"].doubleValue
                    self.arreglo.append(objEntidad)
                }
                self.dpTutoria.reloadAllComponents()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBtnCrearAvancePressed(_ sender: Any) {
        
        
        //Get profeID
        
        
        //Get padreID
        //let tutoriaId : Int = userDefaults.integer(forKey: "selectedPadreAvancedId")
        var tutoriaId = 0
        let currentDateTime = Date()
        if let objEntidad : tutoria = self.arreglo[self.dpTutoria.selectedRow(inComponent: 0)]{
            tutoriaId = objEntidad.idtutoria
        }
        
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
