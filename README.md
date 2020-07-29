# Tokex

Tokenomy Exchange API library for elixir

![Tokenomy](https://www.tokenomy.com/images/tokenomy/LOGO_TOKENOMY.png)

[Tokenomy](https://www.tokenomy.com) is crypto exchange and ICO platform based in Singapore.

The purpose of this library is to provide simple api wrapper which will always give you familiar tupple as return ``` {:ok, result} or {:error, reason} ```, so you can simply pattern match your return and focus on your automated trading logic right away. All the result will be a Map.

The complete list of API can be founded in [Tokenomy's official API Documentation page](https://exchange.tokenomy.com/help/api).

Some example of API call:


  ```
iex(1)> Tokex.summaries
{:ok,
 %{
   "prices_24h" => %{
     "stqeth" => "90",
     "pxgten" => "2500000",
     "npxsbtc" => "15",
     ...
   },
   "prices_7d" => %{
     "stqeth" => "90",
     "pxgten" => "3110000",
     "npxsbtc" => "21",
     "verieth" => "32970000",
     ...
   },
   "server_time" => 1552103666,
   "tickers" => %{
     "ont_btc" => %{
       "buy" => "0.00000852",
       "high" => "0.00018002",
       "last" => "0.00018002",
       "low" => "0.00018002",
       "name" => "Ontology",
       "sell" => "0.00047888",
       "vol_btc" => "0.00000000",
       "vol_ont" => "0.00000000"
     },
     "mas_ten" => %{
       "buy" => "0.0051",
       "high" => "0.041",
       "last" => "0.041",
       "low" => "0.041",
       "name" => "MidasProtocol",
       "sell" => 0,
       "vol_mas" => "0.00000000",
       "vol_ten" => "0.00000000"
     },
     "appc_eth" => %{
       "buy" => "0.00001",
       "high" => "0.00050525",
       "last" => "0.00050525",
       ...
     },
     "ont_ten" => %{"buy" => "7", "high" => "7.8", ...},
     "six_ten" => %{"buy" => "0.0018", ...},
     "lrc_btc" => %{...},
     ...
   }
 }}

  ```





## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `tokex` to your list of dependencies in `mix.exs`:

To use this library you need to generate API key and secret from your tokenomy user profile. https://exchange.tokenomy.com/trade_api


1. Add dependency into your `mix.exs`:

```elixir
def deps do
  [
    {:tokex, "~> 0.1.0"}
  ]
end
```


2. Get the dependency

```
mix deps.get
```


3. Add your Tokenomy Key and Secret into `config.exs`.

```
config :tokex,
  public: "XXXXXXXX-XXXXXXXX-XXXXXXXX-XXXXXXXX-XXXXXXXX",
  secret: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

```

Done! Now you can use it inside your code.


The complete docs can be found at [https://hexdocs.pm/tokex](https://hexdocs.pm/tokex/readme.html#content).

