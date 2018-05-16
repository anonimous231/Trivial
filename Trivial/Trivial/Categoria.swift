//
//  Categoria.swift
//  Trivial
//
//  Created by José Ángel on 6/4/18.
//  Copyright © 2018 Macosx. All rights reserved.
//

import Foundation
import UIKit
import os.log

class Categoria:NSObject, NSCoding{
    struct PropertyKey {
        static let nombre = "nombre"
        static let foto = "foto"
        static let preguntas = "preguntas"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nombre, forKey: PropertyKey.nombre)
        aCoder.encode(foto, forKey: PropertyKey.foto)
        aCoder.encode(preguntas, forKey: PropertyKey.preguntas)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let nombre = aDecoder.decodeObject(forKey: PropertyKey.nombre) as? String else {
            os_log("Unable to decode the name for a Answer object.", log: OSLog.default, type: .debug)
            return nil
        }
        let foto = aDecoder.decodeObject(forKey: PropertyKey.foto) as? UIImage
        let preguntas = aDecoder.decodeObject(forKey:PropertyKey.preguntas) as? [Pregunta]
        //let x = aDecoder.decodeObject(forKey:PropertyKey.preguntas)
        self.init(nombre: nombre, foto: foto, preguntas: preguntas!)
    }
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("categoria")
    
    //MARK: Properties
    
    var nombre: String
    var foto: UIImage?
    var preguntas:[Pregunta];
    //MARK: Initialization
    
    
    init?(nombre: String, foto: UIImage?, preguntas: [Pregunta]){
        if nombre.isEmpty {
            return nil
        }
        //Initialize stored properties
        self.nombre = nombre
        self.foto = foto
        self.preguntas = preguntas
    }
    override init(){
        //Initialize stored properties
        self.nombre = "default"
        self.foto = nil
        self.preguntas = [Pregunta]()
    }
    
    //Mark: Public methods
    
    public func isEmpty()-> Bool{
        if nombre.isEmpty || nombre == "default" {
            return true
        }
        return false
    }
    
    public func añadir(preg: Pregunta) {
        preguntas.append(preg)
    }
    
    public func getPreguntas()->[Pregunta]{
        return preguntas
    }
    
    public func getCategoria()->String{
        return nombre
    }
}

