# Kantox Supermarket

The following assumptions were made:
* The price rounding is performed after applying all the discounts and adding all the prices. Values over or equal to 0.005 are rounded up, while values under 0.005 are rounded down.

Limitations and future work:
* The discounts are hard-coded into the library. They could be read from a JSON file or a database. JSON format is a good candidate for storing the discounts, as it allows for maximum flexibility in the discount's parameters.

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

