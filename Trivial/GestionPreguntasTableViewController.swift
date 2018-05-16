//
//  GestionPreguntasTableViewController.swift
//  Trivial
//
//  Created by José Ángel on 7/5/18.
//  Copyright © 2018 Macosx. All rights reserved.
//

import os.log
import UIKit

class GestionPreguntasTableViewController: UITableViewController {
    //MARK:
    var preguntas = [Pregunta]()
    var category = Categoria()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
            cargarPreguntas()
        
    }
    private func cargarPreguntas(){
        
        //preguntas tenga
        //caso inicial preguntas estan vacio
        for i in (category.getPreguntas()){
            preguntas.append(i)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return preguntas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier = "PreguntasTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PreguntasTableViewCell else{
            fatalError("No se puede mostrar la TableViewCell (dequeue)")
        }
        
        let pregunta = preguntas[indexPath.row]
        
        cell.nombrePregunta.text = pregunta.nombre
       
        return cell
       
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "addPregunta":
            os_log("Adding a new Question.", log: OSLog.default, type: .debug)
            let AñadirPreguntaViewController = segue.destination as? EditarPreguntaViewController
            let catego = category
            AñadirPreguntaViewController?.categ = catego
            
        case "volver":
            os_log("Volviendo al menú principal", log: OSLog.default, type: .debug)
            
            let GestionViewController = segue.destination as? UINavigationController
            
            guard let CategoryDetailViewController = GestionViewController?.viewControllers.first as? GestionTableViewController else {
                fatalError("Couldn't instantiate from NavigationController")
            }
            
            CategoryDetailViewController.categoria = category
            
        case "pasoEditar":
            os_log("Adding a new question.", log: OSLog.default, type: .debug)
           
            let EditarPreguntaViewController = segue.destination as? EditarPreguntaViewController
            
            guard let selectedQuestionCell = sender as? PreguntasTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedQuestionCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let preguntaSeleccionada = preguntas[indexPath.row]
            EditarPreguntaViewController?.preg = preguntaSeleccionada
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    @IBAction func unwindToPregList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? EditarPreguntaViewController, let pregu = sourceViewController.preg {

            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing Question.
                preguntas[selectedIndexPath.row] = pregu
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                category.preguntas[selectedIndexPath.row] = pregu
            }
            else {
                // Add a new Question.
                let newIndexPath = IndexPath(row: preguntas.count, section: 0)
                preguntas.append(pregu)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                category.añadir(preg: pregu)
            }
            // Save the questions.
            saveAnswer()
        }
    }
    
    private func saveAnswer() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(category, toFile: Categoria.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Question successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save question...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadAnswers() -> Categoria?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Categoria.ArchiveURL.path) as? Categoria
    }

}
