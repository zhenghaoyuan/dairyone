//
//  calendarViewController.swift
//  Dairy One
//
//  Created by 郑 on 2017/11/13.
//  Copyright © 2017年 haoyuan. All rights reserved.
//

import UIKit
import JTAppleCalendar

class calendarViewController: UIViewController,progressViewDelegate{
	
	@IBOutlet weak var progressView: progressView!
	
	@IBOutlet weak var calendarView: JTAppleCalendarView!
	let formatter = DateFormatter()
	override func viewDidLoad() {
        super.viewDidLoad()
		progressView.delegate = self;
		setNavigationBar();
		setCalendarView();
		

        // Do any additional setup after loading the view.
    }
	
	func getPhotoNumber() -> Int {
		if (photoDB.sharedInstance.photo.isEmpty) {
			return 0;
		}else {
			return photoDB.sharedInstance.photo.count;
		}
	}
	func setNavigationBar() {
		self.navigationController?.navigationBar.barTintColor = .black;
		self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont(name: "Didot-Italic", size: 25)!];
		
		
	}
	func setCalendarView() {
		calendarView.minimumLineSpacing = 0;
		calendarView.minimumInteritemSpacing = 0;
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated);
		self.progressView.setNeedsDisplay();
		self.calendarView.reloadData();
		let myDate = Date();
		self.calendarView.scrollToDate(myDate);
		
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension calendarViewController:JTAppleCalendarViewDelegate,JTAppleCalendarViewDataSource {
	func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
		let myCell = cell as! calendarCell;
		myCell.dateLabel.text = cellState.text;
		
		
	}
	
	
	
	func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
		self.formatter.dateFormat = "yyyy MM dd";
		formatter.timeZone = Calendar.current.timeZone;
		formatter.locale = Calendar.current.locale;
		let startDate = formatter.date(from: "2017 01 01")!;
		let endDate = formatter.date(from: "2017 12 31")!;
		let parameter = ConfigurationParameters(startDate: startDate, endDate: endDate)
		print("haha I finish calendar configuration");
		return parameter;
	}
	
	func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
		let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "cell", for: indexPath) as! calendarCell
		cell.dateLabel.text = cellState.text;
		cell.selectedView.isHidden = true;
		for cdate in photoDB.sharedInstance.date {
			if (Calendar.current.isDate(cdate, inSameDayAs: cellState.date) ) {
				cell.selectedView.isHidden = false;
				cell.isDate = true;

			}
		}
		
		
		return cell;
	}
	
//	func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
//		guard let  validCell = cell as? calendarCell else {return}
//		validCell.selectedView.isHidden = false;
//		
//		
//	}
//
//	func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
//		guard let  validCell = cell as? calendarCell else {return}
//		validCell.selectedView.isHidden = true;
//		
//	}
	
	
}

