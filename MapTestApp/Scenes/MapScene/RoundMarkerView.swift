//
//  CustomMarkerView.swift
//  MapTestApp
//
//  Created by Artem on 26.12.2020.
//

import UIKit

class RoundMarkerView: UIView {
    
    var imageName: String?
    var borderColor: UIColor?
    
    init(frame: CGRect, imageName: String?, borderColor: UIColor) {
        super.init(frame: frame)
        self.imageName = imageName
        self.borderColor = borderColor
        setupViews()
    }
    
    func setupViews() {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imgView)
        imgView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imgView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imgView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imgView.layer.cornerRadius = frame.width / 2
        imgView.layer.borderColor = borderColor?.cgColor
        imgView.contentMode = .scaleAspectFill
        imgView.layer.borderWidth = 2
        imgView.clipsToBounds = true
        imgView.image = UIImage(named: imageName ?? "")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
