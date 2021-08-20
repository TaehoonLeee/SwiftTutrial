import UIKit

class StockDetailTopView: BaseView {
    let titleLabel = TitleLabel()
    let subTitleLabel = NormalGrayLabel()
    let currentValueTextLabel = SmallLabel()
    let currentValueValueLabel = TitleLabel()
    let investmentLabel = SmallLabel()
    let investmentValueLabel = SmallBoldLabel()
    let gainLabel = SmallLabel()
    let gainValueLabel = SmallBoldLabel()
    let annualReturnLabel = SmallLabel()
    let annualReturnValueLabel = SmallBoldLabel()
    
    override func configureUI() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        
        addSubview(subTitleLabel)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 10).isActive = true
        subTitleLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        
        addSubview(currentValueTextLabel)
        currentValueTextLabel.translatesAutoresizingMaskIntoConstraints = false
        currentValueTextLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        currentValueTextLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        
        addSubview(currentValueValueLabel)
        currentValueValueLabel.translatesAutoresizingMaskIntoConstraints = false
        currentValueValueLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        currentValueValueLabel.topAnchor.constraint(equalTo: currentValueTextLabel.bottomAnchor, constant: 10).isActive = true
        
        addSubview(investmentLabel)
        investmentLabel.translatesAutoresizingMaskIntoConstraints = false
        investmentLabel.topAnchor.constraint(equalTo: currentValueValueLabel.bottomAnchor, constant: 16).isActive = true
        investmentLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        
        addSubview(investmentValueLabel)
        investmentValueLabel.translatesAutoresizingMaskIntoConstraints = false
        investmentValueLabel.centerYAnchor.constraint(equalTo: investmentLabel.centerYAnchor).isActive = true
        investmentValueLabel.rightAnchor.constraint(equalTo: rightAnchor, constant:  -16).isActive = true
        
        addSubview(gainLabel)
        gainLabel.translatesAutoresizingMaskIntoConstraints = false
        gainLabel.topAnchor.constraint(equalTo: investmentValueLabel.bottomAnchor, constant: 10).isActive = true
        gainLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        
        addSubview(gainValueLabel)
        gainValueLabel.translatesAutoresizingMaskIntoConstraints = false
        gainValueLabel.centerYAnchor.constraint(equalTo: gainLabel.centerYAnchor).isActive = true
        gainValueLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        
        addSubview(annualReturnLabel)
        annualReturnLabel.translatesAutoresizingMaskIntoConstraints = false
        annualReturnLabel.topAnchor.constraint(equalTo: gainValueLabel.bottomAnchor, constant: 10).isActive = true
        annualReturnLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        
        addSubview(annualReturnValueLabel)
        annualReturnValueLabel.translatesAutoresizingMaskIntoConstraints = false
        annualReturnValueLabel.centerYAnchor.constraint(equalTo: annualReturnLabel.centerYAnchor).isActive = true
        annualReturnValueLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        annualReturnValueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
}
