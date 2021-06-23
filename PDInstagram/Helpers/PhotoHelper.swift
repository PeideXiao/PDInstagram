//
//  PhotoHelper.swift
//  PDInstagram
//
//  Created by User on 6/23/21.
//

import UIKit
import Photos

class PhotoHelper: NSObject {
    
    var completionHandler: ((UIImage)->())?
    
    func presentActionSheet(from viewController: UIViewController) {
        let controller = UIAlertController(title: nil, message: "Where do you want to get your picture from?", preferredStyle: UIAlertController.Style.actionSheet)
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            let takePhotoAction = UIAlertAction(title: "Take Photo", style: UIAlertAction.Style.default) { action in
                self.presentImagePickerController(with: .camera, from: viewController)
            }
            controller.addAction(takePhotoAction)
        }
        
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let albumAction = UIAlertAction(title: "Photo Library", style: UIAlertAction.Style.default) { _ in
                self.presentImagePickerController(with: .photoLibrary, from: viewController)
            }
            controller.addAction(albumAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { _ in
            
        }
        
        
        
        controller.addAction(cancelAction)
        viewController.present(controller, animated: true, completion: nil)
    }
    
    func presentImagePickerController(with type: UIImagePickerController.SourceType, from viewController: UIViewController) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = type
        imagePickerController.delegate = self
        viewController.present(imagePickerController, animated: true, completion: nil)
    }
    
}

extension PhotoHelper: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            assertionFailure("Error: image is null")
            return
        }
        completionHandler?(image)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
