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
import AVFoundation

final class TrackTableViewCell: UITableViewCell {
    static let identifier = "SearchTableViewCell"
    var disposeBag = DisposeBag()
    
    let musicVideoImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .systemPink.withAlphaComponent(0.7)
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    let titleLabel = UILabel().then {
        $0.textColor = .systemPink
//        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.backgroundColor = .white.withAlphaComponent(0.95)
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }
    let artistLabel = UILabel().then {
        $0.textColor = .systemGray
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }
    let timeLabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.backgroundColor = .black.withAlphaComponent(0.3)
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    let likeButton = UIButton().then {
        $0.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        $0.layer.cornerRadius = 16
        $0.tintColor = .systemPink.withAlphaComponent(0.5)
    }
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stopVideo()
        disposeBag = DisposeBag()
    }
}

extension TrackTableViewCell {
    func setupData(_ data: MusicInfo) {
        titleLabel.text = "  \(data.trackName)  "
        artistLabel.text = "- \(data.artistName)"
        timeLabel.text = formatTime(millis: data.trackTimeMillis)
//        let url = URL(string: data.artworkUrl100)
//        musicVideoImageView.kf.setImage(with: url)
        
        if let videoURL = URL(string: data.previewUrl) {
            playVideo(url: videoURL)
        }
    }
    func setupLikeButton(_ isLike: Bool) {
        let imageName = isLike ? "hand.thumbsup.fill" : "hand.thumbsup"
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
        likeButton.tintColor = isLike ? .systemPink : .systemPink.withAlphaComponent(0.5)
    }
    
    private func formatTime(millis: Int) -> String {
        let totalSeconds = millis / 1000
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: " %02d:%02d ", minutes, seconds)
    }
    
    private func playVideo(url: URL) {
        player = AVPlayer(url: url)
        player?.volume = 0 //리소스 정리 테스트 시 주석 처리
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = musicVideoImageView.bounds
        playerLayer?.videoGravity = .resizeAspectFill
        
        if let playerLayer {
            musicVideoImageView.layer.insertSublayer(playerLayer, at: 0)
        }
        player?.play()
    }
    
    func stopVideo() {
        print("stopVideo 실행됨")
        player?.pause()
        player = nil
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
    }
}

extension TrackTableViewCell {
    private func configureView() {
        self.selectionStyle = .none
        
        [musicVideoImageView, artistLabel, likeButton].forEach { contentView.addSubview($0) }
        [titleLabel, timeLabel].forEach { musicVideoImageView.addSubview($0) }
        [titleLabel, timeLabel].forEach { musicVideoImageView.bringSubviewToFront($0) }
        
        musicVideoImageView.snp.makeConstraints {
            $0.top.equalTo(contentView).inset(10)
            $0.top.horizontalEdges.equalTo(contentView).inset(15)
            $0.height.equalTo(220)
        }
        artistLabel.snp.makeConstraints {
            $0.centerY.equalTo(likeButton).offset(2)
            $0.leading.equalTo(contentView).inset(25)
            $0.trailing.equalTo(likeButton.snp.leading).offset(-10)
        }
        likeButton.snp.makeConstraints {
            $0.top.equalTo(musicVideoImageView.snp.bottom).offset(3)
            $0.trailing.equalTo(contentView).inset(20)
            $0.size.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalTo(musicVideoImageView).inset(10)
            $0.height.equalTo(22)
        }
        timeLabel.snp.makeConstraints {
            $0.bottom.trailing.equalTo(musicVideoImageView).inset(12)
            $0.height.equalTo(20)
        }
    }
}
