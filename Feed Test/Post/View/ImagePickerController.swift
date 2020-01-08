//
//  ImagePickerController.swift
//  Feed Test
//
//  Created by Eli Pacheco Hoyos on 8/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import UIKit


class ImagePickerController: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    typealias ImageResult = (image: UIImage?, error: Error?)
    typealias ImageResultOperation = (ImageResult) -> Void
    var result: ImageResultOperation?

    func pickImage(from viewController: UIViewController, _ result: @escaping ImageResultOperation) {
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera(from: viewController)
        }
        
        let galleryAction = UIAlertAction(title: "Gallery", style: .default){
            UIAlertAction in
            self.openGallery(from: viewController)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }

        // Add the actions
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = viewController.view
        
        self.result = result
        
        viewController.present(alert, animated: true, completion: nil)
    }
    func openCamera(from viewController: UIViewController) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            let alert = UIAlertController(title:"Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
            viewController.present(alert, animated: true)
            return
        }
        
        let picker: UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        viewController.present(picker, animated: true, completion: nil)
    }
    func openGallery(from viewController: UIViewController) {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        viewController.present(picker, animated: true, completion: nil)
    }


    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            result?((image, nil))
        } else {
            result?((nil, info.createError()))
        }
        
    }

    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
        assertionFailure("Not implemented yet")
    }

}

private extension Dictionary where Key == UIImagePickerController.InfoKey {
    
    func createError(with domain: String = "", code: Int = 0) -> Error {
        var errorDict: [String: Any] = [:]
        
        forEach {
            errorDict[$0.key.rawValue] = $0.value
        }
        
        return NSError(domain: domain, code: code, userInfo: errorDict)
    }
    
}
