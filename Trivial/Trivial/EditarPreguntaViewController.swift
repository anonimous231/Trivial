//
//  EditarPreguntaViewController.swift
//  Trivial
//
//  Created by José Ángel on 7/5/18.
//  Copyright © 2018 Macosx. All rights reserved.
//

import os.log
import UIKit

class EditarPreguntaViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var pregunta: UITextField!
    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var r1: UITextField!
    @IBOutlet weak var r2: UITextField!
    @IBOutlet weak var r3: UITextField!
    @IBOutlet weak var r4: UITextField!
    @IBOutlet weak var resp1: UISwitch!
    @IBOutlet weak var resp2: UISwitch!
    @IBOutlet weak var resp3: UISwitch!
    @IBOutlet weak var resp4: UISwitch!
    
    var categ: Categoria?
    
    var preg: Pregunta?
    override func viewDidLoad() {
        super.viewDidLoad()
        nombre.delegate = self
        
        if let preg = preg{
            navigationItem.title = preg.nombre
            nombre.text = preg.nombre
            pregunta.text = preg.pregunta
            foto.image = preg.foto
            r1.text = preg.r1
            r2.text = preg.r2
            r3.text = preg.r3
            r4.text = preg.r4
            resp1.isOn = preg.R1
            resp2.isOn = preg.R2
            resp3.isOn = preg.R3
            resp4.isOn = preg.R4
        }
        updateSaveButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddQuestionMode = presentingViewController is UINavigationController
        
        if isPresentingInAddQuestionMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("It is not inside a navigation controller.")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Comprueba si el botón pulsado es exactamente el botón de guardar
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("El botón de guardar no se ha pulsado, cancelando", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nombre.text ?? "" // Si no hay nada en el text field, asigno una cadena vacía
        let photo = foto.image
        let pr = pregunta.text ?? ""
        let respu1 = r1.text ?? ""
        let respu2 = r2.text ?? ""
        let respu3 = r3.text ?? ""
        let respu4 = r4.text ?? ""
        let respue1 = resp1.isOn
        let respue2 = resp2.isOn
        let respue3 = resp3.isOn
        let respue4 = resp4.isOn
        
        preg = Pregunta(nombre: name, pregunta: pr, foto: photo, /*categoria: (preg?.categoria)!,*/ r1: respu1, r2: respu2, r3: respu3, r4: respu4, R1: respue1, R2: respue2, R3: respue3, R4: respue4)
        categ?.añadir(preg: preg!)
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Antes de nada ocultar el teclado
        nombre.resignFirstResponder()
        
        // Instanciamos un image picker, que permite al usuario coger una foto de su galería
        let imagePickerController = UIImagePickerController()
        
        // Sólo permitimos las imágenes de la galería, no que se abra la cámara
        // Nota: .photoLibrary es equivalente a UIImagePickerControllerSourceType.photoLibrary
        imagePickerController.sourceType = .photoLibrary
        
        // Establecemos el delegate, ya que el manejo de eventos lo haremos en nuestro propio ViewController
        imagePickerController.delegate = self
        
        // Por último, mostramos el picker
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Ocultar el teclado
        textField.resignFirstResponder()
        return true
    }
    
    /**
     * Método que se ejecuta cuando se empieza a editar el texto
     */
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Deshabilitar el botón de guardado mientras se edita
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButton()
        navigationItem.title = textField.text
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Cerramos el picker
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // El diccionario seleccionado contiene múltiples representaciones de la imagen. Nosotros la que queremos es la original. Como el acceso a un Dictionary devuelve un optional, hay que manejar correctamente la situación.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Se esperaba un diccionario que tuviera una imagen, pero se encontró: \(info)")
        }
        
        // Si hemos llegado aquí es que cuando el usuario ha seleccionado una imagen, todo ha ido bien.
        // Establecemos la imagen en el ImageView
        foto.image = selectedImage
        
        // Por último cerrar el picker
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    private func updateSaveButton(){
        let text = nombre.text ?? ""
        let p = pregunta.text ?? ""
        let re1 = r1.text ?? ""
        let re2 = r2.text ?? ""
        let re3 = r3.text ?? ""
        let re4 = r4.text ?? ""
        saveButton.isEnabled = !text.isEmpty && !p.isEmpty && !re1.isEmpty && !re2.isEmpty && !re3.isEmpty && !re4.isEmpty
    }
}
