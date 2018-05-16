//
//  ranking.swift
//  Trivial
//
//  Created by José Ángel on 14/4/18.
//  Copyright © 2018 Macosx. All rights reserved.
//

import Foundation
import UIKit

class Ranking {
    
    var nombre: String
    var puntuacion: Int
    
    init?(nombre: String, puntuacion: Int){
        if nombre.isEmpty {
            return nil
        }
        self.nombre = nombre
        self.puntuacion = puntuacion
    }
}
