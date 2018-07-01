//
//  FavoritosController.swift
//  20plus
//
//  Created by Alumnos on 16/06/18.
//  Copyright © 2018 renato. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class FavoritosController: UITableViewController {
    var id = 0
    var arreglo = [profesorfavorito]()
    var arregloProfesores = [profesor]()
    
    
    
    var selectedRow: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.arregloProfesores.removeAll()
        self.arreglo.removeAll()
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
         //Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/apiprofesorfavoritoes").responseJSON{
        
        
        
        let userDefaults = UserDefaults.standard
        let userId : Int = userDefaults.integer(forKey: "UserId")
        id = userId

            Alamofire.request("http://vmdev1.nexolink.com:90/TeachersAPI/api/profesors?idpadre=" + String(id) ).responseJSON{
                response in
                if let json = response.result.value{
                    let sJSON = JSON(json)
                    for(_,subJson):(String, JSON) in sJSON{
                        print("obteniendo valores")
                        let objItem = profesor()
                        objItem.nombre=subJson["nombre"].stringValue
                        objItem.apellido = subJson["apellido"].stringValue
                        objItem.calificacion = subJson["calificacion"].intValue
                        objItem.celular = subJson["celular"].intValue
                        objItem.descripcion = subJson["descripcion"].stringValue
                        objItem.experiencia = subJson["experiencia"].stringValue
                        self.arregloProfesores.append(objItem)
                        
                        
                    }
                }
                
                
            
            
}
        self.tableView.reloadData()
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arregloProfesores.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mis favoritos cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.arregloProfesores[indexPath.row].nombre + " " + String(self.arregloProfesores[indexPath.row].calificacion)
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if( segue.identifier == "segueFavProfe" ){
            if let controller = segue.destination as? MyProfessorFavViewController {
                controller.profesor = arregloProfesores[self.selectedRow]
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(myItems[indexPath.row].name)
        self.selectedRow = indexPath.row
        self.performSegue(withIdentifier: "segueFavProfe", sender: self)
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
