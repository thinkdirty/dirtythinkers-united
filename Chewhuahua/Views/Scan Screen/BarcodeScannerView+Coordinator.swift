//
//  BarcodeScannerView+Coordinator.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import AVFoundation
import Foundation
import SwiftUI
import Vision

extension BarcodeScannerView {
	class Coordinator: NSObject {
		var parent: BarcodeScannerView?
		
		var setupComplete: Bool = false
		
		let captureSession = AVCaptureSession()
		
		let videoDataOutputQueue = DispatchQueue(label: "com.thinkdirtyapp.BarcodeScanner.VideoDataOutputQueue")
		
		init(_ parent: BarcodeScannerView) {
			self.parent = parent
		}
		
		func setupDetection(_ uiView: BarcodeScannerView.UIViewType) {
			if setupComplete { return }
			
			guard AVCaptureDevice.authorizationStatus(for: .video) == .authorized else {
				requestCameraAccess(uiView)
				return
			}
			
			guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back) else {
				NSLog("Unable to use back camera as capture device")
				return
			}
			
			guard let input = try? AVCaptureDeviceInput(device: captureDevice) else {
				NSLog("Unabel to create device input")
				return
			}
			
			if captureSession.canAddInput(input) {
				captureSession.addInput(input)
			}
			
			let videoOutput = AVCaptureVideoDataOutput()
			videoOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
			
			if captureSession.canAddOutput(videoOutput) {
				captureSession.addOutput(videoOutput)
			} else {
				NSLog("Unable to create video output")
				return
			}
			
			setupPreviewLayer(uiView)
			
			captureSession.startRunning()
			
			setupComplete = true
		}
		
		func setupPreviewLayer(_ uiView: BarcodeScannerView.UIViewType) {
			let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
			previewLayer.videoGravity = .resizeAspectFill
			uiView.layer.addSublayer(previewLayer)
			uiView.previewLayer = previewLayer
		}
		
		func requestCameraAccess(_ uiView: BarcodeScannerView.UIViewType) {
			AVCaptureDevice.requestAccess(for: .video) { granted in
				if granted {
					DispatchQueue.main.async {
						self.setupDetection(uiView)
					}
				} else {
					NSLog("Camera access has not been granted!")
				}
			}
		}
		
		func assignResult(_ result: String) {
			guard let parent = self.parent else {
				return
			}
			
			DispatchQueue.main.async {
				parent.barcode = result
			}
		}
	}
}


extension BarcodeScannerView.Coordinator: AVCaptureVideoDataOutputSampleBufferDelegate {
	func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
		guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
			return
		}
		
		let request = VNDetectBarcodesRequest(completionHandler: self.barcodeRequestHandler)
		let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up, options: [:])
		
		do {
			try handler.perform([request])
		} catch {
			NSLog("Error occurred while performing request handler: \(error)")
		}
	}
	
	func barcodeRequestHandler(request: VNRequest, error: Error?) {
		guard let results = request.results as? [VNBarcodeObservation],
			  let payloadStringValue = results.last?.payloadStringValue else {
			return
		}
		assignResult(payloadStringValue)
	}
}

