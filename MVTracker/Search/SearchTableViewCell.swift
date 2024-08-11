//
//  SearchTableViewCell.swift
//  MVTracker
//
//  Created by NERO on 8/8/24.
//

import UIKit
import Kingfisher
import RxSwift
import SnapKit
import Then

final class SearchTableViewCell: UITableViewCell {
    static let identifier = "SearchTableViewCell"
    var disposeBag = DisposeBag()
    
    let musicVideoImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .systemPink.withAlphaComponent(0.7)
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    let titleLabel = UILabel().then {
        $0.text = "  White Noise  " //임시
        $0.textColor = .systemPink
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }
    let artistLabel = UILabel().then {
        $0.text = "- OFFICIAL HIGE DANDISM" //임시
        $0.textColor = .systemGray4
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 15, weight: .medium)
    }
    let timeLabel = UILabel().then {
        $0.text = "4:14" //임시
        $0.textColor = .white
        $0.textAlignment = .right
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }
    let likeButton = UIButton().then {
        $0.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        $0.layer.cornerRadius = 16
        $0.tintColor = .systemPink.withAlphaComponent(0.5)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

extension SearchTableViewCell {
    func setupData(_ data: MusicInfo) {
        titleLabel.text = "  \(data.trackName)  "
        artistLabel.text = "- \(data.artistName)"
        timeLabel.text = "\(data.trackTimeMillis)"
        let url = URL(string: data.artworkUrl100)
        musicVideoImageView.kf.setImage(with: url)
    }
    func setupLikeButton(_ isLike: Bool) {
        let imageName = isLike ? "hand.thumbsup.fill" : "hand.thumbsup"
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
        likeButton.tintColor = isLike ? .systemPink : .systemPink.withAlphaComponent(0.5)
    }
    
    private func configureView() {
        self.selectionStyle = .none
        
        [musicVideoImageView, artistLabel, likeButton].forEach { contentView.addSubview($0) }
        [titleLabel, timeLabel].forEach { musicVideoImageView.bringSubviewToFront($0) }
        
        musicVideoImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(contentView).inset(20)
            $0.height.equalTo(200)
        }
        artistLabel.snp.makeConstraints {
            $0.centerY.equalTo(likeButton).offset(2)
            $0.leading.equalTo(contentView).inset(30)
            $0.trailing.equalTo(likeButton.snp.leading).offset(-10)
        }
        likeButton.snp.makeConstraints {
            $0.top.equalTo(musicVideoImageView.snp.bottom).offset(5)
            $0.trailing.equalTo(contentView).inset(25)
            $0.size.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalTo(musicVideoImageView).inset(12)
            $0.height.equalTo(24)
        }
        timeLabel.snp.makeConstraints {
            $0.bottom.trailing.equalTo(musicVideoImageView).inset(12)
        }
    }
}
