//
//  TiempoViewModel.swift
//  ElTiempo_MVVM
//
//  Created by Otto Colomina Pardo on 20/1/22.
//

import Foundation
import Combine
import UIKit

class TiempoViewModel {
    let modelo = TiempoModelo()
    
    @Published var estado = ""
    @Published var icono: UIImage?
    
    func consultarTiempoActual(localidad : String) {
      modelo.consultarTiempoActual(localidad: localidad) {
        estado, urlIcono in
        OperationQueue.main.addOperation {
            //como al tocar estas propiedades se va a modificar la interfaz
            //debemos hacerlo desde el hilo principal
            self.estado = estado
            
            if !urlIcono.isEmpty {
                self.descargarIconoDesdeURL(urlIcono)
            } else {
                self.icono = nil
            }
        }
      }
    }
    
    private func descargarIconoDesdeURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                print("Error al descargar la imagen:", error?.localizedDescription ?? "Error desconocido")
                return
            }
            DispatchQueue.main.async {
                self?.icono = UIImage(data: data)
            }
        }.resume()
    }
}
