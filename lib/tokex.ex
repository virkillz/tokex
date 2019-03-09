defmodule Tokex do
  @tapiurl "https://exchange.tokenomy.com/tapi"

  @moduledoc """
  Documentation for Tokex.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Tokex.hello()
      :world

  """
  def hello do
    :world
  end

  def summaries() do
    case HTTPoison.get("https://exchange.tokenomy.com/api/summaries") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, Poison.decode!(body)}
      {:ok, %HTTPoison.Response{status_code: status}} -> {:error, "HTTP Status #{status}"}
      _ -> {:error, "Unsuccessfull"}
    end
  end

  def ticker(pair) do
    call_public("ticker", pair)
  end

  def trades(pair) do
    call_public("trades", pair)
  end

  def depth(pair) do
    call_public("depth", pair)
  end

  # ============================= PRIVATE =========================== #

  def get_info do
    tapi_call(%{method: "getInfo"})
  end

  def trans_history do
    tapi_call(%{method: "transHistory"})
  end

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
