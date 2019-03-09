# Tokex

Tokenomy Exchange API library for elixir

The purpose of this library is to provide simple api call which will always give you familiar tupple as result ``` {:ok, result} or {:error, reason} ```




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

Done! Now you can use it inside your Module.

## How to use

Tokenomy API separated into public and private. Public API can run without credential in config.


You can now call all of Multichain api in simple way by calling `Multichain.api/2`

  Some of example can be seen below:

  ```
  Multichain.api("listaddresses", ["*", true, 3, -3])

  Multichain.api("getinfo", [])

  Multichain.api("help", [])

  ```

  ```
  iex(1)> Multichain.api("validateaddress", ["1KFjut7GpLN2DSvRrh6UATxYxy5nxYaY7EGhys"])
  {:ok,
   %{
     "error" => nil,
     "id" => nil,
     "result" => %{
       "account" => "",
       "address" => "1KFjut7GpLN2DSvRrh6UATxYxy5nxYaY7EGhys",
       "ismine" => false,
       "isscript" => false,
       "isvalid" => true,
       "iswatchonly" => true,
       "synchronized" => false
     }
   }}

  ```


Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/tokex](https://hexdocs.pm/tokex).

