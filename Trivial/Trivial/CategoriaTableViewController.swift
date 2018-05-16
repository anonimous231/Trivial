//
//  CategoriaTableViewController.swift
//  Trivial
//
//  Created by José Ángel on 6/4/18.
//  Copyright © 2018 Macosx. All rights reserved.
//

import UIKit
import os.log

class CategoriaTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var categoria = [Categoria]()
    
    // MARK: Private methods
    

   
    private func cargarCategorias(){
        let foto1 = UIImage(named: "informatica")
        let foto2 = UIImage(named: "matematicas")
        let foto3 = UIImage(named: "psicologia")
        
        guard let categoria1 = Categoria(nombre: "Informatica", foto: foto1, preguntas: []) else {
            fatalError("Ha explotado la Categoría 1")
        }
        guard let categoria2 = Categoria(nombre: "Matematicas", foto: foto2, preguntas: []) else {
            fatalError("Ha explotado la Categoría 2")
        }
        guard let categoria3 = Categoria(nombre: "Psicologia", foto: foto3, preguntas: []) else {
            fatalError("Ha explotado la Categoría 3")
        }
        guard let pregunta1 = Pregunta(nombre: "Hola", pregunta: "Holaaaa", foto: nil, /*categoria: "Informatica", */r1: "r1a", r2: "r2a", r3: "r3a", r4: "r4a", R1: true, R2: false, R3: false, R4: false) else {
            fatalError("Ha explotado la pregunta 1")
        }
        
        guard let pregunta2 = Pregunta(nombre: "Holo", pregunta: "Holooo", foto: nil, /*categoria: "Informatica", */r1: "r1o", r2: "r2o", r3: "r3o", r4: "r4o", R1: true, R2: false, R3: false, R4: false) else {
            fatalError("Ha explotado la pregunta 2")
        }
        
        categoria1.añadir(preg: pregunta1)
        categoria1.añadir(preg: pregunta2)
        
        categoria += [categoria1, categoria2, categoria3]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        cargarCategorias()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoria.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CategoriasTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CategoriasTableViewCell else{
            fatalError("No se puede mostrar la TableViewCell (dequeue)")
        }
        
        let categorias = categoria[indexPath.row]
        
        cell.nombreCategoria.text = categorias.nombre
        cell.imagenCategoria.image = categorias.foto
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "volver":
            os_log("Volviendo al menú principal", log: OSLog.default, type: .debug)
        case "paso":
            let preguntasTableViewController = segue.destination as? PreguntasTableViewController
     
        guard let selectedQuestionCell = sender as? CategoriasTableViewCell else {
            fatalError("Unexpected sender: \(String(describing: sender))")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedQuestionCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let categoriaSeleccionada = categoria[indexPath.row]
            preguntasTableViewController?.categ = categoriaSeleccionada
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
        
    }
}
