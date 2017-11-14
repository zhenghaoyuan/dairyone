//
//  cameraViewController.swift
//  Dairy One
//
//  Created by 郑 on 2017/11/10.
//  Copyright © 2017年 haoyuan. All rights reserved.
//

import UIKit
import AVFoundation
// The customize camera. can only recording video.
class cameraViewController: UIViewController,
//AVCaptureVideoDataOutputDelegate{
AVCaptureFileOutputRecordingDelegate {
	
	
	let captureSession = AVCaptureSession();
	var previewLayer:CALayer!;
	var movieFileOutput = AVCaptureMovieFileOutput();
	var captureDevice:AVCaptureDevice!;
	var record = false;
	
	@IBOutlet weak var tapCircle: UIButton!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated);
		self.navigationController?.isNavigationBarHidden = true;
		self.tabBarController?.tabBar.isHidden = true;
		prepareCamera();
	}
	
	func prepareCamera(){
		//set the captureSession
		captureSession.sessionPreset = AVCaptureSession.Preset.high
		//set the available input devices, including
		// audio and video input
		let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes:[.builtInWideAngleCamera],mediaType:AVMediaType.video,position:.front).devices
		
		captureDevice = availableDevices.first;
		do {
			let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
				captureSession.addInput(captureDeviceInput)
			
		}catch{
			print(error.localizedDescription)
		}
		do {
			let audioDevice = AVCaptureDevice.default(for: .audio)
			let audioDeviceInput = try AVCaptureDeviceInput(device: audioDevice!)
			
			if captureSession.canAddInput(audioDeviceInput) {
				captureSession.addInput(audioDeviceInput)
			} else {
				print("Could not add audio device input to the session")
			}
		} catch {
			print("Could not create audio device input: \(error)")
		}
		beginSession()
	}
	
	func beginSession() {
		// preview layer
		let preview = AVCaptureVideoPreviewLayer(session: captureSession)
		preview.videoGravity = AVLayerVideoGravity.resizeAspectFill;
		preview.connection?.videoOrientation = AVCaptureVideoOrientation.portrait;
		self.previewLayer = preview;
		self.view.layer.insertSublayer(preview, at: 0);
		self.previewLayer.frame = self.view.layer.frame
		captureSession.startRunning()
		//data output
//		let dataOutput = AVCaptureVideoDataOutput()
//		dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String) : NSNumber(value:kCVPixelFormatType_32BGRA)]
//		if captureSession.canAddOutput(dataOutput) {
//			captureSession.addOutput(dataOutput)
//		}
		captureSession.addOutput(movieFileOutput);
		if let videoOutput = self.movieFileOutput.connection(with: .video) {
			videoOutput.videoOrientation = AVCaptureVideoOrientation.portrait;
			print("I have set the video orientation");
			
		}
		
		captureSession.commitConfiguration();
//		let queue = DispatchQueue(label:"haoyuan")
//		dataOutput.setSampleBufferDelegate(self, queue: queue)
		
	}
	
	func stopRecording() {
		print("stopping");
		self.movieFileOutput.stopRecording();
		
		
		
	}
	//start recording the video, and store the video into the gallery first
	func startRecording() {
		captureSession.startRunning()
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		let fileUrl = paths[0].appendingPathComponent("output.mov")
		try? FileManager.default.removeItem(at: fileUrl)
		
		movieFileOutput.startRecording(to: fileUrl, recordingDelegate: self)
		//let delayTime = DispatchTime.now() + 10
		//DispatchQueue.main.asyncAfter(deadline: delayTime) {
		//	print("stopping");
		//	self.movieFileOutput.stopRecording();
		//}
	}
	
	//,after finishing record,
	func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
		print("FINISHED")
		if error == nil {
			UISaveVideoAtPathToSavedPhotosAlbum(outputFileURL.path, nil, nil, nil);
		}
		//change the viewcontroller back to the library view, and catch the thunbnail of the video
		let asset = AVURLAsset(url: outputFileURL, options: nil)
		let imgGenerator = AVAssetImageGenerator(asset: asset)
		do{
			let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
			let uiImage = UIImage(cgImage: cgImage);
			print(uiImage);
			//let imageView = UIImageView(image: uiImage)
			photoDB.sharedInstance.photo.append(uiImage);
			photoDB.sharedInstance.rotation.append(false);
			presentingViewController?.dismiss(animated: true, completion: nil);
			print("give a value to the image");
		}catch {
			print("error in generating thumbnail of image");
		}
		// !! check the error before proceeding
		
		
		
	}
	//tap the button, add some animation to it.
	@IBAction func tapButton(_ sender: Any) {
		if record == false {
		UIView.animate(withDuration: 0.2,animations: {
			self.tapCircle.backgroundColor = .red
		}
		, completion: nil)
			record = true;
		startRecording();
		}
		else if record == true {
			UIView.animate(withDuration: 0.2,animations: {
				self.tapCircle.backgroundColor = .white
			}
				, completion: nil)
			record = false;
			stopRecording();
			
		}
		
		
	}
	//	func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//		if takephoto {
//			takephoto = false;
//			//getImagefromSampleBuffer
//			if let image = self.getImagefromSampleBuffer(buffer: sampleBuffer){
//				let photoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoVC") as! PhotoViewController
//				photoVC.takenPhoto = image
//				DispatchQueue.main.async {
//					self.present(photoVC, animated: true, completion:{
//						self.stopCaptureSession();
//
//					})
//
//				}
//			}
//
//		}
//	}
//
//	func getImagefromSampleBuffer (buffer: CMSampleBuffer) -> UIImage?{
//		if let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) {
//			let ciImage = CIImage(cvPixelBuffer:pixelBuffer)
//			let context = CIContext()
//
//			let imageRect = CGRect(x:0,y:0,width:CVPixelBufferGetWidth(pixelBuffer),height:
//				CVPixelBufferGetHeight(pixelBuffer))
//			if let image = context.createCGImage(ciImage, from: imageRect) {
//				return UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .right)
//
//			}
//
//		}
//		return nil
//
//	}
	
//	func stopCaptureSession() {
//		self.captureSession.stopRunning();
//		if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
//			for input in inputs {
//				self.captureSession.removeInput(input);
//			}
//		}
//
//	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}
