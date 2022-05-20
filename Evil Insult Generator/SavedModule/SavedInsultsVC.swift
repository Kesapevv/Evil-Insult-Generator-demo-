//
//  SavedInsultsVC.swift
//  Evil Insult Generator
//
//  Created by Vadim Voronkov on 15.05.2022.
//

import UIKit
import SnapKit

class SavedInsultsVC: UIViewController {
    
    //MARK: - Properties
    
    private enum Constraints {
        static let insultsViewWidth = 360
        static let insultsViewHeight = 502
        static let insultsViewHorizontal = 10
        
        static let backButtonTop = 16.73
        static let backDeleteButtonHorizontal = 12.3
        
        static let insultLabelTop = 142
        static let insultLabelBottom = 200
        static let insultLabelHorizontal = 8
        
        static let shareButtonTop = 319
        static let shareButtonWidthHeight = 100
        
        static let previousNextHorizontal = 18
        static let previousButtonNextButtonTop = 349
        static let previousButtonNextButtonHightWeight = 70
    }
    
    private enum Constants {
        static let cornerRadius = 16
    }
    
    var presenter: SavedViewPresenterProtocol?
    
    
    //MARK: - Views
    
    private var backgroundImageView = UIImageView.setBackgroundImage(image: "library")
    
    private var insultView = UIView()
    
    private var nextLabel = UILabel()
    private var backLabel = UILabel()
    private var shareLabel = UILabel()
    private var insultLabel = UILabel.insultString()
    
    private var backButton = UIButton(type: .system)
    private var deleteButton = UIButton(type: .system)
    private var shareButton = UIButton(type: .roundedRect)
    private var nextInsultButton = UIButton(type: .roundedRect)
    private var backInsultButton = UIButton(type: .roundedRect)
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        self.setupImages()
        self.setupLayout()
        self.setupData()
    }
    
    //MARK: - Methods
    
    private func setupLayout() {
        self.setupViews()
        self.setupButtons()
        self.setupLabels()
    }
    
    private func setupData() {
        self.setupViewData()
        self.setupButtonsData()
        self.setupLabelsData()
    }
    
    //MARK: - Images
    
    private func setupImages() {
        self.view.addSubview(self.backgroundImageView)
        self.backgroundImageView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    //MARK: - Views
    
    private func setupViews() {
        self.view.addSubview(self.insultView)
        self.insultView.snp.makeConstraints { make in
            make.height.equalTo(Constraints.insultsViewHeight)
            make.width.equalTo(Constraints.insultsViewWidth)
            make.centerY.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Constraints.insultsViewHorizontal)
        }
    }
    
    private func setupViewData() {
        self.insultView.backgroundColor = Colors.whiteBackground.value
        self.insultView.layer.cornerRadius = CGFloat(Constants.cornerRadius)
    }
    
    //MARK: - Labels
    
    private func setupLabels() {
        self.insultView.addSubview(self.insultLabel)
        self.insultLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constraints.insultLabelTop)
            make.bottom.equalToSuperview().inset(Constraints.insultLabelBottom)
            make.leading.trailing.equalToSuperview().inset(Constraints.insultLabelHorizontal)
        }
        
        self.insultView.addSubview(self.shareLabel)
        self.shareLabel.snp.makeConstraints { make in
            make.top.equalTo(self.shareButton.snp.bottom)
            make.centerX.equalTo(self.shareButton)
        }
        
        self.insultView.addSubview(self.backLabel)
        self.backLabel.snp.makeConstraints { make in
            make.top.equalTo(self.backInsultButton.snp.bottom)
            make.centerX.equalTo(self.backInsultButton)
        }
        
        self.insultView.addSubview(self.nextLabel)
        self.nextLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nextInsultButton.snp.bottom)
            make.centerX.equalTo(self.nextInsultButton)
        }
    }
    
    private func setupLabelsData() {
        if self.presenter?.insults.savedInsultsData.isEmpty == true {
            self.insultLabel.text = "no insults"
        } else {
            self.insultLabel.text = self.presenter?.insults.savedInsultsData[0].insult
        }
        
        self.backLabel.text = "Back"
        self.backLabel.font = AppFonts.regular15.font
        
        self.nextLabel.text = "Next"
        self.nextLabel.font = AppFonts.regular15.font
        
        self.shareLabel.text = "Share"
        self.shareLabel.font = AppFonts.regular15.font
    }
    
    //MARK: - Buttons
    
    private func setupButtons() {
        self.insultView.addSubview(self.backButton)
        self.backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        self.backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Constraints.backDeleteButtonHorizontal)
            make.top.equalToSuperview().inset(Constraints.backButtonTop)
        }
        
        self.insultView.addSubview(self.deleteButton)
        self.deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        self.deleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Constraints.backDeleteButtonHorizontal)
            make.top.equalToSuperview().inset(Constraints.backButtonTop)
        }
        
        self.insultView.addSubview(self.shareButton)
        self.shareButton.addTarget(self, action: #selector(self.shareInsultAction), for: .touchUpInside)
        self.shareButton.snp.makeConstraints { make in
            make.top.equalTo(self.insultView.snp.top).inset(Constraints.shareButtonTop)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(Constraints.shareButtonWidthHeight)
        }
        
        self.insultView.addSubview(self.backInsultButton)
        self.backInsultButton.addTarget(self, action: #selector(self.previousInsultAction), for: .touchUpInside)
        self.backInsultButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constraints.previousButtonNextButtonTop)
            make.leading.equalToSuperview().inset(Constraints.previousNextHorizontal)
            make.height.width.equalTo(Constraints.previousButtonNextButtonHightWeight)
        }
        
        self.insultView.addSubview(self.nextInsultButton)
        self.nextInsultButton.addTarget(self, action: #selector(self.nextInsultAction), for: .touchUpInside)
        self.nextInsultButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constraints.previousButtonNextButtonTop)
            make.trailing.equalToSuperview().inset(Constraints.previousNextHorizontal)
            make.height.width.equalTo(Constraints.previousButtonNextButtonHightWeight)
        }
    }
    
    private func setupButtonsData() {
        self.backButton.tintColor = .black
        self.backButton.setImage(UIImage(named: "arrow.left"), for: .normal)
        
        self.deleteButton.tintColor = .black
        self.deleteButton.setImage(UIImage(named: "xmark.bin"), for: .normal)
        
        self.backInsultButton.tintColor = .black
        self.backInsultButton.setImage(UIImage(named: "backward"), for: .normal)
        
        self.shareButton.tintColor = .black
        self.shareButton.setImage(UIImage(named: "location"), for: .normal)
        
        self.nextInsultButton.tintColor = .black
        self.nextInsultButton.setImage(UIImage(named: "forward"), for: .normal)
    }
    
    
    //MARK: - Actions
    
    @objc func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteButtonAction() {
        self.presenter?.deleteInsult()
        if self.presenter?.index == 0 && self.presenter?.insults.savedInsultsData.isEmpty == false {
            self.insultLabel.text = self.presenter?.nextInsult()
        } else if self.presenter?.index == 0 && self.presenter?.insults.savedInsultsData.isEmpty == true {
            self.insultLabel.text = "no insults"
        } else if self.presenter!.index > 0 {
            self.insultLabel.text = self.presenter?.previousInsult()
        }
    }
    
    @objc func shareInsultAction() {
        self.presenter?.shareInsult(vc: self, currentInsult: self.insultLabel.text ?? "Error")
    }
    
    @objc func previousInsultAction() {
        if self.presenter?.insults.savedInsultsData.isEmpty == false {
            self.insultLabel.text = self.presenter?.previousInsult()
        } else {
            self.insultLabel.text = "no insults"
        }
    }
    
    @objc func nextInsultAction() {
        if self.presenter?.insults.savedInsultsData.isEmpty == false {
            self.insultLabel.text = self.presenter?.nextInsult()
        } else {
            self.insultLabel.text = "no insults"
        }
        
    }
    
}


extension SavedInsultsVC: SavedViewProtocol {
    
}
