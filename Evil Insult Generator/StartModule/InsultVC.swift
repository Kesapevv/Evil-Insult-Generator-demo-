//
//  StartViewContoller.swift
//  Evil Insult Generator
//
//  Created by Vadim Voronkov on 12.05.2022.
//

import UIKit
import SnapKit

class InsultVC: UIViewController {
    
    //MARK: - Properties
    
    private enum Constraints {
        static let alertViewWidth = 250
        static let insultViewWidth = 360
        static let alertViewHeight = 125
        static let insultViewHeight = 502
        static let insultAlertViewHorizontal = 10
        
        static let settingButtonTop = 16.73
        static let settingButtonTrailing = 12.3
        
        static let swapButtonTop = 319
        static let swapButtonWidthHeight = 100
        
        static let starLocationHorizontal = 18
        static let starButtonLocationButtonTop = 349
        static let starButtonLocationButtonHightWeight = 70
        
        static let insultLabelTop = 142
        static let insultLabelBottom = 200
        static let insultLabelHorizontal = 8
        
        static let generateInsultLabelTop = 40
        static let generateInsultLabelHorizontal = 5
        
        static let timerLabelTop = 10
        
        static let alertButtonsTop = 90
        static let alertsButtonsHorizontal = 30
    }
    
    private enum Constants {
        static let cornerRadius = 16
    }
    
    var presenter: StartViewPresenterProtocol?
    var coreData: CoreDataManagerProtocol?
    
    //MARK: - View
    
    private var backgroundImageView = UIImageView.setBackgroundImage(image: Images.day)
    
    private var insultView = UIView()
    
    private var saveLabel = UILabel()
    private var swapLabel = UILabel()
    private var sendLabel = UILabel()
    private var insultLabel = UILabel.insultString()
    
    private var saveButton = UIButton(type: .roundedRect)
    private var swapButton = UIButton(type: .roundedRect)
    private var shareButton = UIButton(type: .roundedRect)
    private var settingsButtonImage = UIButton(type: .roundedRect)
    
    //MARK: - Alert View
    
    private var alertView = UIView()
    
    private var timerLabel = UILabel()
    private var generateNewInsultLabel = UILabel()
    
    private var generateNoButton = UIButton(type: .system)
    private var generateYesButton = UIButton(type: .system)
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupImages()
        self.setupLayout()
        self.setupData()
        
        self.alertView.isHidden = true
        self.generateYesButton.isHidden = true
        self.generateNoButton.isHidden = true
        self.generateNewInsultLabel.isHidden = true
        self.timerLabel.isHidden = true
    }
    
    //MARK: - Methods
    
    private func setupLayout() {
        self.setupViews()
        self.setupButtons()
        self.setupLabels()
    }
    
    private func setupData() {
        self.setupViewData()
        self.setupLabelsData()
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
        self.view.addSubview(self.insultView)
        self.insultView.snp.makeConstraints { make in
            make.height.equalTo(Constraints.insultViewHeight)
            make.width.equalTo(Constraints.insultViewWidth)
            make.centerY.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Constraints.insultAlertViewHorizontal)
        }
        
        self.view.addSubview(self.alertView)
        self.alertView.snp.makeConstraints { make in
            make.height.equalTo(Constraints.alertViewHeight)
            make.width.equalTo(Constraints.alertViewWidth)
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func setupViewData() {
        self.insultView.backgroundColor = Colors.whiteBackground.value
        self.insultView.layer.cornerRadius = CGFloat(Constants.cornerRadius)
        
        self.alertView.backgroundColor = Colors.whiteBackground.value
        self.alertView.layer.cornerRadius = CGFloat(Constants.cornerRadius)
    }
    
    //MARK: - Labels
    
    private func setupLabels() {
        self.insultView.addSubview(self.insultLabel)
        self.insultLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constraints.insultLabelTop)
            make.bottom.equalToSuperview().inset(Constraints.insultLabelBottom)
            make.leading.trailing.equalToSuperview().inset(Constraints.insultLabelHorizontal)
        }
        
        self.insultView.addSubview(self.swapLabel)
        self.swapLabel.snp.makeConstraints { make in
            make.top.equalTo(self.swapButton.snp.bottom)
            make.centerX.equalTo(self.swapButton)
        }
        
        self.insultView.addSubview(self.saveLabel)
        self.saveLabel.snp.makeConstraints { make in
            make.top.equalTo(self.saveButton.snp.bottom)
            make.centerX.equalTo(self.saveButton)
        }
        
        self.insultView.addSubview(self.sendLabel)
        self.sendLabel.snp.makeConstraints { make in
            make.top.equalTo(self.shareButton.snp.bottom)
            make.centerX.equalTo(self.shareButton)
        }
        
        self.alertView.addSubview(self.timerLabel)
        self.timerLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.alertView).inset(Constraints.generateInsultLabelHorizontal)
            make.top.equalTo(self.alertView.snp.top).inset(Constraints.timerLabelTop)
        }
        
        self.alertView.addSubview(self.generateNewInsultLabel)
        self.generateNewInsultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.alertView).inset(Constraints.generateInsultLabelTop)
            make.leading.trailing.equalTo(self.alertView).inset(Constraints.generateInsultLabelHorizontal)
        }
    }
    
    private func setupLabelsData() {
        self.insultLabel.attributedText = String.stringConfig(self.presenter?.insult.currentInsult ?? "No insults")
        
        self.saveLabel.text = "Save"
        self.saveLabel.font = AppFonts.regular15.font
        
        self.sendLabel.text = "Send"
        self.sendLabel.font = AppFonts.regular15.font
        
        self.swapLabel.text = "Swap"
        self.swapLabel.font = AppFonts.regular15.font
        
        self.generateNewInsultLabel.numberOfLines = 2
        self.generateNewInsultLabel.textAlignment = .center
        self.generateNewInsultLabel.font = AppFonts.regular15.font
        self.generateNewInsultLabel.text = "Generate a new insult?"
        
        self.timerLabel.textAlignment = .center
        self.timerLabel.font = AppFonts.regular15.font
        self.timerLabel.text = String.timeString(time: TimeInterval(10))
    }
    
    //MARK: - Buttons
    
    private func setupButtons() {
        self.insultView.addSubview(self.settingsButtonImage)
        self.settingsButtonImage.addTarget(self, action: #selector(self.openSettingsAction), for: .touchUpInside)
        self.settingsButtonImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constraints.settingButtonTop)
            make.trailing.equalToSuperview().inset(Constraints.settingButtonTrailing)
        }
        
        self.insultView.addSubview(self.swapButton)
        self.swapButton.addTarget(self, action: #selector(self.swapInsultAction), for: .touchUpInside)
        self.swapButton.snp.makeConstraints { make in
            make.top.equalTo(self.insultView.snp.top).inset(Constraints.swapButtonTop)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(Constraints.swapButtonWidthHeight)
        }
        
        self.insultView.addSubview(self.saveButton)
        self.saveButton.addTarget(self, action: #selector(self.saveInsultAction), for: .touchUpInside)
        self.saveButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constraints.starButtonLocationButtonTop)
            make.leading.equalToSuperview().inset(Constraints.starLocationHorizontal)
            make.height.width.equalTo(Constraints.starButtonLocationButtonHightWeight)
        }
        
        self.insultView.addSubview(self.shareButton)
        self.shareButton.addTarget(self, action: #selector(self.sendInsultAction), for: .touchUpInside)
        self.shareButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constraints.starButtonLocationButtonTop)
            make.trailing.equalToSuperview().inset(Constraints.starLocationHorizontal)
            make.height.width.equalTo(Constraints.starButtonLocationButtonHightWeight)
        }
        
        self.alertView.addSubview(self.generateYesButton)
        self.generateYesButton.addTarget(self, action: #selector(self.generateNewInsultAction), for: .touchUpInside)
        self.generateYesButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constraints.alertButtonsTop)
            make.trailing.equalToSuperview().inset(Constraints.alertsButtonsHorizontal)
        }
        
        self.alertView.addSubview(self.generateNoButton)
        self.generateNoButton.addTarget(self, action: #selector(self.cancelGenerateInsultAction), for: .touchUpInside)
        self.generateNoButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constraints.alertButtonsTop)
            make.leading.equalToSuperview().inset(Constraints.alertsButtonsHorizontal)
        }
    }
    
    private func setupButtonsData() {
        self.settingsButtonImage.tintColor = .black
        self.settingsButtonImage.setImage(UIImage(named: "Settings"), for: .normal)
        
        self.saveButton.tintColor = .black
        self.saveButton.setImage(UIImage(named: "star"), for: .normal)
        
//        let textString = self.insultLabel.text
//        if self.presenter?.insults.savedInsults.contains(text) {
//            self.saveButton.setImage(UIImage(named: "star.fill"), for: .normal)
//        } else {
//            self.saveButton.setImage(UIImage(named: "star"), for: .normal)
//        }
        
        self.shareButton.tintColor = .black
        self.shareButton.setImage(UIImage(named: "location.fill"), for: .normal)
        
        self.swapButton.tintColor = .black
        self.swapButton.setImage(UIImage(named: "arrow.fill"), for: .normal)
        
        self.generateYesButton.setTitleColor(.black, for: .normal)
        self.generateYesButton.setAttributedTitle(String.createString("Yes"), for: .normal)
        
        self.generateNoButton.setTitleColor(.black, for: .normal)
        self.generateNoButton.setAttributedTitle(String.createString("No"), for: .normal)
    }
    
    //MARK: - Actions
    
    @objc func openSettingsAction() {
        self.presenter?.tapOnSettings()
    }
    
    @objc func saveInsultAction() {
        self.saveButton.setImage(UIImage(named: "star.fill"), for: .normal)
        self.presenter?.saveInsult()
    }
    
    @objc func swapInsultAction() {
        if CountdownTimer.timer.isValid {
            self.generateYesButton.isEnabled = false
        } else {
            CountdownTimer().startCountdown(
                totalTime: 10,
                timerEnded: {
                    self.generateYesButton.isEnabled = true
                    print("Countdown is over")
                }, timerInProgress: { elapsedTime in
                    self.generateYesButton.isEnabled = false
                    self.timerLabel.text = String.timeString(time: TimeInterval(elapsedTime))
                }
            )
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.insultView.alpha = 0; self.saveLabel.alpha = 0; self.sendLabel.alpha = 0; self.swapLabel.alpha = 0; self.swapButton.alpha = 0; self.saveButton.alpha = 0; self.shareButton.alpha = 0; self.settingsButtonImage.alpha = 0; self.insultLabel.alpha = 0; self.alertView.alpha = 1; self.timerLabel.alpha = 1; self.generateNewInsultLabel.alpha = 1; self.generateNoButton.alpha = 1; self.generateYesButton.alpha = 1
        }) { (finished) in
            self.insultView.isHidden = true; self.saveLabel.isHidden = finished; self.sendLabel.isHidden = finished; self.swapLabel.isHidden = finished; self.swapButton.isHidden = finished; self.saveButton.isHidden = finished; self.shareButton.isHidden = finished; self.settingsButtonImage.isHidden = finished; self.insultLabel.isHidden = finished; self.alertView.isHidden = false; self.timerLabel.isHidden = false; self.generateNewInsultLabel.isHidden = false; self.generateNoButton.isHidden = false; self.generateYesButton.isHidden = false
        }
    }
    
    @objc func sendInsultAction() {
        self.presenter?.shareInsult(vc: self)
    }
    
    @objc func generateNewInsultAction() {
        self.presenter?.getInsult()
        self.cancelGenerateInsultAction()
    }
    
    @objc func cancelGenerateInsultAction() {
        UIView.animate(withDuration: 0.3, animations: {
            self.insultView.alpha = 1; self.saveLabel.alpha = 1; self.sendLabel.alpha = 1; self.swapLabel.alpha = 1; self.swapButton.alpha = 1; self.saveButton.alpha = 1; self.shareButton.alpha = 1; self.settingsButtonImage.alpha = 1; self.insultLabel.alpha = 1; self.alertView.alpha = 0; self.timerLabel.alpha = 0; self.generateNewInsultLabel.alpha = 0; self.generateNoButton.alpha = 0; self.generateYesButton.alpha = 0
        }) { (finished) in
            self.insultView.isHidden = false; self.saveLabel.isHidden = false; self.sendLabel.isHidden = false; self.swapLabel.isHidden = false; self.swapButton.isHidden = false; self.saveButton.isHidden = false; self.shareButton.isHidden = false; self.settingsButtonImage.isHidden = false; self.insultLabel.isHidden = false; self.alertView.isHidden = finished; self.timerLabel.isHidden = finished; self.generateNewInsultLabel.isHidden = finished; self.generateNoButton.isHidden = finished; self.generateYesButton.isHidden = finished
        }
    }
    
}


extension InsultVC: StartViewProtocol {
    
    func success() {
        self.insultLabel.text = self.presenter?.insult.currentInsult
    }
    
    func failure() {
        let alert = UIAlertController(title: "WTF", message: "No internet connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { [weak self] alert in
            self?.presenter?.getInsult()
        }))
        self.present(alert, animated: true)
    }
    
}

