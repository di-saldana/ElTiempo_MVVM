//
//  TiempoViewModel.swift
//  ElTiempo_MVVM
//
//  Created by Otto Colomina Pardo on 20/1/22.
//

import Foundation
import Combine

class TiempoViewModel {
    let modelo = TiempoModelo()
    
    @Published var estado = ""
    
    func consultarTiempoActual(localidad : String) {
      modelo.consultarTiempoActual(localidad: localidad) {
        estado, urlIcono in
        OperationQueue.main.addOperation {
            //como al tocar estas propiedades se va a modificar la interfaz
            //debemos hacerlo desde el hilo principal
            self.estado = estado
            //de momento no hacemos nada con `urlIcono`
        }
      }
    }
}
