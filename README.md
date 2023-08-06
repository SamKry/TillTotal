# ⚠️ Currently under Development

# Default initialisation
```swift
struct CoinDataHelper {
    static func initEmptyCoinData() -> CoinData {
        return CoinData(
            coinTypes: [
                CoinData.CoinType(icon: Image(systemName: "dollarsign.circle"),
                                  currencies: [
                                    CoinData.Coin(value: 5, count: 0),
                                    CoinData.Coin(value: 2, count: 0),
                                    CoinData.Coin(value: 1, count: 0),
                                    CoinData.Coin(value: 0.50, count: 0),
                                    CoinData.Coin(value: 0.20, count: 0),
                                    CoinData.Coin(value: 0.10, count: 0),
                                    CoinData.Coin(value: 0.05, count: 0)
                                  ], title: "Münzen", color: .green),
                CoinData.CoinType(icon: Image(systemName: "banknote"),
                                  currencies: [
                                    CoinData.Coin(value: 500, count: 0),
                                    CoinData.Coin(value: 200, count: 0),
                                    CoinData.Coin(value: 100, count: 0),
                                    CoinData.Coin(value: 50, count: 0),
                                    CoinData.Coin(value: 20, count: 0),
                                    CoinData.Coin(value: 10, count: 0)
                                  ], title: "Noten", color: .blue),
                CoinData.CoinType(icon: Image(systemName: "cylinder.split.1x2"),
                                  currencies: [
                                    CoinData.Coin(value: 125, count: 0),
                                    CoinData.Coin(value: 100, count: 0),
                                    CoinData.Coin(value: 50, count: 0),
                                    CoinData.Coin(value: 25, count: 0),
                                    CoinData.Coin(value: 10, count: 0),
                                    CoinData.Coin(value: 5, count: 0),
                                    CoinData.Coin(value: 2.50, count: 0)
                                  ], title: "Münzrollen", color: .orange),
                CoinData.CoinType(icon: Image(systemName: "plus.circle"),
                                  currencies: [
                                    CoinData.Other(total: 0),
                                    CoinData.Other(total: 0)
                                  ], title: "Andere", color: .red)
            ]
        )
    }
}
```


# TillTotal

TillTotal is an iOS app developed in Xcode that simplifies cash counting and tracking for store owners. With TillTotal, you can conveniently enter the amount of individual coins or input the total amount, providing flexibility for different counting methods. This feature proves particularly useful when counting banknotes individually but calculating the total value of coins.

## Key Features

- **Flexible Coin Counting**: Easily enter the quantity of each coin denomination or directly input the total amount of coins.
- **Banknote Tracking**: Track banknote count individually for accurate cash management.
- **Precise Cash Calculations**: TillTotal accurately calculates and tallies the daily earnings, ensuring precision in financial tracking.
- **User-friendly Interface**: The intuitive interface makes it easy to navigate and input cash amounts quickly.
- **Convenient Reports**: Generate reports summarizing daily cash earnings for easy reference and analysis.
- **Data Privacy**: Your financial information is stored locally so no one but you can access it.

## Installation

1. Clone or download the TillTotal repository to your local machine.
2. Open the project in Xcode.
3. Connect your iOS device or use the iOS Simulator.
4. Build and run the app on your device.

## Usage

1. Launch TillTotal on your iOS device.
2. Enter the quantity of each coin denomination or input the total amount of coins.
3. Optionally, enter the individual count of banknotes.
4. TillTotal will calculate the total cash amount and provide a comprehensive overview of your daily earnings.
5. View and generate reports to track and analyze your cash flow.

## Contributing

Contributions to TillTotal are welcome! If you find any bugs, have suggestions for new features, or would like to contribute in any way, please open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).

## Contact

For any inquiries or questions, please reach out to me at info@samkry.ch.
