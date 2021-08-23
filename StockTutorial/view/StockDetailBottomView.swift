import UIKit

class StockDetailBottomView: BaseView {
    
    let investmentInputView = InputView()
    let costInputView = InputView()
    let dateInputView = InputView()
    let slider = UISlider()
    
    override func configureUI() {
        addSubview(investmentInputView)
        addSubview(costInputView)
        addSubview(dateInputView)
        addSubview(slider)
        
        investmentInputView.translatesAutoresizingMaskIntoConstraints = false
        costInputView.translatesAutoresizingMaskIntoConstraints = false
        dateInputView.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        investmentInputView.configureUI(placeholder: "Enter your initial investment amount", description: "initial investment amount")
        costInputView.configureUI(placeholder: "Monthly dollar cost averaging amount", description: "Monthly dollar cost averaging amount")
        dateInputView.configureUI(placeholder: "Enter the inital date of investment", description: "Enter the inital date of investment")
        
        investmentInputView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        investmentInputView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        investmentInputView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        investmentInputView.textField.keyboardType = .numberPad
        investmentInputView.textField.addDoneButton()
        
        costInputView.topAnchor.constraint(equalTo: investmentInputView.bottomAnchor, constant: 8).isActive = true
        costInputView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        costInputView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        costInputView.textField.keyboardType = .numberPad
        costInputView.textField.addDoneButton()
        
        dateInputView.topAnchor.constraint(equalTo: costInputView.bottomAnchor, constant: 8).isActive = true
        dateInputView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        dateInputView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        
        slider.topAnchor.constraint(equalTo: dateInputView.bottomAnchor, constant: 8).isActive = true
        slider.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        slider.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
    
    func configureUI(currency: String) {
        investmentInputView.valueLabel.text = "(\(currency))"
        costInputView.valueLabel.text = "(\(currency))"
        dateInputView.valueLabel.text = "(\(currency))"
    }
    
    class InputView: BaseView {
        let textField = UITextField()
        let descriptionLabel = SmallLabel()
        let valueLabel = NormalGrayLabel()
        
        override func configureUI() {
            textField.font = UIFont.systemFont(ofSize: 18)
            textField.autocorrectionType = .no
            
            addSubview(textField)
            addSubview(descriptionLabel)
            addSubview(valueLabel)
            
            textField.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            valueLabel.translatesAutoresizingMaskIntoConstraints = false
            
            textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
            textField.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            textField.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            
            descriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8).isActive = true
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            
            valueLabel.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor).isActive = true
            valueLabel.leftAnchor.constraint(equalTo: descriptionLabel.rightAnchor, constant: 4).isActive = true
        }
        
        func configureUI(placeholder: String, description: String, value: String? = "(USD)") {
            textField.placeholder = placeholder
            descriptionLabel.text = description
            valueLabel.text = value
        }
    }
}
