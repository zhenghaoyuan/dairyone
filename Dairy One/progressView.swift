//
//  progressView.swift
//  Dairy One
//
//  Created by 郑 on 2017/11/16.
//  Copyright © 2017年 haoyuan. All rights reserved.
//

import UIKit

protocol progressViewDelegate {
	func getPhotoNumber() -> Int 
}

class progressView: UIView {
	var delegate: progressViewDelegate!;
    override func draw(_ rect: CGRect) {
	 //draw the progress bar, count the total number of video. and have a progress.
	//Although I personally think is useless, I have to meet the requirement of my final project
		print("la la la , I am begin drawing lines!");
		let num = self.delegate.getPhotoNumber();
			print(num);
			if ( num != 0) {
			let dx = (rect.maxX - rect.minX)/30;
			var len = Double(rect.minX) +  Double(num) * Double(dx);
			if (num > 30) {
				len = Double(rect.maxX);
			}
			let path = UIBezierPath()
			UIColor.red.setStroke()
			path.move(to:CGPoint(x: rect.minX, y: rect.minY));
			path.addLine(to: CGPoint(x:len,y:Double(rect.minY)));
			path.lineWidth = 6;
			path.stroke();
		
		}
		
		
    }


}
