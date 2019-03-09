defmodule Tokex do
  @tapiurl "https://exchange.tokenomy.com/tapi"

  @moduledoc """
  Don't forget to follow the installation isntruction to use this library. You need to get API key and secret from your [Tokenomy profile page](https://exchange.tokenomy.com). 
  """

  @doc """
  Get summary of the market.

  ## Examples

      iex> Tokex.summaries()
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

  """
  def summaries() do
    case HTTPoison.get("https://exchange.tokenomy.com/api/summaries") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, Poison.decode!(body)}
      {:ok, %HTTPoison.Response{status_code: status}} -> {:error, "HTTP Status #{status}"}
      _ -> {:error, "Unsuccessfull"}
    end
  end

  @doc """
  Get the last price for spesific pair. You can check `Tokex.summaries/0` to knwo all available pairs.


  ## Examples

      iex> Tokex.ticker("zec_btc")
      {:ok,
       %{
         "server_time" => 1552104570,
         "ticker" => %{
           "buy" => "0.01273",
           "high" => 0,
           "last" => 0,
           "low" => 0,
           "sell" => 0,
           "vol_btc" => "0.00000000",
           "vol_zec" => "0.00000000"
         }
       }}

  """  
  def ticker(pair) do
    call_public("ticker", pair)
  end

  @doc """
  Get the last trades by all user for spesific pair. You can check `Tokex.summaries/0` to knwo all available pairs.


  ## Examples

      iex> Tokex.trades("zec_btc")
      {:ok,
       [
         %{
           "amount" => "162.69629057",
           "date" => "1552104888",
           "price" => "0.00001294",
           "tid" => "4367859",
           "type" => "buy"
         },
         %{
           "amount" => "101.43441358",
           "date" => "1552104242",
           "price" => "0.00001296",
           "tid" => "4367680",
           ...
         },
         %{
           "amount" => "54.23183925",
           "date" => "1552104227",
           "price" => "0.00001294",
           ...
         },
         %{"amount" => "156.67052469", "date" => "1552104212", ...},
         %{"amount" => "54.23183925", ...},
         %{...},
         ...
       ]}

  """  
  def trades(pair) do
    call_public("trades", pair)
  end

  @doc """
  Get public order book by all user for spesific pair. You can check `Tokex.summaries/0` to knwo all available pairs.


  ## Examples

      iex> Tokex.depth("ten_btc")
        {:ok,
         %{
           "buy" => [
             ["0.00001281", "1108.59016393"],
             ["0.0000128", "359.67343750"],
             ["0.00001275", "375.60627450"],
             ["0.00001247", "17.67201283"],
             ["0.00001245", "15.71405622"],
             ["0.00001243", "20.95816572"],
           ],
           "sell" => [
             ["0.000013", "365.68276992"],
             ["0.00001315", "76.91458496"],
             ["0.00001318", "10.00000000"],
             ["0.0000132", "37.08063841"],
             ["0.00001322", "10.00000000"],
             ["0.00001324", "14.38838850"],
             [...],
             ...
           ]
         }}

  """
  def depth(pair) do
    call_public("depth", pair)
  end

  # ============================= PRIVATE =========================== #

  @doc """
  Get information regarding your account. Including your address, balance, email, user ID, etc.


  ## Examples

      iex> Tokex.get_info
        {:ok,
         %{
           "return" => %{
             "address" => %{
               "appc" => "0x82abf024ce158a0dee2ba94286e9af729eb173be",
               "mith" => "0x82abf024ce158a0dee2ba94286e9af729eb173be",
               "ae" => "0x82abf024ce158a0dee2ba94286e9af729eb173be",
               "bat" => "0x82abf024ce158a0dee2ba94286e9af729eb173be",
               "snt" => "0x82abf024ce158a0dee2ba94286e9af729eb173be",
               "stq" => "0x82abf024ce158a0dee2ba94286e9af729eb173be"
             },
             "balance" => %{
               "appc" => "0.00000000",
               "mith" => "0.00000000",
               "ae" => "0.00000000",
               "bat" => "0.00000000",
               "snt" => "0.00000000",
               ...
             },
             "balance_hold" => %{
               "appc" => "0.00000000",
               "mith" => "0.00000000",
               "ae" => "0.00000000",
               "bat" => "0.00000000",
               "snt" => "0.00000000",
               "stq" => "0.00000000",
               "lrn" => "0.00000000",
               ...
             },
             "email" => "virkill@gmail.com",
             "name" => "virkill",
             "server_time" => 1552105247,
             "user_id" => "xxxx"
           },
           "success" => 1
         }}

  """
  def get_info do
    tapi_call(%{method: "getInfo"})
  end

  @doc """
  Get your transaction history


  ## Examples

      iex> Tokex.trans_history
        {:ok, %{"return" => %{"deposit" => [], "withdraw" => []}, "success" => 1}}

  """
  def trans_history do
    tapi_call(%{method: "transHistory"})
  end

  @doc """
  Get your current open order

  Option: 
    :pair You can specify which exact pair you want to see.


  ## Examples

      iex> Tokex.open_orders
        {:ok,
         %{
           "return" => %{
             "orders" => %{
               "zec_btc" => [
                 %{
                   "order_btc" => "0.00020000",
                   "order_id" => "33847200",
                   "price" => "0.00020000",
                   "remain_btc" => "0.00020000",
                   "submit_time" => "1552099315",
                   "type" => "buy"
                 }
               ]
             }
           },
           "success" => 1
         }}
  
  You can also specify 


  """
  def open_orders(option \\ []) do
    optional_params = Enum.into(option, %{})

    params =
      %{method: "openOrders"}
      |> Map.merge(optional_params)

    tapi_call(params)
  end

  @doc """
  Use this to put a sell or buy order. 

  ## Examples
  Say you want to buy 1 ZEC at the price of 0.000200 BTC you can put order like this

      iex> Tokex.trade("zec_btc", "buy", 0.000200, [zec: 1])
      {:ok,
       %{
         "balance" => %{
           "appc" => "0.00000000",
           "neo" => "0.00000000",
           "mith" => "0.00000000",
           "ae" => "0.00000000",
           ...
         },
         "is_error" => false,
         "order_id" => 33847200,
         "receive_zec" => "0.00000000",
         "remain_btc" => "0.00020000",
         "spend_btc" => "0.00000000",
         "success" => 1
       }}      

  """
  def trade(pair, type, price, option \\ []) do
    optional_params = Enum.into(option, %{})

    params =
      %{method: "trade", pair: pair, type: type, price: price}
      |> Map.merge(optional_params)

    tapi_call(params)
  end

  def trade_history(pair, option \\ []) do
    optional_params = Enum.into(option, %{})

    params =
      %{method: "tradeHistory", pair: pair}
      |> Map.merge(optional_params)

    tapi_call(params)
  end

  def order_history(pair, option \\ []) do
    optional_params = Enum.into(option, %{})

    params =
      %{method: "orderHistory", pair: pair}
      |> Map.merge(optional_params)

    tapi_call(params)
  end

  def get_order(pair, order_id) do
    tapi_call(%{method: "getOrder", pair: pair, order_id: order_id})
  end

  def cancel_order(pair, order_id, type) do
    tapi_call(%{method: "cancelOrder", pair: pair, order_id: order_id, type: type})
  end

  def withdraw_coin(currency, withdraw_address, withdraw_amount, request_id, option \\ []) do
    optional_params = Enum.into(option, %{})

    params =
      %{
        method: "withdrawCoin",
        currency: currency,
        withdraw_address: withdraw_address,
        withdraw_amount: withdraw_amount,
        request_id: request_id
      }
      |> Map.merge(optional_params)

    tapi_call(params)
  end

  # =================================== HELPER ================================

  defp tapi_call(%{} = params) do
    apikey = Application.get_env(:tokex, :public)
    apisecret = Application.get_env(:tokex, :secret)
    nonce = :os.system_time(:micro_seconds)
    data = Map.put(params, :nonce, nonce)
    postdata = URI.encode_query(data)
    sign = Base.encode16(:crypto.hmac(:sha512, apisecret, postdata), case: :lower)
    headers = [Key: apikey, Sign: sign, "Content-Type": "application/x-www-form-urlencoded"]

    case HTTPoison.post(@tapiurl, postdata, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode(body)

      {:ok, %HTTPoison.Response{status_code: status}} ->
        {:error, "Error while call the API. HTTP Status #{status}"}

      _ ->
        {:error, "Unsuccessfull"}
    end
  end

  defp call_public(type, pair) do
    case HTTPoison.get("https://exchange.tokenomy.com/api/#{pair}/#{type}") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, Poison.decode!(body)}
      {:ok, %HTTPoison.Response{status_code: status}} -> {:error, "HTTP Status #{status}"}
      _ -> {:error, "Unsuccessfull"}
    end
  end
end
