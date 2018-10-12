//
//  ViewController.swift
//  photoPickerAndCamera
//
//  Created by Lohen Yumnam on 12/10/18.
//  Copyright © 2018 Lohen Yumnam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return imageView
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Photo", for: UIControl.State.normal)
        button.setTitleColor(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), for: UIControl.State.normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
    }
    
    func setupUI(){
        self.view.addSubview(image)
        image.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
        image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        
        
        self.view.addSubview(addButton)
        addButton.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 50).isActive = true
        addButton.centerXAnchor.constraint(equalTo: image.centerXAnchor, constant: 0).isActive = true
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: UIControl.Event.touchUpInside)
    }

    
    @objc func addButtonTapped(){
        print("Button Tapped")
        photosButtonTapped()
    }
    
    
    func photosButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
                action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true,
                             completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "photo library", style: .default, handler: {
                action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true,
                             completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        
        present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image.image = selectedImage
            dismiss(animated: true, completion: nil)
        }
    }
}

