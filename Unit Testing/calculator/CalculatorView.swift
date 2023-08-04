import SwiftUI

struct CalculatorView: View {
    @StateObject var viewModel = CalculatorViewModel()
    let buttonData: [[String]] = [
        ["%", "+/-", "AC", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["", "0", ".", "="]
    ]
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 1) {
                
                //user input
                Text(viewModel.valueLabel)
                    .font(.system(size: 48))
                    .foregroundColor(.white)
                    .padding(20)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                
                //buttons
                ForEach(buttonData, id: \.self) { row in
                    HStack(spacing: 1) {
                        ForEach(row, id: \.self) { buttonTitle in
                            CalculatorButton(title: buttonTitle, action: {
                                viewModel.handleButtonPressed(buttonTitle)
                            })
                        }
                    }
                }
            }
        }
    }
}

struct CalculatorViewOne_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}

//MARK: - button view
struct CalculatorButton : View {
    let title  : String
    let action : () -> Void
    
    let graybuttons = ["%", "+/-", "AC"]
    let orangeButtons = ["÷", "×", "-", "+", "="]
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title)
                .padding()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(graybuttons.contains(title) ? .gray : (orangeButtons.contains(title) ? .orange : .blue))
        }
    }
}
