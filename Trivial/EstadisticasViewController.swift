//
//  EstadisticasViewController.swift
//  Trivial
//
//  Created by José Ángel on 4/5/18.
//  Copyright © 2018 Macosx. All rights reserved.
//

import UIKit

class EstadisticasViewController: UIViewController {
    @IBOutlet weak var puntuacion: UILabel!
    var cont: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        puntuacion.text = String (cont)
        // Do any additional setup after loading the view.
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
