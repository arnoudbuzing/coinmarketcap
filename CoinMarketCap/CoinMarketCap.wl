BeginPackage["CoinMarketCap`"]

Ticker::usage = "Ticker[] returns the current ticker values for a range of bitcoin based currencies. Ticker[ currency ] also includes information about traditional currencies";
TickerLimit::usage = "TickerLimit is an option to Ticker which limits the number of results";

Begin["`Private`"]

$CoinMarketCapDirectory = DirectoryName[$InputFileName];
Protect[$CoinMarketCapDirectory];

$Currencies = { "AUD", "BRL", "CAD", "CHF", "CLP", "CNY", "CZK", "DKK", "EUR", "GBP", "HKD", "HUF", "IDR", "ILS", "INR", "JPY", "KRW", "MXN", "MYR", "NOK", "NZD", "PHP", "PKR", "PLN", "RUB", "SEK", "SGD", "THB", "TRY", "TWD", "ZAR" };

$CoinMarketCapBaseUrl = "https://api.coinmarketcap.com/v1";

Options[ Ticker ] = { TickerLimit -> None };

Ticker[ opts:OptionsPattern[] ] := Ticker[ "USD", opts ];

Ticker[ convert_String, opts:OptionsPattern[] ] := Module[ { tickerlimit, limit, url },
  tickerlimit = OptionValue[TickerLimit];
  limit = If[ tickerlimit === None , "", ToString[tickerlimit] ];
  url = URLBuild[ $CoinMarketCapBaseUrl, { "limit" -> limit, "convert" -> convert } ]
  ]


End[]

EndPackage[]
