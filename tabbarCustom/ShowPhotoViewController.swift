//
//  ShowPhotoViewController.swift
//  tabbarCustom
//
//  Created by Pelorca on 10/12/2017.
//  Copyright © 2017 Eduardo Pelorca. All rights reserved.
//

import UIKit
import Floaty

class ShowPhotoViewController: UIViewController {
        var imagem: UIImage?
    
    @IBOutlet weak var showImagen: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.backPage))
        btnBack.addGestureRecognizer(tapGesture)
       self.showImagen.image = imagem
    }

    @IBOutlet weak var btnBack: Floaty!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func backPage() {
        dismiss(animated: true, completion: nil)
    }

}
