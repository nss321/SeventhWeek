//
//  BasicPHPickerVIewController.swift
//  SeventhWeek
//
//  Created by BAE on 2/4/25.
//

import UIKit
import PhotosUI

class BasicPHPickerVIewController: BaseViewController {
    
    let backgoundImage = UIImageView()
    let pickerButton = UIButton()
    let photoImageView = UIImageView()
    var selectedImage = UIImage() {
        didSet {
            if let _ = selectedImage.images {
                view.backgroundColor = .white
            } else {
                view.backgroundColor = .black
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configDelegate() {
        
    }
    
    override func configView() {
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect, style: .fill)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        
        view.addSubview(backgoundImage)
        view.addSubview(blurView)
        blurView.contentView.addSubview(vibrancyView)
        view.addSubview(photoImageView)
        view.addSubview(pickerButton)
            
        photoImageView.snp.makeConstraints {
            $0.size.equalTo(300)
            $0.center.equalToSuperview()
        }
        
        pickerButton.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.height.equalTo(50)
            $0.top.equalTo(photoImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        backgoundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
//        backgoundImage.alpha = 0.3
        backgoundImage.contentMode = .scaleAspectFill
        photoImageView.backgroundColor = .systemRed
        pickerButton.configuration = UIButton.Configuration.filled()
        pickerButton.configuration?.title = "앨범"
        
        pickerButton.addAction(UIAction(handler: { [self] _ in
            
            var config = PHPickerConfiguration()
//            config.filter = .images
            config.filter = .any(of: [.screenshots, .images])
            config.selectionLimit = 3
            config.mode = .default
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
            present(picker, animated: true)
            
            print(#function)
        }), for: .touchUpInside)
    }
}

extension BasicPHPickerVIewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        if let itemProvider = results.first?.itemProvider {
            print("1", Thread.isMainThread)
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                print("2", Thread.isMainThread)
                itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    print("3", Thread.isMainThread)
                    DispatchQueue.main.async {
                        print("4", Thread.isMainThread)
                        self.backgoundImage.image = image as? UIImage
                        self.photoImageView.image = image as? UIImage
                    }
                }
            }
        }
        
        
        dismiss(animated: true)
    }
    
    
    
}
