1.) CRYPTO INFO: Provides basic info of Crypto Currency around the globe.

2). API used:
    CoinMarketCap:  "https://coinmarketcap.com/api/"
    API integrated in app:  "https://api.coinmarketcap.com/v1/ticker/"

3.) POD framework used:
    SwiftCharts: "https://github.com/i-schuetz/SwiftCharts"
    Used in app to show the change in CryptoCurrency between certain time period.
    
4.) Launching the project:
    First you have to install cocoapods in your Mac by opening the terminal and typing:
       - sudo gem install cocoapods
    Then ypu have to get in the directory of the project via terminal and type:
        - pod install
    After it is done close the terminal and open ".xcworkspace" file everytime you want to run the project
    
5.) Basics of App:
    When u first launch the app you need to click on reload button in order to fetch new data becoz initially that page shows the saved entities in order to make the app persistent.
    When you terminate the app and launch it again waiting for few seconds and not hitting the reload button that time you'll see the currencyName and symbol is persistent while other need to be loaded from the internet again by hitting the reload button.(Note: Please try this step in order to see persistence and you should be connected to internet.)

6.) All the Alerts have benn added to the app.

7.) Enjoy the app and gain some knowledge about Crypto Currency. :)
