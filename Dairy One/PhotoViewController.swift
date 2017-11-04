//
//  PhotoViewController.swift
//  Dairy One
//
//  Created by 郑 on 2017/10/29.
//  Copyright © 2017年 haoyuan. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
	let takenPhoto:UIImage? = nil
	
	@IBOutlet weak var imageView: UIImageView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		if let availableImage = takenPhoto {
			imageView.image = availableImage;
		}
    }

	@IBAction func goBack(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
		
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
