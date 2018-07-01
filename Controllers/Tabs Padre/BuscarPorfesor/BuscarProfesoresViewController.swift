//
//  BuscarProfesoresViewController.swift
//  20plus
//
//  Created by renato mercado luna on 6/15/18.
//  Copyright © 2018 renato. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class BuscarProfesoresViewController: UITableViewController {

    var id = 0
    var profesors = [profesor]()
    var selectedRow: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
       
        self.profesors.removeAll()
        Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/profesors").responseJSON { response in
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                //Read json
                let sJson = JSON(json)
                
                for (_,subJson):(String, JSON) in sJson {
                    // Do something you want
                    let objItem = profesor()
                    objItem.idprofesor = subJson["idprofesor"].intValue
                    objItem.nombre = subJson["nombre"].stringValue
                    objItem.apellido = subJson["apellido"].stringValue
                    objItem.calificacion = subJson["calificacion"].intValue
                    objItem.celular = subJson["celular"].intValue
                    objItem.descripcion = subJson["descripcion"].stringValue
                    objItem.experiencia = subJson["experiencia"].stringValue
                    self.profesors.append(objItem)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.profesors.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "home cell", for: indexPath)

        cell.textLabel?.text = profesors[indexPath.row].nombre + " " + String(profesors[indexPath.row].calificacion)
        
        selectedRow = indexPath.row
        // Configure the cell...

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if( segue.identifier == "detailProf" ){
            if let controller = segue.destination as? ProfesorInfoViewController {
                controller.profesor = profesors[self.selectedRow]
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(myItems[indexPath.row].name)
        self.selectedRow = indexPath.row
        self.performSegue(withIdentifier: "detailProf", sender: self)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
