//
//  ViewController.swift
//  Dairy One
//
<<<<<<< HEAD
//  Created by 郑 on 2017/10/29.
=======
//  Created by 郑 on 2017/10/28.
>>>>>>> dc47423d36a5fbdab9c5f8ba6dc01391ef4d5f9b
//  Copyright © 2017年 haoyuan. All rights reserved.
//

import UIKit
<<<<<<< HEAD
import AVFoundation

class ViewController: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate {
	let captureSession = AVCaptureSession();
	var previewLayer:CALayer!;
	
	var captureDevice:AVCaptureDevice!;
	var takephoto = false;
=======

class ViewController: UIViewController {
>>>>>>> dc47423d36a5fbdab9c5f8ba6dc01391ef4d5f9b

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
<<<<<<< HEAD
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
	
	func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
		<#code#>
	}
	

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
=======
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		
>>>>>>> dc47423d36a5fbdab9c5f8ba6dc01391ef4d5f9b
		// Dispose of any resources that can be recreated.
	}


}

