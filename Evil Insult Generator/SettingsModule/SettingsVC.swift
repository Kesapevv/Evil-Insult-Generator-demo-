//
//  SettingsViewController.swift
//  Evil Insult Generator
//
//  Created by Vadim Voronkov on 13.05.2022.
//

import UIKit

final class SettingsVC: UIViewController {
    
    //MARK: - Properties
    
    private enum Constraints {
        static let settingsViewWidth = 360
        static let settingsViewHeight = 502
        static let settingsViewHorizontal = 10
        
        static let backButtonTop = 16.73
        static let backButtonLeading = 12.3
        
        static let rateUsButtonTop = 241.94
        static let offNoticeButtonTop = 335.16
        static let offNoticeButtonBottom = 127
        static let savedInsultButtonTop = 142.74
    }
    
    private enum Constants {
        static let cornerRadius = 16
    }
    
    var presenter: SettingsViewPresenterProtocol?
    
    //MARK: - Views
    
    private var backgroundImageView = UIImageView.setBackgroundImage(image: BackgroundImage.chooseDayImage())
    
    private var settingsView = UIView()
    
    private var backButton = UIButton(type: .system)
    private var rateUsButton = UIButton(type: .system)
    private var noticeButton = UIButton(type: .system)
    private var savedInsultsButton = UIButton(type: .system)
    
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
    }
    
    private func setupData() {
        self.setupViewData()
        self.setupButtonsData()
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
        self.view.addSubview(self.settingsView)
        self.settingsView.snp.makeConstraints { make in
            make.height.equalTo(Constraints.settingsViewHeight)
            make.width.equalTo(Constraints.settingsViewWidth)
            make.centerY.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Constraints.settingsViewHorizontal)
        }
    }
    
    private func setupViewData() {
        self.settingsView.backgroundColor = AppViews.chooseViewColor()
        self.settingsView.layer.cornerRadius = CGFloat(Constants.cornerRadius)
    }
    
    //MARK: - Buttons
    
    private func setupButtons() {
        self.settingsView.addSubview(self.backButton)
        self.backButton.addTarget(self, action: #selector(self.backButtonAction), for: .touchUpInside)
        self.backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Constraints.backButtonLeading)
            make.top.equalToSuperview().inset(Constraints.backButtonTop)
        }
        
        self.settingsView.addSubview(self.savedInsultsButton)
        self.savedInsultsButton.addTarget(self, action: #selector(self.savedInsultsAction), for: .touchUpInside)
        self.savedInsultsButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constraints.savedInsultButtonTop)
            make.centerX.equalToSuperview()
        }
        
        self.settingsView.addSubview(self.rateUsButton)
        self.rateUsButton.addTarget(self, action: #selector(self.rateUsAction), for: .touchUpInside)
        self.rateUsButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constraints.rateUsButtonTop)
            make.centerX.equalToSuperview()
        }
        
        self.settingsView.addSubview(self.noticeButton)
        self.noticeButton.addTarget(self, action: #selector(self.offNoticeAction), for: .touchUpInside)
        self.noticeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constraints.offNoticeButtonTop)
            make.bottom.equalToSuperview().inset(Constraints.offNoticeButtonBottom)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupButtonsData() {
        self.backButton.tintColor = AppColors.chooseStringColor()
        self.backButton.setImage(UIImage(named: "arrow.left"), for: .normal)
        
        self.rateUsButton.tintColor = AppColors.chooseStringColor()
        self.rateUsButton.setTitle("RATE US", for: .normal)
        self.rateUsButton.titleLabel?.font = AppFonts.regular17.font
        self.rateUsButton.setImage(UIImage(named: "heart"), for: .normal)
        
        self.savedInsultsButton.tintColor = AppColors.chooseStringColor()
        self.savedInsultsButton.setTitle("SAVED INSULTS", for: .normal)
        self.savedInsultsButton.titleLabel?.font = AppFonts.regular17.font
        self.savedInsultsButton.setImage(UIImage(named: "magazine"), for: .normal)
        
        self.noticeButton.tintColor = AppColors.chooseStringColor()
        self.noticeButton.setTitle("OFF NOTICE", for: .normal)
        self.noticeButton.titleLabel?.font = AppFonts.regular17.font
        self.noticeButton.setImage(UIImage(named: "bell.slash"), for: .normal)
    }
    
    //MARK: - Actions
    
    @objc func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func rateUsAction() {
        self.presenter?.rateUsAction(vc: self)
    }
    
    @objc func savedInsultsAction() {
        self.presenter?.pushSavedVC()
    }
    
    @objc func offNoticeAction() {
        print("offed")
    }
    
}


extension SettingsVC: SettingsViewProtocol {
    
    func isNotification() -> Bool {
        print("Когда будет известно тру или не тру менять картинку нотифика")
        return true
    }
    
}
