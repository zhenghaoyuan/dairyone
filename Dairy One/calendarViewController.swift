//
//  calendarViewController.swift
//  Dairy One
//
//  Created by 郑 on 2017/11/13.
//  Copyright © 2017年 haoyuan. All rights reserved.
//

import UIKit

class calendarViewController: UIViewController {

	@IBOutlet weak var navigationBar: UINavigationBar!
	override func viewDidLoad() {
        super.viewDidLoad()
		setNavigationBar();
		

        // Do any additional setup after loading the view.
    }
	func setNavigationBar() {
		self.navigationController?.navigationBar.barTintColor = .black;
		self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont(name: "Didot-Italic", size: 25)!];
		
		
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
