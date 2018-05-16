//
//  PreguntasTableViewController.swift
//  Trivial
//
//  Created by José Ángel on 14/4/18.
//  Copyright © 2018 Macosx. All rights reserved.
//

import UIKit
//MARK: Properties


class PreguntasTableViewController: UITableViewController {
    
    @IBOutlet weak var Nombre: UILabel!
    @IBOutlet weak var pregunta: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var R1: UIButton!
    @IBOutlet weak var R3: UIButton!
    @IBOutlet weak var R2: UIButton!
    @IBOutlet weak var R4: UIButton!
    var index = 0
    var cont = 0
    var preguntas = [Pregunta]()
    var categ = Categoria()
    
    @IBAction func Volver(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Private methods
    
    private func CargarPreguntas(){
        if(!((categ.getPreguntas()).isEmpty)){
            preguntas = (categ.getPreguntas())
            let preg = preguntas[index]
            Nombre.text = preg.nombre
            pregunta.text = preg.pregunta
            imagen.image? = preg.foto!
            R1.setTitle(preg.r1, for: .normal)
            R2.setTitle(preg.r2, for: .normal)
            R3.setTitle(preg.r3, for: .normal)
            R4.setTitle(preg.r4, for: .normal)
        }else{
//            Alert para cuando no haya preguntas en la categoría seleccionada
        }
    }
    
    @IBAction func pr1(_ sender: Any) {
        preguntas = (categ.getPreguntas())
        let preg = preguntas[index]
        print("Se ha pulsado el botón 1")
        if(preg.R1){
            print("correcto")
            cont += 1
        }else{
            print("incorrecto")
        }
        index+=1
        if(index < preguntas.count){
            CargarPreguntas()
        }else{
            fin()
        }
        
    }
    @IBAction func pr2(_ sender: Any) {
        preguntas = (categ.getPreguntas())
        let preg = preguntas[index]
        print("Se ha pulsado el botón 2")
        if(preg.R2){
            print("correcto")
            cont += 1
        }else{
            print("incorrecto")
        }
        index+=1
        if(index < preguntas.count){
            CargarPreguntas()
        }else{
            fin()
        }
    }
    @IBAction func pr3(_ sender: Any) {
        preguntas = (categ.getPreguntas())
        let preg = preguntas[index]
        print("Se ha pulsado el botón 3")
        if(preg.R3){
            print("correcto")
            cont += 1
        }else{
            print("incorrecto")
        }
        index+=1
        if(index < preguntas.count){
            CargarPreguntas()
        }else{
            fin()
        }
    }
    @IBAction func pr4(_ sender: Any) {
        preguntas = (categ.getPreguntas())
        let preg = preguntas[index]
        print("Se ha pulsado el botón 4")
        if(preg.R4){
            print("correcto")
            cont += 1
        }else{
            print("incorrecto")
        }
        index+=1
        if(index < preguntas.count){
            CargarPreguntas()
        }else{
            fin()
        }
    }
    
    private func fin(){
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vdos = storyboard.instantiateViewController(withIdentifier: "Estadisticas") as! EstadisticasViewController
        vdos.cont = cont
        
        let r = storyboard.instantiateViewController(withIdentifier: "Ranking") as! RankingTableViewController
        guard let rank = Ranking(nombre: "hola", puntuacion: cont) else {
            fatalError("caput ranking1")
        }
        
        //guardar en fichero para que no se pierda el ranking
        r.ranking.append(rank)
        
        self.present(vdos, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CargarPreguntas();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return preguntas.count
//    }

    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cellIdentifier = "PreguntasTableViewCell"
//        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PreguntasTableViewCell else{
//            fatalError("No se puede mostrar la TableViewCell (dequeue)")
//        }
//        
//        let pregunta = preguntas[indexPath.row]
//        
//        cell.nombrePregunta.text = pregunta.nombre
//      
//        
//        return cell
//    }
}
