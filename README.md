# Kantox Supermarket

A supermarket library that processes a list of products and calculates the total price for the listed items. The available products along with their prices are read from a CSV file. Meanwhile, the discounts are read from a JSON file.


The following assumptions were made:
* The price rounding is performed after applying all the discounts and adding all the prices. Values over or equal to 0.005 are rounded up, while values under 0.005 are rounded down.

## Running the library

To run the library in an Elixir console:

```
iex -S mix
```

To run the tests:

```
mix test
```

To perform the type checking:

```
mix dialyzer
```

