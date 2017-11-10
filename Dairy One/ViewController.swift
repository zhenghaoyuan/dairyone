//
//  ViewController.swift
//  Dairy One
//
//  Created by 郑 on 2017/10/29.
//  Copyright © 2017年 haoyuan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate {
	let captureSession = AVCaptureSession();
	var previewLayer:CALayer!;
	
	var captureDevice:AVCaptureDevice!;
	var takephoto = false;

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		prepareCamera();
		
		
	}
	
	func prepareCamera(){
		captureSession.sessionPreset = AVCaptureSession.Preset.photo
		
		let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes:[.builtInWideAngleCamera],mediaType:AVMediaType.video,position:.front).devices
		
		captureDevice = availableDevices.first;
		beginSession()
	}
	
	func beginSession() {
		do {
			let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
			captureSession.addInput(captureDeviceInput)
			
		}catch{
			print(error.localizedDescription)
		}
		let preview = AVCaptureVideoPreviewLayer(session: captureSession)
		self.previewLayer = preview;
		self.view.layer.addSublayer(self.previewLayer)
		self.previewLayer.frame = self.view.layer.frame
		captureSession.startRunning()
		
		let dataOutput = AVCaptureVideoDataOutput()
		dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String) : NSNumber(value:kCVPixelFormatType_32BGRA)]
		if captureSession.canAddOutput(dataOutput) {
			captureSession.addOutput(dataOutput)
			
		}
		captureSession.commitConfiguration()
		
		let queue = DispatchQueue(label:"haoyuan")
		dataOutput.setSampleBufferDelegate(self, queue: queue)
	
	}
	
	@IBAction func takePhoto(_ sender: Any) {
		takephoto = true;
		
	}
	func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
		if takephoto {
			takephoto = false;
			//getImagefromSampleBuffer
			if let image = self.getImagefromSampleBuffer(buffer: sampleBuffer){
				let photoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoVC") as! PhotoViewController
				photoVC.takenPhoto = image
				DispatchQueue.main.async {
					self.present(photoVC, animated: true, completion: nil)
					
				}
			}
			
		}
	}
	
	func getImagefromSampleBuffer (buffer: CMSampleBuffer) -> UIImage?{
		if let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) {
			let ciImage = CIImage(cvPixelBuffer:pixelBuffer)
			let context = CIContext()
			
			let imageRect = CGRect(x:0,y:0,width:CVPixelBufferGetWidth(pixelBuffer),height:
			CVPixelBufferGetHeight(pixelBuffer))
			if let image = context.createCGImage(ciImage, from: imageRect) {
				return UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .right)
				
			}
			
		}
		return nil
		
	}
	

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

