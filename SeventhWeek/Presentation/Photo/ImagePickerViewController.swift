//
//  ImagePickerViewController.swift
//  SeventhWeek
//
//  Created by BAE on 2/4/25.
//

import UIKit

import SnapKit

class ImagePickerViewController: BaseViewController {

    let pickerButton = UIButton()
    let photoImageView = UIImageView()
    let imagePicker = UIImagePickerController()
    let backgoundImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configDelegate() {
        imagePicker.delegate = self
    }
    
    override func configView() {
        view.backgroundColor = .systemBackground
        view.addSubview(backgoundImage)
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
        
        backgoundImage.alpha = 0.3
        backgoundImage.contentMode = .scaleAspectFill
        photoImageView.backgroundColor = .systemRed
        pickerButton.configuration = UIButton.Configuration.filled()
        pickerButton.configuration?.title = "앨범"
        
        pickerButton.addAction(UIAction(handler: { [self] _ in
//            let imagePicker = UIFontPickerViewController()
//            let imagePicker = UIColorPickerViewController()
//            let imagePicker = UIDocumentPickerViewController()
//            let imagePicker = UIActivityViewController(activityItems: [], applicationActivities: [])
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            print(pickerButton, "\(pickerButton.description)")
            present(imagePicker, animated: true)
        }), for: .touchUpInside)
    }
        
}

extension ImagePickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function, "selected")
        backgoundImage.image = info[.originalImage] as! UIImage
        if let result = info[.editedImage] as? UIImage {
            photoImageView.snp.remakeConstraints {
                $0.horizontalEdges.equalToSuperview()
                $0.height.equalTo(view.frame.width / 2.3)
                $0.center.equalToSuperview()
            }
            photoImageView.image = result
        }
        photoImageView.image = info[.originalImage] as? UIImage
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function, "취소!!취소!!취소!!취소!!취소!!취소!!취소!!취소!!")
        dismiss(animated: true)
    }
}
