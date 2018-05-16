//
//  File.swift
//  Trivial
//
//  Created by Macosx on 13/4/18.
//  Copyright © 2018 Macosx. All rights reserved.
//

import Foundation
import UIKit
import os.log

class Pregunta:NSObject, NSCoding{
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nombre, forKey: PropertyKey.nombre)
        aCoder.encode(pregunta, forKey: PropertyKey.pregunta)
        aCoder.encode(foto, forKey: PropertyKey.foto)
        //        aCoder.encode(categoria, forKey: PropertyKey.categoria)
        aCoder.encode(r1, forKey: PropertyKey.r1)
        aCoder.encode(r2, forKey: PropertyKey.r2)
        aCoder.encode(r3, forKey: PropertyKey.r3)
        aCoder.encode(r4, forKey: PropertyKey.r4)
        aCoder.encode(R1, forKey: PropertyKey.R1)
        aCoder.encode(R2, forKey: PropertyKey.R2)
        aCoder.encode(R3, forKey: PropertyKey.R3)
        aCoder.encode(R4, forKey: PropertyKey.R4)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let nombre = aDecoder.decodeObject(forKey: PropertyKey.nombre) as? String else {
            os_log("Unable to decode the name for a Answer object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let pregunta = aDecoder.decodeObject(forKey: PropertyKey.pregunta) as? String else {
            os_log("Unable to decode the name for a Answer object.", log: OSLog.default, type: .debug)
            return nil
        }
        //        guard let categoria = aDecoder.decodeObject(forKey: PropertyKey.categoria) as? String else {
        //            os_log("Unable to decode the name for a Answer object.", log: OSLog.default, type: .debug)
        //            return nil
        //        }
        // Because photo is an optional property of Questions, just use conditional cast.
        let foto = aDecoder.decodeObject(forKey: PropertyKey.foto) as? UIImage
        
        guard let r1 = aDecoder.decodeObject(forKey: PropertyKey.r1) as? String else {
            os_log("Unable to decode the name for a Answer object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let r2 = aDecoder.decodeObject(forKey: PropertyKey.r2) as? String else {
            os_log("Unable to decode the name for a Answer object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let r3 = aDecoder.decodeObject(forKey: PropertyKey.r3) as? String else {
            os_log("Unable to decode the name for a Answer object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let r4 = aDecoder.decodeObject(forKey: PropertyKey.r4) as? String else {
            os_log("Unable to decode the name for a Answer object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let R1 = aDecoder.decodeObject(forKey: PropertyKey.R1) as? Bool else {
            os_log("Unable to decode the name for a Answer object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let R2 = aDecoder.decodeObject(forKey: PropertyKey.R2) as? Bool else {
            os_log("Unable to decode the name for a Answer object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let R3 = aDecoder.decodeObject(forKey: PropertyKey.R3) as? Bool else {
            os_log("Unable to decode the name for a Answer object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let R4 = aDecoder.decodeObject(forKey: PropertyKey.R4) as? Bool else {
            os_log("Unable to decode the name for a Answer object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(nombre: nombre, pregunta: pregunta, foto: foto, /*categoria: categoria,*/ r1: r1, r2: r2, r3: r3, r4: r4, R1: R1, R2: R2, R3: R3, R4: R4)
        
    }
    
    var nombre: String
    var pregunta: String
    var foto: UIImage?
    //    var categoria: String
    var R1: Bool
    var R2: Bool
    var R3: Bool
    var R4: Bool
    var r1: String
    var r2: String
    var r3: String
    var r4: String
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("preguntas")
    
    struct PropertyKey {
        static let nombre = "nombre"
        static let pregunta = "pregunta"
        static let foto = "foto"
        //        static let categoria = "categoria"
        static let r1 = "r1"
        static let r2 = "r2"
        static let r3 = "r3"
        static let r4 = "r4"
        static let R1 = "R1"
        static let R2 = "R2"
        static let R3 = "R3"
        static let R4 = "R4"
    }
    
    init?(nombre: String, pregunta:String, foto: UIImage?, /*categoria: String,*/ r1: String, r2: String, r3: String, r4: String, R1: Bool, R2: Bool, R3: Bool, R4: Bool){
        
        
        if nombre.isEmpty /*|| categoria.isEmpty*/ {
            return nil
        }
        
        //Initialize stored properties
        self.nombre = nombre
        self.pregunta = pregunta
        self.foto = foto
        //        self.categoria = categoria
        self.R1 = R1
        self.R2 = R2
        self.R3 = R3
        self.R4 = R4
        self.r1 = r1
        self.r2 = r2
        self.r3 = r3
        self.r4 = r4
        
    }
}
