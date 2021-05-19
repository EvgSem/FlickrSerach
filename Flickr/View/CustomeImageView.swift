import Foundation
import UIKit

class CustomImageView: UIImageView {
    
    var task: URLSessionTask!
    var spinner = UIActivityIndicatorView()
    
    func load(url: URL) {
        if let task = task {
            task.cancel()
        }
        image = nil
        addSpinner()
        
        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let newImage = UIImage(data: data) else {
                print("could not load image from url: \(url)")
                return
            }
            DispatchQueue.main.async {
                self.image = newImage
                self.removeSpinner()
            }
        }
        task.resume()
    }
    
    func addSpinner(){
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.startAnimating()
        
    }
    func removeSpinner(){
        spinner.removeFromSuperview()
    }
}
