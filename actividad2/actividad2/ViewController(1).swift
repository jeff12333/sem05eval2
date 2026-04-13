import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var loanTextField: UITextField!
    @IBOutlet weak var interestTextField: UITextField!
    @IBOutlet weak var yearsTextField: UITextField!
    
    @IBOutlet weak var monthlyPaymentLabel: UILabel!
    @IBOutlet weak var totalPaymentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Limpiar labels al iniciar
        monthlyPaymentLabel.text = "Cuota: $0.00"
        totalPaymentLabel.text = "Total: $0.00"
    }

    // MARK: - Action
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        
        // 1. Obtener y validar valores
        let p = Double(loanTextField.text ?? "") ?? 0.0 // Capital
        let annualRate = Double(interestTextField.text ?? "") ?? 0.0 // Interés anual
        let years = Double(yearsTextField.text ?? "") ?? 0.0 // Plazo en años
        
        // Validación básica
        if p <= 0 || annualRate <= 0 || years <= 0 {
            monthlyPaymentLabel.text = "Error: Datos inválidos"
            return
        }
        
        // 2. Preparar variables para la fórmula
        // r = tasa mensual (tasa anual / 12 / 100)
        let r = (annualRate / 100) / 12
        // n = número total de pagos (años * 12)
        let n = years * 12
        
        // 3. Aplicar la fórmula de amortización
        // M = P * [ r(1+r)^n ] / [ (1+r)^n - 1 ]
        let commonFactor = pow(1 + r, n)
        let monthlyPayment = p * (r * commonFactor) / (commonFactor - 1)
        
        // 4. Calcular el monto total a pagar
        let totalPayment = monthlyPayment * n
        
        // 5. Mostrar resultados
        monthlyPaymentLabel.text = String(format: "Cuota Mensual: $%.2f", monthlyPayment)
        totalPaymentLabel.text = String(format: "Monto Total: $%.2f", totalPayment)
    }
}
