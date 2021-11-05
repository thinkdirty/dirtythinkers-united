//
//  CameraView.swift
//  Chewhuahua
//
//  Created by Pavel Uvarov on 2021-11-05.
//

import AVFoundation
import Foundation
import UIKit

class CameraView: UIView {
	
	var previewLayer: AVCaptureVideoPreviewLayer?
	
	override public func layoutSubviews() {
		super.layoutSubviews()
		if let previewLayer = self.previewLayer  {
			previewLayer.frame = self.bounds
		}
	}
}
