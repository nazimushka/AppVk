//
//  GroupCell.swift
//  project1
//
//  Created by Алекс Фитнес on 27.08.2023.
//

import UIKit

class GroupCell: UITableViewCell{
    
    private let image : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person")
        return image
    }()
    
    private let groupNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Name"
        label.textAlignment = .center
        label.backgroundColor = .blue
        label.textColor = .white
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Description"
        label.textAlignment = .center
        label.backgroundColor = .blue
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(image)
        contentView.addSubview(groupNameLabel)
        contentView.addSubview(descriptionLabel)
        myConstr()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func updateCell(model: Group) {
        groupNameLabel.text = model.name
        descriptionLabel.text = model.description
        DispatchQueue.global().async {
            if let url = URL(string: model.photo ?? ""), let data = try?Data(contentsOf: url)
            {
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
            }
        }
    }
    
    private func myConstr(){
        image.translatesAutoresizingMaskIntoConstraints = false
        groupNameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            image.heightAnchor.constraint(equalToConstant: 40),
            image.widthAnchor.constraint(equalTo: image.heightAnchor),
            
            groupNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            groupNameLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 20),
            groupNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: groupNameLabel.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: groupNameLabel.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: groupNameLabel.rightAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
    }
}

