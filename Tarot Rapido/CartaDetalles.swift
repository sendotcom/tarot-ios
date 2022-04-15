//
//  CartaDetalles.swift
//  Tarot Rapido
//
//  Created by H.Gio on 10/04/22.
//

import Foundation
import UIKit

class CartaDetalles: UIViewController{
    
    @IBOutlet weak var cartaTitulo: UILabel!
    @IBOutlet weak var cartaImagen: UIImageView!
    @IBOutlet weak var cartaDescripcionNormal: UITextView!
    @IBOutlet weak var cartaDetalleDePosicionTexto: UILabel!
    
    var cartaSeleccionada : Cartas!
    var OrientacionInt: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo.jpg")!)

        cartaTitulo.text = cartaSeleccionada.name
        cartaImagen.image = UIImage(named: cartaSeleccionada.img)
        cartaDescripcionNormal.text = cartaSeleccionada.descripcion_normal
        
        //Añadimos el gesto
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        
        cartaImagen.addGestureRecognizer(tapGesture)
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        
           if (gesture.view as? UIImageView) != nil {
               
               if (self.OrientacionInt == 1){
                   
                   cartaImagen.rotar(completion: {
                       self.cartaImagen.transform = CGAffineTransform(scaleX: -1, y: -1)
                       //Paso a ser 2 porque la regresamos, esta volteada
                       self.OrientacionInt = 2
                       
                       self.cartaDetalleDePosicionTexto.text = "Interpretación de la carta en posicion Invertida:"
                       self.cartaDescripcionNormal.text = self.cartaSeleccionada.descripcion_invertida
                       
                   }, with: self.OrientacionInt)

               }else{
                   cartaImagen.rotar(completion: {
                       self.cartaImagen.transform = CGAffineTransform(scaleX: 1, y: 1)
                       //Paso a ser 1 porque la regresamos, ya esta en posicion normal
                       self.OrientacionInt = 1
                       
                       self.cartaDetalleDePosicionTexto.text = "Interpretación de la carta en posicion Normal:"
                       self.cartaDescripcionNormal.text = self.cartaSeleccionada.descripcion_normal
                   }, with: self.OrientacionInt)
               }
           }
       }
}

extension UIImageView{
    func rotar(completion: @escaping(()-> Void), with orientacion: Int) {
        CATransaction.begin()
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * Double(orientacion))
        rotation.duration = 2
        rotation.isCumulative = true
        //rotation.repeatCount = Float.greatestFiniteMagnitude
        //self.transform = CGAffineTransform(scaleX: 1, y: -1)
        CATransaction.setCompletionBlock(completion)
        self.layer.add(rotation, forKey: "rotationAnimation")
        CATransaction.commit()
    }
}
