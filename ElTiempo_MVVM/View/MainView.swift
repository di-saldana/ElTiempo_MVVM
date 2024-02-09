//
//  ViewController.swift
//  ElTiempo_MVVM
//
//

import UIKit
import Combine

class MainView: UIViewController {

    @IBOutlet weak var estadoLabel: UILabel!
    @IBOutlet weak var estadoImage: UIImageView!
    @IBOutlet weak var campoTexto: UITextField!
    
    let viewModel = TiempoViewModel()
    var estadoLabelCancellable: AnyCancellable?
    var iconoImageCancellable: AnyCancellable?
    
    @IBAction func botonPulsado(_ sender: Any) {
        viewModel.consultarTiempoActual(localidad: campoTexto.text ?? "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        estadoLabelCancellable = viewModel.$estado.assign(to: \.text!, on: estadoLabel)
        iconoImageCancellable = viewModel.$icono.sink { [weak self] image in
            self?.estadoImage.image = image
        }
    }
}

