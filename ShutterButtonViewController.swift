//
//  ShutterButtonViewController.swift
//  AVCam Swift
//
//  Created by Steven Traversi on 7/27/17.
//  Copyright © 2017 Steven Traversi. All rights reserved.
//

import UIKit
import KYShutterButton
import Cartography

class ShutterButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                
        // Set up the center shutter button
        mainShutterButton = KYShutterButton()
        self.view.addSubview(mainShutterButton)
        mainShutterButton.shutterType = .normal
        mainShutterButton.buttonColor = .white
        constrain(mainShutterButton, self.view) { button, superview in
            button.centerX == superview.centerX
            button.width == 60.0
            button.height == 60.0
            button.centerY == superview.centerY
        }
        mainShutterButton.addTarget(self, action: #selector(didTapMainShutter(_:)), for: .touchUpInside)
        
        // Set up the smaller side shutter button
        sideShutterButton = KYShutterButton()
        self.view.addSubview(sideShutterButton)
        sideShutterButton.shutterType = .normal
        sideShutterButton.buttonColor = .white
        constrain(sideShutterButton, self.view) { button, superview in
            button.left == superview.left + 20.0
            button.width == 50.0
            button.height == 50.0
            button.centerY == superview.centerY
        }
        sideShutterButton.addTarget(self, action: #selector(didTapSideShutter(_:)), for: .touchUpInside)
        sideShutterButton.setNeedsLayout()
    }
    
    // Big shutter button
    private var mainShutterButton: KYShutterButton!
    
    // Smaller shutter button for capturing photos while recording video
    private var sideShutterButton: KYShutterButton!
    
    private dynamic func didTapMainShutter(_ sender: KYShutterButton) {
        switch currentCaptureMode {
        case .photo:
            takePhoto()
        case .movie:
            toggleRecord()
        }
    }
    private dynamic func didTapSideShutter(_ sender: KYShutterButton) {
        switch currentCaptureMode {
        case .photo:
            print("! WARNING: side shutter tapped while in photo mode.")
        case .movie:
            takePhoto()
        }
    }
    
    private var currentCaptureMode: CaptureMode = .photo
    
    // MARK: exposed functions
    
    // Parent controller should set this
    public var takePhoto: () -> () = { return }
    
    // Parent controller should set this
    public var toggleRecord: () -> () = { return }
    
    public func setMode(mode: CaptureMode) {
        /*
         Change the appearance of this view, including the hidden attributes
         and visual order of shutter buttons.
         */
        switch mode {
        case .photo:
            currentCaptureMode = .photo
            // switch the UI to photo mode
            mainShutterButton.buttonColor = .white
            mainShutterButton.buttonState = .normal
            sideShutterButton.isHidden = true
        case .movie:
            currentCaptureMode = .movie
            // switch the UI to movie mode
            mainShutterButton.buttonColor = .red
            sideShutterButton.isHidden = false
        }
    }
    
    public func setPhotoButtonEnabled(_ isEnabled: Bool) {
        // update button availability to reflect this change
        switch currentCaptureMode {
        case .photo:
            mainShutterButton.isEnabled = isEnabled
        case .movie:
            sideShutterButton.isEnabled = isEnabled
        }
    }
    
    public func setMovieButtonEnabled(_ isEnabled: Bool) {
        // update button availability to reflect this change
        switch currentCaptureMode {
        case .photo:
            if isEnabled {
                print("! WARNING: movie button enabled while in photo mode")
            }
        case .movie:
            mainShutterButton.isEnabled = isEnabled
        }
    }
    
    public func setMovieButtonRecording(_ isRecording: Bool) {
        // update the button appearance
        if isRecording {
            mainShutterButton.buttonState = .recording
        } else {
            mainShutterButton.buttonState = .normal
        }
    }

}
