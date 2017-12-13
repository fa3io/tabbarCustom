//
//  ViewController.swift
//  tabbarCustom
//
//  Created by Pelorca on 08/12/2017.
//  Copyright © 2017 Eduardo Pelorca. All rights reserved.
//

import UIKit
import Floaty
import FSCalendar


class ViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
   
    @IBAction func showCalendar(_ sender: Any) {
        
        self.performSegue(withIdentifier: "addPhoto", sender: self)
        
        //var calendar = getCalendar()
        //let alert = Calendar(title: "Selecione uma Data", calendar: &calendar)
        //alert.show(animated: true)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.backPage))
        btnBack.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("calendar did select date \(self.formatter.string(from: date))")
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()

    @IBOutlet weak var btnBack: Floaty!
    
    @objc func backPage() {
         dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

