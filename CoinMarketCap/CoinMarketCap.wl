BeginPackage["CoinMarketCap`"]

Ticker::usage = "Ticker[] returns the current ticker values for a range of bitcoin based currencies. Ticker[ currency ] also includes information about traditional currencies";
SingleTicker::usage = "SingleTicker[] returns the current ticker values for the given bitcoin currency. SingleTicker[ currency ] also includes information about traditional currencies";
TickerLimit::usage = "TickerLimit is an option to Ticker which limits the number of results";
TraditionalCurrency::usage = "TraditionalCurrency is an option to Ticker which prompt Ticker to return additional local traditional currency information";
GlobalData::usage = "GlobalData[] returns global information for active currencies and markets";

Begin["`Private`"]

$CoinMarketCapDirectory = DirectoryName[$InputFileName];
Protect[$CoinMarketCapDirectory];

$TraditionalCurrencies = { "AUD", "BRL", "CAD", "CHF", "CLP", "CNY", "CZK", "DKK", "EUR", "GBP", "HKD", "HUF", "IDR", "ILS", "INR", "JPY", "KRW", "MXN", "MYR", "NOK", "NZD", "PHP", "PKR", "PLN", "RUB", "SEK", "SGD", "THB", "TRY", "TWD", "ZAR" };
$BitCoinCurrencies = {} ;

$CoinMarketCapBaseUrl = "https://api.coinmarketcap.com/v1";

Options[ Ticker ] = { TraditionalCurrency -> "USD", TickerLimit -> None };

Ticker[ opts:OptionsPattern[] ] := Module[ { convert, limit, url },
  convert = OptionValue[TraditionalCurrency];
  limit = OptionValue[TickerLimit];
  url = URLBuild[ { $CoinMarketCapBaseUrl, "ticker" }, { "limit" -> limit, "convert" -> convert } ];
  Dataset[ Import[ url, "RawJSON"] ]
  ]

Options[ SingleTicker ] = { TraditionalCurrency -> "USD" };

SingleTicker[ id_String, opts:OptionsPattern[] ] := Module[ { convert, url },
  convert = OptionValue[TraditionalCurrency];
  url = URLBuild[ { $CoinMarketCapBaseUrl, "ticker", id }, { "convert" -> convert } ];
  Dataset[ Import[ url, "RawJSON"] ]
  ]

Options[ GlobalData ] =  { TraditionalCurrency -> "USD" };

GlobalData[ opts:OptionsPattern[] ] := Module[ { convert, url },
  convert = OptionValue[TraditionalCurrency];
  url = URLBuild[ { $CoinMarketCapBaseUrl, "global" }, { "convert" -> convert } ];
  Dataset[ Import[ url, "RawJSON"] ]
  ]

End[]

EndPackage[]
