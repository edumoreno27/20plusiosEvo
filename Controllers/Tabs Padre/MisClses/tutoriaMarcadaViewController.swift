//
//  tutoriaMarcadaViewController.swift
//  20plus
//
//  Created by renato mercado luna on 6/29/18.
//  Copyright © 2018 renato. All rights reserved.
//

import UIKit

class tutoriaMarcadaViewController: UIViewController {
    
    var tutoria: tutoria? = nil
    @IBOutlet weak var lblHora: UILabel!
    @IBOutlet weak var lblNumeroDeHoras: UILabel!
    
    @IBOutlet weak var lblCurso: UILabel!
    @IBOutlet weak var lblEstado: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        
        var number = 0
        number = (tutoria?.numerohoras)!
        
        
        lblHora.text = tutoria?.hora
        lblNumeroDeHoras.text = String(number)
        lblEstado.text = tutoria?.estado
        lblCurso.text = tutoria?.curso
        
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
