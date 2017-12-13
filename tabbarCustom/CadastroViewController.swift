//
//  CadastroViewController.swift
//  tabbarCustom
//
//  Created by Pelorca on 10/12/2017.
//  Copyright © 2017 Eduardo Pelorca. All rights reserved.
//

import UIKit
import Floaty
import FSCalendar

class CadastroViewController: UIViewController, UICollectionViewDelegate,  UIImagePickerControllerDelegate, UICollectionViewDataSource, UINavigationControllerDelegate,DropDownMenuDelegate,  FSCalendarDataSource, FSCalendarDelegate {
   
    
    func didSelectItem(_ dropDownMenu: DropDownMenu, at atIndex: Int) {
        
    }
    
    func didShow(_ dropDownMenu: DropDownMenu) {
        
    }
    
    func didHide(_ dropDownMenu: DropDownMenu) {
        
    }
    
    
    @IBOutlet weak var dropdow: DropDownMenu!
    @IBOutlet weak var lblData: UILabel!
    var listImagens: [UIImage] = [#imageLiteral(resourceName: "iconCamera"),#imageLiteral(resourceName: "iconCamera"),#imageLiteral(resourceName: "iconCamera")] 
    let imagePicker = UIImagePickerController()
    var indexPath: IndexPath?
     @IBOutlet weak var btnBack: Floaty!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.indexPath  = indexPath
        getPhoto()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImagem", for: indexPath) as! CollectionViewCell
        cell.photoDen.image = listImagens[indexPath.row]
        if listImagens[indexPath.row] != #imageLiteral(resourceName: "iconCamera") {
            cell.btnDelete.isHidden = false
        } else {
            cell.btnDelete.isHidden = true
        }
        cell.btnDelete.layer.setValue(indexPath.row, forKey: "index")
        cell.btnDelete.addTarget(self, action: #selector(self.deletePhoto(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc  func deletePhoto(_ sender: UIButton) {
        let index = sender.layer.value(forKey: "index") as! Int
        listImagens[index] = #imageLiteral(resourceName: "iconCamera")
        
        getImages()
        
    }
    
    
    @objc func getPhoto() {
        
        imagePicker.allowsEditing = false
        
        
        let alertController = UIAlertController(title: "Escolhe uma Foto", message: "", preferredStyle: .actionSheet)
        
        
        let Cancelar = UIAlertAction(title: "Cancelar", style: .cancel) { (action:UIAlertAction!) in
            return
        }
        
        alertController.addAction(Cancelar)
        
        let cancelAction = UIAlertAction(title: "Camera", style: .default) { (action:UIAlertAction!) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "Galeria", style: .default) { (action:UIAlertAction!) in
            self.imagePicker.sourceType = .photoLibrary;
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(OKAction)
        if listImagens[(self.indexPath?.row)!] != #imageLiteral(resourceName: "iconCamera") {
            let showPhoto = UIAlertAction(title: "Visualizar", style: .default) { (action:UIAlertAction!) in
                self.performSegue(withIdentifier: "showImage",  sender: self)
            }
            alertController.addAction(showPhoto)
        }
        
        
        
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            listImagens[(indexPath?.row)!] = pickedImage
            getImages()
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func getImages() {
        //self.listImagens.reverse()
        self.collectionView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.backPage))
        btnBack.addGestureRecognizer(tapGesture)
        
        self.dropdow.items = ["Incêndio", "Acidente", "Crime", "Animais Silvestre"];
        self.dropdow.itemsIDs = [0, 1, 2, 3];
        //self.dropdow.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
        self.dropdow.titleTextAlignment = NSTextAlignment.left;
        self.dropdow.delegate = self;
        
    }
    
    @objc func backPage() {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let page: ShowPhotoViewController = segue.destination as! ShowPhotoViewController
        if segue.identifier == "showImage" {
            page.imagem = (self.collectionView?.cellForItem(at: indexPath as! IndexPath) as! CollectionViewCell).photoDen.image
        }
        
    }
    func getCalendar() -> FSCalendar {
        
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 3, width: 320, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        calendar.appearance.titleWeekendColor = UIColor.red
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.appearance.headerDateFormat = "MMMM yyyy"
        calendar.calendarHeaderView.backgroundColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        calendar.appearance.headerTitleColor = UIColor.white
        calendar.appearance.selectionColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        calendar.locale = Locale(identifier: "pt_BR")
        return calendar
        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        lblData.text = "DATA: \(self.formatter.string(from: date))"
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    @IBAction func showMsg(_ sender: Any) {
        
        MessageAlert().alertDecision("Teste Msg Decisão", "Deseja fazer alguma coisa ?", op: { () in
        self.Valida()
        })
    }
    
    func Valida() {
        
        MessageAlert().alert("Sucesso", "Dali Viado", .success)
        
        
    }
    

    @IBAction func btnShowData(_ sender: Any) {
        var calendar = getCalendar()
        let alert = Calendar(title: "Selecione uma Data", calendar: &calendar)
        alert.show(animated: true)
        
    }
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
}
