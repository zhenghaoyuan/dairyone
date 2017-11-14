//
//  PhotoViewController.swift
//  Dairy One
//
//  Created by 郑 on 2017/10/29.
//  Copyright © 2017年 haoyuan. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
	var takenPhoto:UIImage? = nil
	
	@IBOutlet weak var myCollectionView: UICollectionView!
	
    override func viewDidLoad() {
		super.viewDidLoad()
		setNavigationBar();
		setLayout();
		//reload the data when any change happens to our database
//		NotificationCenter.default.addObserver(forName: NSNotification.Name(photoDBChangeNotification), object: photoDB.sharedInstance, queue: nil) { (NSNotification) in self.myCollectionView.reloadData() }
	}
	
	func setNavigationBar() {
		self.navigationController?.navigationBar.barTintColor = .black;
		self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont(name: "Didot-Italic", size: 25)!];
		
		
	}
	func setLayout() {
		let itemSize = UIScreen.main.bounds.width/3 - 1;
		let layout = UICollectionViewFlowLayout();
		layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
		layout.itemSize = CGSize(width: itemSize, height: itemSize*1.6);
		layout.minimumLineSpacing = 1;
		layout.minimumInteritemSpacing = 1;
		myCollectionView.collectionViewLayout = layout;
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		print("set new image, in db the image is");
		self.myCollectionView.reloadData();
		
//		if var image = photoDB.sharedInstance.photo[0] {
//
//		self.imageView.image = image
//		imageView.transform = imageView.transform.rotated(by:CGFloat.pi/2);
//		}
		
		

		
	}
	
	//number of view cells in collection view
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return photoDB.sharedInstance.photo.count;
	}
	
	//populate the view
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! photoCell
		cell.myImageView.image = photoDB.sharedInstance.photo[indexPath.row];
		print("haha, I am here, and the indexpath.row here is");
		print(indexPath.row);
		if photoDB.sharedInstance.rotation[indexPath.row] == false {
			cell.myImageView.transform = cell.myImageView.transform.rotated(by:CGFloat.pi/2);
			photoDB.sharedInstance.rotation[indexPath.row] = true;
		}
		return cell;
	}

		
		
	@IBAction func takePhoto(_ sender: Any) {
		let cameraViewController = storyboard?.instantiateViewController(withIdentifier: "cameraVC") as! cameraViewController;
		present(cameraViewController, animated: true, completion: nil);
		
		
		
	}

//	@IBAction func goBack(_ sender: Any) {
//		self.dismiss(animated: true, completion: nil)
//
//	}
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
