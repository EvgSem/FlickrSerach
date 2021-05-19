import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    lazy var photoView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(photoView)
        
        photoView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 3).isActive = true
        photoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -3).isActive = true
        photoView.widthAnchor.constraint(equalTo: photoView.heightAnchor).isActive = true
        photoView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    }
    
    func configure(photoModel: PhotoModel){
        guard let url = photoModel.pictureUrl as? URL else {
            return
        }
        photoView.load(url: url)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
